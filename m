Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 09/16] AVCTP: Add proper prefix to AVC passthrough codes
Date: Mon, 15 Oct 2012 16:05:29 +0200
Message-Id: <1350309936-31588-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1350309936-31588-1-git-send-email-luiz.dentz@gmail.com>
References: <1350309936-31588-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 audio/avctp.c   | 22 +++++++++++-----------
 audio/avctp.h   | 24 ++++++++++++------------
 audio/control.c |  4 ++--
 3 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/audio/avctp.c b/audio/avctp.c
index c72d2d5..b982a3b 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -178,13 +178,13 @@ static struct {
 	uint8_t avc;
 	uint16_t uinput;
 } key_map[] = {
-	{ "PLAY",		PLAY_OP,		KEY_PLAYCD },
-	{ "STOP",		STAVC_OP_OP,		KEY_STOPCD },
-	{ "PAUSE",		PAUSE_OP,		KEY_PAUSECD },
-	{ "FORWARD",		FORWARD_OP,		KEY_NEXTSONG },
-	{ "BACKWARD",		BACKWARD_OP,		KEY_PREVIOUSSONG },
-	{ "REWIND",		REWIND_OP,		KEY_REWIND },
-	{ "FAST FORWARD",	FAST_FORWARD_OP,	KEY_FASTFORWARD },
+	{ "PLAY",		AVC_PLAY,		KEY_PLAYCD },
+	{ "STOP",		AVC_STOP,		KEY_STOPCD },
+	{ "PAUSE",		AVC_PAUSE,		KEY_PAUSECD },
+	{ "FORWARD",		AVC_FORWARD,		KEY_NEXTSONG },
+	{ "BACKWARD",		AVC_BACKWARD,		KEY_PREVIOUSSONG },
+	{ "REWIND",		AVC_REWIND,		KEY_REWIND },
+	{ "FAST FORWARD",	AVC_FAST_FORWARD,	KEY_FASTFORWARD },
 	{ NULL }
 };
 
@@ -677,10 +677,10 @@ static void init_uinput(struct avctp *session)
 
 	device_get_name(dev->btd_dev, name, sizeof(name));
 	if (g_str_equal(name, "Nokia CK-20W")) {
-		session->key_quirks[FORWARD_OP] |= QUIRK_NO_RELEASE;
-		session->key_quirks[BACKWARD_OP] |= QUIRK_NO_RELEASE;
-		session->key_quirks[PLAY_OP] |= QUIRK_NO_RELEASE;
-		session->key_quirks[PAUSE_OP] |= QUIRK_NO_RELEASE;
+		session->key_quirks[AVC_FORWARD] |= QUIRK_NO_RELEASE;
+		session->key_quirks[AVC_BACKWARD] |= QUIRK_NO_RELEASE;
+		session->key_quirks[AVC_PLAY] |= QUIRK_NO_RELEASE;
+		session->key_quirks[AVC_PAUSE] |= QUIRK_NO_RELEASE;
 	}
 
 	ba2str(&session->dst, address);
diff --git a/audio/avctp.h b/audio/avctp.h
index 41cf6c5..c00a3fc 100644
--- a/audio/avctp.h
+++ b/audio/avctp.h
@@ -49,18 +49,18 @@
 #define AVC_SUBUNIT_PANEL		0x09
 
 /* operands in passthrough commands */
-#define VOL_UP_OP			0x41
-#define VOL_DOWN_OP			0x42
-#define MUTE_OP				0x43
-#define PLAY_OP				0x44
-#define STAVC_OP_OP			0x45
-#define PAUSE_OP			0x46
-#define RECORD_OP			0x47
-#define REWIND_OP			0x48
-#define FAST_FORWARD_OP			0x49
-#define EJECT_OP			0x4a
-#define FORWARD_OP			0x4b
-#define BACKWARD_OP			0x4c
+#define AVC_VOLUME_UP			0x41
+#define AVC_VOLUME_DOWN			0x42
+#define AVC_MUTE			0x43
+#define AVC_PLAY			0x44
+#define AVC_STOP			0x45
+#define AVC_PAUSE			0x46
+#define AVC_RECORD			0x47
+#define AVC_REWIND			0x48
+#define AVC_FAST_FORWARD		0x49
+#define AVC_EJECT			0x4a
+#define AVC_FORWARD			0x4b
+#define AVC_BACKWARD			0x4c
 
 struct avctp;
 
diff --git a/audio/control.c b/audio/control.c
index 5ec8ca3..926bdfb 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -136,7 +136,7 @@ static DBusMessage *volume_up(DBusConnection *conn, DBusMessage *msg,
 	if (!control->target)
 		return btd_error_not_supported(msg);
 
-	err = avctp_send_passthrough(control->session, VOL_UP_OP);
+	err = avctp_send_passthrough(control->session, AVC_VOLUME_UP);
 	if (err < 0)
 		return btd_error_failed(msg, strerror(-err));
 
@@ -156,7 +156,7 @@ static DBusMessage *volume_down(DBusConnection *conn, DBusMessage *msg,
 	if (!control->target)
 		return btd_error_not_supported(msg);
 
-	err = avctp_send_passthrough(control->session, VOL_DOWN_OP);
+	err = avctp_send_passthrough(control->session, AVC_VOLUME_DOWN);
 	if (err < 0)
 		return btd_error_failed(msg, strerror(-err));
 
-- 
1.7.11.4

