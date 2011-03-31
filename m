Return-Path: <cyrus@holtmann.org>
From: Zhang Jiejing <jiejing.zhang@freescale.com>
To: <suraj@atheros.com>, <marcel@holtmann.org>, <padovan@profusion.mobi>,
	<linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Bluetooth: change gfp type in hci_recv_stream_fragment()
Date: Thu, 31 Mar 2011 14:56:56 +0800
Message-ID: <1301554616-27595-1-git-send-email-jiejing.zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

change gfp type passed to hci_reassembly(), replace GFP_ATOMIC
to GFP_KERNEL. Since some HCI_ACLDATA may request 1024+4 bytes
some time GFP_ATOMIC will failed to allocation memory during
large file FTP transfer in high baud rate.

Signed-off-by: Zhang Jiejing <jiejing.zhang@freescale.com>
---
 net/bluetooth/hci_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9c4541b..22b3ded 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1214,7 +1214,7 @@ int hci_recv_stream_fragment(struct hci_dev *hdev, void *data, int count)
 			type = bt_cb(skb)->pkt_type;
 
 		rem = hci_reassembly(hdev, type, data,
-					count, STREAM_REASSEMBLY, GFP_ATOMIC);
+					count, STREAM_REASSEMBLY, GFP_KERNEL);
 		if (rem < 0)
 			return rem;
 
-- 
1.7.0.4
