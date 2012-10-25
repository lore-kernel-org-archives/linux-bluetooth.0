Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 08/11] Bluetooth: AMP: Remove hci_conn receiving error command status
Date: Thu, 25 Oct 2012 15:20:49 +0300
Message-Id: <1351167652-12346-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1351167652-12346-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1350493622.26318.114.camel@aeonflux>
 <1351167652-12346-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

When receiving HCI Event: Command Status for Create Physical Link
with Error code remove AMP hcon.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_event.c |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 14c5f3f..827243d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1803,14 +1803,23 @@ static void hci_cs_create_phylink(struct hci_dev *hdev, u8 status)
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
 
-	if (status)
-		return;
-
 	cp = hci_sent_cmd_data(hdev, HCI_OP_CREATE_PHY_LINK);
 	if (!cp)
 		return;
 
-	amp_write_remote_assoc(hdev, cp->phy_handle);
+	hci_dev_lock(hdev);
+
+	if (status) {
+		struct hci_conn *hcon;
+
+		hcon = hci_conn_hash_lookup_handle(hdev, cp->phy_handle);
+		if (hcon)
+			hci_conn_del(hcon);
+	} else {
+		amp_write_remote_assoc(hdev, cp->phy_handle);
+	}
+
+	hci_dev_unlock(hdev);
 }
 
 static void hci_cs_accept_phylink(struct hci_dev *hdev, u8 status)
-- 
1.7.9.5

