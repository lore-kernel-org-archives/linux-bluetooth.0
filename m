Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 3/7] Bluetooth: AMP: Drop packets when no l2cap conn exist
Date: Fri, 12 Oct 2012 17:10:01 +0300
Message-Id: <1350051005-6015-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1350051005-6015-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1350051005-6015-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

HS hci conn should always have l2cap_conn associated with it.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 38f311e..38b058d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5582,6 +5582,10 @@ int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
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

