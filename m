Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 10/10] Bluetooth: Don't send connection parameters without identity address
Date: Wed,  2 Jul 2014 17:37:34 +0300
Message-Id: <1404311854-12233-11-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404311854-12233-1-git-send-email-johan.hedberg@gmail.com>
References: <1404311854-12233-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If we don't have an identity address for connection parameters it
doesn't really make sense to send them to user space. Instead just
ignore them for now. Later we can add support for sending them when we
eventually get the identity through pairing.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index fb1aa0cac137..50a0a3ec50b0 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5795,6 +5795,9 @@ void mgmt_new_conn_param(struct hci_dev *hdev, bdaddr_t *bdaddr,
 {
 	struct mgmt_ev_new_conn_param ev;
 
+	if (!hci_is_identity_address(bdaddr, bdaddr_type))
+		return;
+
 	memset(&ev, 0, sizeof(ev));
 	bacpy(&ev.addr.bdaddr, bdaddr);
 	ev.addr.type = link_to_bdaddr(LE_LINK, bdaddr_type);
-- 
1.9.3

