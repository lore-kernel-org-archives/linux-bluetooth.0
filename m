Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Juha =?iso-8859-1?B?WXJq9mzk?= <juha.yrjola@iki.fi>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20050119224400.GA7881@salvia.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
Subject: [Bluez-devel] [PATCH] Fix too-many-keys-pressed error in hidp/core.c
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
Date: Thu, 20 Jan 2005 00:44:00 +0200


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,

Attached is a patch which fixes the problem of keys repeating when too many
keys pressed at the same time (e.g. when typing quickly).  This often
results in "mount" becoming "mouount". =)

It seems that the BT keyboard sends a HID report with the keys all set to
0x01 if too many keys were pressed at the same time.  This confused the
previous report handling logic.

Verified working on a Logitech diNovo keyboard.

Signed-off-by: Juha Yrjölä <juha.yrjola@iki.fi>

Oh yeah, the patch is against 2.6.10-mh1.

Cheers,
Juha

--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="too-many-keys-patch.diff"

--- net/bluetooth/hidp/core.c.old	2005-01-20 00:08:05.000000000 +0200
+++ net/bluetooth/hidp/core.c	2005-01-20 00:32:18.000000000 +0200
@@ -175,6 +175,15 @@
 		for (i = 0; i < 8; i++)
 			input_report_key(dev, hidp_keycode[i + 224], (udata[0] >> i) & 1);
 
+		/* If all the key codes have been set to 0x01, it means
+		 * too many keys were pressed at the same time */
+		for (i = 2; i < 8; i++) {
+			if (udata[i] != 0x01)
+				break;
+		}
+		if (i == 8)
+			break;
+
 		for (i = 2; i < 8; i++) {
 			if (keys[i] > 3 && memscan(udata + 2, keys[i], 6) == udata + 8) {
 				if (hidp_keycode[keys[i]])

--opJtzjQTFsWo+cga--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
