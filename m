Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix limited discoverable mode for Zeevo modules
Date: Wed, 23 Oct 2013 08:28:01 -0700
Message-Id: <1382542081-36918-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is an old Panasonic module with a Zeevo chip in there that is
not really operating according to Bluetooth core specification when
it comes to setting the IAC LAP for limited discoverable mode.

For reference, this is the vendor information about this module:

  < HCI Command: Read Local Version Information (0x04|0x0001) plen 0
  > HCI Event: Command Complete (0x0e) plen 12
        Read Local Version Information (0x04|0x0001) ncmd 1
          Status: Success (0x00)
          HCI version: Bluetooth 1.2 (0x02) - Revision 196 (0x00c4)
          LMP version: Bluetooth 1.2 (0x02) - Subversion 61 (0x003d)
          Manufacturer: Zeevo, Inc. (18)

The module reports only the support for one IAC at a time. And that
is totally acceptable according to the Bluetooth core specification
since the minimum supported IAC is only one.

  < HCI Command: Read Number of Supported IAC (0x03|0x0038) plen 0
  > HCI Event: Command Complete (0x0e) plen 5
        Read Number of Supported IAC (0x03|0x0038) ncmd 1
          Status: Success (0x00)
          Number of IAC: 1

The problem arises when trying to program two IAC into the module
on a controller that only supports one.

  < HCI Command: Write Current IAC LAP (0x03|0x003a) plen 7
          Number of IAC: 2
          Access code: 0x9e8b00 (Limited Inquiry)
          Access code: 0x9e8b33 (General Inquiry)
  > HCI Event: Command Status (0x0f) plen 4
        Write Current IAC LAP (0x03|0x003a) ncmd 1
          Status: Unknown HCI Command (0x01)

While this looks strange, but according to the Bluetooth core
specification it is a legal operation. The controller has to
ignore the other values and only program as many as it supports.

  This command shall clear any existing IACs and stores Num_Current_IAC
  and the IAC_LAPs in to the controller. If Num_Current_IAC is greater
  than Num_Support_IAC then only the first Num_Support_IAC shall be
  stored in the controller, and a Command Complete event with error
  code Success (0x00) shall be generated.

This specific controller has a bug here and just returns an error. So
in case the number of supported IAC is less than two and the limited
discoverable mode is requested, now only the LIAC is written to
the controller.

  < HCI Command: Write Current IAC LAP (0x03|0x003a) plen 4
          Number of IAC: 1
          Access code: 0x9e8b00 (Limited Inquiry)
  > HCI Event: Command Complete (0x0e) plen 4
        Write Current IAC LAP (0x03|0x003a) ncmd 1
          Status: Success (0x00)

All other controllers that only support one IAC seem to handle this
perfectly fine, but this fix will only write the LIAC for these
controllers as well.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 074d836..22cf547 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1264,7 +1264,7 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 
 		if (cp->val == 0x02) {
 			/* Limited discoverable mode */
-			hci_cp.num_iac = 2;
+			hci_cp.num_iac = min_t(u8, hdev->num_iac, 2);
 			hci_cp.iac_lap[0] = 0x00;	/* LIAC */
 			hci_cp.iac_lap[1] = 0x8b;
 			hci_cp.iac_lap[2] = 0x9e;
-- 
1.8.3.1

