Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <32901.192.168.3.2.1139416784.squirrel@mailsrv.atlantico.com.br>
From: renan@atlantico.com.br
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Subject: [Bluez-users] Nokia N90 as a HID mouse
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
Date: Wed, 8 Feb 2006 14:39:44 -0200 (BRST)

Hi !

I am trying to connect my Nokia N90 cell phone to Linux through Bluez
"hidd" deamon. I am trying to run an J2ME app that make the cell phone to
act as a HID mouse.

I had to offset the default PSMs under Linux because the range allowed in
the JSR82 is 0x1001 to 0xFFFF. I did this modification, compiled and
installed the bluez-utils again.

Whenever I run the application in the cell phone I notice - sniffing the
HCI interface with "hcidump -x" - that the keys are being received, but
the mouse pointing is not moving nor showing the pop-up menus in the X.

Does anybody know how to solve this problem?

How to make sure that the Linux is considering my cell phone a HID device=
?

Thanks for any help!






-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
