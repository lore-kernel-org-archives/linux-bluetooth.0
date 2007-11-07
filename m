Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <473118CB.5090804@mercuryresearch.com>
Date: Tue, 06 Nov 2007 18:45:47 -0700
From: Dean McCarron <dean@mercuryresearch.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] [PATCH] Apple Aluminum Bluetooth Keyboard
	(Resubmitted w/ sign-off)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--- linux-2.6.23.1/net/bluetooth/hidp/core.c.orig       2007-10-26 
10:28:59.000000000 -0700
+++ linux-2.6.23.1/net/bluetooth/hidp/core.c    2007-10-26 
10:30:59.000000000 -0700
@@ -686,6 +686,7 @@
  } hidp_blacklist[] = {
         /* Apple wireless Mighty Mouse */
         { 0x05ac, 0x030c, HID_QUIRK_MIGHTYMOUSE | 
HID_QUIRK_INVERT_HWHEEL },
+       { 0x05ac, 0x022c, HID_QUIRK_POWERBOOK_HAS_FN },

         { }     /* Terminating entry */
  };
Signed-off-by: Dean McCarron <dean@mercuryresearch.com>


(Hope I got this right, first patch!)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
