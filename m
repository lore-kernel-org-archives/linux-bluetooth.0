Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix resetting remote authentication requirement after pairing
Date: Thu, 17 Jul 2014 15:12:41 +0300
Message-Id: <1405599161-22759-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When a new hci_conn object the remote SSP authentication requirement is
set to the invalid value 0xff to indicate that it is unknown. Once
pairing completes however the code was leaving it as-is. In case a new
pairing happens over the same connection it is important that we reset
the value back to unknown so that the pairing code doesn't make false
assumptions about the requirements.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 041e5c018891..4c41774aa556 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3880,6 +3880,9 @@ static void hci_simple_pair_complete_evt(struct hci_dev *hdev,
 	if (!conn)
 		goto unlock;
 
+	/* Reset the authentication requirement to unknown */
+	conn->remote_auth = 0xff;
+
 	/* To avoid duplicate auth_failed events to user space we check
 	 * the HCI_CONN_AUTH_PEND flag which will be set if we
 	 * initiated the authentication. A traditional auth_complete
-- 
1.9.3

