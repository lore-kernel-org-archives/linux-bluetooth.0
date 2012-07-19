Return-Path: <cyrus@holtmann.org>
From: <ramm@ti.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Ram Malovany <ramm@ti.com>
Subject: [PATCH v2 2/3] Bluetooth: Fix using a NULL inquiry cache entry.
Date: Thu, 19 Jul 2012 10:26:10 +0300
Message-ID: <1342682771-28584-2-git-send-email-ramm@ti.com>
In-Reply-To: <1342682771-28584-1-git-send-email-ramm@ti.com>
References: <1342682771-28584-1-git-send-email-ramm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Ram Malovany <ramm@ti.com>

If the device was not found in a list of found devices names of which
are pending.This may happen in a case when HCI Remote Name Request
was sent as a part of incoming connection establishment procedure.
Hence there is no need to continue resolving a next name as it will
be done upon receiving another Remote Name Request Complete Event.
This will fix a kernel crash when trying to use this entry to resolve
the next name.

Signed-off-by: Ram Malovany <ramm@ti.com>
---
 net/bluetooth/hci_event.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 2de521f..3224dcc 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1396,12 +1396,18 @@ static void hci_check_pending_name(struct hci_dev *hdev, struct hci_conn *conn,
 		return;
 
 	e = hci_inquiry_cache_lookup_resolve(hdev, bdaddr, NAME_PENDING);
-	if (e) {
+	/* If the device was not found in a list of found devices names of which
+	 * are pending. there is no need to continue resolving a next name as it
+	 * will be done upon receiving another Remote Name Request Complete
+	 * Event */
+	if (!e)
+		return;
+
+	list_del(&e->list);
+	if (name) {
 		e->name_state = NAME_KNOWN;
-		list_del(&e->list);
-		if (name)
-			mgmt_remote_name(hdev, bdaddr, ACL_LINK, 0x00,
-					 e->data.rssi, name, name_len);
+		mgmt_remote_name(hdev, bdaddr, ACL_LINK, 0x00,
+				 e->data.rssi, name, name_len);
 	}
 
 	if (hci_resolve_next_name(hdev))
-- 
1.7.4.1

