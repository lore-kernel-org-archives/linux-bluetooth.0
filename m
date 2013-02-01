Return-Path: <cyrus@holtmann.org>
Message-ID: <510B88F5.7010404@wastelink.com.au>
Date: Fri, 01 Feb 2013 20:20:53 +1100
From: Tim Connolly <tconnolly@wastelink.com.au>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Accepting RFCOMM connections without pairing?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Can anybody point me to sample code for an RFCOMM server that can accept 
connections without the need for pairing?

I am trying to get this working under Debian Squeeze, which has Bluez 
4.66. Both ends of the connection are using Bluetooth v2.0 hardware.

I found this discussion:
   http://permalink.gmane.org/gmane.linux.bluez.kernel/13828
indicating that with my hardware, adjusting the security level on the 
server socket will disable pairing. However, I have not been able to 
make this work - bluetoothd triggers a link_key_request and 
pin_code_request on every connection attempt.

Any advice you can offer would be greatly appreciated.

--
Current test server:

#include <stdio.h>
#include <unistd.h>
#include <sys/socket.h>
#include <bluetooth/bluetooth.h>
#include <bluetooth/rfcomm.h>

int main(int argc, char **argv)
{
     struct sockaddr_rc loc_addr = { 0 }, rem_addr = { 0 };
     char buf[1024] = { 0 };
     int s, client, bytes_read;
     unsigned int opt = sizeof(rem_addr);

     // allocate socket
     s = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);

     struct bt_security sec = { BT_SECURITY_LOW };
     if (setsockopt(s, SOL_BLUETOOTH, BT_SECURITY, &sec, sizeof(sec)) < 0) {
         fprintf(stderr, "failed to set security level");
         return 2;
     }

     // bind socket to port 1 of the first available bluetooth adapter
     loc_addr.rc_family = AF_BLUETOOTH;
     loc_addr.rc_bdaddr = *BDADDR_ANY;
     loc_addr.rc_channel = 1;
     bind(s, (struct sockaddr *)&loc_addr, sizeof(loc_addr));

     // put socket into listening mode
     listen(s, 1);

     // accept one connection
     client = accept(s, (struct sockaddr *)&rem_addr, &opt);

     ba2str( &rem_addr.rc_bdaddr, buf );
     fprintf(stderr, "accepted connection from %s\n", buf);
     memset(buf, 0, sizeof(buf));

     // read data from the client
     bytes_read = recv(client, buf, sizeof(buf), 0);
     if( bytes_read > 0 ) {
         printf("received [%s]\n", buf);
     }

     // close connection
     close(client);
     close(s);
     return 0;
}
