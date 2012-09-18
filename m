Return-Path: <cyrus@holtmann.org>
From: Jesse Sung <jesse.sung@canonical.com>
To: linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH v2 1/2] Bluetooth: Introduced a load_firmware callback to struct hci_dev
Date: Tue, 18 Sep 2012 17:49:43 +0800
Message-Id: <e3804705ce378572af7f0a9613eb69b4773a49fc.1347959921.git.jesse.sung@canonical.com>
In-Reply-To: <cover.1347959921.git.jesse.sung@canonical.com>
References: <cover.1347959921.git.jesse.sung@canonical.com>
In-Reply-To: <cover.1347959921.git.jesse.sung@canonical.com>
References: <cover.1347959921.git.jesse.sung@canonical.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Wen-chien Jesse Sung <jesse.sung@canonical.com>

load_firmware will be called at the end of hci_dev_open() if it
is defined.

Signed-off-by: Wen-chien Jesse Sung <jesse.sung@canonical.com>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_core.c         |    2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 593cd1d..40972a3 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -281,6 +281,7 @@ struct hci_dev {
 	int (*send)(struct sk_buff *skb);
 	void (*notify)(struct hci_dev *hdev, unsigned int evt);
 	int (*ioctl)(struct hci_dev *hdev, unsigned int cmd, unsigned long arg);
+	void (*load_firmware)(struct hci_dev *hdev);
 };
 
 struct hci_conn {
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d4de5db..49be87a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -725,6 +725,8 @@ int hci_dev_open(__u16 dev)
 done:
 	hci_req_unlock(hdev);
 	hci_dev_put(hdev);
+	if (!ret && hdev->load_firmware)
+		hdev->load_firmware(hdev);
 	return ret;
 }
 
-- 
1.7.9.5
