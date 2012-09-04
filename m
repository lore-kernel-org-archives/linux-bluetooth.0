Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC v4 18/18] sdp: Fix build error due to unaligned memory access
Date: Tue, 4 Sep 2012 16:41:37 +0200
Message-ID: <1346769697-9930-19-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1346769697-9930-1-git-send-email-szymon.janc@tieto.com>
References: <1346769697-9930-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix following compilation errors on ARM.

  CC     lib/sdp.lo
lib/sdp.c: In function 'sdp_process':
lib/sdp.c:4149:22: error: cast increases required alignment of target type [-Wer
ror=cast-align]
cc1: all warnings being treated as errors
make[1]: *** [lib/sdp.lo] Error 1
make: *** [all] Error 2

---
 lib/sdp.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index a533b12..ee51eca 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -4146,14 +4146,16 @@ int sdp_process(sdp_session_t *session)
 			rsp_count = sizeof(tsrc) + sizeof(csrc) + csrc * 4;
 		} else {
 			/* point to the first csrc */
-			uint16_t *pcsrc = (uint16_t *) (t->rsp_concat_buf.data + 2);
+			uint8_t *pcsrc = t->rsp_concat_buf.data + 2;
+			uint16_t tcsrc = bt_get_unaligned(pcsrc, uint16_t);
 
 			/* FIXME: update the interface later. csrc doesn't need be passed to clients */
 
 			pdata += sizeof(uint16_t); /* point to csrc */
 
 			/* the first csrc contains the sum of partial csrc responses */
-			*pcsrc += bt_get_unaligned(pdata, uint16_t);
+			tcsrc += bt_get_unaligned(pdata, uint16_t);
+			memcpy(pcsrc, &tcsrc, sizeof(tcsrc));
 
 			pdata += sizeof(uint16_t); /* point to the first handle */
 			rsp_count = csrc * 4;
-- 
1.7.9.5

