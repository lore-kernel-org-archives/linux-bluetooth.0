Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 8/8] Bluetooth: Fix sending incorrect new_settings for mgmt_set_powered
Date: Wed,  9 Jan 2013 15:29:40 +0200
Message-Id: <1357738180-4128-9-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1357738180-4128-1-git-send-email-johan.hedberg@gmail.com>
References: <1357738180-4128-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The socket from which a mgmt_set_powered command was received should
only receive the command response but no new_settings event.

The mgmt_powered() function which is used to handle the situation with
the HCI_AUTO_OFF flag tries to check for a pending command to know which
socket to skip the event for, but since the pending command hasn't been
added this will not happen.

This patch fixes the issue by adding the pending command for the
HCI_AUTO_OFF case and thereby ensures that mgmt_powered() will skip the
right socket when sending the new_settings event, but still send the
proper response to the socket where the command came from.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index eb9d48a..60afaee 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -787,8 +787,9 @@ static int set_powered(struct sock *sk, struct hci_dev *hdev, void *data,
 		cancel_delayed_work(&hdev->power_off);
 
 		if (cp->val) {
-			err = send_settings_rsp(sk, MGMT_OP_SET_POWERED, hdev);
-			mgmt_powered(hdev, 1);
+			mgmt_pending_add(sk, MGMT_OP_SET_POWERED, hdev,
+					 data, len);
+			err = mgmt_powered(hdev, 1);
 			goto failed;
 		}
 	}
-- 
1.7.10.4

