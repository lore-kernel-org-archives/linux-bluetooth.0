Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix authentication check for FIPS security level
Date: Fri, 30 May 2014 14:45:19 +0300
Message-Id: <1401450319-14615-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When checking whether we need to request authentication or not we should
include HCI_SECURITY_FIPS to the levels that always need authentication.
This patch fixes check for it in the hci_outgoing_auth_needed()
function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 492d8d5071c7..6cf9596ff69b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1453,6 +1453,7 @@ static int hci_outgoing_auth_needed(struct hci_dev *hdev,
 	 * is requested.
 	 */
 	if (!hci_conn_ssp_enabled(conn) && !(conn->auth_type & 0x01) &&
+	    conn->pending_sec_level != BT_SECURITY_FIPS &&
 	    conn->pending_sec_level != BT_SECURITY_HIGH &&
 	    conn->pending_sec_level != BT_SECURITY_MEDIUM)
 		return 0;
-- 
1.9.3

