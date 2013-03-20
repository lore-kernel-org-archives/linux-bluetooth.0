Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 20 Mar 2013 20:23:37 +0800
Message-ID: <CAPgLHd-SvkWV9frakmbbzc1v6n_nEW+f8afUVLxMF1-=GVSyTw@mail.gmail.com>
Subject: [PATCH -next] Bluetooth: fix error return code in rfcomm_add_listener()
From: Wei Yongjun <weiyj.lk@gmail.com>
To: marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com,
	Dean_Jenkins@mentor.com, andrei.emeltchenko@intel.com, s.syam@samsung.com
Cc: yongjun_wei@trendmicro.com.cn, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fix to return a negative error code from the error handling
case instead of 0, as returned elsewhere in this function.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 net/bluetooth/rfcomm/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index ba93df2..ca957d3 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -2004,8 +2004,10 @@ static int rfcomm_add_listener(bdaddr_t *ba)
 
 	/* Add listening session */
 	s = rfcomm_session_add(sock, BT_LISTEN);
-	if (!s)
+	if (!s) {
+		err = -ENOMEM;
 		goto failed;
+	}
 
 	return 0;
 failed:
