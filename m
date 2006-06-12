Return-Path: <philipl@mail.utexas.edu>
Message-ID: <448D88EE.3030902@mail.utexas.edu>
Date: Mon, 12 Jun 2006 08:31:58 -0700
From: Philip Langdale <philipl@mail.utexas.edu>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: bluez-devel@lists.sourceforge.net
Subject: Observations from mx-5000 bluetooth keyboard + mouse combo
Content-Type: multipart/mixed;
 boundary="------------000206080001000808010207"
List-ID: <bluez-devel.lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------000206080001000808010207
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Marcel,

I originally sent these observations at the end of april but
you were busy at that time and I guess it passed by without
you noticing.

0) Everything works fine in HID mode. All the buttons on the mouse
   and keyboard work correctly at the input level as reported by evtest.

1) The patch to hid2hci.c that Trevor Joynson provided and which was
incorporated is not correct - and this is consistent with the reported
experience of other people with the di novo laser desktop combo.

- the 0x0b02 device is the usb hub itself and it is not the right thing
  to attempt to switch to hci mode. Rather, you try to switch the HID
  devices themselves. In the case of the mx-5000, the hid devices are
  0xc70a (the mouse) and 0xc70e (the keyboard). I belive that the
  di novo devices are 0xc70b and 0xc70c.

- Once switched, the hci device appears as 0xc709 - the same as in the
  di novo receiver.

2) I did not need Trevor's hci_usb patch, which Marcel did not see a
   need for either.

3) I applied the mh patches (now 2.6.16-mh3) to get HID report mode.

4) In HID report mode, the HWHEEL is mangled at some point. Instead of
   reporting a usage of 0x10036, it reports 0xC0238, causing it to be
   marked as an unknown button. I put a hack into hidp's hid.c to catch
   this case and rewrite the usage. The rest of the characteristics seem
   to be correct and the horizontal scrolling works correctly.

   I don't know if the mouse is just reporting the wrong value or if the
   usage is getting mangled somewhere in the stack.

5) The keyboard also sees modified usages, but this is definitely in the
   hidp driver:

   This step is in hidinput_configure_usage:

   while (usage->code <= max && test_and_set_bit(usage->code, bit)) {
       usage->code = find_next_zero_bit(bit, max + 1, usage->code);
   }

   eg: It mangles KEY_UNDO (131) into KEY_SENDFILE (145) which doesn't
   seem very useful.

   It's not the end of the world if the desktop environment/application
   supports configurable keybindings, but it's still not correct.

6) The keyboard has HID consumer reports that hidp doesn't know about.
   So, I added entries for them in hidinput_configure_usage and now they
   work fine.

7) Not a driver matter, but the keyboard features keys that generate no
   bluetooth traffic, at least as far as hcidump is concerned. My
   conclusion was that these buttons are only activated by firmware that
   you download to the keyboard in windows - but I currently have the
   basic firmware running on the keyboard (Gives me data/time/temp) and
   none of these keys work in linux. Philip Lawatsch thinks that it's
   not quite as simple as I describe - he says the firmware files are
   too small to actually include code that would program the buttons
   at a low level. These non-functional buttons also don't work in HID
   proxy mode, in case you were wondering.

8) No idea how extra stuff like battery levels and tweaking the cruise
   control buttons works. Tools like locomo don't work (and they don't
   work with the mx900 either). Could such things still be done through
   the HID endpoints in HCI mode or would they have to be done at the
   bluetooth level? If it's at the bluetooth level, should we see an
   explicit service of somesort listed?

I've attached the hidp patch that I'm using the fix the HWHEEL and the
extra keyboard events, but this is hardly directly applicable. If
nothing else, a proper quirks infrastructure is needed for the HWHEEL
handling.

Thanks,

--phil

--------------000206080001000808010207
Content-Type: text/x-patch;
 name="phil-bt-hid.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="phil-bt-hid.diff"

--- linux/net/bluetooth/hidp/hid.c.org	2006-06-06 22:48:24.000000000 -0700
+++ linux/net/bluetooth/hidp/hid.c	2006-06-06 22:47:59.000000000 -0700
@@ -1137,6 +1137,10 @@
 	int is_abs = 0;
 	unsigned long *bit;
 
+	if (usage->hid == 0xC0238) {
+		usage->hid = 0x10036;
+	}
+
 	switch (usage->hid & HID_USAGE_PAGE) {
 
 		case HID_UP_KEYBOARD:
@@ -1291,10 +1295,20 @@
 				case 0x0e9: usage->code = KEY_VOLUMEUP;		break;
 				case 0x0ea: usage->code = KEY_VOLUMEDOWN;	break;
 
-				case 0x183: usage->code = KEY_CONFIG;		break;
+//				case 0x183: usage->code = KEY_CONFIG;		break;
+			case 0x183: usage->code = KEY_MEDIA;		break;
+			case 0x184: usage->code = KEY_PROG1;		break;
+			case 0x186: usage->code = KEY_PROG2;		break;
+			case 0x188: usage->code = KEY_PROG3;		break;
 				case 0x18a: usage->code = KEY_MAIL;		break;
 				case 0x192: usage->code = KEY_CALC;		break;
 				case 0x194: usage->code = KEY_FILE;		break;
+			case 0x1b6: usage->code = KEY_DOCUMENTS;	break;
+			case 0x1b7: usage->code = KEY_SOUND;		break;
+			case 0x1b8: usage->code = KEY_CAMERA;		break;
+			case 0x1bc: usage->code = KEY_CHAT;		break;
+			case 0x207: usage->code = KEY_SAVE;		break;
+			case 0x208: usage->code = KEY_PRINT;		break;
 				case 0x21a: usage->code = KEY_UNDO;		break;
 				case 0x21b: usage->code = KEY_COPY;		break;
 				case 0x21c: usage->code = KEY_CUT;		break;
@@ -1308,6 +1322,11 @@
 				case 0x227: usage->code = KEY_REFRESH;		break;
 				case 0x22a: usage->code = KEY_BOOKMARKS;	break;
 
+			case 0x22d: usage->code = KEY_KBDILLUMUP;	break;
+			case 0x22e: usage->code = KEY_KBDILLUMDOWN;	break;
+			case 0x230: usage->code = KEY_KBDILLUMTOGGLE;	break;
+			case 0x279: usage->code = KEY_REDO;		break;
+
 				default:    usage->code = KEY_UNKNOWN;		break;
 			}
 
@@ -1389,7 +1408,7 @@
 		default:
 		unknown:
 			resolv_usage(usage->hid);
-
+return;
 			if (field->report_size == 1) {
 
 				if (field->report->type == HID_OUTPUT_REPORT) {

--------------000206080001000808010207--
