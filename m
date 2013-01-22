Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ 1/2] avctp: Create ignore quirk
Date: Tue, 22 Jan 2013 15:18:22 -0300
Message-Id: <1358878703-8100-2-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1358878703-8100-1-git-send-email-jprvita@openbossa.org>
References: <1358878703-8100-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Create a quirk to be able to accept and trow away certain keys.
---
 profiles/audio/avctp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 61890cc..f7e607e 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -58,7 +58,8 @@
 #include "avctp.h"
 #include "avrcp.h"
 
-#define QUIRK_NO_RELEASE 1 << 0
+#define QUIRK_NO_RELEASE	1 << 0
+#define QUIRK_IGNORE		1 << 1
 
 /* Message types */
 #define AVCTP_COMMAND		0
@@ -287,6 +288,11 @@ static size_t handle_panel_passthrough(struct avctp *session,
 
 		key_quirks = session->key_quirks[key_map[i].avc];
 
+		if (key_quirks & QUIRK_IGNORE) {
+			DBG("AV/C: ignoring %s %s", key_map[i].name, status);
+			break;
+		}
+
 		if (key_quirks & QUIRK_NO_RELEASE) {
 			if (!pressed) {
 				DBG("AV/C: Ignoring release");
-- 
1.7.11.7

