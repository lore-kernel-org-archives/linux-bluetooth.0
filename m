Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Shrink size of struct l2cap_ctrl fields
Date: Sun,  8 Jun 2014 10:26:57 +0200
Message-Id: <1402216017-10419-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The struct l2cap_ctrl fields are wasting an unsigned int when all the
bits can fit into an __u8 field.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/bluetooth.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 904777c1cd24..373000de610d 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -260,15 +260,15 @@ struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock);
 
 /* Skb helpers */
 struct l2cap_ctrl {
-	unsigned int	sframe:1,
-			poll:1,
-			final:1,
-			fcs:1,
-			sar:2,
-			super:2;
-	__u16		reqseq;
-	__u16		txseq;
-	__u8		retries;
+	__u8	sframe:1,
+		poll:1,
+		final:1,
+		fcs:1,
+		sar:2,
+		super:2;
+	__u16	reqseq;
+	__u16	txseq;
+	__u8	retries;
 };
 
 struct hci_dev;
-- 
1.9.3

