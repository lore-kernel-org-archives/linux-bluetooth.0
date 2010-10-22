Return-Path: <cyrus@holtmann.org>
From: Anderson Briglia <anderson.briglia@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 5/6] Bluetooth: Fix initiated LE connections
Date: Fri, 22 Oct 2010 19:56:59 -0400
Message-Id: <1287791820-22693-6-git-send-email-anderson.briglia@openbossa.org>
In-Reply-To: <linux-bluetooth@vger.kernel.org>
References: <linux-bluetooth@vger.kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

Fix LE connections not being marked as master.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/hci_conn.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index c7309e4..1a48c6a 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -52,6 +52,7 @@ void hci_le_connect(struct hci_conn *conn)
 
 	conn->state = BT_CONNECT;
 	conn->out = 1;
+	conn->link_mode |= HCI_LM_MASTER;
 
 	memset(&cp, 0, sizeof(cp));
 	cp.scan_interval = cpu_to_le16(0x0004);
-- 
1.7.0.4

