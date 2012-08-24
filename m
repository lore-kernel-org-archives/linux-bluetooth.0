Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 01/22] Bluetooth: debug: Print refcnt for hci_dev
Date: Fri, 24 Aug 2012 17:00:00 +0300
Message-Id: <1345816821-32331-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1345816821-32331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1345816821-32331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci_core.h |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 1bbc109..5354e7b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -612,11 +612,17 @@ static inline void hci_conn_put(struct hci_conn *conn)
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

