Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 13/21] Bluetooth: A2MP: Process A2MP Discover Request
Date: Thu, 10 Nov 2011 16:54:20 +0200
Message-Id: <1320936868-7978-14-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1320936868-7978-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1320936868-7978-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Process A2MP Discover Request, code makes sure that first
controller in the list is BREDR one. Trace is shown below:
...
> ACL data: handle 11 flags 0x02 dlen 16
    A2MP: Discover req: mtu/mps 670 mask: 0x0000
< ACL data: handle 11 flags 0x00 dlen 19
    A2MP: Discover rsp: mtu/mps 670 mask: 0x0000
      Controller list:
        id 0, type 0, status 0x01 (Bluetooth only)
...

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/a2mp.h |    2 +
 net/bluetooth/a2mp.c         |   49 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
index c4cc682..31d98a8 100644
--- a/include/net/bluetooth/a2mp.h
+++ b/include/net/bluetooth/a2mp.h
@@ -15,6 +15,8 @@
 #ifndef __A2MP_H
 #define __A2MP_H
 
+#define A2MP_FEAT_EXT	0x8000
+
 struct amp_mgr {
 	struct list_head	list;
 	struct l2cap_conn	*l2cap_conn;
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 7f931a1..e4ad28d 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -122,6 +122,52 @@ static inline int a2mp_command_rej(struct amp_mgr *mgr, struct sk_buff *skb,
 	return 0;
 }
 
+static inline int a2mp_discover_req(struct amp_mgr *mgr, struct sk_buff *skb,
+							struct a2mp_cmd *hdr)
+{
+	struct a2mp_discov_req *req = (struct a2mp_discov_req *)skb->data;
+	struct a2mp_discov_rsp *rsp;
+	u16 ext_feat;
+	size_t len;
+	u8 num_ctrl;
+
+	if (le16_to_cpu(hdr->len) < sizeof(*req))
+		return -EINVAL;
+
+	skb_pull(skb, sizeof(*req));
+
+	BT_DBG("mtu %d efm 0x%4.4x", le16_to_cpu(req->mtu),
+						le16_to_cpu(req->ext_feat));
+
+	ext_feat = le16_to_cpu(req->ext_feat);
+
+	/* check that packet is not broken for now */
+	while (ext_feat & A2MP_FEAT_EXT) {
+		if (skb->len < sizeof(ext_feat))
+			return -EINVAL;
+
+		ext_feat = get_unaligned_le16(skb->data);
+		BT_DBG("ext_feat 0x%4.4x", le16_to_cpu(req->ext_feat));
+		skb_pull(skb, sizeof(ext_feat));
+	}
+
+	num_ctrl = hci_num_ctrl();
+	len = num_ctrl * sizeof(struct a2mp_cl) + sizeof (*rsp);
+	rsp = kmalloc(len, GFP_KERNEL);
+	if (!rsp)
+		return -ENOMEM;
+
+	rsp->mtu = cpu_to_le16(L2CAP_A2MP_DEFAULT_MTU);
+	rsp->ext_feat = 0;
+
+	__a2mp_add_cl(rsp->cl, num_ctrl);
+
+	a2mp_send(mgr, A2MP_DISCOVER_RSP, hdr->ident, len, rsp);
+
+	kfree(rsp);
+	return 0;
+}
+
 /* Handle A2MP signalling */
 void a2mp_receive(struct sock *sk, struct sk_buff *skb)
 {
@@ -152,6 +198,9 @@ void a2mp_receive(struct sock *sk, struct sk_buff *skb)
 			break;
 
 		case A2MP_DISCOVER_REQ:
+			err = a2mp_discover_req(mgr, skb, hdr);
+			break;
+
 		case A2MP_CHANGE_NOTIFY:
 		case A2MP_GETINFO_REQ:
 		case A2MP_GETAMPASSOC_REQ:
-- 
1.7.4.1

