Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: John Keeping <john@metanate.com>
To: linux-bluetooth@vger.kernel.org
Cc: John Keeping <john@metanate.com>,
	Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH] tools/avinfo: fix big endian build
Date: Wed, 24 Feb 2016 13:57:38 +0000
Message-Id: <1456322258-28742-1-git-send-email-john@metanate.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Commit 101b439 (tools/avinfo: Add partial support for Sony LDAC) added a
new a2dp_ldac_t structure but only inside a little endian ifdef.  Add
the same structure in the big endian code.

The structure definition doesn't differ for the big/little endian cases
but if the unknown fields are discovered in the future it might, so a
copy is added rather than pulling the existing definition below the
endif.
---
 profiles/audio/a2dp-codecs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/profiles/audio/a2dp-codecs.h b/profiles/audio/a2dp-codecs.h
index e9da0bf..4fb5c0c 100644
--- a/profiles/audio/a2dp-codecs.h
+++ b/profiles/audio/a2dp-codecs.h
@@ -234,6 +234,11 @@ typedef struct {
 	uint8_t channel_mode:4;
 } __attribute__ ((packed)) a2dp_aptx_t;
 
+typedef struct {
+	a2dp_vendor_codec_t info;
+	uint8_t unknown[2];
+} __attribute__ ((packed)) a2dp_ldac_t;
+
 #else
 #error "Unknown byte order"
 #endif
-- 
2.7.0.226.gfe986fe

