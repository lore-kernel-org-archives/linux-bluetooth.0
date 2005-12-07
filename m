Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Cannot send messages to my bluetooth enabled
	Phone using RFCOMM
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20051206050255.28756.qmail@web36106.mail.mud.yahoo.com>
References: <20051206050255.28756.qmail@web36106.mail.mud.yahoo.com>
Content-Type: text/plain
Message-Id: <1133946457.11247.10.camel@blade>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 07 Dec 2005 10:07:37 +0100

Hi Swathi,

> I am trying to send some data to my bluetooth enabled
> Sony Ericsson
> handphone T630 from my PC which has the bluez stack
> running on it, i am using the RFCOMM.
> 
> I get the error message "Cant create socket" and "bad
> file descriptor" 
> 
> Can someone help me in finding the mistake and in
> correcting the below code
> 
> ------------------------------------------------------------------
> #include <stdio.h>
> #include <string.h>
> #include <sys/socket.h>
> #include <bluetooth/bluetooth.h>
> #include <bluetooth/rfcomm.h>
> 
> int main(int argc, char **argv)
> {
>    struct sockaddr_rc addr = { 0 };
>    int s, status;
>    char dest[18] = "00:0A:D9:4C:EB:9A";  // BD of my
> sony erricson phone
>    
>    //allocate a socket
>    s =
> socket(AF_BLUETOOTH,SOCK_SEQPACKET,BTPROTO_RFCOMM);
> 
>    if (s < 0) {
>      printf("Cant create socket:\n");
>    }

the RFCOMM protocol is a SOCK_STREAM.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
