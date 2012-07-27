Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: jaganath.k@samsung.com, Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH] Bluetooth: debug: Correct the PSM printing
Date: Fri, 27 Jul 2012 23:51:22 +0530
Message-id: <1343413282-8901-2-git-send-email-s.syam@samsung.com>
In-reply-to: <1343413282-8901-1-git-send-email-s.syam@samsung.com>
References: <1343413282-8901-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Earlier we were printing chan->psm before assigning any value.

Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
---
 net/bluetooth/l2cap_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index bedc960..0912a63 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1447,7 +1447,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 	int err;
 
 	BT_DBG("%s -> %s (type %u) psm 0x%2.2x", batostr(src), batostr(dst),
-	       dst_type, __le16_to_cpu(chan->psm));
+	       dst_type, __le16_to_cpu(psm));
 
 	hdev = hci_get_route(dst, src);
 	if (!hdev)
-- 
1.7.4.1

