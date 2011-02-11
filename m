Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [bluetooth-next -v2 20/24] Bluetooth: Fix initial security level of LE links
Date: Thu, 10 Feb 2011 22:39:05 -0300
Message-Id: <1297388349-14878-21-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1297388349-14878-20-git-send-email-vinicius.gomes@openbossa.org>
References: <1297388349-14878-1-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-2-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-3-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-4-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-5-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-6-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-7-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-8-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-9-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-10-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-11-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-12-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-13-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-14-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-15-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-16-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-17-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-18-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-19-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-20-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As the default security level (BT_SECURITY_SDP) doesn't make sense for
LE links, initialize LE links with something that makes sense.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/hci_conn.c  |    1 +
 net/bluetooth/hci_event.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 693771c..ee7dcdd 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -53,6 +53,7 @@ static void hci_le_connect(struct hci_conn *conn)
 	conn->state = BT_CONNECT;
 	conn->out = 1;
 	conn->link_mode |= HCI_LM_MASTER;
+	conn->sec_level = BT_SECURITY_LOW;
 
 	memset(&cp, 0, sizeof(cp));
 	cp.scan_interval = cpu_to_le16(0x0004);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6d2ebf2..fece2ee 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2462,6 +2462,7 @@ static inline void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff
 		goto unlock;
 	}
 
+	conn->sec_level = BT_SECURITY_LOW;
 	conn->handle = __le16_to_cpu(ev->handle);
 	conn->state = BT_CONNECTED;
 
-- 
1.7.4

