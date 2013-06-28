Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Timo Mueller <timo.mueller@bmw-carit.de>,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v3 6/8] Bluetooth: Use MITM Protection when IO caps allow it
Date: Fri, 28 Jun 2013 10:56:32 +0200
Message-Id: <1372409794-24688-7-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1372409794-24688-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1372409794-24688-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Timo Mueller <timo.mueller@bmw-carit.de>

When responding to a remotely-initiated pairing procedure, a MITM
protected SSP associaton model can be used for pairing if both local
and remote IO capabilities are set to something other than
NoInputNoOutput, regardless of the bonding type (Dedicated or
General).

This was already done for Dedicated Bonding but this patch proposes to
use the same policy for General Bonding as well.

The GAP Specification gives the flexibility to decide whether MITM
Protection is used ot not (Bluetooth Core Specification v4.0 Volume 3,
part C, section 6.5.3).

Note however that the recommendation is *not* to set this flag "unless
the security policy of an available local service requires MITM
Protection" (for both Dedicated and General Bonding). However, the
kernel doesn't necessarily have this information and therefore the
safest choice is to always use MITM Protection, also for General
Bonding.

Signed-off-by: Timo Mueller <timo.mueller@bmw-carit.de>
Signed-off-by: Mikel Astiz <mikel.astiz@bmw-carit.de>
---
 net/bluetooth/hci_event.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 4e5dc5b..283cb3f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3028,11 +3028,6 @@ static u8 hci_get_auth_req(struct hci_conn *conn)
 	    conn->remote_auth == HCI_AT_NO_BONDING_MITM)
 		return conn->remote_auth | (conn->auth_type & 0x01);
 
-	/* For general bonding, use the given auth_type */
-	if (conn->remote_auth == HCI_AT_GENERAL_BONDING ||
-	    conn->remote_auth == HCI_AT_GENERAL_BONDING_MITM)
-		return conn->auth_type;
-
 	/* If both remote and local have enough IO capabilities, require
 	 * MITM protection
 	 */
@@ -3040,8 +3035,8 @@ static u8 hci_get_auth_req(struct hci_conn *conn)
 	    conn->io_capability != HCI_IO_NO_INPUT_OUTPUT)
 		return conn->remote_auth | 0x01;
 
-	/* No MITM protection possible so remove requirement */
-	return conn->remote_auth & ~0x01;
+	/* No MITM protection possible so ignore remote requirement */
+	return (conn->remote_auth & ~0x01) | (conn->auth_type & 0x01);
 }
 
 static void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
-- 
1.8.1.4

