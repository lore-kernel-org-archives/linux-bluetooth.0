Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Enable timestamps for control channel
Date: Wed, 22 Feb 2012 13:15:27 +0100
Message-Id: <1329912927-3433-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The control channel can be also monitored, so include timestamps here
as well.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_sock.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

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
-- 
1.7.7.6

