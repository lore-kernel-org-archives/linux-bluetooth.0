Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 5/5] Bluetooth: Add type information to the hci_connect() debug statement
Date: Wed, 30 May 2012 21:20:20 -0300
Message-Id: <1338423620-32578-5-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1338423620-32578-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1338423620-32578-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now that we have a "connect" function for each link type, we should be
able to indentify which function is going to be called.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/hci_conn.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 8848a1e..d875c68 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -561,7 +561,7 @@ static struct hci_conn *add_sco_conn(struct hci_dev *hdev, bdaddr_t *dst,
 struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
 			     __u8 dst_type, __u8 sec_level, __u8 auth_type)
 {
-	BT_DBG("%s dst %s", hdev->name, batostr(dst));
+	BT_DBG("%s dst %s type 0x%x", hdev->name, batostr(dst), type);
 
 	switch (type) {
 	case LE_LINK:
-- 
1.7.10.3

