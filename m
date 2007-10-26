Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <472227FC.9000206@mercuryresearch.com>
Date: Fri, 26 Oct 2007 10:46:36 -0700
From: Dean McCarron <dean@mercuryresearch.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] Patch to add support for Apple Aluminum Bluetooth
	Keyboard
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


Here's a trivial patch to add support for Apple's aluminum
bluetooth keyboard. The keyboard works out of the the box,
but this enables the Fn modifier key so that a few useful
keys (namely pageup/pagedown using Fn+arrows).

Apologies if I'm not conforming to local patch formatting
conventions, but the needed change is pretty obvious regardless.

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


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
