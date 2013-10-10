Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/7] Bluetooth: Remove hdev->ioctl driver callback
Date: Thu, 10 Oct 2013 10:50:06 -0700
Message-Id: <1381427406-26472-7-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since there is no use of hdev->ioctl by any Bluetooth driver since
ever, so just lets remove it.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 1 -
 net/bluetooth/hci_sock.c         | 5 +----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c065527..237bf8c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -287,7 +287,6 @@ struct hci_dev {
 	int (*setup)(struct hci_dev *hdev);
 	int (*send)(struct sk_buff *skb);
 	void (*notify)(struct hci_dev *hdev, unsigned int evt);
-	int (*ioctl)(struct hci_dev *hdev, unsigned int cmd, unsigned long arg);
 };
 
 #define HCI_PHY_HANDLE(handle)	(handle & 0xff)
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 5b2d3f3..3beaa05 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -553,10 +553,7 @@ static int hci_sock_bound_ioctl(struct sock *sk, unsigned int cmd,
 		return hci_sock_blacklist_del(hdev, (void __user *) arg);
 	}
 
-	if (hdev->ioctl)
-		return hdev->ioctl(hdev, cmd, arg);
-
-	return -EINVAL;
+	return -ENOIOCTLCMD;
 }
 
 static int hci_sock_ioctl(struct socket *sock, unsigned int cmd,
-- 
1.8.3.1

