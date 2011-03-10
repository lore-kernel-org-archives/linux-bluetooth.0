Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH] Add indication/notification support to interactive gatttool
Date: Thu, 10 Mar 2011 16:26:46 -0300
Message-Id: <1299785206-15145-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/interactive.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/attrib/interactive.c b/attrib/interactive.c
index 232cf35..99e99c5 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -98,6 +98,41 @@ static void set_state(enum state st)
 	rl_redisplay();
 }
 
+static void events_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
+{
+	uint8_t opdu[ATT_MAX_MTU];
+	uint16_t handle, i, olen;
+
+	handle = att_get_u16(&pdu[1]);
+
+	printf("\n");
+	switch (pdu[0]) {
+	case ATT_OP_HANDLE_NOTIFY:
+		printf("Notification handle = 0x%04x value: ", handle);
+		break;
+	case ATT_OP_HANDLE_IND:
+		printf("Indication   handle = 0x%04x value: ", handle);
+		break;
+	default:
+		printf("Invalid opcode\n");
+		return;
+	}
+
+	for (i = 3; i < len; i++)
+		printf("%02x ", pdu[i]);
+
+	printf("\n");
+	rl_forced_update_display();
+
+	if (pdu[0] == ATT_OP_HANDLE_NOTIFY)
+		return;
+
+	olen = enc_confirmation(opdu, sizeof(opdu));
+
+	if (olen > 0)
+		g_attrib_send(attrib, 0, opdu[0], opdu, olen, NULL, NULL, NULL);
+}
+
 static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 {
 	if (err) {
@@ -107,6 +142,10 @@ static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 	}
 
 	attrib = g_attrib_new(iochannel);
+	g_attrib_register(attrib, ATT_OP_HANDLE_NOTIFY, events_handler,
+							attrib, NULL);
+	g_attrib_register(attrib, ATT_OP_HANDLE_IND, events_handler,
+							attrib, NULL);
 	set_state(STATE_CONNECTED);
 }
 
-- 
1.7.1

