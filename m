Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Johan Hedberg <johan.hedberg@nokia.com>
Subject: [PATCH v2] Bluetooth: Add blacklist support for incoming connections
Date: Mon, 17 May 2010 17:47:50 +0200
Message-Id: <1274111270-3265-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

In some circumstances it could be desirable to reject incoming
connections on the baseband level. This patch adds this feature through
two new ioctl's: HCIBLOCKADDR and HCIUNBLOCKADDR. Both take a simple
Bluetooth address as a parameter. BDADDR_ANY can be used with
HCIUNBLOCKADDR to remove all devices from the blacklist.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 fs/compat_ioctl.c                |    2 +
 include/net/bluetooth/hci.h      |    3 +
 include/net/bluetooth/hci_core.h |    8 +++
 net/bluetooth/hci_core.c         |    2 +
 net/bluetooth/hci_event.c        |    2 +-
 net/bluetooth/hci_sock.c         |   90 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 106 insertions(+), 1 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 641640d..1863896 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -1328,6 +1328,8 @@ COMPATIBLE_IOCTL(HCISETLINKPOL)
 COMPATIBLE_IOCTL(HCISETLINKMODE)
 COMPATIBLE_IOCTL(HCISETACLMTU)
 COMPATIBLE_IOCTL(HCISETSCOMTU)
+COMPATIBLE_IOCTL(HCIBLOCKADDR)
+COMPATIBLE_IOCTL(HCIUNBLOCKADDR)
 COMPATIBLE_IOCTL(HCIINQUIRY)
 COMPATIBLE_IOCTL(HCIUARTSETPROTO)
 COMPATIBLE_IOCTL(HCIUARTGETPROTO)
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index fc0c502..ca2518e 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -100,6 +100,9 @@ enum {
 #define HCISETACLMTU	_IOW('H', 227, int)
 #define HCISETSCOMTU	_IOW('H', 228, int)
 
+#define HCIBLOCKADDR	_IOW('H', 230, int)
+#define HCIUNBLOCKADDR	_IOW('H', 231, int)
+
 #define HCIINQUIRY	_IOR('H', 240, int)
 
 /* HCI timeouts */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ce3c99e..ffe7827 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -62,6 +62,11 @@ struct hci_conn_hash {
 	unsigned int     sco_num;
 };
 
+struct bdaddr_list {
+	struct list_head list;
+	bdaddr_t bdaddr;
+};
+
 struct hci_dev {
 	struct list_head list;
 	spinlock_t	lock;
@@ -125,6 +130,7 @@ struct hci_dev {
 
 	struct inquiry_cache	inq_cache;
 	struct hci_conn_hash	conn_hash;
+	struct bdaddr_list	blacklist;
 
 	struct hci_dev_stats	stat;
 
@@ -422,6 +428,8 @@ int hci_get_conn_info(struct hci_dev *hdev, void __user *arg);
 int hci_get_auth_info(struct hci_dev *hdev, void __user *arg);
 int hci_inquiry(void __user *arg);
 
+struct bdaddr_list *hci_blacklist_lookup(struct hci_dev *hdev, bdaddr_t *bdaddr);
+
 void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb);
 
 int hci_recv_frame(struct sk_buff *skb);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 4ad2319..669b0db 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -922,6 +922,8 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	hci_conn_hash_init(hdev);
 
+	INIT_LIST_HEAD(&hdev->blacklist.list);
+
 	memset(&hdev->stat, 0, sizeof(struct hci_dev_stats));
 
 	atomic_set(&hdev->promisc, 0);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6c57fc7..1efaf50 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -952,7 +952,7 @@ static inline void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *sk
 
 	mask |= hci_proto_connect_ind(hdev, &ev->bdaddr, ev->link_type);
 
-	if (mask & HCI_LM_ACCEPT) {
+	if ((mask & HCI_LM_ACCEPT) && !hci_blacklist_lookup(hdev, &ev->bdaddr)) {
 		/* Connection accepted */
 		struct inquiry_entry *ie;
 		struct hci_conn *conn;
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 38f08f6..7668c73 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -165,6 +165,86 @@ static int hci_sock_release(struct socket *sock)
 	return 0;
 }
 
+struct bdaddr_list *hci_blacklist_lookup(struct hci_dev *hdev, bdaddr_t *bdaddr)
+{
+	struct list_head *p;
+	struct bdaddr_list *blacklist = &hdev->blacklist;
+
+	list_for_each(p, &blacklist->list) {
+		struct bdaddr_list *b;
+
+		b = list_entry(p, struct bdaddr_list, list);
+
+		if (bacmp(bdaddr, &b->bdaddr) == 0)
+			return b;
+	}
+
+	return NULL;
+}
+
+static int hci_blacklist_add(struct hci_dev *hdev, void __user *arg)
+{
+	bdaddr_t bdaddr;
+	struct bdaddr_list *entry;
+
+	if (copy_from_user(&bdaddr, arg, sizeof(bdaddr)))
+		return -EFAULT;
+
+	if (bacmp(&bdaddr, BDADDR_ANY) == 0)
+		return -EBADF;
+
+	if (hci_blacklist_lookup(hdev, &bdaddr))
+		return -EEXIST;
+
+	entry = kzalloc(sizeof(struct bdaddr_list), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	bacpy(&entry->bdaddr, &bdaddr);
+
+	list_add(&entry->list, &hdev->blacklist.list);
+
+	return 0;
+}
+
+static int hci_blacklist_clear(struct hci_dev *hdev)
+{
+	struct list_head *p, *n;
+	struct bdaddr_list *blacklist = &hdev->blacklist;
+
+	list_for_each_safe(p, n, &blacklist->list) {
+		struct bdaddr_list *b;
+
+		b = list_entry(p, struct bdaddr_list, list);
+
+		list_del(p);
+		kfree(b);
+	}
+
+	return 0;
+}
+
+static int hci_blacklist_del(struct hci_dev *hdev, void __user *arg)
+{
+	bdaddr_t bdaddr;
+	struct bdaddr_list *entry;
+
+	if (copy_from_user(&bdaddr, arg, sizeof(bdaddr)))
+		return -EFAULT;
+
+	if (bacmp(&bdaddr, BDADDR_ANY) == 0)
+		return hci_blacklist_clear(hdev);
+
+	entry = hci_blacklist_lookup(hdev, &bdaddr);
+	if (!entry)
+		return -ENOENT;
+
+	list_del(&entry->list);
+	kfree(entry);
+
+	return 0;
+}
+
 /* Ioctls that require bound socket */
 static inline int hci_sock_bound_ioctl(struct sock *sk, unsigned int cmd, unsigned long arg)
 {
@@ -194,6 +274,16 @@ static inline int hci_sock_bound_ioctl(struct sock *sk, unsigned int cmd, unsign
 	case HCIGETAUTHINFO:
 		return hci_get_auth_info(hdev, (void __user *) arg);
 
+	case HCIBLOCKADDR:
+		if (!capable(CAP_NET_ADMIN))
+			return -EACCES;
+		return hci_blacklist_add(hdev, (void __user *) arg);
+
+	case HCIUNBLOCKADDR:
+		if (!capable(CAP_NET_ADMIN))
+			return -EACCES;
+		return hci_blacklist_del(hdev, (void __user *) arg);
+
 	default:
 		if (hdev->ioctl)
 			return hdev->ioctl(hdev, cmd, arg);
-- 
1.7.0.4

