Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH v2 BlueZ 17/27] alert: Implement MuteOnce command
Date: Thu, 27 Sep 2012 14:36:26 -0400
Message-Id: <1348770996-12236-18-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1348770996-12236-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1348509661-15967-1-git-send-email-anderson.lizardo@openbossa.org>
 <1348770996-12236-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

MuteOnce() is called by BlueZ to instruct the agent to mute the ringer
during a incoming call.
---
 profiles/alert/server.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index e025cb2..64458f4 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -76,6 +76,12 @@ enum {
 	NOTIFY_UNREAD_CAT,
 };
 
+enum {
+	RINGER_SILENT_MODE = 1,
+	RINGER_MUTE_ONCE,
+	RINGER_CANCEL_SILENT_MODE,
+};
+
 /* Ringer Setting characteristic values */
 enum {
 	RINGER_SILENT,
@@ -461,6 +467,25 @@ static uint8_t ringer_cp_write(struct attribute *a,
 {
 	DBG("a = %p", a);
 
+	if (a->len > 1) {
+		DBG("Invalid command size (%zu)", a->len);
+		return 0;
+	}
+
+	switch (a->data[0]) {
+	case RINGER_SILENT_MODE:
+		DBG("Silent Mode");
+		break;
+	case RINGER_MUTE_ONCE:
+		DBG("Mute Once");
+		break;
+	case RINGER_CANCEL_SILENT_MODE:
+		DBG("Cancel Silent Mode");
+		break;
+	default:
+		DBG("Invalid command (0x%02x)", a->data[0]);
+	}
+
 	return 0;
 }
 
-- 
1.7.9.5

