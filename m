Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20060204172632.37736.qmail@web53104.mail.yahoo.com>
From: ermal mino <ermalmino1004@yahoo.it>
To: bluez <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-devel] Help, Connection Reset by peer.
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 4 Feb 2006 18:26:32 +0100 (CET)

Hi,
I know bluez supports max 7 rfcomm connections at one
time, and so it works.
I implemented obex push profile(a part of it) and i
use it to send files to cellphones over rfcomm.
The strange thing is that sometimes when more than one
connection are working at the same time without any
particular apparent reason fail and some of the
connections or both of them stay open.

i close these connections using "hcitool dc"

when i try to browse the services it gives me:
Failed to connect SDP server: Connection reset by peer

i also stop my application
i restart hcid,sdpd
but still the same error,
then i have to reboot to make it work again.

any idea about what can it be the reason?
it happens rarely,randomly without any particular
condition except of the fact that there are two open
connections working, and i use kernel 2.4.27 or 2.4.29

is there any way to reset the device without needing
to reboot the system?

I must say that the only thing my application does is,

while true
1-search for devices,
2-for every device 
     find the service channel
     start a new thread with the sendfile function
goto while

so i don't think my application is the problem.

Thanks in advance.


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
