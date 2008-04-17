Return-Path: <cyrus@holtmann.org>
Message-ID: <48075B6A.2060308@access-company.com>
Date: Thu, 17 Apr 2008 16:15:06 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?= <frederic.dalleau@access-company.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="------------040707060905080201010605"
Subject: [Bluez-devel] [patch] BNEP/PAN Qualification issues
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
--------------040707060905080201010605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit


Hi,

I got my hand over a BNEP and PAN test plan and tried to pass it with 
current PAN implementation (pand, not network service). I met several 
issues and tried to find some solutions to them.

* Handling of 32 and 128 bits uuids,
* Correct response to invalid uuids,
* Respond to control messages before connection setup,
* Handling of bnep extension together with general headers,
* Handling of bnep extensions together with setup connection requests.
* Forwarding of unknown BNEP extensions (not available for broadcast, 
advice requested),
* Give up pan connection after 30 seconds,

The result of that work is two patchs, one for the kernel (based on 
latest git) and one for pand (a bit old that one I fear). However, it 
should be easy to get similar patch for network service.

Let me know if this is of interest for you !

BR,
Frédéric


--------------040707060905080201010605
Content-Type: text/x-patch;
 name="bnep.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bnep.patch"

diff --git a/net/bluetooth/bnep/bnep.h b/net/bluetooth/bnep/bnep.h
index e69244d..8190c3a 100644
--- a/net/bluetooth/bnep/bnep.h
+++ b/net/bluetooth/bnep/bnep.h
@@ -170,6 +170,8 @@ struct bnep_session {
 	struct socket    *sock;
 	struct net_device *dev;
 	struct net_device_stats stats;
+
+	int setup;
 };
 
 void bnep_net_setup(struct net_device *dev);
diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index 347e935..ae3e799 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -113,6 +113,16 @@ static int bnep_send_rsp(struct bnep_session *s, u8 ctrl, u16 resp)
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
@@ -130,6 +140,7 @@ static inline void bnep_set_default_proto_filter(struct bnep_session *s)
 
 static int bnep_ctrl_set_netfilter(struct bnep_session *s, __be16 *data, int len)
 {
+	int l = len;
 	int n;
 
 	if (len < 2)
@@ -170,11 +181,12 @@ static int bnep_ctrl_set_netfilter(struct bnep_session *s, __be16 *data, int len
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
@@ -224,7 +236,77 @@ static int bnep_ctrl_set_mcfilter(struct bnep_session *s, u8 *data, int len)
 #else
 	bnep_send_rsp(s, BNEP_FILTER_MULTI_ADDR_RSP, BNEP_FILTER_UNSUPPORTED_REQ);
 #endif
-	return 0;
+	return l - len;
+}
+
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
 }
 
 static int bnep_rx_control(struct bnep_session *s, void *data, int len)
@@ -236,31 +318,47 @@ static int bnep_rx_control(struct bnep_session *s, void *data, int len)
 
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
+			err = len;
+		}
+		break;
+
 	case BNEP_FILTER_NET_TYPE_SET:
-		err = bnep_ctrl_set_netfilter(s, data, len);
+		if (!s->setup) {
+			bnep_not_understood(s, cmd);
+			err = len;
+		} else {
+			err = bnep_ctrl_set_netfilter(s, data, len);
+		}
 		break;
 
 	case BNEP_FILTER_MULTI_ADDR_SET:
-		err = bnep_ctrl_set_mcfilter(s, data, len);
+		if (!s->setup) {
+			bnep_not_understood(s, cmd);
+			err = len;
+		} else {
+			err = bnep_ctrl_set_mcfilter(s, data, len);
+		}
 		break;
 
-	default: {
-			u8 pkt[3];
-			pkt[0] = BNEP_CONTROL;
-			pkt[1] = BNEP_CMD_NOT_UNDERSTOOD;
-			pkt[2] = cmd;
-			bnep_send(s, pkt, sizeof(pkt));
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
 
@@ -280,11 +378,13 @@ static int bnep_rx_extension(struct bnep_session *s, struct sk_buff *skb)
 
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
 
@@ -292,7 +392,7 @@ static int bnep_rx_extension(struct bnep_session *s, struct sk_buff *skb)
 			err = -EILSEQ;
 			break;
 		}
-	} while (!err && (h->type & BNEP_EXT_HEADER));
+	} while (h->type & BNEP_EXT_HEADER);
 
 	return err;
 }
@@ -311,6 +411,10 @@ static inline int bnep_rx_frame(struct bnep_session *s, struct sk_buff *skb)
 	struct net_device *dev = s->dev;
 	struct sk_buff *nskb;
 	u8 type;
+	struct bnep_session *ss;
+	struct bnep_ext_hdr *h;
+	unsigned char* data;
+	int ext;
 
 	dev->last_rx = jiffies;
 	s->stats.rx_bytes += skb->len;
@@ -321,7 +425,15 @@ static inline int bnep_rx_frame(struct bnep_session *s, struct sk_buff *skb)
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
@@ -335,9 +447,10 @@ static inline int bnep_rx_frame(struct bnep_session *s, struct sk_buff *skb)
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
@@ -346,9 +459,28 @@ static inline int bnep_rx_frame(struct bnep_session *s, struct sk_buff *skb)
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
-	nskb = alloc_skb(2 + ETH_HLEN + skb->len, GFP_KERNEL);
+	nskb = alloc_skb(2 + ETH_HLEN + ext + (ext ? 1 : 0) + skb->len, GFP_KERNEL);
 	if (!nskb) {
 		s->stats.rx_dropped++;
 		kfree_skb(skb);
@@ -356,6 +488,13 @@ static inline int bnep_rx_frame(struct bnep_session *s, struct sk_buff *skb)
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
@@ -382,10 +521,42 @@ static inline int bnep_rx_frame(struct bnep_session *s, struct sk_buff *skb)
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
@@ -574,6 +745,7 @@ int bnep_add_connection(struct bnep_connadd_req *req, struct socket *sock)
 	s->sock  = sock;
 	s->role  = req->role;
 	s->state = BT_CONNECTED;
+	s->setup = req->flags;
 
 	s->msg.msg_flags = MSG_NOSIGNAL;
 

--------------040707060905080201010605
Content-Type: text/x-patch;
 name="pand.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pand.patch"

==== //dev/ALP/main/open-source/bluez-utils/dist/pand/bnep.c#2 - /home/fdalleau/perforce/dev/ALP/main/open-source/bluez-utils/dist/pand/bnep.c ====
183c183
< static int bnep_connadd(int sk, uint16_t role, char *dev)
---
> static int bnep_connadd(int sk, uint16_t role, char *dev, int setup_done)
189a190
> 	req.flags = setup_done;
219,357c220
< 	struct bnep_setup_conn_req *req;
< 	struct bnep_control_rsp *rsp;
< 	unsigned char pkt[BNEP_MTU];
< 	char alignreq[50];
< 	uint16_t *service16;
< 
< 	int r;
< 
< 	r = recv(sk, pkt, BNEP_MTU, 0);
< 	if (r <= 0)
< 		return -1;
< 
< 	errno = EPROTO;
< 
< 	if (r < sizeof(*req))
< 		return -1;
< 
< 	req = (void *) pkt;
< 	if (req->type != BNEP_CONTROL || req->ctrl != BNEP_SETUP_CONN_REQ)
< 		return -1;
< 
< 	/* Check role UUIDs */	
< 
< 	//DST UUID
< 	memcpy(alignreq, &req->service, req->uuid_size);
< 	service16 = (uint16_t *)alignreq;
< 
< 	switch(req->uuid_size) {
< 		case 2:
< 			if((ntohs(*service16) != BNEP_SVC_PANU)
< 				&& (ntohs(*service16) != BNEP_SVC_NAP)
< 				&& (ntohs(*service16) != BNEP_SVC_GN))
< 				goto failed;
< 			break;
< 		case 4:
< 			if(ntohs(*service16) != 0x0000)
< 				goto failed;
< 			service16++;
< 			if((ntohs(*service16) != BNEP_SVC_PANU)
< 				&& (ntohs(*service16) != BNEP_SVC_NAP)
< 				&& (ntohs(*service16) != BNEP_SVC_GN))
< 				goto failed;
< 			break;
< 		case 16:
< 			if(ntohs(*service16) != 0x0000)
< 				goto failed;
< 			service16++;
< 			if((ntohs(*service16) != BNEP_SVC_PANU)
< 				&& (ntohs(*service16) != BNEP_SVC_NAP)
< 				&& (ntohs(*service16) != BNEP_SVC_GN))
< 				goto failed;
< 			service16++;
< 			if(ntohs(*service16) != 0x0000)
< 				goto failed;
< 			service16++;
< 			if(ntohs(*service16) != 0x1000)
< 				goto failed;
< 			service16++;
< 			if(ntohs(*service16) != 0x8000)
< 				goto failed;
< 			service16++;
< 			if(ntohs(*service16) != 0x0080)
< 				goto failed;
< 			service16++;
< 			if(ntohs(*service16) != 0x5F9B)
< 				goto failed;
< 			service16++;
< 			if(ntohs(*service16) != 0x34FB)
< 				goto failed;
< 			break;
< 	}
< 	
< 	//SRC UUID
< 	memcpy(alignreq, ((char*)&req->service)+req->uuid_size, req->uuid_size);
< 	service16 = (uint16_t *)alignreq;
< 
< 	switch(req->uuid_size) {
< 		case 2:
< 			if((ntohs(*service16) != BNEP_SVC_PANU)
< 				&& (ntohs(*service16) != BNEP_SVC_NAP)
< 				&& (ntohs(*service16) != BNEP_SVC_GN))
< 				goto failed;
< 			break;
< 		case 4:
< 			if(ntohs(*service16) != 0x0000)
< 				goto failed;
< 			service16++;
< 			if((ntohs(*service16) != BNEP_SVC_PANU)
< 				&& (ntohs(*service16) != BNEP_SVC_NAP)
< 				&& (ntohs(*service16) != BNEP_SVC_GN))
< 				goto failed;
< 			break;
< 		case 16:
< 			if(ntohs(*service16) != 0x0000)
< 				goto failed;
< 			service16++;
< 			if((ntohs(*service16) != BNEP_SVC_PANU)
< 				&& (ntohs(*service16) != BNEP_SVC_NAP)
< 				&& (ntohs(*service16) != BNEP_SVC_GN))
< 				goto failed;
< 			service16++;
< 			if(ntohs(*service16) != 0x0000)
< 				goto failed;
< 			service16++;
< 			if(ntohs(*service16) != 0x1000)
< 				goto failed;
< 			service16++;
< 			if(ntohs(*service16) != 0x8000)
< 				goto failed;
< 			service16++;
< 			if(ntohs(*service16) != 0x0080)
< 				goto failed;
< 			service16++;
< 			if(ntohs(*service16) != 0x5F9B)
< 				goto failed;
< 			service16++;
< 			if(ntohs(*service16) != 0x34FB)
< 				goto failed;
< 			break;
< 	}
< 
< 	rsp = (void *) pkt;
< 	rsp->type = BNEP_CONTROL;
< 	rsp->ctrl = BNEP_SETUP_CONN_RSP;
< 	rsp->resp = htons(BNEP_SUCCESS);
< 	if (send(sk, rsp, sizeof(*rsp), 0) < 0)
< 		return -1;
< 
< 	return bnep_connadd(sk, role, dev);
< 
< failed:
< 	rsp = (void *) pkt;
< 	rsp->type = BNEP_CONTROL;
< 	rsp->ctrl = BNEP_SETUP_CONN_RSP;
< 	rsp->resp = htons(BNEP_CONN_INVALID_SRC);
< 	if (send(sk, rsp, sizeof(*rsp), 0) < 0)
< 		return -1;
< 
< 	return -1;
---
> 	return bnep_connadd(sk, role, dev, 0);
372a236,238
> 	struct timeval to0;
> 	struct timeval to30 = { 30, 0 };
> 	socklen_t to0s = sizeof(to0);
382a249,251
> 	getsockopt(sk, SOL_SOCKET, SO_RCVTIMEO, &to0, &to0s);
> 	setsockopt(sk, SOL_SOCKET, SO_RCVTIMEO, &to30, sizeof(to30));
> 
391a261,262
> 	setsockopt(sk, SOL_SOCKET, SO_RCVTIMEO, &to0, sizeof(to0));
> 
421c292
< 	return bnep_connadd(sk, role, dev);
---
> 	return bnep_connadd(sk, role, dev, 1);

--------------040707060905080201010605
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--------------040707060905080201010605
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------040707060905080201010605--
