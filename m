Return-Path: <cyrus@holtmann.org>
From: Rafael Fonseca <fonsecasantos.rafael@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: "Rafael F. Santos" <fonsecasantos.rafael@gmail.com>
Subject: [PATCH] Fix spelling errors.
Date: Tue,  3 Apr 2012 10:16:22 -0300
Message-Id: <1333458982-8661-1-git-send-email-fonsecasantos.rafael@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As my first attempt to send a patch to the project, I have used the
codespell tool (https://github.com/lucasdemarchi/codespell) to search for
spelling errors in the code.

If the patch is ok, could someone apply it, please?

Signed-off-by: Rafael F. Santos <fonsecasantos.rafael@gmail.com>
---
 audio/telephony-maemo5.c |    2 +-
 audio/telephony-maemo6.c |    2 +-
 audio/unix.c             |    2 +-
 mgmt/main.c              |    2 +-
 sbc/sbc.h                |    2 +-
 src/uinput.h             |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/audio/telephony-maemo5.c b/audio/telephony-maemo5.c
index 2832062..49230f1 100644
--- a/audio/telephony-maemo5.c
+++ b/audio/telephony-maemo5.c
@@ -1014,7 +1014,7 @@ static void handle_call_status(DBusMessage *msg, const char *call_path)
 					DBUS_TYPE_UINT32, &cause_type,
 					DBUS_TYPE_UINT32, &cause,
 					DBUS_TYPE_INVALID)) {
-		error("Unexpected paramters in Instance.CallStatus() signal");
+		error("Unexpected parameters in Instance.CallStatus() signal");
 		return;
 	}
 
diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
index dd75422..943f1e1 100644
--- a/audio/telephony-maemo6.c
+++ b/audio/telephony-maemo6.c
@@ -1386,7 +1386,7 @@ static void handle_call_status(DBusMessage *msg, const char *call_path)
 					DBUS_TYPE_UINT32, &cause_type,
 					DBUS_TYPE_UINT32, &cause,
 					DBUS_TYPE_INVALID)) {
-		error("Unexpected paramters in Instance.CallStatus() signal");
+		error("Unexpected parameters in Instance.CallStatus() signal");
 		return;
 	}
 
diff --git a/audio/unix.c b/audio/unix.c
index 5199831..6e970f8 100644
--- a/audio/unix.c
+++ b/audio/unix.c
@@ -534,7 +534,7 @@ static int a2dp_append_codec(struct bt_get_capabilities_rsp *rsp,
 
 	space_left = BT_SUGGESTED_BUFFER_SIZE - rsp->h.length;
 
-	/* endianess prevent direct cast */
+	/* endianness prevents direct cast */
 	if (codec_cap->media_codec_type == A2DP_CODEC_SBC) {
 		struct sbc_codec_cap *sbc_cap = (void *) codec_cap;
 		sbc_capabilities_t *sbc = (void *) codec;
diff --git a/mgmt/main.c b/mgmt/main.c
index 90d43e3..3481e14 100644
--- a/mgmt/main.c
+++ b/mgmt/main.c
@@ -1739,7 +1739,7 @@ static void did_rsp(int mgmt_sk, uint16_t op, uint16_t id, uint8_t status,
 		exit(EXIT_FAILURE);
 	}
 
-	printf("Device ID succesfully set\n");
+	printf("Device ID successfully set\n");
 
 	exit(EXIT_SUCCESS);
 }
diff --git a/sbc/sbc.h b/sbc/sbc.h
index 2f830ad..f7ec99d 100644
--- a/sbc/sbc.h
+++ b/sbc/sbc.h
@@ -60,7 +60,7 @@ extern "C" {
 #define SBC_SB_4		0x00
 #define SBC_SB_8		0x01
 
-/* Data endianess */
+/* Data endianness */
 #define SBC_LE			0x00
 #define SBC_BE			0x01
 
diff --git a/src/uinput.h b/src/uinput.h
index e83986b..20e0941 100644
--- a/src/uinput.h
+++ b/src/uinput.h
@@ -55,7 +55,7 @@ extern "C" {
 /*
  * Keys and buttons
  *
- * Most of the keys/buttons are modeled after USB HUT 1.12
+ * Most of the keys/buttons are modelled after USB HUT 1.12
  * (see http://www.usb.org/developers/hidpage).
  * Abbreviations in the comments:
  * AC - Application Control
-- 
1.7.8.5

