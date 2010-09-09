Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 2/3] Bluetooth: check for l2cap header in start fragment
Date: Thu,  9 Sep 2010 10:43:00 +0300
Message-Id: <1284018181-29928-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1284018181-29928-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1284018181-29928-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

BLUETOOTH SPECIFICATION Version 4.0 [Vol 3] page 36 mentioned
"Note: Start Fragments always begin with the Basic L2CAP header
of a PDU."

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
---
 net/bluetooth/l2cap.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 9fad312..ce8f5e4 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -4664,7 +4664,8 @@ static int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 fl
 			l2cap_conn_unreliable(conn, ECOMM);
 		}
 
-		if (skb->len < 2) {
+		/* Start fragment always begin with Basic L2CAP header */
+		if (skb->len < L2CAP_HDR_SIZE) {
 			BT_ERR("Frame is too short (len %d)", skb->len);
 			l2cap_conn_unreliable(conn, ECOMM);
 			goto drop;
-- 
1.7.0.4

