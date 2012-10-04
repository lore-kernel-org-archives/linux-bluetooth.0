Return-Path: <cyrus@holtmann.org>
From: Jesse Sung <jesse.sung@canonical.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 resend 1/2] Introduced a load_firmware callback to struct hci_dev
Date: Thu,  4 Oct 2012 15:30:46 +0800
Message-Id: <1349335847-1615-2-git-send-email-jesse.sung@canonical.com>
In-Reply-To: <1349335847-1615-1-git-send-email-jesse.sung@canonical.com>
References: <cover.1347959921.git.jesse.sung@canonical.com>
 <1349335847-1615-1-git-send-email-jesse.sung@canonical.com>
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
