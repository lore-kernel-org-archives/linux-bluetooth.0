Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 07/26] android/hal-audio: Send packets only when data were encoded
Date: Mon, 26 May 2014 15:16:33 +0200
Message-ID: <1401110212-11526-8-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Codec may not return encoded packet on every encode_mediapacket call,
i.e. in case there's not enough data it may buffer data and encode on
subsequent calls when enough data were provided. We need to make sure
media packet is written only in case somethind was encoded so we don't
send empty packets.
---
 android/hal-audio.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 534620a..9807a5d 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -691,8 +691,12 @@ static bool write_data(struct a2dp_stream_out *out, const void *buffer,
 			}
 		}
 
-		/* in resync mode we'll just drop mediapackets */
-		if (!ep->resync) {
+		/* we send data only in case codec encoded some data, i.e. some
+		 * codecs do internal buffering and output data only if full
+		 * frame can be encoded
+		 * in resync mode we'll just drop mediapackets
+		 */
+		if (written > 0 && !ep->resync) {
 			/* wait some time for socket to be ready for write,
 			 * but we'll just skip writing data if timeout occurs
 			 */
-- 
1.9.3

