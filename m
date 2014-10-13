Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 1/2] Bluetooth: Fix RFCOMM NSC response
Date: Mon, 13 Oct 2014 11:43:53 +0200
Message-Id: <1413193434-16779-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

rfcomm_send_nsc expects CR to be either 0 or 1 since it is later
passed to __mcc_type macro and shitfed. Unfortunatelly CR extracted
from received frame type was not sanitized and shifted value was passed
resulting in bogus response.

Note: shifted value was also passed to other functions but was used
only in if satements so this bug appears only for NSC case.

The CR bit in the value octet shall be set to the same value
as the CR bit in the type field octet of the not supported command
frame but the CR bit for NCS response should be set to 0 since it is
always a response.

This was affecting TC_RFC_BV_25_C PTS qualification test.

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---

V3: fixed invalid CR
V2: moved sanitization to macro ifself
    added second patch that also fix __test_pf 

 net/bluetooth/rfcomm/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index af73bc3..d0bbc73 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -78,7 +78,7 @@ static struct rfcomm_session *rfcomm_session_del(struct rfcomm_session *s);
 #define __get_type(b)     ((b & 0xef))
 
 #define __test_ea(b)      ((b & 0x01))
-#define __test_cr(b)      ((b & 0x02))
+#define __test_cr(b)      (!!(b & 0x02))
 #define __test_pf(b)      ((b & 0x10))
 
 #define __addr(cr, dlci)       (((dlci & 0x3f) << 2) | (cr << 1) | 0x01)
@@ -904,7 +904,7 @@ static int rfcomm_send_nsc(struct rfcomm_session *s, int cr, u8 type)
 	hdr->len  = __len8(sizeof(*mcc) + 1);
 
 	mcc = (void *) ptr; ptr += sizeof(*mcc);
-	mcc->type = __mcc_type(cr, RFCOMM_NSC);
+	mcc->type = __mcc_type(0, RFCOMM_NSC);
 	mcc->len  = __len8(1);
 
 	/* Type that we didn't like */
-- 
1.9.1

