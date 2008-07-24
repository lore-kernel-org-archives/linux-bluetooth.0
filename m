Return-Path: <cyrus@holtmann.org>
Message-ID: <488870AF.3080601@krevsbech.dk>
Date: Thu, 24 Jul 2008 14:08:15 +0200
From: Kasper Revsbech <mail@krevsbech.dk>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: RFCOMM server multiple client connections
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi everyone.
I am trying do do a simple client server setup  with bluez.
I can manage to have a client and a server on rfcomm sockets where the 
server listen on a socket and accept a connection from the client by 
connect. But then if I set the server back to accepting without putting 
down the one client connection it doesn't accept a new connection.
When I read thought the documentation I can find on Bluez and Bluetooth 
in general it seems like it should be possible to multiplex serveal 
virtual rfcomm connections  on one actual connection. But however I 
really can get it working and can't find any code where they do 
something similar.

Hope that someone can give me a hint...

/Kasper Revsbech


Here is a example of what I have tried to make it work:

Client:
--------------------------

#include <stdio.h>
#include <unistd.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <bluetooth/bluetooth.h>
#include <bluetooth/rfcomm.h>
#define number_of_connections 5

int main(int argc, char **argv)
{
 
  struct sockaddr_rc addr = { 0 };
  int s[number_of_connections], status, getpeer_status;
    char dest[18] = "00:11:67:05:4f:dc";
    struct sockaddr peer_address;
    int namelen = sizeof(peer_address),i;

    // set the connection parameters (who to connect to)
    addr.rc_family = AF_BLUETOOTH;
    addr.rc_channel = (uint8_t) 1;
    str2ba( dest, &addr.rc_bdaddr );
   
for (i=0 ;i=(number_of_connections-1);i++){
   
      s[i] = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);

  
     /*connect to server*/
      status = connect(s[i], (struct sockaddr *)&addr, sizeof(addr));
   
   
    // send a message
    if( status == 0 ) {
      status = write(s[i], "hello!", 6);
    }

    if( status < 0 ) perror("uh oh");
    }
  



    for (i=0 ;i=(number_of_connections-1);i++){
      close(s[i]);
    }  

    return 0;
}

-----------------------------------
Server:
-----------------------------------
#include <stdio.h>
#include <unistd.h>
#include <sys/socket.h>
#include <bluetooth/bluetooth.h>
#include <bluetooth/rfcomm.h>
#define number_of_connections 5

int main(int argc, char **argv)
{
    struct sockaddr_rc loc_addr = { 0 }, rem_addr = { 0 };
    char buf[1024] = { 0 };
    int s, client[number_of_connections], bytes_read;
    socklen_t opt = sizeof(rem_addr);
    int i;
    // allocate socket
    s = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);

    // bind socket to port 1 of the first available
    // local bluetooth adapter
    loc_addr.rc_family = AF_BLUETOOTH;
    loc_addr.rc_bdaddr = *BDADDR_ANY;
    loc_addr.rc_channel = (uint8_t) 1;
    bind(s, (struct sockaddr *)&loc_addr, sizeof(loc_addr));

    // put socket into listening mode
    listen(s, number_of_connections);
    for (i=0 ;i=(number_of_connections-1);i++){

    // accept one connection
      client[i] = accept(s, (struct sockaddr *)&rem_addr, &opt);

      ba2str( &rem_addr.rc_bdaddr, buf );
      fprintf(stderr, "accepted connection from %s\n", buf);
      memset(buf, 0, sizeof(buf));

      // read data from the client
      bytes_read = read(client[i], buf, sizeof(buf));
      if( bytes_read > 0 ) {
        printf("received [%s]\n", buf);
      }
    }
   
    // close connection
      for (i=0 ;i=(number_of_connections-1);i++){
       close(client[i]);
     }
     close(s);
    return 0;



