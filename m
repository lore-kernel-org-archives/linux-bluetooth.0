Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/7] Bluetooth: Remove mgmt_set_service_cache
Date: Wed, 14 Dec 2011 23:52:00 +0200
Message-Id: <1323899524-13653-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1323899524-13653-1-git-send-email-johan.hedberg@gmail.com>
References: <1323899524-13653-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Instead of having an explicit service cache command we can make the mgmt
API simpler by implicitly enabling the cache when mgmt_read_info is
called for the first time and disabiling it when mgmt_set_dev_class is
called.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    4 +++
 include/net/bluetooth/mgmt.h     |    5 ---
 net/bluetooth/hci_sock.c         |    7 +++-
 net/bluetooth/mgmt.c             |   56 +++++---------------------------------
 4 files changed, 16 insertions(+), 56 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e34cd71..4e67bb8 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -958,12 +958,16 @@ int mgmt_device_unblocked(struct hci_dev *hdev, bdaddr_t *bdaddr);
 /* HCI info for socket */
 #define hci_pi(sk) ((struct hci_pinfo *) sk)
 
+/* HCI socket flags */
+#define HCI_PI_MGMT_INIT	0
+
 struct hci_pinfo {
 	struct bt_sock    bt;
 	struct hci_dev    *hdev;
 	struct hci_filter filter;
 	__u32             cmsg_mask;
 	unsigned short   channel;
+	unsigned long     flags;
 };
 
 /* HCI security filter */
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index bf217cc..bdb0a58 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -121,11 +121,6 @@ struct mgmt_cp_set_dev_class {
 	__u8 minor;
 } __packed;
 
-#define MGMT_OP_SET_SERVICE_CACHE	0x000C
-struct mgmt_cp_set_service_cache {
-	__u8 enable;
-} __packed;
-
 struct mgmt_link_key_info {
 	bdaddr_t bdaddr;
 	u8 type;
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index f6afe3d..47febe8 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -343,8 +343,11 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr, int addr_le
 	if (haddr.hci_channel > HCI_CHANNEL_CONTROL)
 		return -EINVAL;
 
-	if (haddr.hci_channel == HCI_CHANNEL_CONTROL && !enable_mgmt)
-		return -EINVAL;
+	if (haddr.hci_channel == HCI_CHANNEL_CONTROL) {
+		if (!enable_mgmt)
+			return -EINVAL;
+		set_bit(HCI_PI_MGMT_INIT, &hci_pi(sk)->flags);
+	}
 
 	lock_sock(sk);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 54092c2..25e7bf9 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -316,7 +316,10 @@ static int read_controller_info(struct sock *sk, u16 index)
 
 	hci_dev_lock_bh(hdev);
 
-	set_bit(HCI_MGMT, &hdev->flags);
+	if (test_and_clear_bit(HCI_PI_MGMT_INIT, &hci_pi(sk)->flags)) {
+		set_bit(HCI_MGMT, &hdev->flags);
+		set_bit(HCI_SERVICE_CACHE, &hdev->flags);
+	}
 
 	memset(&rp, 0, sizeof(rp));
 
@@ -989,6 +992,9 @@ static int set_dev_class(struct sock *sk, u16 index, unsigned char *data,
 	hdev->major_class = cp->major;
 	hdev->minor_class = cp->minor;
 
+	if (test_and_clear_bit(HCI_SERVICE_CACHE, &hdev->flags))
+		update_eir(hdev);
+
 	err = update_class(hdev);
 
 	if (err == 0)
@@ -1000,51 +1006,6 @@ static int set_dev_class(struct sock *sk, u16 index, unsigned char *data,
 	return err;
 }
 
-static int set_service_cache(struct sock *sk, u16 index,  unsigned char *data,
-									u16 len)
-{
-	struct hci_dev *hdev;
-	struct mgmt_cp_set_service_cache *cp;
-	int err;
-
-	cp = (void *) data;
-
-	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_SET_SERVICE_CACHE,
-						MGMT_STATUS_INVALID_PARAMS);
-
-	hdev = hci_dev_get(index);
-	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_SET_SERVICE_CACHE,
-						MGMT_STATUS_INVALID_PARAMS);
-
-	hci_dev_lock_bh(hdev);
-
-	BT_DBG("hci%u enable %d", index, cp->enable);
-
-	if (cp->enable) {
-		set_bit(HCI_SERVICE_CACHE, &hdev->flags);
-		err = 0;
-	} else {
-		clear_bit(HCI_SERVICE_CACHE, &hdev->flags);
-		err = update_class(hdev);
-		if (err == 0)
-			err = update_eir(hdev);
-	}
-
-	if (err == 0)
-		err = cmd_complete(sk, index, MGMT_OP_SET_SERVICE_CACHE, NULL,
-									0);
-	else
-		cmd_status(sk, index, MGMT_OP_SET_SERVICE_CACHE, -err);
-
-
-	hci_dev_unlock_bh(hdev);
-	hci_dev_put(hdev);
-
-	return err;
-}
-
 static int load_link_keys(struct sock *sk, u16 index, unsigned char *data,
 								u16 len)
 {
@@ -2170,9 +2131,6 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	case MGMT_OP_SET_DEV_CLASS:
 		err = set_dev_class(sk, index, buf + sizeof(*hdr), len);
 		break;
-	case MGMT_OP_SET_SERVICE_CACHE:
-		err = set_service_cache(sk, index, buf + sizeof(*hdr), len);
-		break;
 	case MGMT_OP_LOAD_LINK_KEYS:
 		err = load_link_keys(sk, index, buf + sizeof(*hdr), len);
 		break;
-- 
1.7.7.3

