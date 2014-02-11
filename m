Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 2/7] android/tester: Update SDP PDU after UUID change
Date: Tue, 11 Feb 2014 14:32:27 -0400
Message-Id: <1392143552-11395-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1392143552-11395-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1392143552-11395-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now it is expected to receive a 16-bit UUID for PNP_INFO.
---
 android/android-tester.c |   14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 870ad8d..d635732 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -3307,16 +3307,10 @@ static void hid_ctrl_connect_cb(uint16_t handle, uint16_t cid, void *user_data)
 
 static const uint8_t did_req_pdu[] = { 0x06, /* PDU id */
 			0x00, 0x00, /* Transaction id */
-			0x00, 0x1d, /* Req length */
-			0x35, 0x11, /* Attributes length */
-			0x1c, 0x00, 0x00, 0x12, 0x00, 0x00, 0x00, 0x10, 0x00,
-			0x80, 0x00, 0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb, 0xff,
-			0xff, 0x35, 0x05, 0x0a, 0x00, 0x00, 0xff, 0xff, 0x00,
-			0x06, 0x00, 0x01, 0x00, 0x1d, 0x35, 0x11, 0x1c, 0x00,
-			0x00, 0x11, 0x24, 0x00, 0x00, 0x10, 0x00, 0x80, 0x00,
-			0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb, 0xff, 0xff, 0x35,
-			0x05, 0x0a, 0x00, 0x0, 0xff, 0xff,
-			0x00 }; /* no continuation */
+			0x00, 0x0f, /* Req length */
+			0x35, 0x03, /* Attributes length */
+			0x19, 0x12, 0x00, 0xff, 0xff, 0x35, 0x05, 0x0a, 0x00,
+			0x00, 0xff, 0xff, 0x00 }; /* no continuation */
 
 static const uint8_t did_rsp_pdu[] = { 0x07, /* PDU id */
 			0x00, 0x00, /* Transaction id */
-- 
1.7.9.5

