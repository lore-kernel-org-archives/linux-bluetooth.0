Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: Remove redundant IRK lookup in mgmt_device_found()
Date: Mon,  7 Jul 2014 12:35:15 +0300
Message-Id: <1404725715-1414-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404725715-1414-1-git-send-email-johan.hedberg@gmail.com>
References: <1404725715-1414-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Now that we have the process_adv_report() function doing the IRK lookup
and updating the bdaddr we don't need to do this anymore in mgmt.c in
the mgmt_device_found() function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index be91d55c258b..40244fc0e326 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6717,7 +6717,6 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 {
 	char buf[512];
 	struct mgmt_ev_device_found *ev = (void *) buf;
-	struct smp_irk *irk;
 	size_t ev_size;
 
 	/* Don't send events for a non-kernel initiated discovery. With
@@ -6739,15 +6738,8 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 
 	memset(buf, 0, sizeof(buf));
 
-	irk = hci_get_irk(hdev, bdaddr, addr_type);
-	if (irk) {
-		bacpy(&ev->addr.bdaddr, &irk->bdaddr);
-		ev->addr.type = link_to_bdaddr(link_type, irk->addr_type);
-	} else {
-		bacpy(&ev->addr.bdaddr, bdaddr);
-		ev->addr.type = link_to_bdaddr(link_type, addr_type);
-	}
-
+	bacpy(&ev->addr.bdaddr, bdaddr);
+	ev->addr.type = link_to_bdaddr(link_type, addr_type);
 	ev->rssi = rssi;
 	ev->flags = cpu_to_le32(flags);
 
-- 
1.9.3

