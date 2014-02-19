Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Don't send store hint for devices using identity addresses
Date: Wed, 19 Feb 2014 11:51:54 -0800
Message-Id: <1392839514-36896-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The identity resolving keys should only be stored for devices using
resolvable random addresses. If the device is already using an
identity address, inform it about the new identity resolving key,
but tell userspace that this key is not persistent.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1daa837da091..e8b9d2f261ee 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4798,7 +4798,22 @@ void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk)
 
 	memset(&ev, 0, sizeof(ev));
 
-	ev.store_hint = 0x01;
+	/* For identity resolving keys from devices that are already
+	 * using a public address or static random address, do not
+	 * ask for storing this key. The identity resolving key really
+	 * is only mandatory for devices using resovlable random
+	 * addresses.
+	 *
+	 * Storing all identity resolving keys has the downside that
+	 * they will be also loaded on next boot of they system. More
+	 * identity resolving keys, means more time during scanning is
+	 * needed to actually resolve these addresses.
+	 */
+	if (bacmp(&irk->rpa, BDADDR_ANY))
+		ev.store_hint = 0x01;
+	else
+		ev.store_hint = 0x00;
+
 	bacpy(&ev.rpa, &irk->rpa);
 	bacpy(&ev.irk.addr.bdaddr, &irk->bdaddr);
 	ev.irk.addr.type = link_to_bdaddr(LE_LINK, irk->addr_type);
-- 
1.8.5.3

