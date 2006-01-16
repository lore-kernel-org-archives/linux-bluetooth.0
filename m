Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Franz Furbass" <franz.furbass@erzia.com>
To: <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-Id: <20060116091447.674C01F0164@mrelay2.st2.lyceu.net>
Subject: [Bluez-users] Cellink BTA-3120 for Kernel 2.6.15
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
Date: Mon, 16 Jan 2006 10:16:50 +0100

Hello all,

To use the Cellink BTA-3120 USB dongle in Kernel 2.6.15 I had to apply the
following patch:



--- linux-2.6.15/drivers/bluetooth/hci_usb.c    2006-01-16
09:54:53.000000000 +0100
+++ linux-2.6.15/drivers/bluetooth/hci_usb.c    2006-01-13
16:09:00.000000000 +0100
@@ -95,6 +95,9 @@
        /* Ericsson with non-standard id */
        { USB_DEVICE(0x0bdb, 0x1002) },

+       /* Cellink USB dongle BTA 3120 */
+       { USB_DEVICE(0x0c10, 0x0000) },
+
        { }     /* Terminating entry */
 };



Regards,
Franz
 



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
