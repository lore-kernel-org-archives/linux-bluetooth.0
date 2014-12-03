Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 38/49] Bluetooth: Add SC-only mode support for SMP
Date: Wed,  3 Dec 2014 17:02:32 +0200
Message-Id: <1417618963-18010-39-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
References: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When Secure Connections-only mode is enabled we should reject any
pairing command that does not have Secure Connections set in the
authentication requirements. This patch adds the appropriate logic for
this to the command handlers of Pairing Request/Response and Security
Request.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 12294935d258..3a4579b3ab06 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1608,6 +1608,9 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	    (auth & SMP_AUTH_BONDING))
 		return SMP_PAIRING_NOTSUPP;
 
+	if (test_bit(HCI_SC_ONLY, &hdev->dev_flags) && !(auth & SMP_AUTH_SC))
+		return SMP_AUTH_REQUIREMENTS;
+
 	smp->preq[0] = SMP_CMD_PAIRING_REQ;
 	memcpy(&smp->preq[1], req, sizeof(*req));
 	skb_pull(skb, sizeof(*req));
@@ -1752,6 +1755,9 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	auth = rsp->auth_req & AUTH_REQ_MASK(hdev);
 
+	if (test_bit(HCI_SC_ONLY, &hdev->dev_flags) && !(auth & SMP_AUTH_SC))
+		return SMP_AUTH_REQUIREMENTS;
+
 	smp->prsp[0] = SMP_CMD_PAIRING_RSP;
 	memcpy(&smp->prsp[1], rsp, sizeof(*rsp));
 
@@ -2008,6 +2014,9 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	auth = rp->auth_req & AUTH_REQ_MASK(hdev);
 
+	if (test_bit(HCI_SC_ONLY, &hdev->dev_flags) && !(auth & SMP_AUTH_SC))
+		return SMP_AUTH_REQUIREMENTS;
+
 	if (hcon->io_capability == HCI_IO_NO_INPUT_OUTPUT)
 		sec_level = BT_SECURITY_MEDIUM;
 	else
-- 
2.1.0

