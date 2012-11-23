Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/4] sdpd-request: Fix build errors due to unaligned memory access
Date: Fri, 23 Nov 2012 11:09:14 +0100
Message-ID: <1353665354-32178-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1353665354-32178-1-git-send-email-szymon.janc@tieto.com>
References: <1353665354-32178-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix following compilation errors on ARM.

  CC     src/bluetoothd-sdpd-request.o
src/sdpd-request.c: In function ‘extract_des’:
src/sdpd-request.c:186:17: error: cast increases required alignment of
	target type [-Werror=cast-align]
src/sdpd-request.c:186:17: error: cast increases required alignment of
	target type [-Werror=cast-align]
src/sdpd-request.c:210:17: error: cast increases required alignment of
	target type [-Werror=cast-align]
src/sdpd-request.c:210:17: error: cast increases required alignment of
	target type [-Werror=cast-align]
cc1: all warnings being treated as errors
make[1]: *** [src/bluetoothd-sdpd-request.o] Error 1
---
 src/sdpd-request.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/src/sdpd-request.c b/src/sdpd-request.c
index 2af743e..a79efc7 100644
--- a/src/sdpd-request.c
+++ b/src/sdpd-request.c
@@ -182,8 +182,12 @@ static int extract_des(uint8_t *buf, int len, sdp_list_t **svcReqSeq, uint8_t *p
 				aid->uint16 = bt_get_be16(p);
 				pElem = (char *) aid;
 			} else {
+				uint16_t tmp;
+
+				memcpy(&tmp, p, sizeof(tmp));
+
 				pElem = malloc(sizeof(uint16_t));
-				bt_put_be16(bt_get_unaligned((uint16_t *)p), pElem);
+				bt_put_be16(tmp, pElem);
 			}
 			p += sizeof(uint16_t);
 			seqlen += sizeof(uint16_t);
@@ -206,8 +210,12 @@ static int extract_des(uint8_t *buf, int len, sdp_list_t **svcReqSeq, uint8_t *p
 
 				pElem = (char *) aid;
 			} else {
+				uint32_t tmp;
+
+				memcpy(&tmp, p, sizeof(tmp));
+
 				pElem = malloc(sizeof(uint32_t));
-				bt_put_be32(bt_get_unaligned((uint32_t *)p), pElem);
+				bt_put_be32(tmp, pElem);
 			}
 			p += sizeof(uint32_t);
 			seqlen += sizeof(uint32_t);
-- 
1.7.9.5

