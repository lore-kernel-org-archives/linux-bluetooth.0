Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Enable timestamps for control channel
Date: Wed, 22 Feb 2012 13:49:28 +0100
Message-Id: <1329914968-7643-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The control channel can be also monitored, so include timestamps here
as well. And make sure management events get their timestamp when they
are created.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_sock.c |    1 +
 net/bluetooth/mgmt.c     |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index b768393..f0912d8 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -783,6 +783,7 @@ static int hci_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
 	case HCI_CHANNEL_RAW:
 		hci_sock_cmsg(sk, msg, skb);
 		break;
+	case HCI_CHANNEL_CONTROL:
 	case HCI_CHANNEL_MONITOR:
 		sock_recv_timestamp(msg, sk, skb);
 		break;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9fb4490..d650c02 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -817,6 +817,9 @@ static int mgmt_event(u16 event, struct hci_dev *hdev, void *data,
 	if (data)
 		memcpy(skb_put(skb, data_len), data, data_len);
 
+	/* Time stamp */
+	__net_timestamp(skb);
+
 	hci_send_to_control(skb, skip_sk);
 	kfree_skb(skb);
 
-- 
1.7.7.6

