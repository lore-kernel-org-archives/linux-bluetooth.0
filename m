Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Martin =?ISO-8859-1?Q?R=F6hricht?= <ml@felicis.org>
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="=-OhhAwnvr9Evt5xYmypyu"
Message-Id: <1142257097.10826.34.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-devel] L2CAP Flow Control - 2nd stage
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 13 Mar 2006 14:38:17 +0100


--=-OhhAwnvr9Evt5xYmypyu
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hello together,

I worked on some Flow Control mechanisms on the L2CAP layer for the past
few weeks/months and want to give everybody who is interested in this
work the opportunity to review the code, add comments or get an
overview.
The current status is that I can obtain all necessary information from
incoming information requests and responses as well as configuration
requests and responses. A valid configuration request is parsed and a
reasonable configuration response will be created.
The next step will include to create information requests by ourself and
(especially from the corresponding information responses) to create
configuration requests with all flow control options set.
After that real Flow Control needs to take place and all the logic
behind it will be implemented according to the procedures specified in
Section 8 of the current specification.

Some notes on the current patch:
In my last patch I already created the new function =BBl2cap_get_conf_opt=
=AB
which is only called from within l2cap_parse_conf_opt. This function
checks a parsed option for validity and returns the corresponding result
code (Success or Unacceptable Parameters). This will be the return code
for this specific option, say result[L2CAP_CONF_MTU] for the MTU or
equivalent. Refer to my mail from Feb 13 for more information about the
result codes.
The function =BBl2cap_parse_conf_opt=AB didn't change in logic but became
smaller as parts of the response building process is moved to the
function =BBl2cap_build_conf_rsp=AB which makes the data flow appear more
logically (the parse function should really only parse and not build
anything). Therefore the build_conf_rsp function is now much bigger as
we have to very specific about which option is to be included in our
response (see specification). Whenever we build a response option that
has to be put into a response packet, we call =BBl2cap_add_conf_opt=AB with
the appropriate data.
The function =BBl2cap_build_conf_req=AB is not done yet but should already
work for an MTU option as expected.
At the end I worked on the two functions =BBl2cap_information_req=AB and
=BBl2cap_information_rsp=AB. Both should be able to handle Flow Control
options, but couldn't be tested yet as I lack devices that make use of
this functionality :-/ The latter function sets the flow control bits in
the extended features mask (see section 4.12 in the spec). The next step
would be to use this information in the configuration request building
process (first send an information request, read the response and create
an appropriate configuration request).

That's it for now.

Martin

--=-OhhAwnvr9Evt5xYmypyu
Content-Disposition: attachment; filename=patch-l2cap.2006-03-13
Content-Type: text/x-patch; name=patch-l2cap.2006-03-13; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

diff -urN linux-2.6.15-mh2/include/net/bluetooth/l2cap.h linux-2.6.15-mr/include/net/bluetooth/l2cap.h
--- linux-2.6.15-mh2/include/net/bluetooth/l2cap.h	2006-02-16 11:38:18.000000000 +0100
+++ linux-2.6.15-mr/include/net/bluetooth/l2cap.h	2006-03-13 12:01:10.000000000 +0100
@@ -27,7 +27,10 @@
 
 /* L2CAP defaults */
 #define L2CAP_DEFAULT_MTU	672
+#define L2CAP_MIN_MTU		48
 #define L2CAP_DEFAULT_FLUSH_TO	0xFFFF
+#define L2CAP_MIN_TXW		1
+#define L2CAP_MAX_TXW		32
 
 #define L2CAP_CONN_TIMEOUT	(HZ * 40)
 
@@ -47,6 +50,10 @@
 	__u8  mode;
 };
 
+#define L2CAP_MODE_BASIC	0x00
+#define L2CAP_MODE_RET		0x01
+#define L2CAP_MODE_FLOW		0x02
+
 #define L2CAP_CONNINFO	0x02
 struct l2cap_conninfo {
 	__u16 hci_handle;
@@ -129,8 +136,10 @@
 	__u8       data[0];
 } __attribute__ ((packed));
 
-#define L2CAP_CONF_SUCCESS	0x00
-#define L2CAP_CONF_UNACCEPT	0x01
+#define L2CAP_CONF_SUCCESS	0x0000
+#define L2CAP_CONF_UNACCEPT	0x0001
+#define L2CAP_CONF_REJ		0x0002
+#define L2CAP_CONF_UNKNOWN	0x0003
 
 struct l2cap_conf_opt {
 	__u8       type;
@@ -144,8 +153,20 @@
 #define L2CAP_CONF_QOS		0x03
 #define L2CAP_CONF_RFC		0x04
 
+#define SET_BIT(x, v) ((x) |= 1 << (v))
+#define HAS_BIT(x, v) (((x) & (1 << (v))) != 0)
+
 #define L2CAP_CONF_MAX_SIZE	22
 
+struct l2cap_conf_rfc {
+	u8	mode;
+	u8	txw;
+	u8	maxt;
+	u16	ret_to;
+	u16	mon_to;
+	u16	mps;
+} __attribute__ ((packed));
+
 struct l2cap_disconn_req {
 	__le16     dcid;
 	__le16     scid;
@@ -158,7 +179,6 @@
 
 struct l2cap_info_req {
 	__le16      type;
-	__u8        data[0];
 } __attribute__ ((packed));
 
 struct l2cap_info_rsp {
@@ -168,12 +188,17 @@
 } __attribute__ ((packed));
 
 /* info type */
-#define L2CAP_IT_CL_MTU     0x0001
-#define L2CAP_IT_FEAT_MASK  0x0002
+#define L2CAP_IT_CL_MTU		0x0001
+#define L2CAP_IT_FEAT_MASK	0x0002
+
+/* bits for extended features */
+#define L2CAP_EXT_FCM		0
+#define L2CAP_EXT_RTM		1
+#define L2CAP_EXT_QOS		2
 
 /* info result */
-#define L2CAP_IR_SUCCESS    0x0000
-#define L2CAP_IR_NOTSUPP    0x0001
+#define L2CAP_IR_SUCCESS	0x0000
+#define L2CAP_IR_NOTSUPP	0x0001
 
 /* ----- L2CAP connections ----- */
 struct l2cap_chan_list {
@@ -215,11 +240,39 @@
 	__u16		flush_to;
 
 	__u32		link_mode;
+	/* connectionless MTU size from info response */
+	__u16		info_mtu;
+	/* extended feature mask from info response */
+	__u32		info_ext;
 
 	__u8		conf_state;
 	__u8		conf_retry;
 	__u16		conf_mtu;
 
+	/* Configuration Request RFC Options */
+	__u8		conf_mode;
+	__u8		conf_txw;
+	__u8		conf_maxt;
+	__u16		conf_ret_to;
+	__u16		conf_mon_to;
+	__u16		conf_mps;
+
+	/* incoming RFC Options */
+	__u8		imode;
+	__u8		itxw;
+	__u8		imaxt;
+	__u16		iret_to;
+	__u16		imon_to;
+	__u16		imps;
+
+	/* outgoing RFC Options */
+	__u8		omode;
+	__u8		otxw;
+	__u8		omaxt;
+	__u16		oret_to;
+	__u16		omon_to;
+	__u16		omps;
+
 	__u8		ident;
 
 	struct l2cap_conn	*conn;
diff -urN linux-2.6.15-mh2/net/bluetooth/l2cap.c linux-2.6.15-mr/net/bluetooth/l2cap.c
--- linux-2.6.15-mh2/net/bluetooth/l2cap.c	2006-02-16 11:38:19.000000000 +0100
+++ linux-2.6.15-mr/net/bluetooth/l2cap.c	2006-03-13 12:10:31.000000000 +0100
@@ -1234,162 +1234,361 @@
 	return NULL;
 }
 
-static inline int l2cap_get_conf_opt(void **ptr, int *type, int *olen, unsigned long *val)
+/**
+ * l2cap_check_conf_opt - check an incoming conf option for valid parameters
+ * @sk: corresponding socket
+ * @option: option that's parameters will be checked
+ * @return: result code for this request's option
+ *
+ * All parameters of a particular option from an incoming request will be
+ * checked. The result code for this option (e.g. L2CAP_CONF_UNACCEPT) is
+ * returned.
+ */
+static int l2cap_check_conf_opt(struct sock *sk, int option)
 {
-	struct l2cap_conf_opt *opt = *ptr;
-	int len;
-
-	len = L2CAP_CONF_OPT_SIZE + opt->len;
-	*ptr += len;
-
-	*type = opt->type;
-	*olen = opt->len;
+	int result = L2CAP_CONF_SUCCESS;
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
 
-	switch (opt->len) {
-	case 1:
-		*val = *((__u8 *) opt->val);
+	switch (option) {
+	case L2CAP_CONF_MTU:
+		if (pi->conf_mtu < L2CAP_MIN_MTU)
+			result = L2CAP_CONF_UNACCEPT;
 		break;
-
-	case 2:
-		*val = __le16_to_cpu(*((__le16 *) opt->val));
+	case L2CAP_CONF_FLUSH_TO:
 		break;
-
-	case 4:
-		*val = __le32_to_cpu(*((__le32 *) opt->val));
+	case L2CAP_CONF_QOS:
 		break;
-
-	default:
-		*val = (unsigned long) opt->val;
+	case L2CAP_CONF_RFC:
+		if (pi->conf_mode == L2CAP_MODE_BASIC) {
+			pi->omode = L2CAP_MODE_BASIC;
+			break;
+		}
+		/* Retransmission Mode not supported yet */
+		if (pi->conf_mode != L2CAP_MODE_FLOW) {
+			pi->conf_mode = L2CAP_MODE_FLOW;
+			result = L2CAP_CONF_UNACCEPT;
+		}
+		if (pi->conf_txw < 1 || pi->conf_txw > 32) {
+			pi->conf_txw = 32;
+			result = L2CAP_CONF_UNACCEPT;
+		}
+		if (pi->conf_maxt < 1) {
+			pi->conf_maxt = 8;
+			result = L2CAP_CONF_UNACCEPT;
+		}
+		if (pi->conf_ret_to < 100) {
+			pi->conf_ret_to = 1000;
+			result = L2CAP_CONF_UNACCEPT;
+		}
+		if (pi->conf_mon_to < 100) {
+			pi->conf_mon_to = 1000;
+			result = L2CAP_CONF_UNACCEPT;
+		}
 		break;
 	}
 
-	BT_DBG("type 0x%2.2x len %d val 0x%lx", *type, opt->len, *val);
-	return len;
+	return result;
 }
 
-static inline void l2cap_parse_conf_req(struct sock *sk, void *data, u16 len)
-{
-	int type, hint, olen; 
-	unsigned long val;
-	void *ptr = data;
+/**
+ * l2cap_parse_conf_req - parses a configuration request packet for options
+ * @sk: corresponding socket structure
+ * @data: conf request data that consists of type, length and option data
+ * @len: length of the whole configuration request packet
+ * @result: array (128 Bytes) of collected result codes
+ *
+ * Parses a configuration request that may contain multiple configuration
+ * options. Sets the appropriate configuration request parameters from the
+ * remote peer if all options are valid and understood. Rejects them if
+ * they are malformed and prepares an unknown status for options that we
+ * do not support yet.
+ */
+static inline void l2cap_parse_conf_req(struct sock *sk, void *data, u16 len, u8 *result)
+{
+	struct l2cap_pinfo *cap = l2cap_pi(sk);
+	int type, hint;
+	u8 *ptr = data;
+	u8 options = 0; /* bit flag that indicates which options are set */
+	unsigned int i;
 
 	BT_DBG("sk %p len %d", sk, len);
 
+	memset(result, 255, sizeof(result));
+	result[0] = L2CAP_CONF_SUCCESS;
+
 	while (len >= L2CAP_CONF_OPT_SIZE) {
-		len -= l2cap_get_conf_opt(&ptr, &type, &olen, &val);
+		u8 req_len = *(u8*)(ptr + 1);
+
+		/* Bail out if req length > packet length */
+		if (len < req_len) return;
+		
+		len -= req_len + 2;
+		type = *(u8*)(ptr + 0);
 
 		hint  = type & 0x80;
 		type &= 0x7f;
 
+		BT_DBG("Type: %d len: %d", type, req_len);
+
 		switch (type) {
+		case 0:
+			result[0] = L2CAP_CONF_REJ;
+			break;
 		case L2CAP_CONF_MTU:
-			l2cap_pi(sk)->conf_mtu = val;
+			if (HAS_BIT(options, L2CAP_CONF_MTU)) break;
+			if (req_len != 2) {
+				result[0] = L2CAP_CONF_REJ;
+				break;
+			}
+			cap->conf_mtu = __le16_to_cpup((__le16*)(ptr + 2));
+			SET_BIT(options, L2CAP_CONF_MTU);
+			result[L2CAP_CONF_MTU] = l2cap_check_conf_opt(sk, L2CAP_CONF_MTU);
+			if (result[L2CAP_CONF_MTU] == L2CAP_CONF_UNACCEPT)
+				result[0] = L2CAP_CONF_UNACCEPT;
 			break;
 
+		/* Flush Timeout not supported yet */
+#if 0
 		case L2CAP_CONF_FLUSH_TO:
-			l2cap_pi(sk)->flush_to = val;
+			if (HAS_BIT(options, L2CAP_CONF_FLUSH_TO)) break;
+			if (req_len != 2) {
+				result[0] = L2CAP_CONF_REJ;
+				break;
+			}
+			cap->flush_to = __le16_to_cpup((__le16*)(ptr + 2));
+			result[0] = L2CAP_CONF_UNKNOWN;
+			result[L2CAP_FLUSH_TO] = L2CAP_CONF_UNKNOWN;
+			SET_BIT(options, L2CAP_CONF_FLUSH_TO);
 			break;
+#endif
 
+		/* QoS not supported yet */
+#if 0
 		case L2CAP_CONF_QOS:
+			if (HAS_BIT(options, L2CAP_CONF_QOS)) break;
+			if (req_len != 22) {
+				result[0] = L2CAP_CONF_REJ;
+				break;
+			}
+			result[0] = L2CAP_CONF_UNKNOWN;
+			result[L2CAP_CONF_QOS] = L2CAP_CONF_UNKNOWN;
+			SET_BIT(options, L2CAP_CONF_QOS);
 			break;
+#endif
 
-		default:
-			if (hint)
+		case L2CAP_CONF_RFC: {
+			if (HAS_BIT(options, L2CAP_CONF_RFC)) break;
+			if (req_len != 9) {
+				result[0] = L2CAP_CONF_REJ;
 				break;
+			}
+			cap->conf_mode = *(__u8*)(ptr + 2);
+			cap->conf_txw  = *(__u8*)(ptr + 3);
+			cap->conf_maxt = *(__u8*)(ptr + 4);
+			cap->conf_ret_to = __le16_to_cpup((__le16*)(ptr + 5));
+			cap->conf_mon_to = __le16_to_cpup((__le16*)(ptr + 7));
+			cap->conf_mps    = __le16_to_cpup((__le16*)(ptr + 9));
+			SET_BIT(options, L2CAP_CONF_RFC);
+			result[L2CAP_CONF_RFC] = l2cap_check_conf_opt(sk, L2CAP_CONF_RFC);
+			if (result[L2CAP_CONF_RFC] == L2CAP_CONF_UNACCEPT)
+				result[0] = L2CAP_CONF_UNACCEPT;
+			break;
+		}
 
-			/* FIXME: Reject unknown option */
+		default:
+			result[0] = L2CAP_CONF_UNKNOWN;
+			result[type] = L2CAP_CONF_UNKNOWN;
+			/* Hints are not supported yet */
+			if (hint) 
+				break;
 			break;
 		}
+
+		/* Go to start of (possible) next request */
+		ptr += req_len;
 	}
 }
 
-static void l2cap_add_conf_opt(void **ptr, u8 type, u8 len, unsigned long val)
+/**
+ * l2cap_add_conf_opt - adds a configuration option to a response or request
+ * @ptr: pointer to location where all options are finally stored
+ * @data: data for one option (type, len and all parameters)
+ * @type: option type
+ * @len: option length
+ *
+ * Adds a complete configuration parameter option to a configuration response
+ * or a configuration request.
+ */
+static void l2cap_add_conf_opt(void **ptr, void *data, u8 type, u8 len)
 {
 	struct l2cap_conf_opt *opt = *ptr;
+	int i = 0;
+	u8 *dbg_ptr = data;
 
-	BT_DBG("type 0x%2.2x len %d val 0x%lx", type, len, val);
-
+	BT_DBG("type 0x%2.2x len %d data ", type, len);
+	
 	opt->type = type;
 	opt->len  = len;
 
-	switch (len) {
-	case 1:
-		*((__u8 *) opt->val)  = val;
+	switch (type) {
+	case L2CAP_CONF_MTU:
+		*((__le16 *) opt->val) = cpu_to_le16(*(__le16 *) data);
 		break;
 
-	case 2:
-		*((__le16 *) opt->val) = __cpu_to_le16(val);
-		break;
-
-	case 4:
-		*((__le32 *) opt->val) = __cpu_to_le32(val);
-		break;
-
-	default:
-		memcpy(opt->val, (void *) val, len);
+	case L2CAP_CONF_RFC: {
+		struct l2cap_conf_rfc *tmp = (struct l2cap_conf_rfc *) data;
+		struct l2cap_conf_rfc *rfc = (struct l2cap_conf_rfc *) opt->val;
+		rfc->mode   = tmp->mode;
+		rfc->txw    = tmp->txw;
+		rfc->maxt   = tmp->maxt;
+		rfc->ret_to = tmp->ret_to;
+		rfc->mon_to = tmp->mon_to;
+		rfc->mps    = tmp->mps;
 		break;
 	}
+	}
 
+	/* increase pointer for next (possible) option */
 	*ptr += L2CAP_CONF_OPT_SIZE + len;
 }
 
+/**
+ * l2cap_build_conf_req - Builds a configuration request
+ * @sk: pointer to socket structure
+ * @data: data portion of a conf. request packet (dcid, flags, options)
+ *
+ * The function parameter data is cast into a l2cap_conf_req struct where
+ * another data portion is extracted from. This one corresponds to the
+ * configuration parameter options part (may contain multiple options like
+ * MTU, RFC, ...).
+ * returns the packet's length (dcid, flags and options)
+ */
 static int l2cap_build_conf_req(struct sock *sk, void *data)
 {
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	struct l2cap_conf_req *req = data;
-	void *ptr = req->data;
+	void *conf_opts = req->data;
 
 	BT_DBG("sk %p", sk);
 
 	if (pi->imtu != L2CAP_DEFAULT_MTU)
-		l2cap_add_conf_opt(&ptr, L2CAP_CONF_MTU, 2, pi->imtu);
-
-	/* FIXME: Need actual value of the flush timeout */
-	//if (flush_to != L2CAP_DEFAULT_FLUSH_TO)
-	//   l2cap_add_conf_opt(&ptr, L2CAP_CONF_FLUSH_TO, 2, pi->flush_to);
+		l2cap_add_conf_opt(&conf_opts, &(pi->imtu), L2CAP_CONF_MTU, 2);
 
 	req->dcid  = __cpu_to_le16(pi->dcid);
 	req->flags = __cpu_to_le16(0);
 
-	return ptr - data;
+	return conf_opts - data;
 }
 
-static inline int l2cap_conf_output(struct sock *sk, void **ptr)
-{
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
-	int result = 0;
-
-	/* Configure output options and let the other side know
-	 * which ones we don't like. */
-	if (pi->conf_mtu < pi->omtu) {
-		l2cap_add_conf_opt(ptr, L2CAP_CONF_MTU, 2, pi->omtu);
-		result = L2CAP_CONF_UNACCEPT;
-	} else {
-		pi->omtu = pi->conf_mtu;
-	}
-
-	BT_DBG("sk %p result %d", sk, result);
-	return result;
-}
-
-static int l2cap_build_conf_rsp(struct sock *sk, void *data, int *result)
+/**
+ * l2cap_build_conf_rsp - builds a configuration response
+ * @sk: corresponding socket
+ * @data: data portion of rsp packet (scid, flags, result, config)
+ * @complete: indicates whether C flag is set (0 == incomplete)
+ * @result: pointer to collected result codes of result[128]
+ *
+ * Building a configuration response on base of the collected result codes.
+ * The fundamental result code result[0] delegates the action that is taken.
+ * For each result[i] that is set appropriately the response packet will
+ * be built.
+ * Returns the length of the data field in octets of the command only (does 
+ * not cover the Code, Identifier, and Length field): scid + flags + result +
+ * configuration options.
+ */
+static int l2cap_build_conf_rsp(struct sock *sk, void *data, int complete, u8 *result)
 {
 	struct l2cap_conf_rsp *rsp = data;
-	void *ptr = rsp->data;
+	struct l2cap_pinfo *cap = l2cap_pi(sk);
+	void *conf_opts = rsp->data;
 	u16 flags = 0;
+	int i, len = 0;
 
-	BT_DBG("sk %p complete %d", sk, result ? 1 : 0);
+	BT_DBG("sk %p complete %d", sk, complete ? 1 : 0);
 
-	if (result)
-		*result = l2cap_conf_output(sk, &ptr);
-	else
+	if (result[0] == L2CAP_CONF_SUCCESS) {
+		for (i = 1; i < sizeof(result); ++i) {
+			if (result[i] == L2CAP_CONF_SUCCESS) {
+				switch (i) {
+				case L2CAP_CONF_MTU: {
+					cap->omtu = cap->conf_mtu;
+					len = 2;
+					l2cap_add_conf_opt(&conf_opts, &(cap->omtu), i, len);
+					break;
+				}
+				case L2CAP_CONF_RFC: {
+					struct l2cap_conf_rfc rfc_params;
+					struct l2cap_conf_rfc *val = &rfc_params;
+					cap->omode = cap->conf_mode;
+					cap->otxw  = cap->conf_txw;
+					cap->omaxt = cap->conf_maxt;
+					cap->oret_to = cap->conf_ret_to;
+					cap->omon_to = cap->conf_mon_to;
+					cap->omps = cap->conf_mps;
+					len = 9;
+					val->mode = cap->omode;
+					val->txw  = cap->otxw;
+					val->maxt = cap->omaxt;
+					val->ret_to = cap->oret_to;
+					val->mon_to = cap->omon_to;
+					val->mps = cap->omps;
+					l2cap_add_conf_opt(&conf_opts, val, i, len);
+					break;
+				}
+				}
+			}
+		}
+	}
+	
+	if (result[0] == L2CAP_CONF_UNACCEPT) {
+		for (i = 1; i < sizeof(result); ++i) {
+			if (result[i] == L2CAP_CONF_UNACCEPT) {
+				switch (i) {
+				case L2CAP_CONF_MTU: {
+					__le16 mtu = L2CAP_DEFAULT_MTU;
+					len = 2;
+					l2cap_add_conf_opt(&conf_opts, &mtu, i, len);
+					break;
+				}
+				case L2CAP_CONF_RFC: {
+					struct l2cap_conf_rfc rfc_params;
+					struct l2cap_conf_rfc *val = &rfc_params;
+					val->mode = cap->conf_mode;
+					val->txw  = cap->conf_txw;
+					val->maxt = cap->conf_maxt;
+					val->ret_to = cap->conf_ret_to;
+					val->mon_to = cap->conf_mon_to;
+					val->mps = cap->conf_mps;
+					len = 9;
+					l2cap_add_conf_opt(&conf_opts, val, i, len);
+					break;
+				}
+				}
+			}
+		}
+	}
+	
+	if (result[0] == L2CAP_CONF_REJ) {
+		/* send plain reject response */
+		l2cap_add_conf_opt(&conf_opts, NULL, 0, 0);
+	}
+	
+	if (result[0] == L2CAP_CONF_UNKNOWN) {
+		for (i = 1; i < sizeof(result); ++i) {
+			if (result[i] == L2CAP_CONF_UNKNOWN) {
+				l2cap_add_conf_opt(&conf_opts, NULL, i, 0);
+			}
+		}
+	}
+	
+	if (!complete)
 		flags = 0x0001;
 
 	rsp->scid   = __cpu_to_le16(l2cap_pi(sk)->dcid);
-	rsp->result = __cpu_to_le16(result ? *result : 0);
+	rsp->result = __cpu_to_le16(result[0]);
 	rsp->flags  = __cpu_to_le16(flags);
 
-	return ptr - data;
+	/* return length of actual data */
+	return conf_opts - data;
 }
 
 static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd, u8 *data)
@@ -1480,6 +1679,9 @@
 	return 0;
 }
 
+/**
+ * l2cap_connect_rsp - handles an incoming connection response
+ */
 static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd, u8 *data)
 {
 	struct l2cap_conn_rsp *rsp = (struct l2cap_conn_rsp *) data;
@@ -1507,8 +1709,11 @@
 		sk->sk_state = BT_CONFIG;
 		l2cap_pi(sk)->ident = 0;
 		l2cap_pi(sk)->dcid = dcid;
+		/* TODO: send information request
+		 * l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_INFO_REQ,
+		 * 			l2cap_build_info_req(sk, info), info); */
 		l2cap_pi(sk)->conf_state |= L2CAP_CONF_REQ_SENT;
-
+		/* build configuration request */
 		l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
 					l2cap_build_conf_req(sk, req), req);
 		break;
@@ -1525,13 +1730,19 @@
 	return 0;
 }
 
+/**
+ * l2cap_config_req - handles an incoming configuration request
+ */
 static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd, u8 *data)
 {
 	struct l2cap_conf_req *req = (struct l2cap_conf_req *) data;
 	u16 dcid, flags, cmd_len = __le16_to_cpu(cmd->len);
-	u8 rsp[64];
+	/* allocate memory for response */
+	u8 rsp[128];
 	struct sock *sk;
-	int result;
+	/* collected result codes for max 128 theor. possible options
+	 * result[0] indicates the overall result code for all options */
+	u8 result[128];
 
 	dcid  = __le16_to_cpu(req->dcid);
 	flags = __le16_to_cpu(req->flags);
@@ -1541,20 +1752,21 @@
 	if (!(sk = l2cap_get_chan_by_scid(&conn->chan_list, dcid)))
 		return -ENOENT;
 
-	l2cap_parse_conf_req(sk, req->data, cmd_len - sizeof(*req));
+	l2cap_parse_conf_req(sk, req->data, cmd_len - sizeof(*req), result);
 
 	if (flags & 0x0001) {
-		/* Incomplete config. Send empty response. */
+		/* Incomplete config. */
 		l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP,
-				l2cap_build_conf_rsp(sk, rsp, NULL), rsp);
+				l2cap_build_conf_rsp(sk, rsp, 0, result), rsp);
 		goto unlock;
 	}
 
 	/* Complete config. */
 	l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP,
-			l2cap_build_conf_rsp(sk, rsp, &result), rsp);
+			l2cap_build_conf_rsp(sk, rsp, 1, result), rsp);
 
-	if (result)
+	/* Success */
+	if (result[0])
 		goto unlock;
 
 	/* Output config done */
@@ -1564,7 +1776,7 @@
 		sk->sk_state = BT_CONNECTED;
 		l2cap_chan_ready(sk);
 	} else if (!(l2cap_pi(sk)->conf_state & L2CAP_CONF_REQ_SENT)) {
-		u8 req[64];
+		u8 req[128];
 		l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
 					l2cap_build_conf_req(sk, req), req);
 	}
@@ -1574,6 +1786,9 @@
 	return 0;
 }
 
+/**
+ * l2cap_config_rsp - handles an incoming configuration response
+ */
 static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd, u8 *data)
 {
 	struct l2cap_conf_rsp *rsp = (struct l2cap_conf_rsp *)data;
@@ -1595,7 +1810,7 @@
 
 	case L2CAP_CONF_UNACCEPT:
 		if (++l2cap_pi(sk)->conf_retry < L2CAP_CONF_MAX_RETRIES) {
-			char req[128];
+			u8 req[128];
 			/* It does not make sense to adjust L2CAP parameters
 			 * that are currently defined in the spec. We simply
 			 * resend config request that we sent earlier. It is
@@ -1685,10 +1900,15 @@
 	return 0;
 }
 
+/**
+ * l2cap_information_req - handles an incoming information request
+ */
 static inline int l2cap_information_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd, u8 *data)
 {
 	struct l2cap_info_req *req = (struct l2cap_info_req *) data;
 	struct l2cap_info_rsp rsp;
+	/* length of data field in information response */
+	u8 len_data;
 	u16 type;
 
 	type = __le16_to_cpu(req->type);
@@ -1696,25 +1916,64 @@
 	BT_DBG("type 0x%4.4x", type);
 
 	rsp.type   = __cpu_to_le16(type);
-	rsp.result = __cpu_to_le16(L2CAP_IR_NOTSUPP);
-	l2cap_send_cmd(conn, cmd->ident, L2CAP_INFO_RSP, sizeof(rsp), &rsp);
+	
+	switch (type) {
+	case L2CAP_IT_CL_MTU:
+		len_data = 2;
+		rsp.result  = __cpu_to_le16(L2CAP_IR_SUCCESS);
+		*(__le16 *)(rsp.data) = __cpu_to_le16(L2CAP_DEFAULT_MTU);
+		break;
+	case L2CAP_IT_FEAT_MASK:
+		len_data = 4;
+		rsp.result = __cpu_to_le16(L2CAP_IR_SUCCESS);
+		/* currently only Flow Control Mode supported */
+		SET_BIT(*(rsp.data), L2CAP_EXT_FCM);
+		break;
+	default:
+		len_data = 0;
+		rsp.result = __cpu_to_le16(L2CAP_IR_NOTSUPP);
+		break;
+	}
+
+	l2cap_send_cmd(conn, cmd->ident, L2CAP_INFO_RSP, sizeof(rsp) + len_data, &rsp);
 
 	return 0;
 }
 
+/**
+ * l2cap_information_rsp - handles an incoming information response
+ */
 static inline int l2cap_information_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd, u8 *data)
 {
 	struct l2cap_info_rsp *rsp = (struct l2cap_info_rsp *) data;
 	u16 type, result;
+	struct sock *sk;
 
 	type   = __le16_to_cpu(rsp->type);
 	result = __le16_to_cpu(rsp->result);
+	if (!(sk = l2cap_get_chan_by_ident(&conn->chan_list, cmd->ident)))
+		return 0;
 
 	BT_DBG("type 0x%4.4x result 0x%2.2x", type, result);
 
+	if (result == L2CAP_IR_SUCCESS) {
+		switch (type) {
+		case L2CAP_IT_CL_MTU:
+			l2cap_pi(sk)->info_mtu = __le16_to_cpup((__le16 *) rsp->data);
+			break;
+		case L2CAP_IT_FEAT_MASK:
+			if (HAS_BIT(*(rsp->data), L2CAP_EXT_FCM))
+				SET_BIT(l2cap_pi(sk)->info_ext, L2CAP_EXT_FCM);
+			break;
+		}
+	}
+
 	return 0;
 }
 
+/**
+ * l2cap_sig_channel - handles incoming signals
+ */
 static inline void l2cap_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	u8 *data = skb->data;

--=-OhhAwnvr9Evt5xYmypyu--



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
