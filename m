Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v5 3/6] Bluetooth: Use hci_connect_sco directly
Date: Tue, 16 Apr 2013 17:08:37 +0200
Message-Id: <1366124920-10185-4-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1366124920-10185-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1366124920-10185-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hci_connect is a super function for connecting hci protocols. But the
voice_setting parameter is only needed by SCO and security requirements are not
needed for SCO channels. Thus, it makes sense to have a separate function.

Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
---
 include/net/bluetooth/hci_core.h |    2 ++
 net/bluetooth/hci_conn.c         |    9 +++------
 net/bluetooth/sco.c              |    3 +--
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 33f570c..5c6c5b0 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -592,6 +592,8 @@ struct hci_chan *hci_chan_lookup_handle(struct hci_dev *hdev, __u16 handle);
 
 struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
 			     __u8 dst_type, __u8 sec_level, __u8 auth_type);
+struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
+				 __u16 setting);
 int hci_conn_check_link_mode(struct hci_conn *conn);
 int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level);
 int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b1a02ce..61f686b 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -563,13 +563,13 @@ static struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 	return acl;
 }
 
-static struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type,
-				bdaddr_t *dst, u8 sec_level, u8 auth_type)
+struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
+				 __u16 setting)
 {
 	struct hci_conn *acl;
 	struct hci_conn *sco;
 
-	acl = hci_connect_acl(hdev, dst, sec_level, auth_type);
+	acl = hci_connect_acl(hdev, dst, BT_SECURITY_LOW, HCI_AT_NO_BONDING);
 	if (IS_ERR(acl))
 		return acl;
 
@@ -615,9 +615,6 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
 		return hci_connect_le(hdev, dst, dst_type, sec_level, auth_type);
 	case ACL_LINK:
 		return hci_connect_acl(hdev, dst, sec_level, auth_type);
-	case SCO_LINK:
-	case ESCO_LINK:
-		return hci_connect_sco(hdev, type, dst, sec_level, auth_type);
 	}
 
 	return ERR_PTR(-EINVAL);
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 454ab64..4e69923 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -176,8 +176,7 @@ static int sco_connect(struct sock *sk)
 	else
 		type = SCO_LINK;
 
-	hcon = hci_connect(hdev, type, dst, BDADDR_BREDR, BT_SECURITY_LOW,
-			   HCI_AT_NO_BONDING);
+	hcon = hci_connect_sco(hdev, type, dst, sco_pi(sk)->setting);
 	if (IS_ERR(hcon)) {
 		err = PTR_ERR(hcon);
 		goto done;
-- 
1.7.9.5

