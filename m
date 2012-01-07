Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi,
	marcel@holtmann.org,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 01/18] Bluetooth: Make hci-destruct callback optional
Date: Sat,  7 Jan 2012 15:47:07 +0100
Message-Id: <1325947644-11736-2-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1325947644-11736-1-git-send-email-dh.herrmann@googlemail.com>
References: <1325947644-11736-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Several drivers already provide an empty callback so we can actually make this
optional and then remove all those empty callbacks in the drivers.

This callback isn't needed at all by most drivers as they can remove their
allocated structures on device disconnect and not on hci destruction.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 include/net/bluetooth/hci_core.h |    6 ++++--
 net/bluetooth/hci_core.c         |    2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 5e2e984..b2c23e6 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -568,8 +568,10 @@ static inline void hci_conn_put(struct hci_conn *conn)
 /* ----- HCI Devices ----- */
 static inline void __hci_dev_put(struct hci_dev *d)
 {
-	if (atomic_dec_and_test(&d->refcnt))
-		d->destruct(d);
+	if (atomic_dec_and_test(&d->refcnt)) {
+		if (d->destruct)
+			d->destruct(d);
+	}
 }
 
 /*
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 6d38d80..6fdd6e5 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1450,7 +1450,7 @@ int hci_register_dev(struct hci_dev *hdev)
 	BT_DBG("%p name %s bus %d owner %p", hdev, hdev->name,
 						hdev->bus, hdev->owner);
 
-	if (!hdev->open || !hdev->close || !hdev->destruct)
+	if (!hdev->open || !hdev->close)
 		return -EINVAL;
 
 	/* Do not allow HCI_AMP devices to register at index 0,
-- 
1.7.8.1
