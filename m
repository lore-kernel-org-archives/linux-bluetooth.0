Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH 4/4] Bluetooth: LE passive scan trigger in hci_connect()
Date: Tue,  9 Aug 2011 19:52:40 -0300
Message-Id: <1312930360-30860-5-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1312930360-30860-1-git-send-email-andre.guedes@openbossa.org>
References: <1312930360-30860-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

During LE connection, if the entry isn't found in the advertising
cache the passive scan is triggered and the connection creation is
postponed until the passive scan finishes.

The scan parameters were chosen based on some simulation results sent
to Bluetooth SIG mailing list (GATT Profile Architecture Working Group)
in April 2011.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_conn.c  |   18 ++++++++++++++----
 net/bluetooth/hci_event.c |    2 ++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index cc36358..1f404cf 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -507,14 +507,24 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
 		if (le)
 			return ERR_PTR(-EBUSY);
 
-		entry = hci_find_adv_entry(hdev, dst);
-		if (!entry)
-			return ERR_PTR(-EHOSTUNREACH);
-
 		le = hci_conn_add(hdev, LE_LINK, dst);
 		if (!le)
 			return ERR_PTR(-ENOMEM);
 
+		entry = hci_find_adv_entry(hdev, dst);
+		if (!entry) {
+			int err;
+
+			err = hci_do_le_scan(hdev, 3869, 0x00, 0x60, 0x30);
+			if (err < 0) {
+				hci_conn_del(le);
+				return ERR_PTR(err);
+			}
+
+			hci_conn_hold(le);
+			return le;
+		}
+
 		le->dst_type = entry->bdaddr_type;
 
 		hci_le_connect(le);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6bbf4d7..540ee81 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -941,6 +941,8 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 			mgmt_start_discovery_complete(hdev->id);
 			hci_dev_unlock(hdev);
 		}
+
+		hci_conn_check_pending(hdev, LE_LINK);
 	}
 }
 
-- 
1.7.5.2

