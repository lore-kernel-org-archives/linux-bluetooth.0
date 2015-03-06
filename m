Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/7] Bluetooth: Add mgmt HCI channel registration API
Date: Fri,  6 Mar 2015 14:10:14 +0200
Message-Id: <1425643820-7644-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1425643820-7644-1-git-send-email-johan.hedberg@gmail.com>
References: <1425643820-7644-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds an API for registering HCI channels with mgmt-like
semantics. For now the only user will be HCI_CHANNEL_CONTROL, but e.g.
6lowpan is intended to use this as well in the future.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h | 17 ++++++++
 net/bluetooth/hci_sock.c         | 85 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 99 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 15c761c1f82a..0c84d48e5517 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1273,6 +1273,23 @@ void hci_send_to_monitor(struct hci_dev *hdev, struct sk_buff *skb);
 
 void hci_sock_dev_event(struct hci_dev *hdev, int event);
 
+struct hci_mgmt_handler {
+	int (*func) (struct sock *sk, struct hci_dev *hdev, void *data,
+		     u16 data_len);
+	bool var_len;
+	size_t data_len;
+};
+
+struct hci_mgmt_chan {
+	struct list_head list;
+	unsigned short channel;
+	size_t handler_count;
+	const struct hci_mgmt_handler *handlers;
+};
+
+int hci_mgmt_chan_register(struct hci_mgmt_chan *c);
+void hci_mgmt_chan_unregister(struct hci_mgmt_chan *c);
+
 /* Management interface */
 #define DISCOV_TYPE_BREDR		(BIT(BDADDR_BREDR))
 #define DISCOV_TYPE_LE			(BIT(BDADDR_LE_PUBLIC) | \
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index cb4bc4883350..0d5ace8922b1 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -31,6 +31,9 @@
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/hci_mon.h>
 
+static LIST_HEAD(mgmt_chan_list);
+static DEFINE_MUTEX(mgmt_chan_list_lock);
+
 static atomic_t monitor_promisc = ATOMIC_INIT(0);
 
 /* ----- HCI socket interface ----- */
@@ -401,6 +404,56 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event)
 	}
 }
 
+static struct hci_mgmt_chan *__hci_mgmt_chan_find(unsigned short channel)
+{
+	struct hci_mgmt_chan *c;
+
+	list_for_each_entry(c, &mgmt_chan_list, list) {
+		if (c->channel == channel)
+			return c;
+	}
+
+	return NULL;
+}
+
+static struct hci_mgmt_chan *hci_mgmt_chan_find(unsigned short channel)
+{
+	struct hci_mgmt_chan *c;
+
+	mutex_lock(&mgmt_chan_list_lock);
+	c = __hci_mgmt_chan_find(channel);
+	mutex_unlock(&mgmt_chan_list_lock);
+
+	return c;
+}
+
+int hci_mgmt_chan_register(struct hci_mgmt_chan *c)
+{
+	if (c->channel < HCI_CHANNEL_CONTROL)
+		return -EINVAL;
+
+	mutex_lock(&mgmt_chan_list_lock);
+	if (__hci_mgmt_chan_find(c->channel)) {
+		mutex_unlock(&mgmt_chan_list_lock);
+		return -EALREADY;
+	}
+
+	list_add_tail(&c->list, &mgmt_chan_list);
+
+	mutex_unlock(&mgmt_chan_list_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL(hci_mgmt_chan_register);
+
+void hci_mgmt_chan_unregister(struct hci_mgmt_chan *c)
+{
+	mutex_lock(&mgmt_chan_list_lock);
+	list_del(&c->list);
+	mutex_unlock(&mgmt_chan_list_lock);
+}
+EXPORT_SYMBOL(hci_mgmt_chan_unregister);
+
 static int hci_sock_release(struct socket *sock)
 {
 	struct sock *sk = sock->sk;
@@ -718,8 +771,22 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 		break;
 
 	default:
-		err = -EINVAL;
-		goto done;
+		if (!hci_mgmt_chan_find(haddr.hci_channel)) {
+			err = -EINVAL;
+			goto done;
+		}
+
+		if (haddr.hci_dev != HCI_DEV_NONE) {
+			err = -EINVAL;
+			goto done;
+		}
+
+		if (!capable(CAP_NET_ADMIN)) {
+			err = -EPERM;
+			goto done;
+		}
+
+		break;
 	}
 
 
@@ -837,6 +904,10 @@ static int hci_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	case HCI_CHANNEL_MONITOR:
 		sock_recv_timestamp(msg, sk, skb);
 		break;
+	default:
+		if (hci_mgmt_chan_find(hci_pi(sk)->channel))
+			sock_recv_timestamp(msg, sk, skb);
+		break;
 	}
 
 	skb_free_datagram(sk, skb);
@@ -848,6 +919,7 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 			    size_t len)
 {
 	struct sock *sk = sock->sk;
+	struct hci_mgmt_chan *chan;
 	struct hci_dev *hdev;
 	struct sk_buff *skb;
 	int err;
@@ -876,7 +948,14 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 		err = -EOPNOTSUPP;
 		goto done;
 	default:
-		err = -EINVAL;
+		mutex_lock(&mgmt_chan_list_lock);
+		chan = __hci_mgmt_chan_find(hci_pi(sk)->channel);
+		if (chan)
+			err = -ENOSYS; /* FIXME: call handler */
+		else
+			err = -EINVAL;
+
+		mutex_unlock(&mgmt_chan_list_lock);
 		goto done;
 	}
 
-- 
2.1.0

