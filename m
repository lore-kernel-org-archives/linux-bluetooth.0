Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20051206072019.81758.qmail@web36102.mail.mud.yahoo.com>
From: Swathi Mathur80 <swathi_mathur80@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-users] not able to create socket using any of the protocols ?
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
Date: Mon, 5 Dec 2005 23:20:19 -0800 (PST)

Hello,
I tried creating sockets using all the three protocols
but i get the error saying "no such file or directory"

My code is as below 
------------------------------------------------
#include <stdio.h>
#include <errno.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <signal.h>
#include <termios.h>
#include <sys/wait.h>
#include <sys/time.h>
#include <sys/ioctl.h>
#include <sys/socket.h>

#include <bluetooth/bluetooth.h>
#include <bluetooth/hci.h>
#include <bluetooth/hci_lib.h>
#include <bluetooth/sco.h>
#include <bluetooth/rfcomm.h>

#include <unistd.h>
#include <stdarg.h>     /* we need va_list */
#include <errno.h>

int main(int argc, char **argv)
{

	int s;

	if ((s = socket(PF_BLUETOOTH, SOCK_STREAM,
BTPROTO_RFCOMM)) < 0) {
		perror("What is wrong: \n");
	}
return 0;
}

------------------------------------------------------

even if i replace the above with the below 
	if ((s = socket(PF_BLUETOOTH, SOCK_SEQPACKET,
BTPROTO_SCO)) < 0) {
		perror("What is wrong: \n");
	}

------------------------------------------------

Struck with the socket creation. Can somebody identify
the pblm ?

Thanks & Warm Regards,
Swathi.


		
__________________________________________ 
Yahoo! DSL – Something to write home about. 
Just $16.99/mo. or less. 
dsl.yahoo.com 



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
