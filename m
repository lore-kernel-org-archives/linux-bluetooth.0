Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [bluetooth-next 11/15] Bluetooth: Fix initial security level of LE links
Date: Tue,  5 Apr 2011 22:51:52 -0300
Message-Id: <1302054716-24534-12-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1302054716-24534-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1302054716-24534-1-git-send-email-vinicius.gomes@openbossa.org>
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
index d2ef350..9a4a769 100644
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
index 364e6f9..aa0d013 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2585,6 +2585,7 @@ static inline void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff
 		goto unlock;
 	}
 
+	conn->sec_level = BT_SECURITY_LOW;
 	conn->handle = __le16_to_cpu(ev->handle);
 	conn->state = BT_CONNECTED;
 
-- 
1.7.4.1

