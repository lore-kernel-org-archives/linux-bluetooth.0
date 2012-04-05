Return-Path: <cyrus@holtmann.org>
From: Hemant Gupta <hemant.gupta@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Hemant Gupta <hemantgupta.ste@gmail.com>,
	Hemant Gupta <hemant.gupta@stericsson.com>
Subject: [PATCH v1] Bluetooth: mgmt: Fix missing connect failed event for LE
Date: Thu, 5 Apr 2012 16:51:04 +0530
Message-ID: <1333624864-15720-1-git-send-email-hemant.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds management connect failed event when LE Create Connection
Command fails to inform user space that LE Connection failed to get
established.

Signed-off-by: Hemant Gupta <hemant.gupta@stericsson.com>
---
 net/bluetooth/hci_event.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 7325300..bb6d802 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1649,6 +1649,8 @@ static void hci_cs_le_create_conn(struct hci_dev *hdev, __u8 status)
 	if (status) {
 		if (conn && conn->state == BT_CONNECT) {
 			conn->state = BT_CLOSED;
+			mgmt_connect_failed(hdev, &cp->peer_addr, conn->type,
+					    conn->dst_type, status);
 			hci_proto_connect_cfm(conn, status);
 			hci_conn_del(conn);
 		}
-- 
1.7.0.4

