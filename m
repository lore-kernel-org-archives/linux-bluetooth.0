Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Update sec_level and auth_type for already existing connections
Date: Tue, 15 Jun 2010 15:56:05 +0300
Message-Id: <1276606565-4381-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Ville Tervo <ville.tervo@nokia.com>

Update auth level for already existing connections if it is lower
than required by new connection.

Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
Reviewed-by: Emeltchenko Andrei <andrei.emeltchenko@nokia.com>
Signed-off-by: Luciano Coelho <luciano.coelho@nokia.com>
Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
---
 net/bluetooth/hci_conn.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b10e3cd..800b6b9 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -358,6 +358,11 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
 		acl->sec_level = sec_level;
 		acl->auth_type = auth_type;
 		hci_acl_connect(acl);
+	} else {
+		if (acl->sec_level < sec_level)
+			acl->sec_level = sec_level;
+		if (acl->auth_type < auth_type)
+			acl->auth_type = auth_type;
 	}
 
 	if (type == ACL_LINK)
-- 
1.7.0.4

