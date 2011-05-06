Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH 12/12] Bluetooth: Set 'peer_addr_type' in hci_le_connect()
Date: Fri,  6 May 2011 14:05:21 -0300
Message-Id: <1304701521-26459-13-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1304701521-26459-1-git-send-email-andre.guedes@openbossa.org>
References: <1304701521-26459-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Set the 'peer_addr_type' field of the LE Create Connection command
sent in hci_le_connect().

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_conn.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index ed9ca28..18081a7 100644
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
1.7.1

