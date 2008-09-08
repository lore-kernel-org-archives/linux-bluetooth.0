Return-Path: <cyrus@holtmann.org>
Message-ID: <48C4E8E6.7090906@access-company.com>
Date: Mon, 08 Sep 2008 10:57:10 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?= <frederic.dalleau@access-company.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <48075B6A.2060308@access-company.com>	<1209058941.12684.37.camel@violet.holtmann.net>	<48355289.7070906@access-company.com>	<5D487EED-A2B2-4AEA-AA7B-9EC8681157C0@holtmann.org>	<48357D9C.9080009@access-company.com>	<486A6392.6080008@access-company.com>
	<1218148463.7819.44.camel@californication>
In-Reply-To: <1218148463.7819.44.camel@californication>
Content-Type: multipart/mixed; boundary="------------020009010801050206090800"
Subject: Re: [Bluez-devel] [patch] BNEP/PAN Qualification issues
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------020009010801050206090800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Marcel,

Great you could start integrating.
Please find attached the remaining patches.

Let me know what you think.

Regards,

Frédéric DALLEAU





Marcel Holtmann a écrit :
> Hi Frederic,
>
>   
>> I'm working at making this easier to integrate but it will makes a bunch 
>> of patches.
>> Let's start with the small and self contained.
>>
>> Resend patch for bluez-utils, and network service timeout  (after 
>> SETUP_CONN_REQ is sent and no answer for  30 sec, disconnect)
>>     
>
> I applied the bluez-utils patches to our 4.x repository.
>
>   
>> Other patch adds a parameter to bnep module for disabling header 
>> compression.
>>     
>
> I am going through that one know.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
> Build the coolest Linux based applications with Moblin SDK & win great prizes
> Grand prize is a trip for two to an Open Source event anywhere in the world
> http://moblin-contest.org/redirect.php?banner_id=100&url=/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>   

--------------020009010801050206090800
Content-Type: text/x-patch;
 name="0001-Add-bnep_not_understood.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-Add-bnep_not_understood.patch"

>>From 27ff0ea542342df8b0de29323cc0de95367bd831 Mon Sep 17 00:00:00 2001
From: fred <fred@fred-laptop.(none)>
Date: Mon, 8 Sep 2008 09:55:38 +0200
Subject: [PATCH] Add bnep_not_understood

---
 net/bluetooth/bnep/bnep.h |    1 +
 net/bluetooth/bnep/core.c |   16 +++++++++++-----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/bnep/bnep.h b/net/bluetooth/bnep/bnep.h
index b69bf4e..7220b05 100644
--- a/net/bluetooth/bnep/bnep.h
+++ b/net/bluetooth/bnep/bnep.h
@@ -166,6 +166,7 @@ struct bnep_session {
 	struct socket    *sock;
 	struct net_device *dev;
 	struct net_device_stats stats;
+	int setup;
 };
 
 void bnep_net_setup(struct net_device *dev);
diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index 80ba30c..1e63938 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -112,6 +112,16 @@ static int bnep_send_rsp(struct bnep_session *s, u8 ctrl, u16 resp)
 	return bnep_send(s, &rsp, sizeof(rsp));
 }
 
+int bnep_not_understood(struct bnep_session *s, u8 cmd)
+{
+	u8 pkt[3];
+	pkt[0] = BNEP_CONTROL;
+	pkt[1] = BNEP_CMD_NOT_UNDERSTOOD;
+	pkt[2] = cmd;
+	bnep_send(s, pkt, sizeof(pkt));
+	return sizeof(pkt);
+}
+
 #ifdef CONFIG_BT_BNEP_PROTO_FILTER
 static inline void bnep_set_default_proto_filter(struct bnep_session *s)
 {
@@ -251,11 +261,7 @@ static int bnep_rx_control(struct bnep_session *s, void *data, int len)
 		break;
 
 	default: {
-			u8 pkt[3];
-			pkt[0] = BNEP_CONTROL;
-			pkt[1] = BNEP_CMD_NOT_UNDERSTOOD;
-			pkt[2] = cmd;
-			bnep_send(s, pkt, sizeof(pkt));
+			bnep_not_understood(s, cmd);
 		}
 		break;
 	}
-- 
1.5.3.GIT


--------------020009010801050206090800
Content-Type: text/x-patch;
	name="0002-Handle-BNEP-setup-CONN-REQ-in-kernel.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="0002-Handle-BNEP-setup-CONN-REQ-in-kernel.patch"

>>From 676acf41cf623e7c21c3c6798ebf29883f6331ff Mon Sep 17 00:00:00 2001
From: fred <fred@fred-laptop.(none)>
Date: Mon, 8 Sep 2008 09:56:44 +0200
Subject: [PATCH] Handle BNEP setup CONN REQ in kernel

---
 net/bluetooth/bnep/core.c |   92 +++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 89 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index 1e63938..8764930 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -236,6 +236,76 @@ static int bnep_ctrl_set_mcfilter(struct bnep_session *s, u8 *data, int len)
 	return 0;
 }
 
+static struct {
+	unsigned char size;
+	unsigned char data[16];
+} uuids[] = {
+{  2, { 0x11, 0x15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 } },
+{  2, { 0x11, 0x16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 } },
+{  2, { 0x11, 0x17, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 } },
+
+{  4, { 0, 0, 0x11, 0x15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 } },
+{  4, { 0, 0, 0x11, 0x16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 } },
+{  4, { 0, 0, 0x11, 0x17, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 } },
+
+{ 16, { 0, 0, 0x11, 0x15, 0, 0, 0x10, 0, 0x80, 0, 0, 0x80, 0x5F, 0x9B, 0x34, 0xFB } },
+{ 16, { 0, 0, 0x11, 0x16, 0, 0, 0x10, 0, 0x80, 0, 0, 0x80, 0x5F, 0x9B, 0x34, 0xFB } },
+{ 16, { 0, 0, 0x11, 0x17, 0, 0, 0x10, 0, 0x80, 0, 0, 0x80, 0x5F, 0x9B, 0x34, 0xFB } },
+};
+
+static int bnep_ctrl_setup_conn_req(struct bnep_session *s, u8 *data, int len)
+{
+	int l = len;
+	int match, i, n, dstsrc = 2;
+	u8 uuid[16];
+
+	if (len < 2)
+		return -EILSEQ;
+
+	n = *data;
+	data ++; len --;
+
+	BT_DBG("len %d n %d", len, n);
+
+	if (n != 2 && n != 4 && n != 16)
+		return -EILSEQ;
+
+	if (len < 2 * n)
+		return -EILSEQ;
+
+	/* Check dest uuid, then source uuid */
+	while (dstsrc) {
+		match = 0;
+
+		for(i = 0; i < n; i++) {
+			uuid[i] = *data;
+			data ++; len --;
+		}
+
+		for(i = 0; i < sizeof(uuids)/sizeof(uuids[0]); i++) {
+			if(uuids[i].size == n && !memcmp(uuid, uuids[i].data, n)) {
+				match = 1;
+				BT_DBG("matched uuid %d (%d bits)", i, n*8);
+				break;
+			}
+		}
+
+		if(!match)
+			goto bad_src;
+
+		dstsrc--;
+	}
+
+	s->setup = 1;
+
+	bnep_send_rsp(s, BNEP_SETUP_CONN_RSP, BNEP_SUCCESS);
+	return l - len;
+
+bad_src:
+	bnep_send_rsp(s, BNEP_SETUP_CONN_RSP, BNEP_CONN_INVALID_SRC);
+	return -1;
+}
+
 static int bnep_rx_control(struct bnep_session *s, void *data, int len)
 {
 	u8  cmd = *(u8 *)data;
@@ -245,19 +315,34 @@ static int bnep_rx_control(struct bnep_session *s, void *data, int len)
 
 	switch (cmd) {
 	case BNEP_CMD_NOT_UNDERSTOOD:
-	case BNEP_SETUP_CONN_REQ:
 	case BNEP_SETUP_CONN_RSP:
 	case BNEP_FILTER_NET_TYPE_RSP:
 	case BNEP_FILTER_MULTI_ADDR_RSP:
 		/* Ignore these for now */
 		break;
 
+	case BNEP_SETUP_CONN_REQ:
+		if (!s->setup) {
+			err = bnep_ctrl_setup_conn_req(s, data, len);
+		} else {
+			bnep_send_rsp(s, BNEP_SETUP_CONN_RSP, BNEP_CONN_NOT_ALLOWED);
+		}
+		break;
+
 	case BNEP_FILTER_NET_TYPE_SET:
-		err = bnep_ctrl_set_netfilter(s, data, len);
+		if (!s->setup) {
+			bnep_not_understood(s, cmd);
+		} else {
+			err = bnep_ctrl_set_netfilter(s, data, len);
+		}
 		break;
 
 	case BNEP_FILTER_MULTI_ADDR_SET:
-		err = bnep_ctrl_set_mcfilter(s, data, len);
+		if (!s->setup) {
+			bnep_not_understood(s, cmd);
+		} else {
+			err = bnep_ctrl_set_mcfilter(s, data, len);
+		}
 		break;
 
 	default: {
@@ -584,6 +669,7 @@ int bnep_add_connection(struct bnep_connadd_req *req, struct socket *sock)
 	s->sock  = sock;
 	s->role  = req->role;
 	s->state = BT_CONNECTED;
+	s->setup = req->flags;
 
 	s->msg.msg_flags = MSG_NOSIGNAL;
 
-- 
1.5.3.GIT


--------------020009010801050206090800
Content-Type: text/x-patch;
	name="0003-Find-cumulative-length-of-extensions.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="0003-Find-cumulative-length-of-extensions.patch"

>>From f637bbf49fef96f6aadc1adfa5581be87d945b91 Mon Sep 17 00:00:00 2001
From: fred <fred@fred-laptop.(none)>
Date: Mon, 8 Sep 2008 09:57:28 +0200
Subject: [PATCH] Find cumulative length of extensions

---
 net/bluetooth/bnep/core.c |   39 +++++++++++++++++++++++++++++----------
 1 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index 8764930..a3c4372 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -139,6 +139,7 @@ static inline void bnep_set_default_proto_filter(struct bnep_session *s)
 
 static int bnep_ctrl_set_netfilter(struct bnep_session *s, __be16 *data, int len)
 {
+	int l = len;
 	int n;
 
 	if (len < 2)
@@ -179,11 +180,12 @@ static int bnep_ctrl_set_netfilter(struct bnep_session *s, __be16 *data, int len
 #else
 	bnep_send_rsp(s, BNEP_FILTER_NET_TYPE_RSP, BNEP_FILTER_UNSUPPORTED_REQ);
 #endif
-	return 0;
+	return l - len;
 }
 
 static int bnep_ctrl_set_mcfilter(struct bnep_session *s, u8 *data, int len)
 {
+	int l = len;
 	int n;
 
 	if (len < 2)
@@ -233,7 +235,7 @@ static int bnep_ctrl_set_mcfilter(struct bnep_session *s, u8 *data, int len)
 #else
 	bnep_send_rsp(s, BNEP_FILTER_MULTI_ADDR_RSP, BNEP_FILTER_UNSUPPORTED_REQ);
 #endif
-	return 0;
+	return l - len;
 }
 
 static struct {
@@ -326,12 +328,14 @@ static int bnep_rx_control(struct bnep_session *s, void *data, int len)
 			err = bnep_ctrl_setup_conn_req(s, data, len);
 		} else {
 			bnep_send_rsp(s, BNEP_SETUP_CONN_RSP, BNEP_CONN_NOT_ALLOWED);
+			err = len;
 		}
 		break;
 
 	case BNEP_FILTER_NET_TYPE_SET:
 		if (!s->setup) {
 			bnep_not_understood(s, cmd);
+			err = len;
 		} else {
 			err = bnep_ctrl_set_netfilter(s, data, len);
 		}
@@ -340,17 +344,20 @@ static int bnep_rx_control(struct bnep_session *s, void *data, int len)
 	case BNEP_FILTER_MULTI_ADDR_SET:
 		if (!s->setup) {
 			bnep_not_understood(s, cmd);
+			err = len;
 		} else {
 			err = bnep_ctrl_set_mcfilter(s, data, len);
 		}
 		break;
 
-	default: {
-			bnep_not_understood(s, cmd);
-		}
+	default:
+		bnep_not_understood(s, cmd);
+		err = len;
 		break;
 	}
 
+	if (err >= 0)
+		err++;
 	return err;
 }
 
@@ -370,11 +377,13 @@ static int bnep_rx_extension(struct bnep_session *s, struct sk_buff *skb)
 
 		switch (h->type & BNEP_TYPE_MASK) {
 		case BNEP_EXT_CONTROL:
-			bnep_rx_control(s, skb->data, skb->len);
+			if (bnep_rx_control(s, skb->data, h->len) != h->len)
+				return -EILSEQ;
 			break;
 
 		default:
 			/* Unknown extension, skip it. */
+			err += sizeof(*h) + h->len;
 			break;
 		}
 
@@ -382,7 +391,7 @@ static int bnep_rx_extension(struct bnep_session *s, struct sk_buff *skb)
 			err = -EILSEQ;
 			break;
 		}
-	} while (!err && (h->type & BNEP_EXT_HEADER));
+	} while (h->type & BNEP_EXT_HEADER);
 
 	return err;
 }
@@ -401,6 +410,7 @@ static inline int bnep_rx_frame(struct bnep_session *s, struct sk_buff *skb)
 	struct net_device *dev = s->dev;
 	struct sk_buff *nskb;
 	u8 type;
+	int ext;
 
 	dev->last_rx = jiffies;
 	s->stats.rx_bytes += skb->len;
@@ -411,7 +421,15 @@ static inline int bnep_rx_frame(struct bnep_session *s, struct sk_buff *skb)
 		goto badframe;
 
 	if ((type & BNEP_TYPE_MASK) == BNEP_CONTROL) {
-		bnep_rx_control(s, skb->data, skb->len);
+		if ((ext = bnep_rx_control(s, skb->data, skb->len)) < 0)
+			goto badframe;
+
+		skb_pull(skb, ext);
+
+		if (type & BNEP_EXT_HEADER) {
+			if ((ext = bnep_rx_extension(s, skb)) < 0)
+				goto badframe;
+		}
 		kfree_skb(skb);
 		return 0;
 	}
@@ -425,9 +443,10 @@ static inline int bnep_rx_frame(struct bnep_session *s, struct sk_buff *skb)
 	s->eh.h_proto = get_unaligned((__be16 *) (skb->data - 2));
 
 	if (type & BNEP_EXT_HEADER) {
-		if (bnep_rx_extension(s, skb) < 0)
+		if ((ext = bnep_rx_extension(s, skb)) < 0)
 			goto badframe;
-	}
+	} else
+		ext = 0;
 
 	/* Strip 802.1p header */
 	if (ntohs(s->eh.h_proto) == 0x8100) {
-- 
1.5.3.GIT


--------------020009010801050206090800
Content-Type: text/x-patch;
	name="0005-Forward-BNEP-packets-containing-extensions.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename*0="0005-Forward-BNEP-packets-containing-extensions.patch"

>>From 2420f247ef05aef15bcfcc9f2bb79e5a0a2a8543 Mon Sep 17 00:00:00 2001
From: fred <fred@fred-laptop.(none)>
Date: Mon, 8 Sep 2008 09:58:03 +0200
Subject: [PATCH] Forward BNEP packets containing extensions

---
 net/bluetooth/bnep/core.c |   44 +++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 43 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index a3491ae..c5042d9 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -410,6 +410,9 @@ static inline int bnep_rx_frame(struct bnep_session *s, struct sk_buff *skb)
 	struct net_device *dev = s->dev;
 	struct sk_buff *nskb;
 	u8 type;
+	struct bnep_session *ss;
+	struct bnep_ext_hdr *h;
+	unsigned char* data;
 	int ext;
 
 	dev->last_rx = jiffies;
@@ -476,7 +479,7 @@ static inline int bnep_rx_frame(struct bnep_session *s, struct sk_buff *skb)
 
 	/* We have to alloc new skb and copy data here :(. Because original skb
 	 * may not be modified and because of the alignment requirements. */
-	nskb = alloc_skb(2 + ETH_HLEN + skb->len, GFP_KERNEL);
+	nskb = alloc_skb(2 + ETH_HLEN + ext + (ext ? 1 : 0) + skb->len, GFP_KERNEL);
 	if (!nskb) {
 		s->stats.rx_dropped++;
 		kfree_skb(skb);
@@ -484,6 +487,13 @@ static inline int bnep_rx_frame(struct bnep_session *s, struct sk_buff *skb)
 	}
 	skb_reserve(nskb, 2);
 
+	/* Add BNEP header for direct forwarding */
+	if (ext > 0) {
+		char hdr = BNEP_GENERAL | BNEP_EXT_HEADER;
+		memcpy(__skb_put(nskb, 1), &hdr, 1);
+		skb_set_mac_header(nskb, nskb->tail - nskb->data);
+	}
+
 	/* Decompress header and construct ether frame */
 	switch (type & BNEP_TYPE_MASK) {
 	case BNEP_COMPRESSED:
@@ -510,10 +520,42 @@ static inline int bnep_rx_frame(struct bnep_session *s, struct sk_buff *skb)
 		break;
 	}
 
+	/* Copy extensions from original packet */
+	if (ext > 0) {
+
+		data = skb_mac_header(skb) + __bnep_rx_hlen[type & BNEP_TYPE_MASK];
+
+		do {
+			h = (void *) data;
+
+			switch (h->type & BNEP_TYPE_MASK) {
+			case BNEP_EXT_CONTROL:
+				/* Control extension is not copied. */
+				break;
+
+			default:
+				/* Unknown extension, forward it. */
+				memcpy(__skb_put(nskb, sizeof(*h) + h->len),
+					data, sizeof(*h) + h->len);
+				break;
+			}
+			data += sizeof(*h) + h->len;
+		} while (h->type & BNEP_EXT_HEADER);
+	}
+
 	skb_copy_from_linear_data(skb, __skb_put(nskb, skb->len), skb->len);
 	kfree_skb(skb);
 
 	s->stats.rx_packets++;
+
+	if (ext > 0) {
+		if ((ss = __bnep_get_session(skb_mac_header(nskb))) != NULL)
+			bnep_send(ss, nskb->data, nskb->len);
+
+		kfree_skb(nskb);
+		return 0;
+	}
+
 	nskb->ip_summed = CHECKSUM_NONE;
 	nskb->protocol  = eth_type_trans(nskb, dev);
 	netif_rx_ni(nskb);
-- 
1.5.3.GIT


--------------020009010801050206090800
Content-Type: text/x-patch;
 name="0006-Add-ksetup-parameter.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0006-Add-ksetup-parameter.patch"

>>From 7de817f39757607f691990584f4b69c8ba2fad65 Mon Sep 17 00:00:00 2001
From: fred <fred@fred-laptop.(none)>
Date: Mon, 8 Sep 2008 10:28:20 +0200
Subject: [PATCH] Add ksetup parameter

---
 net/bluetooth/bnep/core.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index c5042d9..3395b16 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -61,6 +61,7 @@
 
 static int compress_src = 1;
 static int compress_dst = 1;
+static unsigned int ksetup = 1;
 
 static LIST_HEAD(bnep_session_list);
 static DECLARE_RWSEM(bnep_session_sem);
@@ -908,6 +909,9 @@ MODULE_PARM_DESC(compress_src, "Compress sources headers");
 module_param(compress_dst, bool, 0644);
 MODULE_PARM_DESC(compress_dst, "Compress destination headers");
 
+module_param(ksetup, uint, 0644);
+MODULE_PARM_DESC(ksetup, "Present if kernel can handle BNEP_SETUP_CONN_REQ");
+
 MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Bluetooth BNEP ver " VERSION);
 MODULE_VERSION(VERSION);
-- 
1.5.3.GIT


--------------020009010801050206090800
Content-Type: text/x-patch;
	name="utils-0001-Add-support-for-kernel-side-BNEP_SETUP_CONN_REQ.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename*0="utils-0001-Add-support-for-kernel-side-BNEP_SETUP_CONN_REQ.p";
	filename*1="atch"

>>From 8cb22dbab9475f579cd08b9a3e7632a640932e9a Mon Sep 17 00:00:00 2001
From: fred <fred@fred-laptop.(none)>
Date: Mon, 8 Sep 2008 10:28:47 +0200
Subject: [PATCH] Add support for kernel side BNEP_SETUP_CONN_REQ

---
 compat/bnep.c        |   23 ++++++++++++++++++++---
 network/common.c     |    3 ++-
 network/common.h     |    2 +-
 network/connection.c |    2 +-
 network/server.c     |   31 ++++++++++++++++++++++++++-----
 5 files changed, 50 insertions(+), 11 deletions(-)

diff --git a/compat/bnep.c b/compat/bnep.c
index 841e5fa..c47769f 100644
--- a/compat/bnep.c
+++ b/compat/bnep.c
@@ -32,6 +32,8 @@
 #include <stdlib.h>
 #include <sys/socket.h>
 #include <sys/ioctl.h>
+#include <sys/types.h>
+#include <sys/stat.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/l2cap.h>
@@ -180,13 +182,14 @@ int bnep_kill_all_connections(void)
 	return 0;
 }
 
-static int bnep_connadd(int sk, uint16_t role, char *dev)
+static int bnep_connadd(int sk, uint16_t role, char *dev, int setup_done)
 {
 	struct bnep_connadd_req req;
 
 	strncpy(req.device, dev, 16);
 	req.device[15] = '\0';
 	req.sock = sk;
+	req.flags = setup_done;
 	req.role = role;
 	if (ioctl(ctl, bnepconnadd, &req))
 		return -1;
@@ -220,6 +223,20 @@ int bnep_accept_connection(int sk, uint16_t role, char *dev)
 	struct bnep_control_rsp *rsp;
 	unsigned char pkt[BNEP_MTU];
 	int r;
+	FILE *f;
+	int ksetup = 0;
+
+	/* Read BNEP kernel module version number */
+
+	f = fopen("/sys/module/bnep/parameters/ksetup", "rt");
+	if(f) {
+		if(fscanf(f, "%d", &ksetup) != 1)
+			ksetup = 0;
+		fclose(f);
+	}
+
+	if(ksetup)
+		return bnep_connadd(sk, role, dev, 0);
 
 	r = recv(sk, pkt, BNEP_MTU, 0);
 	if (r <= 0)
@@ -243,7 +260,7 @@ int bnep_accept_connection(int sk, uint16_t role, char *dev)
 	if (send(sk, rsp, sizeof(*rsp), 0) < 0)
 		return -1;
 
-	return bnep_connadd(sk, role, dev);
+	return bnep_connadd(sk, role, dev, 1);
 }
 
 /* Create BNEP connection 
@@ -319,5 +336,5 @@ receive:
 		return -1;
 	}
 
-	return bnep_connadd(sk, role, dev);
+	return bnep_connadd(sk, role, dev, 1);
 }
diff --git a/network/common.c b/network/common.c
index 980486f..f7ab8d1 100644
--- a/network/common.c
+++ b/network/common.c
@@ -198,7 +198,7 @@ int bnep_kill_all_connections(void)
 	return 0;
 }
 
-int bnep_connadd(int sk, uint16_t role, char *dev)
+int bnep_connadd(int sk, uint16_t role, char *dev, int setup_done)
 {
 	struct bnep_connadd_req req;
 
@@ -206,6 +206,7 @@ int bnep_connadd(int sk, uint16_t role, char *dev)
 	strncpy(req.device, dev, 16);
 	req.device[15] = '\0';
 	req.sock = sk;
+	req.flags = setup_done;
 	req.role = role;
 	if (ioctl(ctl, BNEPCONNADD, &req) < 0) {
 		int err = errno;
diff --git a/network/common.h b/network/common.h
index 78d0d76..3e421fb 100644
--- a/network/common.h
+++ b/network/common.h
@@ -36,6 +36,6 @@ const char *bnep_name(uint16_t id);
 int bnep_kill_connection(bdaddr_t *dst);
 int bnep_kill_all_connections(void);
 
-int bnep_connadd(int sk, uint16_t role, char *dev);
+int bnep_connadd(int sk, uint16_t role, char *dev, int setup_done);
 int bnep_if_up(const char *devname, uint16_t id);
 int bnep_if_down(const char *devname);
diff --git a/network/connection.c b/network/connection.c
index c17950b..3f574ec 100644
--- a/network/connection.c
+++ b/network/connection.c
@@ -215,7 +215,7 @@ static gboolean bnep_connect_cb(GIOChannel *chan, GIOCondition cond,
 
 	setsockopt(sk, SOL_SOCKET, SO_RCVTIMEO, &timeo, sizeof(timeo));
 
-	if (bnep_connadd(sk, BNEP_SVC_PANU, nc->dev)) {
+	if (bnep_connadd(sk, BNEP_SVC_PANU, nc->dev, 1)) {
 		error("%s could not be added", nc->dev);
 		goto failed;
 	}
diff --git a/network/server.c b/network/server.c
index e283a99..67d18d7 100644
--- a/network/server.c
+++ b/network/server.c
@@ -64,6 +64,7 @@ struct setup_session {
 	uint16_t	src_role;	/* Source role */
 	int		nsk;		/* L2CAP socket */
 	guint		watch;		/* BNEP socket watch */
+	int		ksetup;		/* Kernel does BNEP_SETUP_CONN_REQ */
 };
 
 struct timeout {
@@ -126,7 +127,8 @@ static struct network_server *find_server(GSList *list, uint16_t id)
 }
 
 static struct setup_session *setup_session_new(gchar *address,
-		uint16_t dst_role, uint16_t src_role, int nsk, guint watch)
+		uint16_t dst_role, uint16_t src_role, int nsk,
+		guint watch, int ksetup)
 {
 	struct setup_session *setup;
 
@@ -136,6 +138,7 @@ static struct setup_session *setup_session_new(gchar *address,
 	setup->src_role = src_role;
 	setup->nsk = nsk;
 	setup->watch = watch;
+	setup->ksetup = ksetup;
 
 	return setup;
 }
@@ -298,7 +301,7 @@ static ssize_t send_bnep_ctrl_rsp(int sk, uint16_t val)
 }
 
 static int server_connadd(struct network_server *ns, int nsk,
-			const gchar *address, uint16_t dst_role)
+			const gchar *address, uint16_t dst_role, int ksetup)
 {
 	char devname[16];
 	const char *bridge;
@@ -311,7 +314,7 @@ static int server_connadd(struct network_server *ns, int nsk,
 	memset(devname, 0, 16);
 	strncpy(devname, prefix, strlen(prefix));
 
-	err = bnep_connadd(nsk, dst_role, devname);
+	err = bnep_connadd(nsk, dst_role, devname, !ksetup);
 	if (err < 0)
 		return err;
 
@@ -358,7 +361,7 @@ static void req_auth_cb(DBusError *derr, void *user_data)
 	}
 
 	if (server_connadd(ns, setup->nsk,
-			setup->address, setup->dst_role) < 0)
+			setup->address, setup->dst_role, setup->ksetup) < 0)
 		val = BNEP_CONN_NOT_ALLOWED;
 	else
 		val = BNEP_SUCCESS;
@@ -444,6 +447,8 @@ static gboolean bnep_setup(GIOChannel *chan,
 	char address[18];
 	uint16_t rsp, src_role, dst_role;
 	int n, sk;
+	FILE *f;
+	int ksetup = 0;
 
 	if (cond & G_IO_NVAL)
 		return FALSE;
@@ -455,6 +460,20 @@ static gboolean bnep_setup(GIOChannel *chan,
 
 	sk = g_io_channel_unix_get_fd(chan);
 
+	/* Read BNEP kernel module version number */
+
+	f = fopen("/sys/module/bnep/parameters/ksetup", "rt");
+	if(f) {
+		if(fscanf(f, "%d", &ksetup) != 1)
+			ksetup = 0;
+		fclose(f);
+	}
+
+	if(ksetup) {
+		src_role = dst_role = BNEP_SVC_NAP;
+		goto end_read;
+	}
+
 	/* Reading BNEP_SETUP_CONNECTION_REQUEST_MSG */
 	n = read(sk, packet, sizeof(packet));
 	if (n < 0) {
@@ -473,6 +492,7 @@ static gboolean bnep_setup(GIOChannel *chan,
 	if (rsp)
 		goto reply;
 
+end_read:
 	size = sizeof(sa);
 	if (getsockname(sk, (struct sockaddr *) &sa, &size) < 0) {
 		rsp = BNEP_CONN_NOT_ALLOWED;
@@ -500,7 +520,8 @@ static gboolean bnep_setup(GIOChannel *chan,
 		goto reply;
 	}
 
-	setup = setup_session_new(address, dst_role, src_role, sk, to->watch);
+	setup = setup_session_new(address, dst_role, src_role, sk,
+		to->watch, ksetup);
 
 	/* Wait authorization before reply success */
 	if (authorize_connection(ns, address) < 0) {
-- 
1.5.3.GIT


--------------020009010801050206090800
Content-Type: text/x-patch;
 name="0004-Skip-extensions-not-forwarded.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="0004-Skip-extensions-not-forwarded.patch"

>>From 3487a358cd33c69af4c194ada3904fe29c30eb01 Mon Sep 17 00:00:00 2001
From: fred <fred@fred-laptop.(none)>
Date: Mon, 8 Sep 2008 09:57:46 +0200
Subject: [PATCH] String extensions not forwarded

---
 net/bluetooth/bnep/core.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index a3c4372..a3491ae 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -455,6 +455,25 @@ static inline int bnep_rx_frame(struct bnep_session *s, struct sk_buff *skb)
 		s->eh.h_proto = get_unaligned((__be16 *) (skb->data - 2));
 	}
 
+	/* Strip extensions if they are not to be forwarded */
+	if (ext > 0) {
+		switch (type & BNEP_TYPE_MASK) {
+		case BNEP_COMPRESSED:
+		case BNEP_COMPRESSED_SRC_ONLY:
+			/* Specified destination is this session */
+			ext = 0;
+			break;
+
+		case BNEP_COMPRESSED_DST_ONLY:
+		case BNEP_GENERAL:
+			/* Check if specified destination is this session */
+			if (!compare_ether_addr(skb_mac_header(skb), s->eh.h_dest)) {
+				ext = 0;
+			}
+			break;
+		}
+	}
+
 	/* We have to alloc new skb and copy data here :(. Because original skb
 	 * may not be modified and because of the alignment requirements. */
 	nskb = alloc_skb(2 + ETH_HLEN + skb->len, GFP_KERNEL);
-- 
1.5.3.GIT


--------------020009010801050206090800
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--------------020009010801050206090800
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------020009010801050206090800--
