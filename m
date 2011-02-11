Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [bluetooth-next -v2 07/24] Bluetooth: Fix initiated LE connections
Date: Thu, 10 Feb 2011 22:38:52 -0300
Message-Id: <1297388349-14878-8-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1297388349-14878-7-git-send-email-vinicius.gomes@openbossa.org>
References: <1297388349-14878-1-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-2-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-3-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-4-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-5-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-6-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-7-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix LE connections not being marked as master.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/hci_conn.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index aecd78e..efcd2b5 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -52,6 +52,7 @@ static void hci_le_connect(struct hci_conn *conn)
 
 	conn->state = BT_CONNECT;
 	conn->out = 1;
+	conn->link_mode |= HCI_LM_MASTER;
 
 	memset(&cp, 0, sizeof(cp));
 	cp.scan_interval = cpu_to_le16(0x0004);
-- 
1.7.4

