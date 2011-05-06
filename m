Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 2/2] Bluetooth: Add support for disconnecting LE links via mgmt
Date: Fri,  6 May 2011 18:41:44 -0300
Message-Id: <1304718104-6448-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1304718104-6448-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1304718104-6448-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If we can't find a ACL link between the devices, we search
the connection list one second time looking for LE links.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/mgmt.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 2481d25..dae382c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1033,6 +1033,9 @@ static int disconnect(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	}
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &cp->bdaddr);
+	if (!conn)
+		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &cp->bdaddr);
+
 	if (!conn) {
 		err = cmd_status(sk, index, MGMT_OP_DISCONNECT, ENOTCONN);
 		goto failed;
-- 
1.7.4.3

