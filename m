Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix using the correct source address type
Date: Sat, 12 Nov 2016 17:03:07 +0200
Message-Id: <1478962987-29898-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The hci_get_route() API is used to look up local HCI devices, however
so far it has been incapable of dealing with anything else than the
public address of HCI devices. This completely breaks with LE-only HCI
devices that do not come with a public address, but use a static
random address instead.

This patch exteds the hci_get_route() API with a src_type parameter
that's used for comparing with the right address of each HCI device.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  2 +-
 net/bluetooth/6lowpan.c          |  4 ++--
 net/bluetooth/hci_conn.c         | 26 ++++++++++++++++++++++++--
 net/bluetooth/l2cap_core.c       |  2 +-
 net/bluetooth/rfcomm/tty.c       |  2 +-
 net/bluetooth/sco.c              |  2 +-
 6 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f00bf667ec33..554671c81f4a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1018,7 +1018,7 @@ static inline void hci_set_drvdata(struct hci_dev *hdev, void *data)
 }
 
 struct hci_dev *hci_dev_get(int index);
-struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src);
+struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src, u8 src_type);
 
 struct hci_dev *hci_alloc_dev(void);
 void hci_free_dev(struct hci_dev *hdev);
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index d020299baba4..1904a93f47d5 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -1090,7 +1090,6 @@ static int get_l2cap_conn(char *buf, bdaddr_t *addr, u8 *addr_type,
 {
 	struct hci_conn *hcon;
 	struct hci_dev *hdev;
-	bdaddr_t *src = BDADDR_ANY;
 	int n;
 
 	n = sscanf(buf, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx %hhu",
@@ -1101,7 +1100,8 @@ static int get_l2cap_conn(char *buf, bdaddr_t *addr, u8 *addr_type,
 	if (n < 7)
 		return -EINVAL;
 
-	hdev = hci_get_route(addr, src);
+	/* The LE_PUBLIC address type is ignored because of BDADDR_ANY */
+	hdev = hci_get_route(addr, BDADDR_ANY, BDADDR_LE_PUBLIC);
 	if (!hdev)
 		return -ENOENT;
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 3809617aa98d..dc59eae54717 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -613,7 +613,7 @@ int hci_conn_del(struct hci_conn *conn)
 	return 0;
 }
 
-struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src)
+struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src, uint8_t src_type)
 {
 	int use_src = bacmp(src, BDADDR_ANY);
 	struct hci_dev *hdev = NULL, *d;
@@ -634,7 +634,29 @@ struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src)
 		 */
 
 		if (use_src) {
-			if (!bacmp(&d->bdaddr, src)) {
+			bdaddr_t id_addr;
+			u8 id_addr_type;
+
+			if (src_type == BDADDR_BREDR) {
+				if (!lmp_bredr_capable(d))
+					continue;
+				bacpy(&id_addr, &d->bdaddr);
+				id_addr_type = BDADDR_BREDR;
+			} else {
+				if (!lmp_le_capable(d))
+					continue;
+
+				hci_copy_identity_address(d, &id_addr,
+							  &id_addr_type);
+
+				/* Convert from HCI to three-value type */
+				if (id_addr_type == ADDR_LE_DEV_PUBLIC)
+					id_addr_type = BDADDR_LE_PUBLIC;
+				else
+					id_addr_type = BDADDR_LE_RANDOM;
+			}
+
+			if (!bacmp(&id_addr, src) && id_addr_type == src_type) {
 				hdev = d; break;
 			}
 		} else {
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d4cad29b033f..577f1c01454a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7060,7 +7060,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 	BT_DBG("%pMR -> %pMR (type %u) psm 0x%2.2x", &chan->src, dst,
 	       dst_type, __le16_to_cpu(psm));
 
-	hdev = hci_get_route(dst, &chan->src);
+	hdev = hci_get_route(dst, &chan->src, chan->src_type);
 	if (!hdev)
 		return -EHOSTUNREACH;
 
diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 8e385a0ae60e..2f2cb5e27cdd 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -178,7 +178,7 @@ static void rfcomm_reparent_device(struct rfcomm_dev *dev)
 	struct hci_dev *hdev;
 	struct hci_conn *conn;
 
-	hdev = hci_get_route(&dev->dst, &dev->src);
+	hdev = hci_get_route(&dev->dst, &dev->src, BDADDR_BREDR);
 	if (!hdev)
 		return;
 
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index f52bcbf2e58c..3125ce670c2f 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -219,7 +219,7 @@ static int sco_connect(struct sock *sk)
 
 	BT_DBG("%pMR -> %pMR", &sco_pi(sk)->src, &sco_pi(sk)->dst);
 
-	hdev = hci_get_route(&sco_pi(sk)->dst, &sco_pi(sk)->src);
+	hdev = hci_get_route(&sco_pi(sk)->dst, &sco_pi(sk)->src, BDADDR_BREDR);
 	if (!hdev)
 		return -EHOSTUNREACH;
 
-- 
2.7.4

