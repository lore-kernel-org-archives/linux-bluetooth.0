Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Martin =?ISO-8859-1?Q?R=F6hricht?= <ml@felicis.org>
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="=-sqsLzViHEfq6sJox7SyK"
Message-Id: <1146757417.2039.59.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-devel] L2CAP Flow Control - 3rd stage
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
Date: Thu, 04 May 2006 17:43:37 +0200


--=-sqsLzViHEfq6sJox7SyK
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hello together,

it took me some time since my last post to fix some annoying bugs
regarding my implementation of flow control features in BlueZ.
Currently I have only three test devices: a Siemens S55 mobile phone, a
Siemens S75 mobile phone and another Acer laptop with the Windows XP
Bluetooth stack. I hope to get another USB adaptor with a Toshiba stack
within the next few days which may even work with the Apple Bluetooth
stack at my iMac G4.

I will go over some investigations and implementation specific things
now.
First of all I extended l2cap.h to provide some global constants for
Flow Control. The reject command (struct l2cap_cmd_rej) offers some
information data for two of the three possible reject reasons so I
figured out it might be interesting to see why this rejection applied
and added the variable length array =BBdata=AB as well as the three possibl=
e
reject reasons as constants.
The different configuration states (conf_states) have been extended,
too. All the other stuff should already be covered by one of my earlier
mails.

Secondly I worked on l2cap.c for most of the time.
Most of these functions didn't change since my last post. I fixed some
bugs in l2cap_config_rsp() and this is one function that might be still
erroneous (I couldn't validate the L2CAP_CONF_UNKNOWN and the default
cases), but it works with those three devices mentioned above.
l2cap_build_conf_rsp() was one of the trouble makers, which was
basically my fault. I removed the l2cap_conf_output() function and put
its functionality into l2cap_build_conf_rsp().
The reject command is now really handled by its own function
l2cap_command_rej() and corresponding debug messages are printed.
One major issue about my implementation (and the long delay) is the =BBnew
technique=AB that applies now: Instead of sending a configuration request
first, we start with an information request and do not send a
configuration request before we got an answer in form of an information
response. We can trust this model as it is stated in the specification:
	=BBInformation requests are used to request implementation=20
	specific information from a remote L2CAP entity. L2CAP=20
	implementations _shall_ respond to a valid Information Request=20
	with an Information Response [...]=AB (section 4.10)
This assumption is rather hard, but we must send an information request
before we try to make use of flow control options in configuration
requests ... So the downside is now, that if the remote peer is not able
to send a simple information response (which is really simple) we do not
come into the stage of any configuration process.
The main problem was now to send a configuration request right after
getting (and parsing) the information response. This was problematic
because I was not able to retrieve the working socket from within our
l2cap_information_rsp() function. This took me some weeks but finally I
seem to have this issue solved. To retrieve the socket I use the
function l2cap_get_chan_by_ident(&conn->chan_list, cmd->ident) which
didn't work with the Windows stack but with my Siemens mobile phones. I
had to set the socket's identificator to the next available connection's
identificator instead of starting from 0, and use this socket's ident in
our l2cap_connect_rsp() function as the command code for our information
request.


Okay, so that's basically it. The current patch makes the configuration
process to work with my three devices. Unfortunately none of those three
devices wants to =BBflow control=AB with me :-( The nearest one is the
Siemens S75 which claims to support all the extended features, including
flow control (explicitly) but when I start a configuration request
trying to use flow control, it responds with =BBunacceptable parameters=AB
and states it wants to use the Basic L2CAP Mode ... Damn. Windows and
the S55 do not offer the extended features in an information response. I
hope to have more luck with the Toshiba and the Apple stack.
This patch does only set the flow control parameters and does not do
anything regarding the flow control process itself. If somebody has
devices with newer Bluetooth stacks (Widcomm for example) he is welcomed
to compile this patch and just initiate a send and receive action to see
if it still works.

Martin

--=-sqsLzViHEfq6sJox7SyK
Content-Disposition: attachment; filename=patch-l2cap.2006-05-04
Content-Type: text/x-patch; name=patch-l2cap.2006-05-04; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

diff -urN linux-2.6.15-mh2/include/net/bluetooth/l2cap.h linux-2.6.15-mr/include/net/bluetooth/l2cap.h
--- linux-2.6.15-mh2/include/net/bluetooth/l2cap.h	2006-02-16 11:38:18.000000000 +0100
+++ linux-2.6.15-mr/include/net/bluetooth/l2cap.h	2006-05-04 16:36:34.000000000 +0200
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
@@ -144,8 +168,20 @@
 #define L2CAP_CONF_QOS		0x03
 #define L2CAP_CONF_RFC		0x04
 
+#define SET_BIT(x, v) ((x) |= 1 << (v))
+#define HAS_BIT(x, v) (((x) & (1 << (v))) != 0)
+
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
@@ -158,7 +194,6 @@
 
 struct l2cap_info_req {
 	__le16      type;
-	__u8        data[0];
 } __attribute__ ((packed));
 
 struct l2cap_info_rsp {
@@ -168,12 +203,17 @@
 } __attribute__ ((packed));
 
 /* info type */
-#define L2CAP_IT_CL_MTU     0x0001
-#define L2CAP_IT_FEAT_MASK  0x0002
+#define L2CAP_IT_CL_MTU		0x0001
+#define L2CAP_IT_FEAT_MASK	0x0002
+
+/* bits for extended features (no. of bit position) */
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
@@ -215,11 +255,40 @@
 	__u16		flush_to;
 
 	__u32		link_mode;
+	/* connectionless MTU size from info response */
+	__u16		info_mtu;
+	/* extended feature mask from info response */
+	__u32		info_ext;
 
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
@@ -227,10 +296,15 @@
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
 
diff -urN linux-2.6.15-mh2/net/bluetooth/l2cap.c linux-2.6.15-mr/net/bluetooth/l2cap.c
--- linux-2.6.15-mh2/net/bluetooth/l2cap.c	2006-02-16 11:38:19.000000000 +0100
+++ linux-2.6.15-mr/net/bluetooth/l2cap.c	2006-05-04 16:36:15.000000000 +0200
@@ -50,6 +50,8 @@
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>
 
+#define CONFIG_BT_L2CAP_DEBUG
+
 #ifndef CONFIG_BT_L2CAP_DEBUG
 #undef  BT_DBG
 #define BT_DBG(D...)
@@ -172,16 +174,20 @@
 	write_unlock(&l->lock);
 }
 
+/**
+ * l2cap_get_ident - get next available identificator
+ * @conn: corresponding connection
+ *
+ * l2cap_get_ident returns the next available identificator for a given
+ * connection with respect to the following convention:
+ *    1 - 128 are used by kernel
+ *  129 - 199 are reserved
+ *  200 - 254 are used by utilities like l2ping, etc.
+ */
 static inline u8 l2cap_get_ident(struct l2cap_conn *conn)
 {
 	u8 id;
 
-	/* Get next available identificator.
-	 *    1 - 128 are used by kernel.
-	 *  129 - 199 are reserved.
-	 *  200 - 254 are used by utilities like l2ping, etc.
-	 */
-
 	spin_lock(&conn->lock);
 
 	if (++conn->tx_ident > 128)
@@ -361,9 +367,15 @@
 		pi->link_mode = 0;
 	}
 
-	/* Default config options */
 	pi->conf_mtu = L2CAP_DEFAULT_MTU;
 	pi->flush_to = L2CAP_DEFAULT_FLUSH_TO;
+	/* RFC options */
+	pi->conf_mode = L2CAP_MODE_FLOW;
+	pi->conf_txw = L2CAP_DEFAULT_TXW;
+	pi->conf_maxt = L2CAP_DEFAULT_MAXT;
+	pi->conf_ret_to = L2CAP_DEFAULT_RETTO;
+	pi->conf_mon_to = L2CAP_DEFAULT_MONTO;
+	pi->conf_mps = L2CAP_DEFAULT_MPS;
 }
 
 static struct proto l2cap_proto = {
@@ -1100,7 +1112,8 @@
 			l2cap_pi(sk)->ident = l2cap_get_ident(conn);
 			req.scid = __cpu_to_le16(l2cap_pi(sk)->scid);
 			req.psm  = l2cap_pi(sk)->psm;
-			l2cap_send_cmd(conn, l2cap_pi(sk)->ident, L2CAP_CONN_REQ, sizeof(req), &req);
+			l2cap_send_cmd(conn, l2cap_pi(sk)->ident, L2CAP_CONN_REQ, 
+					sizeof(req), &req);
 		}
 
 		bh_unlock_sock(sk);
@@ -1184,7 +1197,7 @@
 	struct l2cap_hdr *lh;
 	int len, count;
 
-	BT_DBG("conn %p, code 0x%2.2x, ident 0x%2.2x, len %d", conn, code, ident, dlen);
+	BT_DBG("conn %p, code 0x%2.2x, id 0x%2.2x, len %d", conn, code, ident, dlen);
 
 	len = L2CAP_HDR_SIZE + L2CAP_CMD_HDR_SIZE + dlen;
 	count = min_t(unsigned int, conn->mtu, len);
@@ -1234,162 +1247,428 @@
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
+        int result = L2CAP_CONF_SUCCESS;
+        struct l2cap_pinfo *pi = l2cap_pi(sk);
 
-	len = L2CAP_CONF_OPT_SIZE + opt->len;
-	*ptr += len;
-
-	*type = opt->type;
-	*olen = opt->len;
-
-	switch (opt->len) {
-	case 1:
-		*val = *((__u8 *) opt->val);
-		break;
+        switch (option) {
+        case L2CAP_CONF_MTU:
+		if (pi->conf_mtu < L2CAP_MIN_MTU)
+			result = L2CAP_CONF_UNACCEPT;
+                break;
+        case L2CAP_CONF_FLUSH_TO:
+                break;
+        case L2CAP_CONF_QOS:
+                break;
+        case L2CAP_CONF_RFC:
+                if (pi->conf_mode == L2CAP_MODE_BASIC) {
+                        pi->omode = L2CAP_MODE_BASIC;
+                        break;
+                }
+                /* Retransmission Mode not supported yet */
+                if (pi->conf_mode != L2CAP_MODE_FLOW) {
+                        pi->conf_mode = L2CAP_MODE_FLOW;
+                        result = L2CAP_CONF_UNACCEPT;
+                }
+                if (pi->conf_txw < 1 || pi->conf_txw > 32) {
+                        pi->conf_txw = 32;
+                        result = L2CAP_CONF_UNACCEPT;
+                }
+                if (pi->conf_maxt < 1) {
+                        pi->conf_maxt = 8;
+                        result = L2CAP_CONF_UNACCEPT;
+                }
+                if (pi->conf_ret_to < 100) {
+                        pi->conf_ret_to = 1000;
+                        result = L2CAP_CONF_UNACCEPT;
+                }
+                if (pi->conf_mon_to < 100) {
+                        pi->conf_mon_to = 1000;
+                        result = L2CAP_CONF_UNACCEPT;
+                }
+                break;
+        }
+
+        return result;
+}
+
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
 
-	case 2:
-		*val = __le16_to_cpu(*((__le16 *) opt->val));
-		break;
+	BT_DBG("sk %p len %d", sk, len);
 
-	case 4:
-		*val = __le32_to_cpu(*((__le32 *) opt->val));
-		break;
+	memset(result, 255, sizeof(result));
 
-	default:
-		*val = (unsigned long) opt->val;
-		break;
-	}
+	/* result[0] stays 255 for an empty request */
+	if (len != 0) result[0] = L2CAP_CONF_SUCCESS;
 
-	BT_DBG("type 0x%2.2x len %d val 0x%lx", *type, opt->len, *val);
-	return len;
-}
+	while (len >= L2CAP_CONF_OPT_SIZE) {
+		u8 req_len = *(u8 *)(ptr + 1);
 
-static inline void l2cap_parse_conf_req(struct sock *sk, void *data, u16 len)
-{
-	int type, hint, olen; 
-	unsigned long val;
-	void *ptr = data;
+		/* Bail out if req length > packet length */
+		if (len < req_len) return;
 
-	BT_DBG("sk %p len %d", sk, len);
-
-	while (len >= L2CAP_CONF_OPT_SIZE) {
-		len -= l2cap_get_conf_opt(&ptr, &type, &olen, &val);
+		len -= req_len + 2;
+		type = *(u8 *)(ptr + 0);
 
 		hint  = type & 0x80;
 		type &= 0x7f;
 
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
+			cap->conf_mtu = __le16_to_cpup((__le16 *)(ptr + 2));
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
+			cap->flush_to = __le16_to_cpup((__le16 *)(ptr + 2));
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
+
+		case L2CAP_CONF_RFC: {
+			if (HAS_BIT(options, L2CAP_CONF_RFC)) break;
+			if (req_len != 9) {
+				result[0] = L2CAP_CONF_REJ;
+				break;
+			}
+			cap->conf_mode = *(__u8 *)(ptr + 2);
+			cap->conf_txw  = *(__u8 *)(ptr + 3);
+			cap->conf_maxt = *(__u8 *)(ptr + 4);
+			cap->conf_ret_to = __le16_to_cpup((__le16 *)(ptr + 5));
+			cap->conf_mon_to = __le16_to_cpup((__le16 *)(ptr + 7));
+			cap->conf_mps    = __le16_to_cpup((__le16 *)(ptr + 9));
+			SET_BIT(options, L2CAP_CONF_RFC);
+			result[L2CAP_CONF_RFC] = l2cap_check_conf_opt(sk, L2CAP_CONF_RFC);
+			if (result[L2CAP_CONF_RFC] == L2CAP_CONF_UNACCEPT)
+				result[0] = L2CAP_CONF_UNACCEPT;
+			break;
+		}
 
 		default:
+			result[0] = L2CAP_CONF_UNKNOWN;
+			result[type] = L2CAP_CONF_UNKNOWN;
+			/* Hints are not supported yet */
 			if (hint)
 				break;
-
-			/* FIXME: Reject unknown option */
 			break;
 		}
+
+		/* Go to start of (possible) next request */
+		ptr += req_len + L2CAP_CONF_OPT_SIZE;
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
+	u8 *tmp = data;
+	int i = 0;
 
-	BT_DBG("type 0x%2.2x len %d val 0x%lx", type, len, val);
+	BT_DBG("type 0x%2.2x len %d data ", type, len);
 
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
+ * @sk: corresponding socket
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
+	void *opts = req->data;
 
 	BT_DBG("sk %p", sk);
 
-	if (pi->imtu != L2CAP_DEFAULT_MTU)
-		l2cap_add_conf_opt(&ptr, L2CAP_CONF_MTU, 2, pi->imtu);
+	if (pi->conf_state & L2CAP_CONF_UNACCEPT_MTU)
+		l2cap_add_conf_opt(&opts, &(pi->conf_mtu), L2CAP_CONF_MTU, 2);
 
-	/* FIXME: Need actual value of the flush timeout */
-	//if (flush_to != L2CAP_DEFAULT_FLUSH_TO)
-	//   l2cap_add_conf_opt(&ptr, L2CAP_CONF_FLUSH_TO, 2, pi->flush_to);
+	if ((pi->conf_state & L2CAP_CONF_UNACCEPT_RFC) ||
+			(HAS_BIT(pi->info_ext, L2CAP_EXT_FCM))) {
+		struct l2cap_conf_rfc rfc_opts;
+		rfc_opts.mode = pi->conf_mode;
+		rfc_opts.txw  = pi->conf_txw;
+		rfc_opts.maxt = pi->conf_maxt;
+		rfc_opts.ret_to = pi->conf_ret_to;
+		rfc_opts.mon_to = pi->conf_mon_to;
+		rfc_opts.mps = pi->conf_mps;
+		l2cap_add_conf_opt(&opts, &rfc_opts, L2CAP_CONF_RFC, 9);
+	}
+
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
+ * For each result[i] that is set appropriately the response packet will
+ * be built.
+ * Returns the length of the data field in octets of the command only (does
+ * not cover the Code, Identifier, and Length field): scid + flags + result +
+ * configuration options.
+ */
+static int l2cap_build_conf_rsp(struct sock *sk, void *data, int complete, u8 *result)
 {
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
-	int result = 0;
+	struct l2cap_conf_rsp *rsp = data;
+	struct l2cap_pinfo *cap = l2cap_pi(sk);
+	void *opts = rsp->data;
+	u16 flags = 0;
+	int i, len = 0;
 
-	/* Configure output options and let the other side know
-	 * which ones we don't like. */
-	if (pi->conf_mtu < pi->omtu) {
-		l2cap_add_conf_opt(ptr, L2CAP_CONF_MTU, 2, pi->omtu);
-		result = L2CAP_CONF_UNACCEPT;
-	} else {
-		pi->omtu = pi->conf_mtu;
-	}
+	BT_DBG("sk %p complete %d", sk, complete);
 
-	BT_DBG("sk %p result %d", sk, result);
-	return result;
-}
+	switch (result[0]) {
+	/* 255 represents the case for an empty request */
+	case 255:
+		cap->omtu = cap->conf_mtu;
+		result[0] = L2CAP_CONF_SUCCESS;
+		break;
+	case L2CAP_CONF_SUCCESS:
+		for (i = 1; i < L2CAP_MAX_OPTS; ++i) {
+			if (result[i] == L2CAP_CONF_SUCCESS) {
+				switch (i) {
+				case L2CAP_CONF_MTU: {
+					cap->omtu = cap->conf_mtu;
+					len = 2;
+					l2cap_add_conf_opt(&opts, &(cap->omtu), i, len);
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
+					l2cap_add_conf_opt(&opts, val, i, len);
+					break;
+				}
+				}
+			}
+		}
+		break;
 
-static int l2cap_build_conf_rsp(struct sock *sk, void *data, int *result)
-{
-	struct l2cap_conf_rsp *rsp = data;
-	void *ptr = rsp->data;
-	u16 flags = 0;
+	case L2CAP_CONF_UNACCEPT:
+		for (i = 1; i < sizeof(result); ++i) {
+			if (result[i] == L2CAP_CONF_UNACCEPT) {
+				switch (i) {
+				case L2CAP_CONF_MTU: {
+					__le16 mtu = L2CAP_DEFAULT_MTU;
+					len = 2;
+					l2cap_add_conf_opt(&opts, &mtu, i, len);
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
+					l2cap_add_conf_opt(&opts, val, i, len);
+					break;
+				}
+				}
+			}
+		}
+		break;
 
-	BT_DBG("sk %p complete %d", sk, result ? 1 : 0);
+	case L2CAP_CONF_REJ:
+		/* send plain reject response */
+		l2cap_add_conf_opt(&opts, NULL, 0, 0);
+		break;
 
-	if (result)
-		*result = l2cap_conf_output(sk, &ptr);
-	else
+	case L2CAP_CONF_UNKNOWN:
+		for (i = 1; i < sizeof(result); ++i) {
+			if (result[i] == L2CAP_CONF_UNKNOWN) {
+				l2cap_add_conf_opt(&opts, NULL, i, 0);
+			}
+		}
+		break;
+	}
+
+	if (!complete)
 		flags = 0x0001;
 
 	rsp->scid   = __cpu_to_le16(l2cap_pi(sk)->dcid);
-	rsp->result = __cpu_to_le16(result ? *result : 0);
+	rsp->result = __cpu_to_le16(result[0] == 255 ? 0 : result[0]);
 	rsp->flags  = __cpu_to_le16(flags);
 
-	return ptr - data;
+	/* return length of actual data */
+	return opts - data;
+}
+
+/**
+ * l2cap_build_info_req - Builds an information request
+ * @data: pointer to allocated data (infotype)
+ */
+static int l2cap_build_info_req(void *data)
+{
+	struct l2cap_info_req *info = data;
+	u8 len = 2;
+
+	/* check if remote peer supports extended features */
+	info->type = __cpu_to_le16(L2CAP_IT_FEAT_MASK);
+
+	return len;
+}
+
+static inline int l2cap_command_rej(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd, u8 *data)
+{
+	struct l2cap_cmd_rej *rej = (struct l2cap_cmd_rej *) data;
+	u16 reason;
+	u8 len; /* depends on the reason code */
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
+		BT_DBG("invalid channel 0x%04X 0x%04X ", ptr[0], ptr[1]);
+		break;
+	default:
+		return reason;
+	}
+
+	return 0;
 }
 
 static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd, u8 *data)
@@ -1485,7 +1764,10 @@
 	struct l2cap_conn_rsp *rsp = (struct l2cap_conn_rsp *) data;
 	u16 scid, dcid, result, status;
 	struct sock *sk;
+	u16 info;
+	/*
 	u8 req[128];
+	*/
 
 	scid   = __le16_to_cpu(rsp->scid);
 	dcid   = __le16_to_cpu(rsp->dcid);
@@ -1505,12 +1787,17 @@
 	switch (result) {
 	case L2CAP_CR_SUCCESS:
 		sk->sk_state = BT_CONFIG;
-		l2cap_pi(sk)->ident = 0;
+		l2cap_pi(sk)->ident = l2cap_get_ident(conn);
 		l2cap_pi(sk)->dcid = dcid;
+		/* send information request first */
+		l2cap_pi(sk)->conf_state |= L2CAP_INFO_REQ_SENT;
+		l2cap_send_cmd(conn, l2cap_pi(sk)->ident, L2CAP_INFO_REQ,
+					l2cap_build_info_req(&info), &info);
+		/*
 		l2cap_pi(sk)->conf_state |= L2CAP_CONF_REQ_SENT;
-
 		l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
 					l2cap_build_conf_req(sk, req), req);
+		*/
 		break;
 
 	case L2CAP_CR_PEND:
@@ -1529,9 +1816,12 @@
 {
 	struct l2cap_conf_req *req = (struct l2cap_conf_req *) data;
 	u16 dcid, flags, cmd_len = __le16_to_cpu(cmd->len);
-	u8 rsp[64];
+	/* allocated memory for response packet */
+	u8 rsp[128];
 	struct sock *sk;
-	int result;
+	/* collected result codes for theor. max 128 possible options
+	 * result[0] indicates the general result code for all options */
+	u8 result[L2CAP_MAX_OPTS];
 
 	dcid  = __le16_to_cpu(req->dcid);
 	flags = __le16_to_cpu(req->flags);
@@ -1541,20 +1831,20 @@
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
@@ -1563,10 +1853,14 @@
 	if (l2cap_pi(sk)->conf_state & L2CAP_CONF_INPUT_DONE) {
 		sk->sk_state = BT_CONNECTED;
 		l2cap_chan_ready(sk);
-	} else if (!(l2cap_pi(sk)->conf_state & L2CAP_CONF_REQ_SENT)) {
-		u8 req[64];
-		l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
-					l2cap_build_conf_req(sk, req), req);
+	} else if (!(l2cap_pi(sk)->conf_state & L2CAP_CONF_REQ_SENT) &&
+		   !(l2cap_pi(sk)->conf_state & L2CAP_INFO_REQ_SENT)) {
+		u16 info;
+		/* send information request */
+		l2cap_pi(sk)->ident = l2cap_get_ident(conn);
+		l2cap_pi(sk)->conf_state |= L2CAP_INFO_REQ_SENT;
+		l2cap_send_cmd(conn, l2cap_pi(sk)->ident, L2CAP_INFO_REQ,
+					l2cap_build_info_req(&info), &info);
 	}
 
 unlock:
@@ -1574,37 +1868,124 @@
 	return 0;
 }
 
+/**
+ * l2cap_config_rsp - handles an incoming configuration response
+ * @conn: corresponding connection
+ * @cmd: command header
+ * @data: contains the whole response (scid, flags, result, data)
+ */
 static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd, u8 *data)
 {
-	struct l2cap_conf_rsp *rsp = (struct l2cap_conf_rsp *)data;
-	u16 scid, flags, result;
+	struct l2cap_conf_rsp *rsp = (struct l2cap_conf_rsp *) data;
+	struct l2cap_pinfo *cap;
+	u16 scid, flags, result, len;
 	struct sock *sk;
+	u8 type;
+	int i;
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
+	cap = l2cap_pi(sk);
+
+	BT_DBG("scid 0x%4.4x flags 0x%2.2x result 0x%2.2x len %d", scid, flags, result, len);
 
 	switch (result) {
 	case L2CAP_CONF_SUCCESS:
+		/* The response may be empty in case of success if all
+		 * requested values are acceptable by the remote peer */
+		while (len >= L2CAP_CONF_OPT_SIZE) {
+			u8 rsp_len = *(u8 *)(ptr + 1);
+			/* bail out if rsp length > packet length */
+			if (len < rsp_len) return 0;
+
+			len -= rsp_len + 2;
+			type = *(u8 *)(ptr + 0);
+
+			switch (type) {
+			case L2CAP_CONF_MTU:
+				cap->imtu = *(__le16 *)(ptr + 2);
+				break;
+			case L2CAP_CONF_RFC:
+				cap->imode = *(u8 *)(ptr + 2);
+				cap->itxw  = *(u8 *)(ptr + 3);
+				cap->imaxt = *(u8 *)(ptr + 4);
+				cap->iret_to = __le16_to_cpup((__le16 *)(ptr + 5));
+				cap->imon_to = __le16_to_cpup((__le16 *)(ptr + 7));
+				cap->imps    = __le16_to_cpup((__le16 *)(ptr + 9));
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
+			/* bail out if rsp length > packet length */
+			if (len < rsp_len) return 0;
+
+			len -= rsp_len + 2;
+			type = *(u8 *)(ptr + 0);
+
+			switch (type) {
+			case L2CAP_CONF_MTU:
+				cap->conf_mtu = *(__le16 *)(ptr + 2);
+				/* add MTU option to new request */
+				l2cap_pi(sk)->conf_state |= L2CAP_CONF_UNACCEPT_MTU;
+				break;
+			case L2CAP_CONF_RFC:
+				cap->conf_mode = *(u8 *)(ptr + 2);
+				cap->conf_txw  = *(u8 *)(ptr + 3);
+				cap->conf_maxt = *(u8 *)(ptr + 4);
+				cap->conf_ret_to = __le16_to_cpup((__le16 *)(ptr + 5));
+				cap->conf_mon_to = __le16_to_cpup((__le16 *)(ptr + 7));
+				cap->conf_mps    = __le16_to_cpup((__le16 *)(ptr + 9));
+				/* add RFC option to new request */
+				l2cap_pi(sk)->conf_state |= L2CAP_CONF_UNACCEPT_RFC;
+				break;
+			}
+	
+			/* go to start of (possible) next request */
+			ptr += rsp_len + L2CAP_CONF_OPT_SIZE;
+		}
+		l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ, 
+					l2cap_build_conf_req(sk, req), req);
+		goto done;
+	}
+
+	case L2CAP_CONF_UNKNOWN:
+		while (len >= L2CAP_CONF_OPT_SIZE) {
+			u8 req[128];
+			u8 rsp_len = *(u8 *)(ptr + 1);
+			/* bail out if rsp length > packet length */
+			if (len < rsp_len) return 0;
+
+			len -= rsp_len + 2;
+			type = *(u8 *)(ptr + 0);
+
+			switch (type) {
+			case L2CAP_CONF_RFC:
+				l2cap_pi(sk)->conf_mode = L2CAP_MODE_BASIC;
+				break;
+			}
+
+			l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ, 
+					l2cap_build_conf_req(sk, req), req);
+
+			/* go to start of (possible) next request */
+			ptr += rsp_len + L2CAP_CONF_OPT_SIZE;
 		}
+		goto done;
 
 	default: 
 		sk->sk_state = BT_DISCONN;
@@ -1702,15 +2083,47 @@
 	return 0;
 }
 
+/**
+ * l2cap_information_rsp - handles an incoming information response
+ * @conn: corresponding connection
+ * @cmd: command header (type, ident, length)
+ * @data: contains infotype, result and (if result == 0) infodata
+ */
 static inline int l2cap_information_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd, u8 *data)
 {
 	struct l2cap_info_rsp *rsp = (struct l2cap_info_rsp *) data;
 	u16 type, result;
+	struct sock *sk;
+	u8 req[128];
+	u8 *ptr = rsp->data;
+	int i, len = 4;
 
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
+			if (HAS_BIT(*ptr, L2CAP_EXT_FCM))
+				SET_BIT(l2cap_pi(sk)->info_ext, L2CAP_EXT_FCM);
+			break;
+		}
+	} else {
+		l2cap_pi(sk)->conf_mode = L2CAP_MODE_BASIC;
+	}
+
+	/* build configuration request */
+	l2cap_pi(sk)->conf_state |= L2CAP_CONF_REQ_SENT;
+	l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
+				l2cap_build_conf_req(sk, req), req);
 
 	return 0;
 }
@@ -1741,7 +2154,7 @@
 
 		switch (cmd.code) {
 		case L2CAP_COMMAND_REJ:
-			/* FIXME: We should process this */
+			err = l2cap_command_rej(conn, &cmd, data);
 			break;
 
 		case L2CAP_CONN_REQ:

--=-sqsLzViHEfq6sJox7SyK--



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
