#! /bin/bash
PSQL="psql --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~~~~~~~~~~~Kapil Salon~~~~~~~~~~~~\n"


MAIN_MENU(){
  if [[ $1 ]]
  then
  echo -e "\n$1"
  fi
  echo -e " Welcome to My luxrious Salon, How can i help you?\n"
  SERVICE=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id")
  echo "$SERVICE" | while  read SERVICE_ID  BAR NAME
  do
  echo "$SERVICE_ID) $NAME"
  done
  read SERVICE_ID_SELECTED
  CHOICE_ID=$($PSQL "SELECT service_id FROM services WHERE service_id = '$SERVICE_ID_SELECTED'")
  if [[ -z $CHOICE_ID ]]
  then
  MAIN_MENU 
  else
  echo "What is your mobile number?"
  read CUSTOMER_PHONE
  PHONE_ID_SELECTED=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  if [[ -z $PHONE_ID_SELECTED ]]
  then
  echo "Number is not available in data , please tell your name?"
  echo hello
  read CUSTOMER_NAME
  echo hello
  DATA_CUSTOMER=$($PSQL "INSERT INTO customers(phone , name) VALUES('$CUSTOMER_PHONE' ,'$CUSTOMER_NAME')")
  SELECT_ID=$($PSQL "SELECT customer_id FROM customers WHERE name = '$CUSTOMER_NAME'")
  echo "What time me preferred cuting?"
  read SERVICE_TIME
  TIME_CUSTOMER=$($PSQL "INSERT INTO appointments(customer_id , time, service_id) VALUES($SELECT_ID ,'$SERVICE_TIME', $SERVICE_ID_SELECTED)")
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = '$CHOICE_ID'")
  echo I have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME.
  fi
  fi
 
}
MAIN_MENU