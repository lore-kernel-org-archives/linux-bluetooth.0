Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Revert requirement for privacy during discovery
Date: Sun, 29 Jun 2014 17:15:47 +0200
Message-Id: <1404054947-36784-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The discovery procedure was changed to use non-resolvable private
addresses to keep the system a little bit more private and with
that make it harder to track.

However as it turns out some Low Energy HID devices like the
Microsoft Arc Touch Mouse SE are using direct advertising for
the re-connection procedures. When using a non-resolvable private
address, these events are filtered out by the controller and it
becomes impossible to re-connect the HID device.

When the HID device is discoverable and ready for pairing,
everything works as expected and ADV_IND reports are used.

> HCI Event: LE Meta Event (0x3e) plen 43
    LE Advertising Report (0x02)
      Num reports: 1
      Event type: Connectable undirected - ADV_IND (0x00)
      Address type: Random (0x01)
      Address: E7:AD:BC:AA:1A:3B (Static)
      Data length: 31
      Name (complete): Arc Touch Mouse SE
      Appearance: Mouse (0x03c2)
      Flags: 0x05
        LE Limited Discoverable Mode
        BR/EDR Not Supported
      16-bit Service UUIDs (complete): 1 entry
        Human Interface Device (0x1812)
      RSSI: -57 dBm (0xc7)
> HCI Event: LE Meta Event (0x3e) plen 12
    LE Advertising Report (0x02)
      Num reports: 1
      Event type: Scan response - SCAN_RSP (0x04)
      Address type: Random (0x01)
      Address: E7:AD:BC:AA:1A:3B (Static)
      Data length: 0
      RSSI: -57 dBm (0xc7)

Once the HID device is paired and got disconnected, it only
tries to reconnect using ADV_DIRECT_IND reports.

> HCI Event: LE Meta Event (0x3e) plen 12
    LE Advertising Report (0x02)
      Num reports: 1
      Event type: Connectable directed - ADV_DIRECT_IND (0x01)
      Address type: Random (0x01)
      Address: E7:AD:BC:AA:1A:3B (Static)
      Data length: 0
      RSSI: -53 dBm (0xcb)

These reports are filtered out by the controller if they do
not match the address. When using a non-resolvable private
address to decrease trackability, the controller will not
forward these reports up to the host stack. This means that
re-connection is not possible.

The solution to this problem is to use passive background
scanning with the identity address. Until the support for
true background scanning is available, turn the privacy
requirement for discovery off. It will be turned back on
once HID devices are connected via background scanning.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Cc: stable@vger.kernel.org # 3.15.x
---
 net/bluetooth/mgmt.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b9d193157a27..7e9471117e72 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3571,8 +3571,15 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 		/* All active scans will be done with either a resolvable
 		 * private address (when privacy feature has been enabled)
 		 * or unresolvable private address.
+		 *
+		 * However until passive background scanning is fully
+		 * integrated set require_privacy to false. This allows
+		 * to receive direct advertising reports during discovery.
+		 *
+		 * Once auto-connection handling makes use of background
+		 * scanning, the require_privacy can be set to true.
 		 */
-		err = hci_update_random_address(&req, true, &own_addr_type);
+		err = hci_update_random_address(&req, false, &own_addr_type);
 		if (err < 0) {
 			err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
 					 MGMT_STATUS_FAILED);
-- 
1.9.3

