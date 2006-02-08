Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <32800.192.168.3.2.1139408221.squirrel@mailsrv.atlantico.com.br>
From: renan@atlantico.com.br
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Subject: [Bluez-devel] hidd deamon
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
Date: Wed, 8 Feb 2006 12:17:01 -0200 (BRST)

Hi !

I am trying to connect my Nokia N90 cell phone to Linux through Bluez
"hidd" deamon. I am trying to run an J2ME app that make the cell phone to
act as a HID mouse.

I had to offset the default PSMs under Linux because the range allowed in
the JSR82 is 0x1001 to 0xFFFF. I did this modification, compiled and
installed the bluez-utils again. After, I execute "hidd -d" (starting the
server mode).

Whenever I run the application in the cell phone I notice, sniffing the
HCI interface with "hcidump -x", that the keys are being received, but th=
e
mouse pointing is not moving nor showing the pop-up menus in the X.

Does anybody know how to solve this problem?





-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
