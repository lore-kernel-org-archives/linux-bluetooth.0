Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: Fix remove_device behavior for explicit connects
Date: Fri, 16 Oct 2015 08:41:41 +0300
Message-Id: <1444974102-32379-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1444974102-32379-1-git-send-email-johan.hedberg@gmail.com>
References: <1444974102-32379-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Devices undergoing an explicit connect should not have their
conn_params struct removed by the mgmt Remove Device command. This
patch fixes the necessary checks in the command handler to correct the
behavior.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e798d6511a59..50eee6ff1db0 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6386,7 +6386,8 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 			goto unlock;
 		}
 
-		if (params->auto_connect == HCI_AUTO_CONN_DISABLED) {
+		if (params->auto_connect == HCI_AUTO_CONN_DISABLED ||
+		    params->auto_connect == HCI_AUTO_CONN_EXPLICIT) {
 			err = cmd->cmd_complete(cmd,
 						MGMT_STATUS_INVALID_PARAMS);
 			mgmt_pending_remove(cmd);
@@ -6422,6 +6423,10 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 			if (p->auto_connect == HCI_AUTO_CONN_DISABLED)
 				continue;
 			device_removed(sk, hdev, &p->addr, p->addr_type);
+			if (p->explicit_connect) {
+				p->auto_connect = HCI_AUTO_CONN_EXPLICIT;
+				continue;
+			}
 			list_del(&p->action);
 			list_del(&p->list);
 			kfree(p);
-- 
2.4.3

