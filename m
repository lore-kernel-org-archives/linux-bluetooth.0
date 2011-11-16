Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <padovan@profusion.mobi>
Cc: Brian Gix <bgix@codeaurora.org>
Subject: [PATCH-v4 3/9] Bluetooth: Differentiate LE User Pairing Responses
Date: Wed, 16 Nov 2011 13:53:14 -0800
Message-Id: <1321480400-17397-4-git-send-email-bgix@codeaurora.org>
In-Reply-To: <1321480400-17397-1-git-send-email-bgix@codeaurora.org>
References: <1321480400-17397-1-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Low Energy (LE) pairing responses must be recognized and handled
differently from BR/EDR pairing responses. BR/EDR responses are
handled via HCI commands by the LMP layer, and LE responses are
handled by the Host.

Signed-off-by: Brian Gix <bgix@codeaurora.org>
---
 net/bluetooth/mgmt.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 394222e..c06a05c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1587,6 +1587,30 @@ static int user_pairing_resp(struct sock *sk, u16 index, bdaddr_t *bdaddr,
 		goto done;
 	}
 
+	/*
+	 * Check for an existing ACL link, if present pair via
+	 * HCI commands.
+	 *
+	 * If no ACL link is present, check for an LE link and if
+	 * present, pair via the SMP engine.
+	 *
+	 * If neither ACL nor LE links are present, fail with error.
+	 */
+	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, bdaddr);
+	if (!conn) {
+		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, bdaddr);
+		if (!conn) {
+			err = cmd_status(sk, index, mgmt_op,
+						MGMT_STATUS_NOT_CONNECTED);
+			goto done;
+		}
+
+		/* Continue with pairing via SMP */
+
+		err = cmd_status(sk, index, mgmt_op, MGMT_STATUS_SUCCESS);
+		goto done;
+	}
+
 	cmd = mgmt_pending_add(sk, mgmt_op, hdev, bdaddr, sizeof(*bdaddr));
 	if (!cmd) {
 		err = -ENOMEM;
-- 
1.7.7.2

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum 
