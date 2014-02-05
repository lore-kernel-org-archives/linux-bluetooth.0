Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] audio/AVCTP: Lookup key name from key_map table
Date: Wed,  5 Feb 2014 16:24:32 +0200
Message-Id: <1391610272-12991-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1391610272-12991-1-git-send-email-luiz.dentz@gmail.com>
References: <1391610272-12991-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The key_map table already contain the key name.
---
 android/avctp.c        | 36 ++++++++----------------------------
 profiles/audio/avctp.c | 38 +++++++++-----------------------------
 2 files changed, 17 insertions(+), 57 deletions(-)

diff --git a/android/avctp.c b/android/avctp.c
index f7544a2..1e414d1 100644
--- a/android/avctp.c
+++ b/android/avctp.c
@@ -1136,36 +1136,16 @@ int avctp_send_browsing_req(struct avctp *session,
 	return 0;
 }
 
-static char *op2str(uint8_t op)
+static const char *op2str(uint8_t op)
 {
-	switch (op & 0x7f) {
-	case AVC_VOLUME_UP:
-		return "VOLUME UP";
-	case AVC_VOLUME_DOWN:
-		return "VOLUME DOWN";
-	case AVC_MUTE:
-		return "MUTE";
-	case AVC_PLAY:
-		return "PLAY";
-	case AVC_STOP:
-		return "STOP";
-	case AVC_PAUSE:
-		return "PAUSE";
-	case AVC_RECORD:
-		return "RECORD";
-	case AVC_REWIND:
-		return "REWIND";
-	case AVC_FAST_FORWARD:
-		return "FAST FORWARD";
-	case AVC_EJECT:
-		return "EJECT";
-	case AVC_FORWARD:
-		return "FORWARD";
-	case AVC_BACKWARD:
-		return "BACKWARD";
-	default:
-		return "UNKNOWN";
+	int i;
+
+	for (i = 0; key_map[i].name != NULL; i++) {
+		if ((op & 0x7F) == key_map[i].avc)
+			return key_map[i].name;
 	}
+
+	return "UNKNOWN";
 }
 
 static int avctp_passthrough_press(struct avctp *session, uint8_t op)
diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index ae142bd..28c7685 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -1610,36 +1610,16 @@ int avctp_send_browsing_req(struct avctp *session,
 	return 0;
 }
 
-static char *op2str(uint8_t op)
-{
-	switch (op & 0x7f) {
-	case AVC_VOLUME_UP:
-		return "VOLUME UP";
-	case AVC_VOLUME_DOWN:
-		return "VOLUME DOWN";
-	case AVC_MUTE:
-		return "MUTE";
-	case AVC_PLAY:
-		return "PLAY";
-	case AVC_STOP:
-		return "STOP";
-	case AVC_PAUSE:
-		return "PAUSE";
-	case AVC_RECORD:
-		return "RECORD";
-	case AVC_REWIND:
-		return "REWIND";
-	case AVC_FAST_FORWARD:
-		return "FAST FORWARD";
-	case AVC_EJECT:
-		return "EJECT";
-	case AVC_FORWARD:
-		return "FORWARD";
-	case AVC_BACKWARD:
-		return "BACKWARD";
-	default:
-		return "UNKNOWN";
+static const char *op2str(uint8_t op)
+{
+	int i;
+
+	for (i = 0; key_map[i].name != NULL; i++) {
+		if ((op & 0x7F) == key_map[i].avc)
+			return key_map[i].name;
 	}
+
+	return "UNKNOWN";
 }
 
 static int avctp_passthrough_press(struct avctp *session, uint8_t op)
-- 
1.8.5.3

