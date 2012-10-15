Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 5/6] Bluetooth: AMP: Get amp_mgr reference in HS hci_conn
Date: Mon, 15 Oct 2012 11:58:43 +0300
Message-Id: <1350291524-13258-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1350291524-13258-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1350051005-6015-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1350291524-13258-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

When assigning amp_mgr in hci_conn (type AMP_LINK) get also reference.
In hci_conn_del those references would be put for both types.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/amp.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
index 59da0f1..e525e23 100644
--- a/net/bluetooth/amp.c
+++ b/net/bluetooth/amp.c
@@ -123,9 +123,11 @@ struct hci_conn *phylink_add(struct hci_dev *hdev, struct amp_mgr *mgr,
 	hcon->attempt++;
 	hcon->handle = __next_handle(mgr);
 	hcon->remote_id = remote_id;
-	hcon->amp_mgr = mgr;
 	hcon->out = out;
 
+	hcon->amp_mgr = mgr;
+	amp_mgr_get(mgr);
+
 	return hcon;
 }
 
-- 
1.7.9.5

