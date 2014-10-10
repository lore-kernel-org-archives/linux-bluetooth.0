Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] Bluetooth: Fix RFCOMM NSC response
Date: Fri, 10 Oct 2014 15:21:29 +0200
Message-Id: <1412947289-27091-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

rfcomm_send_nsc expects cr to be either 0 or 1 since it is later
passed to __mcc_type macro and shitfed. Unfortunatelly cr extracted
from received frame type was not sanitized and shifted value was passed
resulting in bogus response.

Note: shifted value was also passed to other functions but was used
only in if satements so this bug appears only for NSC case.

This was affecting TC_RFC_BV_25_C PTS qualification test.

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/rfcomm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index ca957d3..d340577 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1558,7 +1558,7 @@ static int rfcomm_recv_mcc(struct rfcomm_session *s, struct sk_buff *skb)
 	struct rfcomm_mcc *mcc = (void *) skb->data;
 	u8 type, cr, len;
 
-	cr   = __test_cr(mcc->type);
+	cr   = !!__test_cr(mcc->type);
 	type = __get_mcc_type(mcc->type);
 	len  = __get_mcc_len(mcc->len);
 
-- 
1.9.1

