Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v4 2/2] Bluetooth: Fix white list handling with resolvable private addresses
Date: Thu, 24 Jul 2014 15:20:58 +0200
Message-Id: <1406208058-15299-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Devices using resolvable private addresses are required to provide
an identity resolving key. These devices can not be found using
the current controller white list support. This means if the kernel
knows about any devices with an identity resolving key, the white
list filtering must be disabled.

However so far the kernel kept identity resolving keys around even
for devices that are not using resolvable private addresses. The
notification to userspace clearly hints to not store the key and
so it is best to just remove the key from the kernel as well at
that point.

With this it easy now to detect when using the white list is
possible or when kernel side resolving of addresses is required.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 12 ++++++++++++
 net/bluetooth/smp.c      | 16 ++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ecff30ab22a0..2e2961a3cf6f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -5468,6 +5468,12 @@ static u8 update_white_list(struct hci_request *req)
 			return 0x00;
 		}
 
+		if (hci_find_irk_by_addr(hdev, &params->addr,
+					 params->addr_type)) {
+			/* White list can not be used with RPAs */
+			return 0x00;
+		}
+
 		white_list_entries++;
 		add_to_white_list(req, params);
 	}
@@ -5486,6 +5492,12 @@ static u8 update_white_list(struct hci_request *req)
 			return 0x00;
 		}
 
+		if (hci_find_irk_by_addr(hdev, &params->addr,
+					 params->addr_type)) {
+			/* White list can not be used with RPAs */
+			return 0x00;
+		}
+
 		white_list_entries++;
 		add_to_white_list(req, params);
 	}
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index e49c83d8b957..a7c344b4acbc 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1291,6 +1291,22 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 		bacpy(&hcon->dst, &smp->remote_irk->bdaddr);
 		hcon->dst_type = smp->remote_irk->addr_type;
 		l2cap_conn_update_id_addr(hcon);
+
+		/* When receiving an indentity resolving key for
+		 * a remote device that does not use a resolvable
+		 * private address, just remove the key so that
+		 * it is possible to use the controller white
+		 * list for scanning.
+		 *
+		 * Userspace will have been told to not store
+		 * this key at this point. So it is safe to
+		 * just remove it.
+		 */
+		if (!bacmp(&smp->remote_irk->rpa, BDADDR_ANY)) {
+			list_del(&smp->remote_irk->list);
+			kfree(smp->remote_irk);
+			smp->remote_irk = NULL;
+		}
 	}
 
 	/* The LTKs and CSRKs should be persistent only if both sides
-- 
1.9.3

