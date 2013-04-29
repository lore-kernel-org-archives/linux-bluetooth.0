Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 04/13] Bluetooth: Fix LE vs BR/EDR selection when connecting
Date: Mon, 29 Apr 2013 19:35:36 +0300
Message-Id: <1367253345-12482-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1367253345-12482-1-git-send-email-johan.hedberg@gmail.com>
References: <1367253345-12482-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The choice between LE and BR/EDR should be made on the destination
address type instead of the destination CID. This is particularly
important when in the future more than one CID will be allowed for LE.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d5e4404..95d46cd 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1792,7 +1792,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 
 	auth_type = l2cap_get_auth_type(chan);
 
-	if (chan->dcid == L2CAP_CID_ATT)
+	if (bdaddr_type_is_le(dst_type))
 		hcon = hci_connect(hdev, LE_LINK, dst, dst_type,
 				   chan->sec_level, auth_type);
 	else
-- 
1.7.10.4

