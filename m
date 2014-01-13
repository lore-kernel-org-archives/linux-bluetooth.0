Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH] android/a2dp: Fix buffer size calculation for codec caps
Date: Mon, 13 Jan 2014 13:53:47 +0100
Message-ID: <1389617627-4617-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/a2dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index 05edd71..1f7678a 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -415,7 +415,7 @@ static gboolean sep_getcap_ind(struct avdtp *session,
 	service = avdtp_service_cap_new(AVDTP_MEDIA_TRANSPORT, NULL, 0);
 	*caps = g_slist_append(*caps, service);
 
-	codec = g_malloc0(sizeof(*codec) + sizeof(cap->len));
+	codec = g_malloc0(sizeof(*codec) + cap->len);
 	codec->media_type = AVDTP_MEDIA_TYPE_AUDIO;
 	codec->media_codec_type = endpoint->codec;
 	memcpy(codec->data, cap->data, cap->len);
-- 
1.8.5.2

