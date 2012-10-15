Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 3/6] Bluetooth: AMP: Drop packets when no l2cap conn exist
Date: Mon, 15 Oct 2012 11:58:41 +0300
Message-Id: <1350291524-13258-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1350291524-13258-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1350051005-6015-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1350291524-13258-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

High Speed hci_conn should always have l2cap_conn associated with it.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/l2cap_core.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 5fd236f..e7bec6c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5579,6 +5579,10 @@ int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 	struct l2cap_hdr *hdr;
 	int len;
 
+	/* For AMP controller do not create l2cap conn */
+	if (!conn && hcon->hdev->dev_type != HCI_BREDR)
+		goto drop;
+
 	if (!conn)
 		conn = l2cap_conn_add(hcon, 0);
 
-- 
1.7.9.5

