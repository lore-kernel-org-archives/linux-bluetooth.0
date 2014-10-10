Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 2/2] Bluetooth: Improve RFCOMM __test_pf macro robustness
Date: Fri, 10 Oct 2014 15:43:13 +0200
Message-Id: <1412948593-32106-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1412948593-32106-1-git-send-email-szymon.janc@tieto.com>
References: <1412948593-32106-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Value returned by this macro might be used as bit value so it should
return either 0 or 1 to avoid possible bugs (similar to NSC bug)
when shifting it.

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/rfcomm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index aa38fa8..7e9ed17 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -79,7 +79,7 @@ static struct rfcomm_session *rfcomm_session_del(struct rfcomm_session *s);
 
 #define __test_ea(b)      ((b & 0x01))
 #define __test_cr(b)      (!!(b & 0x02))
-#define __test_pf(b)      ((b & 0x10))
+#define __test_pf(b)      (!!(b & 0x10))
 
 #define __addr(cr, dlci)       (((dlci & 0x3f) << 2) | (cr << 1) | 0x01)
 #define __ctrl(type, pf)       (((type & 0xef) | (pf << 4)))
-- 
1.9.1

