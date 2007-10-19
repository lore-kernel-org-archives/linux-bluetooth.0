Return-Path: <hidave.darkstar@gmail.com>
Date: Fri, 19 Oct 2007 13:00:58 +0800
From: Dave Young <hidave.darkstar@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: bluez-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] bluetooth: hidp core debug code wrong argument fix
Message-ID: <20071019050057.GA8734@darkstar.te-china.tietoenator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <bluez-devel.lists.sourceforge.net>

In the debug code of the hidp_queue_report function, the "device" variable does not exist, replace it with "session->hid"

Signed-off-by: Dave Young <hidave.darkstar@gmail.com> 

---
net/bluetooth/hidp/core.c |    2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

diff -upr linux/net/bluetooth/hidp/core.c linux.new/net/bluetooth/hidp/core.c
--- linux/net/bluetooth/hidp/core.c	2007-10-15 14:05:23.000000000 +0800
+++ linux.new/net/bluetooth/hidp/core.c	2007-10-15 14:06:38.000000000 +0800
@@ -247,7 +247,7 @@ static inline int hidp_queue_report(stru
 {
 	struct sk_buff *skb;
 
-	BT_DBG("session %p hid %p data %p size %d", session, device, data, size);
+	BT_DBG("session %p hid %p data %p size %d", session, session->hid, data, size);
 
 	if (!(skb = alloc_skb(size + 1, GFP_ATOMIC))) {
 		BT_ERR("Can't allocate memory for new frame");
