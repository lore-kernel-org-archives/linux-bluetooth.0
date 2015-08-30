Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Use BROKEN_STORED_LINK_KEY quirk for HCI_Read_Stored_Link_Key
Date: Sun, 30 Aug 2015 21:47:20 +0300
Message-Id: <1440960441-31324-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Some counterfeit CSR controllers also have broken behavior with the
HCI_Read_Stored_Link_Key command:

< HCI Command: Read Stored Link Key (0x03|0x000d) plen 7
        Address: 00:00:00:00:00:00 (OUI 00-00-00)
        Read all: 0x01
> HCI Event: Command Complete (0x0e) plen 8
      Read Stored Link Key (0x03|0x000d) ncmd 1
        Status: Unsupported Feature or Parameter Value (0x11)
        Max num keys: 0
        Num keys: 0

Extend the existing HCI_QUIRK_BROKEN_STORED_LINK_KEY to be also used
for this HCI command.

Reported-and-tested-by: Rhobison Alves Pereira <rhobison@hotmail.com>
Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index adcbc74c2432..5a3602046a8b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -693,7 +693,8 @@ static void hci_init3_req(struct hci_request *req, unsigned long opt)
 
 	hci_setup_event_mask(req);
 
-	if (hdev->commands[6] & 0x20) {
+	if (hdev->commands[6] & 0x20 &&
+	    !test_bit(HCI_QUIRK_BROKEN_STORED_LINK_KEY, &hdev->quirks)) {
 		struct hci_cp_read_stored_link_key cp;
 
 		bacpy(&cp.bdaddr, BDADDR_ANY);
-- 
2.4.3

