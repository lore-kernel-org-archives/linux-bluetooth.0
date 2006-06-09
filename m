Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Martin =?ISO-8859-1?Q?R=F6hricht?= <ml@felicis.org>
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="=-tYVHGRAlAeV33ckwoQl1"
Date: Fri, 09 Jun 2006 13:41:17 +0200
Message-Id: <1149853277.13058.10.camel@bart.T-Online.de>
Mime-Version: 1.0
Subject: [Bluez-devel] L2CAP Flow Control 4th stage
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--=-tYVHGRAlAeV33ckwoQl1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello together,

this is an update for the last version of my L2CAP Flow Control Patch.
Note that there is still no flow control in action, but the
configuration process should be matched with this patch. The next step
is to implement the flow control mechanisms itself.

I fixed some bugs, mainly one really bad deadlock that occurred
frequently on SMP machines or preemptible kernels. One socket lock had
to be released in l2cap_information_rsp() (see the bh_unlock_sock(sk)
statement at the end of the function). Further more I removed my macros
HAS_BIT() and SET_BIT() and tried to switch to test_bit() and set_bit()
from <asm/bitops.h> where appropriate.
Notably is the small implementation of the command reject, too.

I noticed that there is <linux/capability.h> included. Does anybody
what's that for?

I think that's it for the moment.

Martin

--=-tYVHGRAlAeV33ckwoQl1
Content-Disposition: attachment; filename=patch-l2cap.2006-06-09
Content-Type: text/x-patch; name=patch-l2cap.2006-06-09; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -urN linux-2.6.16-mh2/include/net/bluetooth/l2cap.h linux-2.6.16-mr/include/net/bluetooth/l2cap.h
--- linux-2.6.16-mh2/include/net/bluetooth/l2cap.h	2006-06-09 13:03:53.000000000 +0200
+++ linux-2.6.16-mr/include/net/bluetooth/l2cap.h	2006-06-09 13:06:33.000000000 +0200
@@ -27,7 +27,19 @@
 
 /* L2CAP defaults */
 #define L2CAP_DEFAULT_MTU	672
+#define L2CAP_MIN_MTU		48
 #define L2CAP_DEFAULT_FLUSH_TO	0xFFFF
+#define L2CAP_DEFAULT_TXW 	32
+#define L2CAP_MIN_TXW		1
+#define L2CAP_MAX_TXW		32
+#define L2CAP_DEFAULT_MAXT 	32
+#define L2CAP_DEFAULT_RETTO 	1000
+#define L2CAP_DEFAULT_MONTO 	1000
+#define L2CAP_DEFAULT_MPS 	0xFFFF
+#define L2CAP_MAX_MPS		0xFFFF
+
+/* maximum possible options for one request/response */
+#define L2CAP_MAX_OPTS 		128
 
 #define L2CAP_CONN_TIMEOUT	(HZ * 40)
 
@@ -47,6 +59,10 @@
 	__u8  mode;
 };
 
+#define L2CAP_MODE_BASIC	0x00
+#define L2CAP_MODE_RET		0x01
+#define L2CAP_MODE_FLOW		0x02
+
 #define L2CAP_CONNINFO	0x02
 struct l2cap_conninfo {
 	__u16 hci_handle;
@@ -90,8 +106,14 @@
 
 struct l2cap_cmd_rej {
 	__le16     reason;
+	__le16     data[0];
 } __attribute__ ((packed));
 
+/* command reject reasons */
+#define L2CAP_CMD_NOT_UNDERSTOOD 	0x0000
+#define L2CAP_MTU_EXCEEDED 		0x0001
+#define L2CAP_INVALID_CID 		0x0002
+
 struct l2cap_conn_req {
 	__le16     psm;
 	__le16     scid;
@@ -129,8 +151,10 @@
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
@@ -146,6 +170,15 @@
 
 #define L2CAP_CONF_MAX_SIZE	22
 
+struct l2cap_conf_rfc {
+	__u8	mode;
+	__u8	txw;
+	__u8	maxt;
+	__le16	ret_to;
+	__le16	mon_to;
+	__le16	mps;
+} __attribute__ ((packed));
+
 struct l2cap_disconn_req {
 	__le16     dcid;
 	__le16     scid;
@@ -158,7 +191,6 @@
 
 struct l2cap_info_req {
 	__le16      type;
-	__u8        data[0];
 } __attribute__ ((packed));
 
 struct l2cap_info_rsp {
@@ -168,12 +200,17 @@
 } __attribute__ ((packed));
 
 /* info type */
-#define L2CAP_IT_CL_MTU     0x0001
-#define L2CAP_IT_FEAT_MASK  0x0002
+#define L2CAP_IT_CL_MTU		0x0001
+#define L2CAP_IT_FEAT_MASK	0x0002
+
+/* bits for extended features */
+#define L2CAP_EXT_FCM		0x01
+#define L2CAP_EXT_RTM		0x02
+#define L2CAP_EXT_QOS		0x04
 
 /* info result */
-#define L2CAP_IR_SUCCESS    0x0000
-#define L2CAP_IR_NOTSUPP    0x0001
+#define L2CAP_IR_SUCCESS	0x0000
+#define L2CAP_IR_NOTSUPP	0x0001
 
 /* ----- L2CAP connections ----- */
 struct l2cap_chan_list {
@@ -215,11 +252,40 @@
 	__u16		flush_to;
 
 	__u32		link_mode;
+	/* connectionless MTU size from info response */
+	__u16		info_mtu;
+	/* extended feature mask from info response */
+	u32		info_ext;
 
-	__u8		conf_state;
+	/* bitmask for current config state */
+	__u16		conf_state;
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
@@ -227,10 +293,15 @@
 	struct sock		*prev_c;
 };
 
-#define L2CAP_CONF_REQ_SENT    0x01
-#define L2CAP_CONF_INPUT_DONE  0x02
-#define L2CAP_CONF_OUTPUT_DONE 0x04
-#define L2CAP_CONF_MAX_RETRIES 2
+#define L2CAP_CONF_MAX_RETRIES	2
+
+/* different conf_states */
+#define L2CAP_INFO_REQ_SENT 	0x01
+#define L2CAP_CONF_REQ_SENT 	0x02
+#define L2CAP_CONF_INPUT_DONE	0x04
+#define L2CAP_CONF_OUTPUT_DONE	0x08
+#define L2CAP_CONF_UNACCEPT_MTU	0x10
+#define L2CAP_CONF_UNACCEPT_RFC	0x20
 
 void l2cap_load(void);
 
diff -urN linux-2.6.16-mh2/net/bluetooth/l2cap.c linux-2.6.16-mr/net/bluetooth/l2cap.c
--- linux-2.6.16-mh2/net/bluetooth/l2cap.c	2006-06-09 13:03:31.000000000 +0200
+++ linux-2.6.16-mr/net/bluetooth/l2cap.c	2006-06-09 13:37:08.000000000 +0200
@@ -46,6 +46,7 @@
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <asm/unaligned.h>
+#include <asm/bitops.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -365,6 +366,12 @@
 	/* Default config options */
 	pi->conf_mtu = L2CAP_DEFAULT_MTU;
 	pi->flush_to = L2CAP_DEFAULT_FLUSH_TO;
+	pi->conf_mode = L2CAP_MODE_FLOW;
+	pi->conf_txw = L2CAP_DEFAULT_TXW;
+	pi->conf_maxt = L2CAP_DEFAULT_MAXT;
+	pi->conf_ret_to = L2CAP_DEFAULT_RETTO;
+	pi->conf_mon_to = L2CAP_DEFAULT_MONTO;
+	pi->conf_mps = L2CAP_DEFAULT_MPS;
 }
 
 static struct proto l2cap_proto = {
@@ -969,7 +976,8 @@
 	}
 	return s;
 }
-
+/* Find channel with given ident.
+ * Returns lockaed socket */
 static inline struct sock *l2cap_get_chan_by_ident(struct l2cap_chan_list *l, u8 ident)
 {
 	struct sock *s;
@@ -1236,102 +1244,192 @@
 	return NULL;
 }
 
-static inline int l2cap_get_conf_opt(void **ptr, int *type, int *olen, unsigned long *val)
+/**
+ * l2cap_check_conf_opt - checks an incoming option for valid parameters
+ * @sk: corresponding socket
+ * @option: option that's parameters will be checked
+ * @return: result code for this request's option
+ *
+ * All parameters of a particular option from an incoming request will be
+ * checked. The result code for this option (e.g. L2CAP_CONF_UNACCEPT) is
+ * returned.
+ */
+static inline int l2cap_check_conf_opt(struct sock *sk, int option)
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
 {
-	int type, hint, olen; 
-	unsigned long val;
-	void *ptr = data;
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	int type, hint;
+	u8 *ptr = data;
+	/* bit flag to avoid multiple examination of already parsed options */
+	unsigned long options = 0;
 
 	BT_DBG("sk %p len %d", sk, len);
 
+	memset(result, 255, sizeof(result));
+
+	/* result[0] stays 255 for an empty request */
+	if (len != 0)
+		result[0] = L2CAP_CONF_SUCCESS;
+
 	while (len >= L2CAP_CONF_OPT_SIZE) {
-		len -= l2cap_get_conf_opt(&ptr, &type, &olen, &val);
+		u8 req_len = *(u8 *)(ptr + 1);
+
+		/* bail out if req length > packet length */
+		if (len < req_len) return;
+
+		len -= req_len + 2;
+		type = *(u8 *)(ptr + 0);
 
 		hint  = type & 0x80;
 		type &= 0x7f;
 
 		switch (type) {
-		case L2CAP_CONF_MTU:
-			l2cap_pi(sk)->conf_mtu = val;
+		case 0:
+			result[0] = L2CAP_CONF_REJ;
 			break;
+		case L2CAP_CONF_MTU:
+			if (test_bit(L2CAP_CONF_MTU, &options))
+				break;
+			if (req_len != 2) {
+				result[0] = L2CAP_CONF_REJ;
+				break;
+			}
+			pi->conf_mtu = __le16_to_cpup((__le16 *)(ptr + 2));
+			set_bit(L2CAP_CONF_MTU, &options);
+			result[L2CAP_CONF_MTU] = l2cap_check_conf_opt(sk, L2CAP_CONF_MTU);
+			if (result[L2CAP_CONF_MTU] == L2CAP_CONF_UNACCEPT)
+				result[0] = L2CAP_CONF_UNACCEPT;
 
-		case L2CAP_CONF_FLUSH_TO:
-			l2cap_pi(sk)->flush_to = val;
 			break;
 
-		case L2CAP_CONF_QOS:
+		case L2CAP_CONF_RFC:
+			if (test_bit(L2CAP_CONF_RFC, &options))
+				break;
+			if (req_len != 9) {
+				result[0] = L2CAP_CONF_REJ;
+				break;
+			}
+			pi->conf_mode = *(__u8 *)(ptr + 2);
+			pi->conf_txw  = *(__u8 *)(ptr + 3);
+			pi->conf_maxt = *(__u8 *)(ptr + 4);
+			pi->conf_ret_to = __le16_to_cpup((__le16 *)(ptr + 5));
+			pi->conf_mon_to = __le16_to_cpup((__le16 *)(ptr + 7));
+			pi->conf_mps    = __le16_to_cpup((__le16 *)(ptr + 9));
+			set_bit(L2CAP_CONF_RFC, &options);
+			result[L2CAP_CONF_RFC] = l2cap_check_conf_opt(sk, L2CAP_CONF_RFC);
+			if (result[L2CAP_CONF_RFC] == L2CAP_CONF_UNACCEPT)
+				result[0] = L2CAP_CONF_UNACCEPT;
+
 			break;
 
 		default:
+			result[0] = L2CAP_CONF_UNKNOWN;
+			result[type] = L2CAP_CONF_UNKNOWN;
+			/* hints are not supported yet */
 			if (hint)
 				break;
-
-			/* FIXME: Reject unknown option */
-			break;
 		}
+
+		/* go to start of (possible) next request */
+		ptr += req_len + L2CAP_CONF_OPT_SIZE;
 	}
 }
 
-static void l2cap_add_conf_opt(void **ptr, u8 type, u8 len, unsigned long val)
+/**
+ * l2cap_add_conf_opt - adds a configuration option to a rsp or req
+ * @ptr: pointer to location where all options are finally stored
+ * @data: data for one option (type, len, and all parameters)
+ * @type: option type
+ * @len: option length
+ *
+ * Adds a complete configuration parameter option to a configuration
+ * response or a configuration request
+ */
+static void l2cap_add_conf_opt(void **ptr, void *data, u8 type, u8 len)
 {
 	struct l2cap_conf_opt *opt = *ptr;
 
-	BT_DBG("type 0x%2.2x len %d val 0x%lx", type, len, val);
+	BT_DBG("type 0x%2.2x len %d", type, len);
 
 	opt->type = type;
 	opt->len  = len;
 
-	switch (len) {
-	case 1:
-		*((__u8 *) opt->val)  = val;
+	switch (type) {
+	case L2CAP_CONF_MTU:
+		*((__le16 *) opt->val) = cpu_to_le16(*(__le16 *) data);
 		break;
-
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
 
@@ -1339,59 +1437,194 @@
 {
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	struct l2cap_conf_req *req = data;
-	void *ptr = req->data;
+	void *opts = req->data;
 
 	BT_DBG("sk %p", sk);
 
-	if (pi->imtu != L2CAP_DEFAULT_MTU)
-		l2cap_add_conf_opt(&ptr, L2CAP_CONF_MTU, 2, pi->imtu);
+	if (pi->conf_state & L2CAP_CONF_UNACCEPT_MTU) {
+		l2cap_add_conf_opt(&opts, &(pi->conf_mtu), L2CAP_CONF_MTU, 2);
+		/* clear bit in conf_state */
+		pi->conf_state &= (~L2CAP_CONF_UNACCEPT_MTU);
+	}
+
+	/* either we got unacceptable rfc options in former response
+	 * or we discovered support for rfc in an information request */
+	if ((pi->conf_state & L2CAP_CONF_UNACCEPT_RFC) ||
+			(pi->info_ext & L2CAP_EXT_FCM)) {
+		struct l2cap_conf_rfc rfc;
+		rfc.mode = pi->conf_mode;
+		rfc.txw  = pi->conf_txw;
+		rfc.maxt = pi->conf_maxt;
+		rfc.ret_to = pi->conf_ret_to;
+		rfc.mon_to = pi->conf_mon_to;
+		rfc.mps = pi->conf_mps;
+		l2cap_add_conf_opt(&opts, &rfc, L2CAP_CONF_RFC, 9);
+		/* clear bit in conf_state */
+		pi->conf_state &= (~L2CAP_CONF_UNACCEPT_RFC);
+	}
 
-	/* FIXME: Need actual value of the flush timeout */
-	//if (flush_to != L2CAP_DEFAULT_FLUSH_TO)
-	//   l2cap_add_conf_opt(&ptr, L2CAP_CONF_FLUSH_TO, 2, pi->flush_to);
+	if (pi->imtu != L2CAP_DEFAULT_MTU)
+		l2cap_add_conf_opt(&opts, &(pi->imtu), L2CAP_CONF_MTU, 2);
 
 	req->dcid  = __cpu_to_le16(pi->dcid);
 	req->flags = __cpu_to_le16(0);
 
-	return ptr - data;
+	return opts - data;
 }
 
-static inline int l2cap_conf_output(struct sock *sk, void **ptr)
+/**
+ * l2cap_build_conf_rsp - builds a configuration response
+ * @sk: corresponding socket
+ * @data: data portion of rsp packet (scid, flags, result, config)
+ * @complete: indicates whether C flag is set (0 == incomplete)
+ * @result: pointer to collected result codes of result[128]
+ *
+ * Building a configuration response on base of the collected result codes.
+ * The fundamental result code result[0] delegates the action that is taken.
+ * For each result[i] that is set appropriately the response packet will be 
+ * built.
+ * Returns the length of the data field in octets of the command only (does
+ * not cover the Code, Identifier, and Length field): scid + flags + result +
+ * configuration options.
+ */
+static int l2cap_build_conf_rsp(struct sock *sk, void *data, int complete, u8 *result)
 {
+	struct l2cap_conf_rsp *rsp = data;
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
-	int result = 0;
+	void *opts = rsp->data;
+	u16 flags = 0;
+	int i, len = 0;
 
-	/* Configure output options and let the other side know
-	 * which ones we don't like. */
-	if (pi->conf_mtu < pi->omtu) {
-		l2cap_add_conf_opt(ptr, L2CAP_CONF_MTU, 2, pi->omtu);
-		result = L2CAP_CONF_UNACCEPT;
-	} else {
+	BT_DBG("sk %p complete %d", sk, complete);
+
+	switch (result[0]) {
+	/* 255 represents the case for an empty request */
+	case 255:
 		pi->omtu = pi->conf_mtu;
+		result[0] = L2CAP_CONF_SUCCESS;
+		break;
+		
+	case L2CAP_CONF_SUCCESS:
+		for (i = 1; i < L2CAP_MAX_OPTS; ++i) {
+			if (result[i] == L2CAP_CONF_SUCCESS) {
+				switch (i) {
+				case L2CAP_CONF_MTU:
+					pi->omtu = pi->conf_mtu;
+					len = 2;
+					l2cap_add_conf_opt(&opts, &(pi->omtu), i, len);
+					break;
+				case L2CAP_CONF_RFC: {
+					struct l2cap_conf_rfc params;
+					struct l2cap_conf_rfc *rfc = &params;
+					pi->omode = pi->conf_mode;
+					pi->otxw  = pi->conf_txw;
+					pi->omaxt = pi->conf_maxt;
+					pi->oret_to = pi->conf_ret_to;
+					pi->omon_to = pi->conf_mon_to;
+					pi->omps = pi->conf_mps;
+					len = 9;
+					rfc->mode = pi->omode;
+					rfc->txw  = pi->otxw;
+					rfc->maxt = pi->omaxt;
+					rfc->ret_to = pi->oret_to;
+					rfc->mon_to = pi->omon_to;
+					rfc->mps = pi->omps;
+					l2cap_add_conf_opt(&opts, rfc, i, len);
+					break;
+				}
+				}
+			}
+		}
+		break;
+		
+	case L2CAP_CONF_UNACCEPT:
+		for (i = 1; i < L2CAP_MAX_OPTS; ++i) {
+			if (result[i] == L2CAP_CONF_UNACCEPT) {
+				switch (i) {
+				case L2CAP_CONF_MTU: {
+					__le16 mtu = L2CAP_DEFAULT_MTU;
+					len = 2;
+					l2cap_add_conf_opt(&opts, &mtu, i, len);
+					break;
+				}
+				case L2CAP_CONF_RFC: {
+					struct l2cap_conf_rfc params;
+					struct l2cap_conf_rfc *rfc = &params;
+					rfc->mode = pi->conf_mode;
+					rfc->txw  = pi->conf_txw;
+					rfc->maxt = pi->conf_maxt;
+					rfc->ret_to = pi->conf_ret_to;
+					rfc->mon_to = pi->conf_mon_to;
+					rfc->mps = pi->conf_mps;
+					len = 9;
+					l2cap_add_conf_opt(&opts, rfc, i, len);
+					break;
+				}
+				}
+			}
+		}
+		break;
+		
+	case L2CAP_CONF_REJ:
+		/* send plain reject response */
+		l2cap_add_conf_opt(&opts, NULL, 0, 0);
+		break;
+		
+	case L2CAP_CONF_UNKNOWN:
+		for (i = 1; i < L2CAP_MAX_OPTS; ++i) {
+			if (result[i] == L2CAP_CONF_UNKNOWN) {
+				l2cap_add_conf_opt(&opts, NULL, i, 0);
+			}
+		}
+		break;
 	}
 
-	BT_DBG("sk %p result %d", sk, result);
-	return result;
+	rsp->scid   = __cpu_to_le16(l2cap_pi(sk)->dcid);
+	rsp->result = __cpu_to_le16(result[0] == 255 ? 0 : result[0]);
+	rsp->flags  = __cpu_to_le16(flags);
+
+	/* return length of actual data */
+	return opts - data;
 }
 
-static int l2cap_build_conf_rsp(struct sock *sk, void *data, int *result)
+static int l2cap_build_info_req(void *data)
 {
-	struct l2cap_conf_rsp *rsp = data;
-	void *ptr = rsp->data;
-	u16 flags = 0;
+	struct l2cap_info_req *info = data;
+	u8 len = 2;
 
-	BT_DBG("sk %p complete %d", sk, result ? 1 : 0);
+	info->type = __cpu_to_le16(L2CAP_IT_FEAT_MASK);
 
-	if (result)
-		*result = l2cap_conf_output(sk, &ptr);
-	else
-		flags = 0x0001;
+	return len;
+}
 
-	rsp->scid   = __cpu_to_le16(l2cap_pi(sk)->dcid);
-	rsp->result = __cpu_to_le16(result ? *result : 0);
-	rsp->flags  = __cpu_to_le16(flags);
+static inline int l2cap_command_rej(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd, u8 *data)
+{
+	struct l2cap_cmd_rej *rej = (struct l2cap_cmd_rej *) data;
+	u16 reason;
+	u8 len; /* depends on reason code */
+	__le16 *ptr = rej->data;
+
+	reason = __le16_to_cpu(rej->reason);
+
+	BT_DBG("reason 0x%4.4x", reason);
+
+	switch (reason) {
+	case L2CAP_CMD_NOT_UNDERSTOOD:
+		len = 0;
+		break;
+	case L2CAP_MTU_EXCEEDED:
+		len = 2;
+		BT_DBG("max acceptable signalling MTU 0x%02X", ptr[0]);
+		break;
+	case L2CAP_INVALID_CID:
+		len = 4;
+		BT_DBG("invalid channel 0x%04X 0x%04X", ptr[0], ptr[1]);
+		break;
+	default:
+		return reason;
+	}
 
-	return ptr - data;
+	return 0;
 }
 
 static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd, u8 *data)
@@ -1487,7 +1720,7 @@
 	struct l2cap_conn_rsp *rsp = (struct l2cap_conn_rsp *) data;
 	u16 scid, dcid, result, status;
 	struct sock *sk;
-	u8 req[128];
+	u16 info;
 
 	scid   = __le16_to_cpu(rsp->scid);
 	dcid   = __le16_to_cpu(rsp->dcid);
@@ -1503,16 +1736,16 @@
 		if (!(sk = l2cap_get_chan_by_ident(&conn->chan_list, cmd->ident)))
 			return 0;
 	}
-
+	
 	switch (result) {
 	case L2CAP_CR_SUCCESS:
 		sk->sk_state = BT_CONFIG;
-		l2cap_pi(sk)->ident = 0;
+		l2cap_pi(sk)->ident = l2cap_get_ident(conn);
 		l2cap_pi(sk)->dcid = dcid;
-		l2cap_pi(sk)->conf_state |= L2CAP_CONF_REQ_SENT;
-
-		l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
-					l2cap_build_conf_req(sk, req), req);
+		/* send information request first */
+		l2cap_pi(sk)->conf_state |= L2CAP_INFO_REQ_SENT;
+		l2cap_send_cmd(conn, l2cap_pi(sk)->ident, L2CAP_INFO_REQ,
+					l2cap_build_info_req(&info), &info);
 		break;
 
 	case L2CAP_CR_PEND:
@@ -1531,9 +1764,11 @@
 {
 	struct l2cap_conf_req *req = (struct l2cap_conf_req *) data;
 	u16 dcid, flags, cmd_len = __le16_to_cpu(cmd->len);
-	u8 rsp[64];
+	u8 rsp[128];
 	struct sock *sk;
-	int result;
+	/* collected result codes for theor. max 128 possible options
+	 * result[0] indicates the general result code for all options */
+	u8 result[L2CAP_MAX_OPTS];
 
 	dcid  = __le16_to_cpu(req->dcid);
 	flags = __le16_to_cpu(req->flags);
@@ -1543,20 +1778,20 @@
 	if (!(sk = l2cap_get_chan_by_scid(&conn->chan_list, dcid)))
 		return -ENOENT;
 
-	l2cap_parse_conf_req(sk, req->data, cmd_len - sizeof(*req));
+	l2cap_parse_conf_req(sk, req->data, cmd_len - sizeof(*req), result);
 
 	if (flags & 0x0001) {
 		/* Incomplete config. Send empty response. */
 		l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP,
-				l2cap_build_conf_rsp(sk, rsp, NULL), rsp);
+				l2cap_build_conf_rsp(sk, rsp, 0, NULL), rsp);
 		goto unlock;
 	}
 
 	/* Complete config. */
 	l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP,
-			l2cap_build_conf_rsp(sk, rsp, &result), rsp);
+			l2cap_build_conf_rsp(sk, rsp, 1, result), rsp);
 
-	if (result)
+	if (result[0])
 		goto unlock;
 
 	/* Output config done */
@@ -1578,35 +1813,113 @@
 
 static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd, u8 *data)
 {
-	struct l2cap_conf_rsp *rsp = (struct l2cap_conf_rsp *)data;
-	u16 scid, flags, result;
+	struct l2cap_conf_rsp *rsp = (struct l2cap_conf_rsp *) data;
+	struct l2cap_pinfo *pi;
+	u16 scid, flags, result, len;
 	struct sock *sk;
+	u8 type;
+	u8 *ptr = rsp->data;
+	/* length of all options in config data field */
+	len = __le16_to_cpu(cmd->len) - sizeof(*rsp);
 
 	scid   = __le16_to_cpu(rsp->scid);
 	flags  = __le16_to_cpu(rsp->flags);
 	result = __le16_to_cpu(rsp->result);
 
-	BT_DBG("scid 0x%4.4x flags 0x%2.2x result 0x%2.2x", scid, flags, result);
-
 	if (!(sk = l2cap_get_chan_by_scid(&conn->chan_list, scid)))
 		return 0;
+	pi = l2cap_pi(sk);
+
+	BT_DBG("scid 0x%4.4x flags 0x%2.2x result 0x%2.2x len %d", scid, flags, result, len);
 
 	switch (result) {
 	case L2CAP_CONF_SUCCESS:
+		while (len >= L2CAP_CONF_OPT_SIZE) {
+			u8 rsp_len = *(u8 *)(ptr + 1);
+			/* bail out if rsp len > packet len */
+			if (len < rsp_len) return 0;
+
+			len -= rsp_len + 2;
+			type = *(u8 *)(ptr + 0);
+
+			switch (type) {
+			case L2CAP_CONF_MTU:
+				pi->imtu = *(__le16 *)(ptr + 2);
+				break;
+			case L2CAP_CONF_RFC:
+				pi->imode = *(u8 *)(ptr + 2);
+				pi->itxw  = *(u8 *)(ptr + 3);
+				pi->imaxt = *(u8 *)(ptr + 4);
+				pi->iret_to = __le16_to_cpup((__le16 *)(ptr + 5));
+				pi->imon_to = __le16_to_cpup((__le16 *)(ptr + 7));
+				pi->imps    = __le16_to_cpup((__le16 *)(ptr + 9));
+				break;
+			}
+
+			/* go to start of (possible) next request */
+			ptr += rsp_len + L2CAP_CONF_OPT_SIZE;
+		}
 		break;
 
-	case L2CAP_CONF_UNACCEPT:
-		if (++l2cap_pi(sk)->conf_retry < L2CAP_CONF_MAX_RETRIES) {
-			char req[128];
-			/* It does not make sense to adjust L2CAP parameters
-			 * that are currently defined in the spec. We simply
-			 * resend config request that we sent earlier. It is
-			 * stupid, but it helps qualification testing which
-			 * expects at least some response from us. */
-			l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
-						l2cap_build_conf_req(sk, req), req);
-			goto done;
+	case L2CAP_CONF_UNACCEPT: {
+		u8 req[128];
+		while (len >= L2CAP_CONF_OPT_SIZE) {
+			u8 rsp_len = *(u8 *)(ptr + 1);
+			/* bail out if rsp len > packet len */
+			if (len < rsp_len) return 0;
+
+			len -= rsp_len + 2;
+			type = *(u8 *)(ptr + 0);
+
+			switch (type) {
+			case L2CAP_CONF_MTU:
+				pi->conf_mtu = *(__le16 *)(ptr + 2);
+				/* add MTU option to new request */
+				pi->conf_state |= L2CAP_CONF_UNACCEPT_MTU;
+				break;
+			case L2CAP_CONF_RFC:
+				pi->conf_mode = *(u8 *)(ptr + 2);
+				pi->conf_txw  = *(u8 *)(ptr + 3);
+				pi->conf_maxt = *(u8 *)(ptr + 4);
+				pi->conf_ret_to = __le16_to_cpup((__le16 *)(ptr + 5));
+				pi->conf_mon_to = __le16_to_cpup((__le16 *)(ptr + 7));
+				pi->conf_mps    = __le16_to_cpup((__le16 *)(ptr + 9));
+				/* add RFC option to new request */
+				pi->conf_state |= L2CAP_CONF_UNACCEPT_RFC;
+				break;
+			}
+
+			/* go to start of (possible) next request */
+			ptr += rsp_len + L2CAP_CONF_OPT_SIZE;
 		}
+		l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
+					l2cap_build_conf_req(sk, req), req);
+		goto done;
+	}
+
+	case L2CAP_CONF_UNKNOWN: {
+		u8 req[128];
+		while (len >= L2CAP_CONF_OPT_SIZE) {
+			u8 rsp_len = *(u8 *)(ptr + 1);
+			/* bail out if rsp len > packet len */
+			if (len < rsp_len) return 0;
+
+			len -= rsp_len + 2;
+			type = *(u8 *)(ptr + 0);
+
+			switch (type) {
+			case L2CAP_CONF_RFC:
+				pi->conf_mode = L2CAP_MODE_BASIC;
+				break;
+			}
+
+			/* go to start of (possible) next request */
+			ptr += rsp_len + L2CAP_CONF_OPT_SIZE;
+		}
+		l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
+				l2cap_build_conf_req(sk, req), req);
+		goto done;
+	}
 
 	default: 
 		sk->sk_state = BT_DISCONN;
@@ -1708,12 +2021,38 @@
 {
 	struct l2cap_info_rsp *rsp = (struct l2cap_info_rsp *) data;
 	u16 type, result;
+	struct sock *sk;
+	u8 req[128];
+	u8 *ptr = rsp->data;
 
 	type   = __le16_to_cpu(rsp->type);
 	result = __le16_to_cpu(rsp->result);
 
-	BT_DBG("type 0x%4.4x result 0x%2.2x", type, result);
+	BT_DBG("type 0x%4.4x result 0x%2.2x ident %d", type, result, cmd->ident);
+
+	if (!(sk = l2cap_get_chan_by_ident(&conn->chan_list, cmd->ident)))
+		return 0;
+
+	if (result == L2CAP_IR_SUCCESS) {
+		switch (type) {
+		case L2CAP_IT_CL_MTU:
+			l2cap_pi(sk)->info_mtu = __le16_to_cpup((__le16 *) ptr);
+			break;
+		case L2CAP_IT_FEAT_MASK:
+			if (*ptr & L2CAP_EXT_FCM)
+				l2cap_pi(sk)->info_ext |= L2CAP_EXT_FCM;
+			break;
+		}
+	} else {
+		l2cap_pi(sk)->conf_mode = L2CAP_MODE_BASIC;
+	}
 
+	/* build configuration request */
+	l2cap_pi(sk)->conf_state |= L2CAP_CONF_REQ_SENT;
+	l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
+			l2cap_build_conf_req(sk, req), req);
+
+	bh_unlock_sock(sk);
 	return 0;
 }
 
@@ -1743,7 +2082,7 @@
 
 		switch (cmd.code) {
 		case L2CAP_COMMAND_REJ:
-			/* FIXME: We should process this */
+			err = l2cap_command_rej(conn, &cmd, data);
 			break;
 
 		case L2CAP_CONN_REQ:

--=-tYVHGRAlAeV33ckwoQl1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-tYVHGRAlAeV33ckwoQl1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-tYVHGRAlAeV33ckwoQl1--
