Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/3] android/bluetooth: Always create device object in create bond
Date: Thu,  8 May 2014 15:26:03 +0200
Message-Id: <1399555563-21054-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1399555563-21054-1-git-send-email-szymon.janc@tieto.com>
References: <1399555563-21054-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If device is not known (ie. OOB pairing) create new device object
so it can be later used in pairing events.
---
 android/bluetooth.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 85db038..be7b47c 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -3157,20 +3157,16 @@ static void handle_create_bond_cmd(const void *buf, uint16_t len)
 	cp.io_cap = DEFAULT_IO_CAPABILITY;
 	android2bdaddr(cmd->bdaddr, &cp.addr.bdaddr);
 
-	dev = find_device(&cp.addr.bdaddr);
+	/* type is used only as fallback when device is not in cache */
+	dev = get_device(&cp.addr.bdaddr, BDADDR_BREDR);
 
-	if (dev) {
-		if (dev->bond_state != HAL_BOND_STATE_NONE) {
-			status = HAL_STATUS_FAILED;
-			goto fail;
-		}
-
-		cp.addr.type = dev->bredr ? BDADDR_BREDR : dev->bdaddr_type;
-	} else {
-		/* Fallback to BREDR if device is unknown eg. OOB */
-		cp.addr.type = BDADDR_BREDR;
+	if (dev->bond_state != HAL_BOND_STATE_NONE) {
+		status = HAL_STATUS_FAILED;
+		goto fail;
 	}
 
+	cp.addr.type = dev->bredr ? BDADDR_BREDR : dev->bdaddr_type;
+
 	if (mgmt_send(mgmt_if, MGMT_OP_PAIR_DEVICE, adapter.index, sizeof(cp),
 				&cp, pair_device_complete, NULL, NULL) == 0) {
 		status = HAL_STATUS_FAILED;
@@ -3179,9 +3175,7 @@ static void handle_create_bond_cmd(const void *buf, uint16_t len)
 
 	status = HAL_STATUS_SUCCESS;
 
-	if (dev)
-		set_device_bond_state(dev, HAL_STATUS_SUCCESS,
-							HAL_BOND_STATE_BONDING);
+	set_device_bond_state(dev, HAL_STATUS_SUCCESS, HAL_BOND_STATE_BONDING);
 
 fail:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_BLUETOOTH, HAL_OP_CREATE_BOND,
-- 
1.9.1

