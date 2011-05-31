Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH 4/4] Bluetooth: Set 'peer_addr_type' in hci_le_connect()
Date: Tue, 31 May 2011 14:20:57 -0300
Message-Id: <1306862457-20310-4-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1306862457-20310-1-git-send-email-andre.guedes@openbossa.org>
References: <1306862457-20310-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Set the 'peer_addr_type' field of the LE Create Connection command
sent in hci_le_connect().

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
Acked-by: Ville Tervo <ville.tervo@nokia.com>
---
 net/bluetooth/hci_conn.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index f6729a6..664d77c 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -58,6 +58,7 @@ static void hci_le_connect(struct hci_conn *conn)
 	cp.scan_interval = cpu_to_le16(0x0004);
 	cp.scan_window = cpu_to_le16(0x0004);
 	bacpy(&cp.peer_addr, &conn->dst);
+	cp.peer_addr_type = conn->dst_type;
 	cp.conn_interval_min = cpu_to_le16(0x0008);
 	cp.conn_interval_max = cpu_to_le16(0x0100);
 	cp.supervision_timeout = cpu_to_le16(0x0064);
-- 
1.7.4.1

