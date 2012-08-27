Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [RFC BlueZ 18/22] alert: Implement MuteOnce command
Date: Mon, 27 Aug 2012 13:12:02 -0400
Message-Id: <1346087526-15107-19-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1346087526-15107-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1346087526-15107-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/alert/server.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index bdf13ee..fcbd5aa 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -73,6 +73,12 @@ enum {
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
@@ -460,6 +466,25 @@ static uint8_t ringer_cp_write(struct attribute *a,
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

