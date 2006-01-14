Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43C94820.4040006@schugy.de>
From: Christian Schuglitsch <subjectbluez@schugy.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Subject: [Bluez-users] usb_hci, Belkin tetra hub and ehci-hcd errors
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
Date: Sat, 14 Jan 2006 19:51:12 +0100

I have bought Belkin tetra hubs that have a TT-chip for every USB port 
and plugged my Epox BT DG03 dongle into it. The problem is that the 
usb_hci-driver doesn't work when the tetra hubs do what they are 
designed for: Splitting 480 EHCI-MBit into 4 12 OHCI-MBit. If I use the 
ohci-hcd driver instead everything works fine. There're two drivers for 
my hardware that aren't compatible with EHCI translation, usb_hci and 
pwc (from saillard.org).

Regards

Schugy



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
