Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 04/16] android/bluetooth: Add tracking if device is in white list
Date: Tue,  2 Sep 2014 12:09:49 +0200
Message-Id: <1409652601-28689-5-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1409652601-28689-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1409652601-28689-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds tracking if device is in white list or not.
This is in order to make sure that we call mgmt inteface only when
neccessary
---
 android/bluetooth.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 99e2aab..2f3a6d6 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -141,6 +141,8 @@ struct device {
 	bool le_paired;
 	bool le_bonded;
 
+	bool in_white_list;
+
 	char *name;
 	char *friendly_name;
 
@@ -1661,14 +1663,21 @@ bool bt_auto_connect_add(const bdaddr_t *addr)
 		return false;
 	}
 
+	if (dev->in_white_list) {
+		DBG("Device already in white list");
+		return true;
+	}
+
 	memset(&cp, 0, sizeof(cp));
 	bacpy(&cp.addr.bdaddr, addr);
 	cp.addr.type = dev->bdaddr_type;
 	cp.action = 0x02;
 
 	if (mgmt_send(mgmt_if, MGMT_OP_ADD_DEVICE, adapter.index, sizeof(cp),
-						&cp, NULL, NULL, NULL) > 0)
+						&cp, NULL, NULL, NULL) > 0) {
+		dev->in_white_list = true;
 		return true;
+	}
 
 	error("Failed to add device");
 
@@ -1692,13 +1701,20 @@ void bt_auto_connect_remove(const bdaddr_t *addr)
 		return;
 	}
 
+	if (!dev->in_white_list) {
+		DBG("Device already removed from white list");
+		return;
+	}
+
 	memset(&cp, 0, sizeof(cp));
 	bacpy(&cp.addr.bdaddr, addr);
 	cp.addr.type = dev->bdaddr_type;
 
 	if (mgmt_send(mgmt_if, MGMT_OP_REMOVE_DEVICE, adapter.index,
-					sizeof(cp), &cp, NULL, NULL, NULL) > 0)
+				sizeof(cp), &cp, NULL, NULL, NULL) > 0) {
+		dev->in_white_list = false;
 		return;
+	}
 
 	error("Failed to remove device");
 }
@@ -2148,6 +2164,9 @@ static void mgmt_device_unpaired_event(uint16_t index, uint16_t length,
 
 	update_device_state(dev, ev->addr.type, HAL_STATUS_SUCCESS, false,
 								false, false);
+
+	/* Unpaired device is removed from the white list */
+	dev->in_white_list = false;
 }
 
 static void store_ltk(const bdaddr_t *dst, uint8_t bdaddr_type, bool master,
-- 
1.8.4

