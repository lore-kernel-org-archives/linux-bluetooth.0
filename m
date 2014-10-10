Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 1/2] Bluetooth: Fix RFCOMM NSC response
Date: Fri, 10 Oct 2014 15:43:12 +0200
Message-Id: <1412948593-32106-1-git-send-email-szymon.janc@tieto.com>
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

V2: moved sanitization to macro ifself
    added second patch that also fix __test_pf 

 net/bluetooth/rfcomm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index ca957d3..aa38fa8 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -78,7 +78,7 @@ static struct rfcomm_session *rfcomm_session_del(struct rfcomm_session *s);
 #define __get_type(b)     ((b & 0xef))
 
 #define __test_ea(b)      ((b & 0x01))
-#define __test_cr(b)      ((b & 0x02))
+#define __test_cr(b)      (!!(b & 0x02))
 #define __test_pf(b)      ((b & 0x10))
 
 #define __addr(cr, dlci)       (((dlci & 0x3f) << 2) | (cr << 1) | 0x01)
-- 
1.9.1

