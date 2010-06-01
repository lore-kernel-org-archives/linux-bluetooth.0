Return-Path: <cyrus@holtmann.org>
Subject: [PATCH 1/3] Rename hci_recv_fragment to hci_recv_packet_fragment
From: suraj <suraj@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, <Luis.Rodriguez@Atheros.com>,
	<Jothikumar.Mothilal@Atheros.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 1 Jun 2010 13:34:00 +0530
Message-ID: <1275379440.19477.9.camel@atheros013-desktop>
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Renaming hci_recv_fragment to hci_recv_packet_fragment as it will be used 
only for reassembling HCI fragments with know packet type.

Signed-off-by: suraj <suraj@Atheros.com>
---
 include/net/bluetooth/hci_core.h |    3 ++-
 net/bluetooth/hci_core.c         |    5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e42f6ed..65c3c13 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -427,7 +427,8 @@ int hci_inquiry(void __user *arg);
 void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb);
 
 int hci_recv_frame(struct sk_buff *skb);
-int hci_recv_fragment(struct hci_dev *hdev, int type, void *data, int count);
+int hci_recv_packet_fragment(struct hci_dev *hdev, int type, void *data,
+				int count);
 
 int hci_register_sysfs(struct hci_dev *hdev);
 void hci_unregister_sysfs(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5e83f8e..e7ce432 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1033,7 +1033,8 @@ EXPORT_SYMBOL(hci_recv_frame);
 /* Receive packet type fragment */
 #define __reassembly(hdev, type)  ((hdev)->reassembly[(type) - 2])
 
-int hci_recv_fragment(struct hci_dev *hdev, int type, void *data, int count)
+int hci_recv_packet_fragment(struct hci_dev *hdev, int type, void *data,
+				int count)
 {
 	if (type < HCI_ACLDATA_PKT || type > HCI_EVENT_PKT)
 		return -EILSEQ;
@@ -1112,7 +1113,7 @@ int hci_recv_fragment(struct hci_dev *hdev, int type, void *data, int count)
 
 	return 0;
 }
-EXPORT_SYMBOL(hci_recv_fragment);
+EXPORT_SYMBOL(hci_recv_packet_fragment);
 
 /* ---- Interface to upper protocols ---- */
 
-- 
1.7.0
