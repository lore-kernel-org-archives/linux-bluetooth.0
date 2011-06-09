Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [bluetooth-next v4 13/16] Bluetooth: Add support for building pairing commands
Date: Thu,  9 Jun 2011 18:50:52 -0300
Message-Id: <1307656255-8659-14-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1307656255-8659-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1307656255-8659-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Before we are able to do a proper exchange of pairing parameters,
we need a unified way of building pairing requests and responses.

For IO Capability we use the value that was set by userspace,
using the management interface.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/smp.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index da46d76..d29700d 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -181,6 +181,17 @@ static void smp_send_cmd(struct l2cap_conn *conn, u8 code, u16 len, void *data)
 	hci_send_acl(conn->hcon, skb, 0);
 }
 
+static void build_pairing_cmd(struct l2cap_conn *conn,
+				struct smp_cmd_pairing *cmd, __u8 authreq)
+{
+	cmd->io_capability = conn->hcon->io_capability;
+	cmd->oob_flag = SMP_OOB_NOT_PRESENT;
+	cmd->max_key_size = 16;
+	cmd->init_key_dist = 0x00;
+	cmd->resp_key_dist = 0x00;
+	cmd->auth_req = authreq;
+}
+
 static void smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct smp_cmd_pairing *rp = (void *) skb->data;
-- 
1.7.5.4

