Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [RFC v2 1/6] lib: SCO voice setting support header
Date: Fri,  5 Jul 2013 17:46:42 +0200
Message-Id: <1373039207-20959-2-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1373039207-20959-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1373039207-20959-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Modify headers to enable support for changing SCO voice setting.
Corresponding commit implements functionality on kernel side.
---
 lib/bluetooth.h |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 48323f0..012fde4 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -104,6 +104,14 @@ struct bt_security {
  */
 #define BT_CHANNEL_POLICY_AMP_PREFERRED		2
 
+#define BT_VOICE		11
+struct bt_voice {
+	uint16_t setting;
+};
+
+#define BT_VOICE_TRANSPARENT			0x0003
+#define BT_VOICE_CVSD_16BIT			0x0060
+
 /* Connection and socket states */
 enum {
 	BT_CONNECTED = 1, /* Equal to TCP_ESTABLISHED to make net code happy */
-- 
1.7.9.5

