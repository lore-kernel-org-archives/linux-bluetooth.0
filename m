Return-Path: <cyrus@holtmann.org>
From: David Stockwell <dstockwell@frequency-one.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] AVRCP: Add Passthrough Signal
Date: Tue, 23 Aug 2011 22:27:11 -0500
Cc: lucas.demarchi@profusion.mobi, luiz.dentz@gmail.com,
	johan.hedberg@gmail.com
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201108232227.12124.dstockwell@frequency-one.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

AVRCP: Add Passthrough Signal

Send Passthrough signal, not only for simple keystrokes,
but especially for Vendor Unique key, passing company-id
and vendor-unique string as well.
---
 audio/control.c     |   90 
+++++++++++++++++++++++++++++++++++++++++++--------
 doc/control-api.txt |   14 +++-----
 2 files changed, 81 insertions(+), 23 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index dd2930c..fcaad7c 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -106,6 +106,8 @@
 #define FORWARD_OP		0x4b
 #define BACKWARD_OP		0x4c
 
+#define VENDOR_UNIQUE_OP	0x7E
+
 /* Company IDs for vendor dependent commands */
 #define IEEEID_BTSIG		0x001958
 
@@ -515,28 +517,88 @@ static void send_key(int fd, uint16_t key, int pressed)
 	send_event(fd, EV_SYN, SYN_REPORT, 0);
 }
 
+/**
+ *	handle_panel_passthrough:
+ *
+ *	Handles AVRCP 1.0+ PASSTHROUGH command, passes the keystroke to uinput.
+ *
+ *	Added a Passthrough signal, with the key state and the optional
+ *	following company_id and vendor-unique message.
+ */
+
 static void handle_panel_passthrough(struct control *control,
-					const unsigned char *operands,
+					const uint8_t *operands,
 					int operand_count)
 {
 	const char *status;
-	int pressed, i;
-
-	if (operand_count == 0)
+	int i;
+	uint8_t key_pressed;
+	gboolean key_state;
+	uint32_t pass_company_id;
+	char *pass_string;
+	/*
+	 * operands[1] is operation_data_field_length (AV/C Panel Specification
+	 * v1.23, sect 9.4.5). Should always be present, even if zero.
+	 */
+	if (operand_count < 2)
 		return;
 
-	if (operands[0] & 0x80) {
-		status = "released";
-		pressed = 0;
+	key_pressed = operands[0] & 0x7F;
+
+	/* If key is pressed, key state bit is zero (AVRCP v13r00 p89). */
+	key_state = ((operands[0] & 0x80) == 0);
+	status = key_state ? "pressed" : "released";
+
+	DBG("Passthrough Key: %x %s", key_pressed, status);
+
+	if (key_pressed == VENDOR_UNIQUE_OP) {
+		if (operands[1] == 0 || operand_count < 5) {
+			pass_company_id = 0;
+			pass_string = g_malloc0(1);
+			DBG("Passthrough: No Company_ID or String");
+		} else if (operands[1] == 3 && operand_count == 5) {
+			pass_company_id = get_company_id(operands + 2);
+			pass_string = g_malloc0(1);
+			DBG("Passthrough Company_ID: %06X String: <none>",
+						pass_company_id);
+		} else if (operands[1] > 3 &&
+					operand_count == operands[1] + 2) {
+			pass_company_id = get_company_id(operands + 2);
+			pass_string = g_strndup((gchar *) operands + 5,
+							operands[1] - 3);
+			DBG("Passthrough Company_ID: %06X String: %s",
+						pass_company_id, pass_string);
+		} else { /* op_length does not match operand_count */
+			DBG("Passthrough: Malformed message");
+			DBG("op_len %u, op_cnt %u", operands[1], operand_count);
+			pass_company_id = 0;
+			pass_string = g_malloc0(1);
+		}
 	} else {
-		status = "pressed";
-		pressed = 1;
+		pass_company_id = 0;
+		pass_string = g_malloc0(1);
 	}
 
+	/*
+	 * Generate passthrough signal only if not BTSIG Company_ID.
+	 * For BTSIG, passthrough only for Group Navigation (unimplemented).
+	 */
+
+	if (pass_company_id != IEEEID_BTSIG)
+		g_dbus_emit_signal(control->dev->conn, control->dev->path,
+			   AUDIO_CONTROL_INTERFACE, "Passthrough",
+			   DBUS_TYPE_BYTE, &key_pressed,
+			   DBUS_TYPE_BOOLEAN, &key_state,
+			   DBUS_TYPE_UINT32, &pass_company_id,
+			   DBUS_TYPE_STRING, &pass_string,
+			   DBUS_TYPE_INVALID);
+
+	g_free(pass_string);
+
 	for (i = 0; key_map[i].name != NULL; i++) {
 		uint8_t key_quirks;
 
-		if ((operands[0] & 0x7F) != key_map[i].avrcp)
+		if (key_pressed != key_map[i].avrcp)
 			continue;
 
 		DBG("AVRCP: %s %s", key_map[i].name, status);
@@ -544,7 +606,7 @@ static void handle_panel_passthrough(struct control 
*control,
 		key_quirks = control->key_quirks[key_map[i].avrcp];
 
 		if (key_quirks & QUIRK_NO_RELEASE) {
-			if (!pressed) {
+			if (!key_state) {
 				DBG("AVRCP: Ignoring release");
 				break;
 			}
@@ -555,13 +617,12 @@ static void handle_panel_passthrough(struct control 
*control,
 			break;
 		}
 
-		send_key(control->uinput, key_map[i].uinput, pressed);
+		send_key(control->uinput, key_map[i].uinput, key_state);
 		break;
 	}
 
 	if (key_map[i].name == NULL)
-		DBG("AVRCP: unknown button 0x%02X %s",
-						operands[0] & 0x7F, status);
+		DBG("AVRCP: unknown button 0x%02X %s", key_pressed, status);
 }
 
 static unsigned int attr_get_max_val(uint8_t attr)
@@ -2291,6 +2352,7 @@ static GDBusSignalTable control_signals[] = {
 	{ "Connected",			"",	G_DBUS_SIGNAL_FLAG_DEPRECATED},
 	{ "Disconnected",		"",	G_DBUS_SIGNAL_FLAG_DEPRECATED},
 	{ "PropertyChanged",		"sv"	},
+	{ "Passthrough",		"ybus"	},
 	{ NULL, NULL }
 };
 
diff --git a/doc/control-api.txt b/doc/control-api.txt
index a7e5cbb..64ea5d3 100644
--- a/doc/control-api.txt
+++ b/doc/control-api.txt
@@ -55,18 +55,14 @@ Signals		Connected()
 			Sent when the AVRCP connection to the remote device
 			has been disconnected.
 
-		Passthrough(uint8 key, boolean state, int32 company_id,
+		Passthrough(uint8 key, boolean state, uint32 company_id,
 								string op_data)
 
-			Called when Passthrough command is received from
-			connected device.
+			Sent when Passthrough received from CT.
 
-			NOTE: according to the AV/C Subpanel Spec, company_id
-			and op_data are passed ONLY when the key is
-			"Vendor_Unique", or 0x7E.
-
-			When the key is NOT 0x7E, the signal returns
-			company_id=-1, and zero-length op_data.
+			Company_id and op_data returned only when key is 0x7E
+			(OP_VENDOR_UNIQUE).  Otherwise, returns zero for
+			company_id, and zero-length op_data.
 
 		VendorDependentReceived(string op_data)
 
-- 
1.7.3.4

