Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 10/10] Bluetooth: Set store_hint to 0 for non-identity addresses
Date: Wed,  2 Jul 2014 16:36:01 +0300
Message-Id: <1404308161-15100-11-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404308161-15100-1-git-send-email-johan.hedberg@gmail.com>
References: <1404308161-15100-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If we don't have an identity address for connection parameters it's not
very valuable to store them persistently. Therefore, set the store_hint
to 0 in case we don't have an identity address.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index fb1aa0cac137..76cd22a43dec 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5795,6 +5795,9 @@ void mgmt_new_conn_param(struct hci_dev *hdev, bdaddr_t *bdaddr,
 {
 	struct mgmt_ev_new_conn_param ev;
 
+	if (!hci_is_identity_address(bdaddr, bdaddr_type))
+		store_hint = 0x00;
+
 	memset(&ev, 0, sizeof(ev));
 	bacpy(&ev.addr.bdaddr, bdaddr);
 	ev.addr.type = link_to_bdaddr(LE_LINK, bdaddr_type);
-- 
1.9.3

