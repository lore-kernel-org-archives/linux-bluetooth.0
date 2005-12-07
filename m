Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] not able to create socket using any of the
	protocols ?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20051206072019.81758.qmail@web36102.mail.mud.yahoo.com>
References: <20051206072019.81758.qmail@web36102.mail.mud.yahoo.com>
Content-Type: text/plain
Message-Id: <1133946413.11247.8.camel@blade>
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
Date: Wed, 07 Dec 2005 10:06:53 +0100

Hi Swathi,

> I tried creating sockets using all the three protocols
> but i get the error saying "no such file or directory"
> 
> My code is as below 
> ------------------------------------------------
> #include <stdio.h>
> #include <errno.h>
> #include <fcntl.h>
> #include <unistd.h>
> #include <stdlib.h>
> #include <signal.h>
> #include <termios.h>
> #include <sys/wait.h>
> #include <sys/time.h>
> #include <sys/ioctl.h>
> #include <sys/socket.h>
> 
> #include <bluetooth/bluetooth.h>
> #include <bluetooth/hci.h>
> #include <bluetooth/hci_lib.h>
> #include <bluetooth/sco.h>
> #include <bluetooth/rfcomm.h>
> 
> #include <unistd.h>
> #include <stdarg.h>     /* we need va_list */
> #include <errno.h>
> 
> int main(int argc, char **argv)
> {
> 
> 	int s;
> 
> 	if ((s = socket(PF_BLUETOOTH, SOCK_STREAM,
> BTPROTO_RFCOMM)) < 0) {
> 		perror("What is wrong: \n");
> 	}
> return 0;
> }
> 
> ------------------------------------------------------
> 
> even if i replace the above with the below 
> 	if ((s = socket(PF_BLUETOOTH, SOCK_SEQPACKET,
> BTPROTO_SCO)) < 0) {
> 		perror("What is wrong: \n");
> 	}
> 
> ------------------------------------------------
> 
> Struck with the socket creation. Can somebody identify
> the pblm ?

make sure the correct kernel modules are loaded.

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
