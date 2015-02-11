Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 2/3] Bluetooth: Improve error handling in connect acl
Date: Wed, 11 Feb 2015 12:31:41 +0100
Message-Id: <1423654302-32348-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1423654302-32348-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1423654302-32348-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch -EOPNOTSUPP will be returned by hci_connect_acl for LE
only controllers. If it is dual device with disabled BREDR -ECONNREFUSED
will be returned

Signed-off-by: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
---
 net/bluetooth/hci_conn.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 409c05e..e3263b6 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -864,8 +864,12 @@ struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 {
 	struct hci_conn *acl;
 
-	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
+	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
+		if (lmp_bredr_capable(hdev))
+			return ERR_PTR(-ECONNREFUSED);
+
 		return ERR_PTR(-EOPNOTSUPP);
+	}
 
 	acl = hci_conn_hash_lookup_ba(hdev, ACL_LINK, dst);
 	if (!acl) {
-- 
1.8.4

