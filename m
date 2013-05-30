Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Timo Mueller <timo.mueller@bmw-carit.de>,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v2 2/2] Bluetooth: Use MITM protection when responding LM
Date: Thu, 30 May 2013 11:26:56 +0200
Message-Id: <1369906016-17006-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1369906016-17006-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1369906016-17006-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Timo Mueller <timo.mueller@bmw-carit.de>

A MITM protected SSP associaton model can be used for pairing if both
local and remote IO capabilities are set to something other than
NoInputNoOutput, regardless of the bonding type (dedicated or general).

With these IO capabilities a MITM protected SSP association model has
been used by the Kernel if we are initiating the pairing process
(initiating LM).

When responding to a pairing request (remote device is the initiating
LM) the pairing should also be proteced against MITM attacks, as
proposed in this patch.

Signed-off-by: Timo Mueller <timo.mueller@bmw-carit.de>
Signed-off-by: Mikel Astiz <mikel.astiz@bmw-carit.de>
---
 net/bluetooth/hci_event.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 777a040..ca59623 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3024,22 +3024,19 @@ unlock:
 
 static u8 hci_get_auth_req(struct hci_conn *conn)
 {
-	/* If remote requests dedicated bonding follow that lead */
-	if ((conn->remote_auth & ~0x01) == HCI_AT_DEDICATED_BONDING) {
-		/* If both remote and local IO capabilities allow MITM
-		 * protection then require it, otherwise don't */
-		if (conn->remote_cap == SMP_IO_NO_INPUT_OUTPUT ||
-		    conn->io_capability == SMP_IO_NO_INPUT_OUTPUT)
-			return 0x02;
-		else
-			return 0x03;
-	}
-
 	/* If remote requests no-bonding follow that lead */
 	if ((conn->remote_auth & ~0x01) == HCI_AT_NO_BONDING)
 		return conn->remote_auth | (conn->auth_type & 0x01);
 
-	return conn->auth_type;
+	/* If both remote and local IO capabilities allow MITM protection
+	 * then require it
+	 */
+	if (conn->remote_cap != SMP_IO_NO_INPUT_OUTPUT &&
+	    conn->io_capability != SMP_IO_NO_INPUT_OUTPUT)
+		return conn->remote_auth | 0x01;
+
+	/* No MITM protection possible due to lacking capabilities */
+	return conn->remote_auth & ~0x01;
 }
 
 static void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
-- 
1.8.1.4

