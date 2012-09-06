Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/6] Bluetooth: debug: Print refcnt for hci_dev
Date: Thu,  6 Sep 2012 15:05:45 +0300
Message-Id: <1346933147-11789-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1346933147-11789-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1346933147-11789-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci_core.h |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4704ca4..6a3337e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -603,11 +603,17 @@ static inline void hci_conn_put(struct hci_conn *conn)
 /* ----- HCI Devices ----- */
 static inline void hci_dev_put(struct hci_dev *d)
 {
+	BT_DBG("%s orig refcnt %d", d->name,
+	       atomic_read(&d->dev.kobj.kref.refcount));
+
 	put_device(&d->dev);
 }
 
 static inline struct hci_dev *hci_dev_hold(struct hci_dev *d)
 {
+	BT_DBG("%s orig refcnt %d", d->name,
+	       atomic_read(&d->dev.kobj.kref.refcount));
+
 	get_device(&d->dev);
 	return d;
 }
-- 
1.7.9.5

