Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 1/5] Bluetooth: Check address in mgmt_disconnect_failed()
Date: Wed, 30 Oct 2013 19:01:40 -0300
Message-Id: <1383170504-16602-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1383170504-16602-1-git-send-email-andre.guedes@openbossa.org>
References: <1383170504-16602-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Check the address and address type in mgmt_disconnect_failed() otherwise
we may wrongly fail the MGMT_OP_DISCONNECT command.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/mgmt.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 22cf547..6a74aa7 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4613,6 +4613,8 @@ void mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
 void mgmt_disconnect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			    u8 link_type, u8 addr_type, u8 status)
 {
+	u8 bdaddr_type = link_to_bdaddr(link_type, addr_type);
+	struct mgmt_cp_disconnect *cp;
 	struct mgmt_rp_disconnect rp;
 	struct pending_cmd *cmd;
 
@@ -4623,8 +4625,16 @@ void mgmt_disconnect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	if (!cmd)
 		return;
 
+	cp = cmd->param;
+
+	if (bacmp(bdaddr, &cp->addr.bdaddr))
+		return;
+
+	if (cp->addr.type != bdaddr_type)
+		return;
+
 	bacpy(&rp.addr.bdaddr, bdaddr);
-	rp.addr.type = link_to_bdaddr(link_type, addr_type);
+	rp.addr.type = bdaddr_type;
 
 	cmd_complete(cmd->sk, cmd->index, MGMT_OP_DISCONNECT,
 		     mgmt_status(status), &rp, sizeof(rp));
-- 
1.8.4

