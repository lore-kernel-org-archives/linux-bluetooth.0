Return-Path: <cyrus@holtmann.org>
From: Suraj Sumangala <suraj@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <Jothikumar.Mothilal@Atheros.com>,
	Suraj Sumangala <suraj@atheros.com>
Subject: [RFC v2] Bluetooth: Provide access to reassembled Rx packets
Date: Mon, 26 Jul 2010 12:04:54 +0530
Message-ID: <1280126094-18004-1-git-send-email-suraj@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Provide the HCI transport driver access to reassembled Rx packets before
sending to Host.

Signed-off-by: Suraj Sumangala <suraj@atheros.com>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_core.c         |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 350b3e6..532169c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -156,6 +156,7 @@ struct hci_dev {
 	int (*close)(struct hci_dev *hdev);
 	int (*flush)(struct hci_dev *hdev);
 	int (*send)(struct sk_buff *skb);
+	int (*recv)(struct sk_buff *skb);
 	void (*destruct)(struct hci_dev *hdev);
 	void (*notify)(struct hci_dev *hdev, unsigned int evt);
 	int (*ioctl)(struct hci_dev *hdev, unsigned int cmd, unsigned long arg);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 995c9f9..85e09ef 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1132,6 +1132,10 @@ static int hci_reassembly(struct hci_dev *hdev, int type, void *data,
 			/* Complete frame */
 
 			bt_cb(skb)->pkt_type = type;
+
+			if (hdev->recv)
+				hdev->recv(skb);
+
 			hci_recv_frame(skb);
 
 			hdev->reassembly[index] = NULL;
-- 
1.7.0.4

