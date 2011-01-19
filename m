Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: ville.tervo@nokia.com
Subject: [PATCH 1/5] Revert "Bluetooth: Update sec_level/auth_type for already existing connections"
Date: Wed, 19 Jan 2011 12:06:48 +0530
Message-Id: <1295419012-25717-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1295419012-25717-1-git-send-email-johan.hedberg@gmail.com>
References: <1295419012-25717-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

This reverts commit 045309820afe047920a50de25634dab46a1e851d. That
commit is wrong for two reasons:

- The conn->sec_level should be updated without performing
authentication first (as it's supposed to represent the level of
security that the existing connection has)

- A higher auth_type value doesn't mean "more secure" like the commit
seems to assume. E.g. dedicated bonding with MITM protection is 0x03
whereas general bonding without MITM protection is 0x04. hci_conn_auth
already takes care of updating conn->auth_type so hci_connect doesn't
need to do it.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 net/bluetooth/hci_conn.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 6b90a41..65a3fb5 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -382,11 +382,6 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
 		acl->sec_level = sec_level;
 		acl->auth_type = auth_type;
 		hci_acl_connect(acl);
-	} else {
-		if (acl->sec_level < sec_level)
-			acl->sec_level = sec_level;
-		if (acl->auth_type < auth_type)
-			acl->auth_type = auth_type;
 	}
 
 	if (type == ACL_LINK)
-- 
1.7.2.3

