Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v2 1/2] Bluetooth: fix autoconnect for pending connect attempt
Date: Tue, 13 Oct 2015 10:22:18 -0700
Message-Id: <1444756939-28776-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When adding device to auto connect whitelist when there is pending
connect attempt, there is no need to update scan, or to add it to
pend_le_conns list.

When trying to connect to le device, it is added to pend_le_conns and
background scan is updated. There's no need to repeat this operation when
adding device to auto connect list. Only update of params->auto_connect
value is required.

If both operations try to update background scan, and are quickly queued
together when scan was disabled, second operation might improperly try to
start, instead of restarting scan. This means that adding device to
connect whitelist would report failure, even though it succeeded.

In order to reproduce this bug type in bluetoothctl:
connect D9:00:00:00:00
disconnect D9:00:00:00:00
connect D9:00:00:00:00

and observe bluetoothd logs (error happens during second connect attempt):
src/device.c:device_connect_le() Connection attempt to: D0:5F:B8:52:22:9F
Failed to add device D0:5F:B8:52:22:9F (1): Busy (0x0a)

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 net/bluetooth/mgmt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9f9a70f..b42613a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6124,7 +6124,11 @@ static int hci_conn_params_set(struct hci_request *req, bdaddr_t *addr,
 	case HCI_AUTO_CONN_ALWAYS:
 		if (!is_connected(hdev, addr, addr_type)) {
 			list_add(&params->action, &hdev->pend_le_conns);
-			__hci_update_background_scan(req);
+			/* If we are connecting to device using random address,
+			 * we were already added to pend_le_conns and scanning.
+			 */
+			if (params->auto_connect != HCI_AUTO_CONN_EXPLICIT)
+				__hci_update_background_scan(req);
 		}
 		break;
 	}
-- 
2.6.0.rc2.230.g3dd15c0

