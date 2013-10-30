Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 2/5] Bluetooth: Add an extra check in mgmt_device_disconnected()
Date: Wed, 30 Oct 2013 19:01:41 -0300
Message-Id: <1383170504-16602-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1383170504-16602-1-git-send-email-andre.guedes@openbossa.org>
References: <1383170504-16602-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds an extra check in mgmt_device_disconnected() so we only
send the "Device Disconnected" event if it is ACL_LINK or LE_LINK link
type.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/mgmt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6a74aa7..a03ca3c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4595,6 +4595,9 @@ void mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	struct mgmt_ev_device_disconnected ev;
 	struct sock *sk = NULL;
 
+	if (link_type != ACL_LINK && link_type != LE_LINK)
+		return;
+
 	mgmt_pending_foreach(MGMT_OP_DISCONNECT, hdev, disconnect_rsp, &sk);
 
 	bacpy(&ev.addr.bdaddr, bdaddr);
-- 
1.8.4

