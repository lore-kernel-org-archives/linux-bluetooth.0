Return-Path: <cyrus@holtmann.org>
From: mail@timomueller.eu
To: linux-bluetooth@vger.kernel.org
Cc: Timo Mueller <timo.mueller@bmw-carit.de>
Subject: [RFC] Bluetooth: Fix missing MITM protection when being responding LM
Date: Mon, 21 Jan 2013 18:35:48 +0100
Message-Id: <1358789748-318-1-git-send-email-mail@timomueller.eu>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Timo Mueller <timo.mueller@bmw-carit.de>

A MITM protected SSP associaton model can be used for pairing if both
local and remote IO capabilities are set to something other than
NoInputNoOutput.

With these IO capabilities a MITM protected SSP association model is
used if we are initiating the pairing process (initiating LM).

When responding to a pairing request - remote device is the initiating
LM - the pairing should also be proteced against MITM attacks.

Signed-off-by: Timo Mueller <timo.mueller@bmw-carit.de>
---
When we were testing the iPhone 5 we noticed that the association
model changes depending on which side initiates the pairing. For
example if we paired from the phone "Just Works" was used while if the
phone was the responding LM a "Numeric Comparison" was used instead.

We'd like to enforce MITM protection in our cars whenever possible.
That is why we want to set the MITM protection even when being the
responding LM. The patch proposes this policy as the default approach.

Expected SSP accociation model:
|-------------------------------------------|
|  Device          |  SSP assocation model  |
|===========================================|
|  KeyboardDisplay |  Numeric Comparison    |
| ------------------------------------------|
|  NoInputNoOutput |  Just Works            |
| ------------------------------------------|
|  KeyboardOnly    |  Passkey Entry         |
|-------------------------------------------|

Tested Devices:
  KeyboardDisplay:
    iPhone 4 (iOS4), iPhone 5 (iOS6), Nokia N9, HTC One S,
    Samsung Galaxy (CM 10.1), Nexus 4, Nokia 6313 Classic,
    BlueZ 5 - Simple Agent

  NoInputNoOutput:
    BlueZ 5 - Simple Agent

  KeyboardOnly:
    Logitech Keyboard Case, BlueZ 5 - Simple Agent

I've also tested this patch with the following kernels:
  3.8-rc4
  3.4

Best regards,
	 Timo

 net/bluetooth/hci_conn.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 25bfce0..806583b 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -357,11 +357,15 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 	conn->type  = type;
 	conn->mode  = HCI_CM_ACTIVE;
 	conn->state = BT_OPEN;
-	conn->auth_type = HCI_AT_GENERAL_BONDING;
 	conn->io_capability = hdev->io_capability;
 	conn->remote_auth = 0xff;
 	conn->key_type = 0xff;
 
+	if (hdev->io_capability == 0x03)
+		conn->auth_type = HCI_AT_GENERAL_BONDING;
+	else
+		conn->auth_type = HCI_AT_GENERAL_BONDING_MITM;
+
 	set_bit(HCI_CONN_POWER_SAVE, &conn->flags);
 	conn->disc_timeout = HCI_DISCONN_TIMEOUT;
 
-- 
1.7.11.7

