Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>,
	Timo Mueller <timo.mueller@bmw-carit.de>
Subject: [RFC BlueZ v3 2/8] Bluetooth: Use defines in in hci_get_auth_req()
Date: Fri, 28 Jun 2013 10:56:28 +0200
Message-Id: <1372409794-24688-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1372409794-24688-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1372409794-24688-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Make the code in hci_get_auth_req() more readable by using the
defined macros instead of inlining magic numbers.

Signed-off-by: Mikel Astiz <mikel.astiz@bmw-carit.de>
Signed-off-by: Timo Mueller <timo.mueller@bmw-carit.de>
---
 net/bluetooth/hci_event.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0437200..ce8be0b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3024,17 +3024,20 @@ unlock:
 static u8 hci_get_auth_req(struct hci_conn *conn)
 {
 	/* If remote requests dedicated bonding follow that lead */
-	if (conn->remote_auth == 0x02 || conn->remote_auth == 0x03) {
+	if (conn->remote_auth == HCI_AT_DEDICATED_BONDING ||
+	    conn->remote_auth == HCI_AT_DEDICATED_BONDING_MITM) {
 		/* If both remote and local IO capabilities allow MITM
 		 * protection then require it, otherwise don't */
-		if (conn->remote_cap == 0x03 || conn->io_capability == 0x03)
-			return 0x02;
+		if (conn->remote_cap == HCI_IO_NO_INPUT_OUTPUT ||
+		    conn->io_capability == HCI_IO_NO_INPUT_OUTPUT)
+			return HCI_AT_DEDICATED_BONDING;
 		else
-			return 0x03;
+			return HCI_AT_DEDICATED_BONDING_MITM;
 	}
 
 	/* If remote requests no-bonding follow that lead */
-	if (conn->remote_auth == 0x00 || conn->remote_auth == 0x01)
+	if (conn->remote_auth == HCI_AT_NO_BONDING ||
+	    conn->remote_auth == HCI_AT_NO_BONDING_MITM)
 		return conn->remote_auth | (conn->auth_type & 0x01);
 
 	return conn->auth_type;
-- 
1.8.1.4

