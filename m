Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Vesa Halttunen <vesuri@jormas.com>
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="=-yMz7P6ETkL/3/jsmOANl"
Message-Id: <1087736028.19379.19.camel@pc.vesuri.net>
Mime-Version: 1.0
Subject: [Bluez-devel] Logitech Cordless Desktop Bluetooth (MX900 + Elite keyboard),
 bthid and a patch
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 20 Jun 2004 15:53:48 +0300


--=-yMz7P6ETkL/3/jsmOANl
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Hi,

I have a Logitech Cordless Desktop Bluetooth (an MX900 mouse and an
Elite keyboard). I've been using them in HCI mode by using hid2hci, hcid
and bthid. This setup has been working somewhat OK but I had a
problem: if I typed specific character sequences very rapidly - the
word "sources", for example, some characters got repeated and so that
"sources" came out as "sourceces". The behaviour was consistent.

Today I took a look at what is causing the problem. By debugging
parser.c I found out that when I type "ces" rapidly the device reports
input events for "c down", "ce down", then 6 times "key 1 down", then
"ce down", then "ces down"... Because the "key 1 down" event got mapped
into "no keys down" it caused the repetition of "ce".

I have no idea what the "key 1 down" event is supposed to be but I wrote
a small hack to get the problem fixed. What I'm doing is use -1 as a
special value for keys_down so that if keys_down == -1 the input event
will be ignored. If a "key 1 down" event is received I ignore the event
by using keys_down = 1.

I don't know if this solution makes any sense with any other keyboard
than this but it seems to work for me - no more duplicate characters.
If anyone knows what the strange "key 1 down" event is and knows a
better way to fix this I'm happy to hear about it. However, a patch
that works for me is attached to this message.

Regards,

-Vesa
-- 
            · Vesa Halttunen - http://www.jormas.com/~vesuri/ ·

--=-yMz7P6ETkL/3/jsmOANl
Content-Disposition: attachment; filename=bluez-utils2-hid-parser.c-vesuri-patch.diff
Content-Type: text/x-patch; name=bluez-utils2-hid-parser.c-vesuri-patch.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- parser.c	2004-06-20 15:30:49.000000000 +0300
+++ parser.c-vesuri	2004-06-20 15:30:24.000000000 +0300
@@ -158,8 +158,8 @@
 						gst.logical_min,
 						gst.logical_max,
 						gst.report_size);
-					if (local_ct && (val & RPT_VAR &&
-							usage++ == loc[k].usage_max ||
+					if (local_ct && ((val & RPT_VAR &&
+							usage++ == loc[k].usage_max) ||
 							!(val & RPT_VAR))) {
 						if (k < local_ct - 1)
 							k++;
@@ -375,10 +375,14 @@
 
 	case 0x0007:	/* Keyboard */
 		//any_keyboard = 1;
-		if (val && usage & 0xffff) {
-			butt = hid_to_linux[usage & 0xffff];
-			if (butt)
-				parser->key_down[parser->keys_down++] = butt;
+		if (val && (usage & 0xffff)) {
+			if ((usage & 0xffff) == 1) {
+				parser->keys_down = -1;
+			} else {
+				butt = hid_to_linux[usage & 0xffff];
+				if (butt)
+					parser->key_down[parser->keys_down++] = butt;
+			}
 		}
 		return;
 
@@ -494,7 +498,7 @@
 	struct hid_report *r = NULL;
 	struct hid_field *f;
 	int prev_key_down[32];
-	int prev_keys_down;
+	int prev_keys_down = 0;
 
 	if (!parser)
 		return -ENODEV;
@@ -519,9 +523,12 @@
 		return -EINVAL;
 	}
 
-	for (i = 0; i < parser->keys_down; i++)
-		prev_key_down[i] = parser->key_down[i];
-	prev_keys_down = parser->keys_down;
+	if(parser->keys_down >= 0) {
+		for (i = 0; i < parser->keys_down; i++) {
+			prev_key_down[i] = parser->key_down[i];
+		}
+		prev_keys_down = parser->keys_down;
+	}
 	parser->keys_down = 0;
 
 	for (i = 0; i < r->num_fields; i++) {

--=-yMz7P6ETkL/3/jsmOANl--



-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
