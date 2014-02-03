Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2 5/6] android/hal-audio: Fix RTP sequence numbers
Date: Mon, 3 Feb 2014 17:55:48 +0100
Message-ID: <1391446549-31455-6-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1391446549-31455-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1391446549-31455-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-audio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index be17c76..6439880 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -458,7 +458,6 @@ static ssize_t sbc_write_data(void *codec_data, const void *buffer,
 
 	mp->hdr.v = 2;
 	mp->hdr.pt = 1;
-	mp->hdr.sequence_number = htons(sbc_data->seq++);
 	mp->hdr.ssrc = htonl(1);
 	mp->payload.frame_count = 0;
 
@@ -488,6 +487,8 @@ static ssize_t sbc_write_data(void *codec_data, const void *buffer,
 				bytes == consumed ||
 				mp->payload.frame_count ==
 							MAX_FRAMES_IN_PAYLOAD) {
+			mp->hdr.sequence_number = htons(sbc_data->seq++);
+
 			ret = write_media_packet(fd, sbc_data, mp, encoded);
 			if (ret < 0)
 				return ret;
-- 
1.8.5.3

