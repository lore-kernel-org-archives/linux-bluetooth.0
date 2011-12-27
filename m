Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 4/5] Bluetooth: Remove local_bh_disable() from hci_sock.c
Date: Tue, 27 Dec 2011 15:28:47 -0200
Message-Id: <1325006928-3338-4-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1325006928-3338-3-git-send-email-padovan@profusion.mobi>
References: <1325006928-3338-1-git-send-email-padovan@profusion.mobi>
 <1325006928-3338-2-git-send-email-padovan@profusion.mobi>
 <1325006928-3338-3-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

Everything is in process context now, we do not need such a call.

Acked-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/hci_sock.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 189a667..896a72f 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -767,7 +767,6 @@ static int hci_sock_dev_event(struct notifier_block *this, unsigned long event,
 		/* Detach sockets from device */
 		read_lock(&hci_sk_list.lock);
 		sk_for_each(sk, node, &hci_sk_list.head) {
-			local_bh_disable();
 			bh_lock_sock_nested(sk);
 			if (hci_pi(sk)->hdev == hdev) {
 				hci_pi(sk)->hdev = NULL;
@@ -778,7 +777,6 @@ static int hci_sock_dev_event(struct notifier_block *this, unsigned long event,
 				hci_dev_put(hdev);
 			}
 			bh_unlock_sock(sk);
-			local_bh_enable();
 		}
 		read_unlock(&hci_sk_list.lock);
 	}
-- 
1.7.7.5

