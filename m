Return-Path: <cyrus@holtmann.org>
From: "Poulain, Loic" <loic.poulain@intel.com>
To: "marcel@holtmann.org" <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Bluetooth: Remove hci_h4 unused defines
Date: Tue, 1 Apr 2014 14:56:17 +0000
Message-ID: <50C3158CF44D924791C15F1437EF2EC65D65E9@HASMSX104.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

H4 states are not used anymore.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 drivers/bluetooth/hci_h4.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
index 7048a58..66db9a8 100644
--- a/drivers/bluetooth/hci_h4.c
+++ b/drivers/bluetooth/hci_h4.c
@@ -55,13 +55,6 @@ struct h4_struct {
 	struct sk_buff_head txq;
 };
 =

-/* H4 receiver States */
-#define H4_W4_PACKET_TYPE	0
-#define H4_W4_EVENT_HDR		1
-#define H4_W4_ACL_HDR		2
-#define H4_W4_SCO_HDR		3
-#define H4_W4_DATA		4
-
 /* Initialize protocol */
 static int h4_open(struct hci_uart *hu)
 {
-- =

1.8.3.2
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
