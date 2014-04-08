Return-Path: <cyrus@holtmann.org>
From: Timo Mueller <timo.mueller@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>,
	Timo Mueller <timo.mueller@bmw-carit.de>
Subject: [RFCv5 4/4] Bluetooth: Request MITM Protection when initiator
Date: Tue,  8 Apr 2014 14:21:34 +0200
Message-Id: <7d81693e4e83c5d2978eb1e125fc6847820bf8f2.1396943583.git.timo.mueller@bmw-carit.de>
In-Reply-To: <4acef1ec343a64bcce2ed65b9d79df523fad5276.1396943583.git.timo.mueller@bmw-carit.de>
References: <cover.1396943583.git.timo.mueller@bmw-carit.de>
 <4493824f7a251d7345f2120c70e80b673368b475.1396943583.git.timo.mueller@bmw-carit.de>
 <cab20b0aaed6f4543ccbdad89d8e81e379167722.1396943583.git.timo.mueller@bmw-carit.de>
 <4acef1ec343a64bcce2ed65b9d79df523fad5276.1396943583.git.timo.mueller@bmw-carit.de>
In-Reply-To: <cover.1396943583.git.timo.mueller@bmw-carit.de>
References: <cover.1396943583.git.timo.mueller@bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The GAP Specification gives the flexibility to decide whether MITM
Protection is requested or not (Bluetooth Core Specification v4.0
Volume 3, part C, section 6.5.3) when replying to an
HCI_EV_IO_CAPA_REQUEST event.

The recommendation is *not* to set this flag "unless the security
policy of an available local service requires MITM Protection"
(regardless of the bonding type). However, the kernel doesn't
necessarily have this information and therefore the safest choice is
to always use MITM Protection, also for General Bonding.

This patch changes the behavior for the General Bonding initiator
role, always requesting MITM Protection even if no high security level
is used. Depending on the remote capabilities, the protection might
not be actually used, and we will accept this locally unless of course
a high security level was originally required.

Note that this was already done for Dedicated Bonding. No-Bonding is
left unmodified because MITM Protection is normally not desired in
these cases.

Signed-off-by: Mikel Astiz <mikel.astiz@bmw-carit.de>
Signed-off-by: Timo Mueller <timo.mueller@bmw-carit.de>
---
 net/bluetooth/hci_event.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8f76e35..07c37d0 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3467,9 +3467,11 @@ static void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		if (conn->remote_auth == 0xff) {
 			cp.authentication = conn->auth_type;
 
-			/* Use MITM protection for outgoing dedicated bonding */
+			/* Request MITM protection if our IO caps allow it
+			 * except for the no-bonding case
+			 */
 			if (conn->io_capability != HCI_IO_NO_INPUT_OUTPUT &&
-			    cp.authentication == HCI_AT_DEDICATED_BONDING)
+			    cp.authentication != HCI_AT_NO_BONDING)
 				cp.authentication |= 0x01;
 		} else {
 			conn->auth_type = hci_get_auth_req(conn);
-- 
1.9.0

