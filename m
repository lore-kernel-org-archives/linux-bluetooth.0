Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/7] Bluetooth: Use Identity Address in Device Found event
Date: Tue, 18 Feb 2014 21:41:37 +0200
Message-Id: <1392752497-8696-8-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1392752497-8696-1-git-send-email-johan.hedberg@gmail.com>
References: <1392752497-8696-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Whenever a device uses an RPA we want to have user space identify it by
its Identity Address if we've got an IRK available for it. This patch
updates the Device Found mgmt event to contain the Identity Address if
an IRK is available for the device in question.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 24a85fe76cd8..747cb9bbc331 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5325,6 +5325,7 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 {
 	char buf[512];
 	struct mgmt_ev_device_found *ev = (void *) buf;
+	struct smp_irk *irk;
 	size_t ev_size;
 
 	if (!hci_discovery_active(hdev))
@@ -5336,8 +5337,15 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 
 	memset(buf, 0, sizeof(buf));
 
-	bacpy(&ev->addr.bdaddr, bdaddr);
-	ev->addr.type = link_to_bdaddr(link_type, addr_type);
+	irk = hci_get_irk(hdev, bdaddr, addr_type);
+	if (irk) {
+		bacpy(&ev->addr.bdaddr, &irk->bdaddr);
+		ev->addr.type = link_to_bdaddr(link_type, irk->addr_type);
+	} else {
+		bacpy(&ev->addr.bdaddr, bdaddr);
+		ev->addr.type = link_to_bdaddr(link_type, addr_type);
+	}
+
 	ev->rssi = rssi;
 	if (cfm_name)
 		ev->flags |= __constant_cpu_to_le32(MGMT_DEV_FOUND_CONFIRM_NAME);
-- 
1.8.5.3

