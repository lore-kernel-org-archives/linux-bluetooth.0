Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 03/26] android/hal-audio: Fix PT in media packets
Date: Mon, 26 May 2014 15:16:29 +0200
Message-ID: <1401110212-11526-4-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to A2DP 1.3 spec section 4.3.3.2:
"A payload type in the RTP dynamic range shall be chosen (see [22],
section 3)." - [22] = RFC3551

As per referenced RFC3551, values in range 96-127 are reserved for
dynamic assignment so we can set PT to 96.
---
 android/hal-audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 49b829a..49393e2 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -479,7 +479,7 @@ static bool open_endpoint(struct audio_endpoint *ep,
 	if (!ep->mp)
 		goto failed;
 	ep->mp->hdr.v = 2;
-	ep->mp->hdr.pt = 1;
+	ep->mp->hdr.pt = 0x60;
 	ep->mp->hdr.ssrc = htonl(1);
 
 	ep->mp_data_len = payload_len;
-- 
1.9.3

