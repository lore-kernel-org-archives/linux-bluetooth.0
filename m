Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi,
	marcel@holtmann.org,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 14/18] Bluetooth: Remove unused hci-destruct cb
Date: Sat,  7 Jan 2012 15:47:20 +0100
Message-Id: <1325947644-11736-15-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1325947644-11736-1-git-send-email-dh.herrmann@googlemail.com>
References: <1325947644-11736-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The hci-destruct callback is not used by any driver so we can remove it. There
is no reason to keep it alive, anymore. Drivers can free their internal data on
driver-release and we do not need to provide a public destruct callback.

Internally, we still use a destruct callback inside of hci_sysfs.c. This one is
used to correctly free our hci_dev data structure if no more users have a
reference to it.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 include/net/bluetooth/hci_core.h |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b2c23e6..ab97ad3 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -254,7 +254,6 @@ struct hci_dev {
 	int (*close)(struct hci_dev *hdev);
 	int (*flush)(struct hci_dev *hdev);
 	int (*send)(struct sk_buff *skb);
-	void (*destruct)(struct hci_dev *hdev);
 	void (*notify)(struct hci_dev *hdev, unsigned int evt);
 	int (*ioctl)(struct hci_dev *hdev, unsigned int cmd, unsigned long arg);
 };
@@ -568,10 +567,7 @@ static inline void hci_conn_put(struct hci_conn *conn)
 /* ----- HCI Devices ----- */
 static inline void __hci_dev_put(struct hci_dev *d)
 {
-	if (atomic_dec_and_test(&d->refcnt)) {
-		if (d->destruct)
-			d->destruct(d);
-	}
+	atomic_dec(&d->refcnt);
 }
 
 /*
-- 
1.7.8.1
