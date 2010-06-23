Return-Path: <cyrus@holtmann.org>
From: harri.mahonen@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Harri Mahonen <harri.mahonen@gmail.com>
Subject: [PATCH] audio: fix memory leak with typefinding
Date: Wed, 23 Jun 2010 22:10:06 +0300
Message-Id: <1277320206-6969-1-git-send-email-harri.mahonen@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Harri Mahonen <harri.mahonen@gmail.com>

sbc structure gets leaked each time when there is no data or SBC
syncword, because sbc_finalize is not called. Call sbc_init after
checking the data for syncword.

Signed-off-by: Harri Mahonen <harri.mahonen@gmail.com>
---
 audio/gstbluetooth.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/audio/gstbluetooth.c b/audio/gstbluetooth.c
index 26dd4a5..11aefd7 100644
--- a/audio/gstbluetooth.c
+++ b/audio/gstbluetooth.c
@@ -50,10 +50,10 @@ static void sbc_typefind(GstTypeFind *tf, gpointer ignore)
 	sbc_t sbc;
 	guint8 *data = gst_type_find_peek(tf, 0, 32);
 
-	if (sbc_init(&sbc, 0) < 0)
+	if (data == NULL || *data != 0x9c)	/* SBC syncword */
 		return;
 
-	if (data == NULL || *data != 0x9c)	/* SBC syncword */
+	if (sbc_init(&sbc, 0) < 0)
 		return;
 
 	aux = g_new(guint8, 32);
-- 
1.7.0.4

