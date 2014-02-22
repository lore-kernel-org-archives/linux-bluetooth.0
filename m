Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 11/15] Bluetooth: Update local RPA if necessary when connecting LE
Date: Sat, 22 Feb 2014 19:06:41 +0200
Message-Id: <1393088805-28658-12-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393088805-28658-1-git-send-email-johan.hedberg@gmail.com>
References: <1393088805-28658-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When we initiate LE connections we need to regenerate the local RPA in
case it has expired. This patch adds the necessary code for doing this
in the hci_create_le_conn function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_conn.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index bd66c52eff95..325b42afc61e 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -560,6 +560,9 @@ static int hci_create_le_conn(struct hci_conn *conn)
 
 	hci_req_init(&req, hdev);
 
+	if (test_and_clear_bit(HCI_RPA_EXPIRED, &hdev->dev_flags))
+		hci_update_rpa(&req);
+
 	memset(&cp, 0, sizeof(cp));
 	cp.scan_interval = cpu_to_le16(hdev->le_scan_interval);
 	cp.scan_window = cpu_to_le16(hdev->le_scan_window);
-- 
1.8.5.3

