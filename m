Return-Path: <cyrus@holtmann.org>
From: harri.mahonen@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Harri Mahonen <harri.mahonen@gmail.com>
Subject: [PATCH v3] audio: fix memory leak with typefinding
Date: Thu, 24 Jun 2010 18:01:12 +0300
Message-Id: <1277391672-10563-1-git-send-email-harri.mahonen@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Harri Mahonen <harri.mahonen@gmail.com>

Each time sbc_typefind is called and there is no syncword, sbc_finalize
never gets called. Instead of hardcoded syncword check, rely on
sbc_parse to do it properly.
---
 audio/gstbluetooth.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/audio/gstbluetooth.c b/audio/gstbluetooth.c
index 26dd4a5..3bc0690 100644
--- a/audio/gstbluetooth.c
+++ b/audio/gstbluetooth.c
@@ -50,21 +50,25 @@ static void sbc_typefind(GstTypeFind *tf, gpointer ignore)
 	sbc_t sbc;
 	guint8 *data = gst_type_find_peek(tf, 0, 32);
 
-	if (sbc_init(&sbc, 0) < 0)
+	if (data == NULL)
 		return;
 
-	if (data == NULL || *data != 0x9c)	/* SBC syncword */
+	if (sbc_init(&sbc, 0) < 0)
 		return;
 
 	aux = g_new(guint8, 32);
 	memcpy(aux, data, 32);
-	sbc_parse(&sbc, aux, 32);
-	g_free(aux);
-	caps = gst_sbc_parse_caps_from_sbc(&sbc);
-	sbc_finish(&sbc);
 
+	if (sbc_parse(&sbc, aux, 32) < 0)
+		goto done;
+
+	caps = gst_sbc_parse_caps_from_sbc(&sbc);
 	gst_type_find_suggest(tf, GST_TYPE_FIND_POSSIBLE, caps);
 	gst_caps_unref(caps);
+
+done:
+	g_free(aux);
+	sbc_finish(&sbc);
 }
 
 static gchar *sbc_exts[] = { "sbc", NULL };
-- 
1.7.0.4

