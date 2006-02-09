Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Martin =?ISO-8859-1?Q?R=F6hricht?= <ml@felicis.org>
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="=-L09hnqOG/YqzE00A6xL4"
Message-Id: <1139482797.2349.32.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-devel] L2CAP Flow Control
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
Date: Thu, 09 Feb 2006 11:59:56 +0100


--=-L09hnqOG/YqzE00A6xL4
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hello together,

I'm currently trying to implement Flow Control on the L2CAP layer. I
already made some good progress but before things become too complicated
all of a sudden, I send my first lines of code to the list to give
everyone the opportuntiy to get an understanding of what I am doing.
So this =BBpatch=AB doesn't bring Flow Control into play, yet. But it
shouldn't break connections either.

I am only working on l2cap.h and l2cap.c
I added some basic constants to the header file as well as two macros
=BBSET_BIT=AB and =BBHAS_BIT=AB which I need later to determine whether one=
 of
the four possible options in a request has already been seen in this
request (imagine a request consisting of MTU + QoS + MTU). Further more
I added all the different parameter fields for our channel and socket
(struct l2cap_pinfo): o stands for outgoing, i for incoming and conf
reflects the parameters sent in a configuration request. Later on we
will have to deal with these conf parameters, compare them to reasonable
values and so on.
In l2cap.c I removed the function =BBl2cap_get_conf_opt=AB because I think
we would run into trouble on Big Endian machines with this code. The
problem is that the basic MTU option consists of only one 16 bit wide
parameter so we can use __le16_to_cpu() for that, but in case of QoS or
my Flow Control, we have a bunch of unfortunately unaligned data fields.
Therefore I access those data fields directly (e.g. cap->conf_mode =3D
*(__u8*)(ptr + 2);).=20
The result flag corresponds to the result values of a configuration
request. We need more than just one, because to be standard compliant we
need to let the other side know, which options are unknown (in such a
case) or which parameters are unacceptable of which particular option.
So we have one basic result code for our responds (result[0]) -- this is
like the max function of {success; Failure/unacceptable parameters;
Failure/rejected; Failure/unknown options}. But we need to keep track of
our failures for a good responds.
The while loop extracts all options of a single request. We have some
basic error check mechanisms to avoid buffer overflow attacks by
corrupted requests.
Inside each option parser we use the HAS_BIT macro to make sure we will
only consider the first of possible multiple options of similar type
within one request. The hint is not processed yet.

This is only basic stuff to detect the different options and parse them
correctly. Now it becomes more complicated as we have to keep track of
all possible failures, parameters, result codes etc. I would write a
function l2cap_check_conf_opt(struct sock *sk, int option) to check the
individual parameters of a particular option. It gets harder to build
the configuration response individually.

That's it for now.

Martin

--=-L09hnqOG/YqzE00A6xL4
Content-Disposition: attachment; filename=patch-2.6.14-mr
Content-Type: text/plain; name=patch-2.6.14-mr; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- linux-2.6.14-mh2/include/net/bluetooth/l2cap.h	2005-12-23 21:14:59.000000000 +0100
+++ linux-2.6.14-mr/include/net/bluetooth/l2cap.h	2006-02-09 10:54:57.000000000 +0100
@@ -28,6 +28,8 @@
 /* L2CAP defaults */
 #define L2CAP_DEFAULT_MTU	672
 #define L2CAP_DEFAULT_FLUSH_TO	0xFFFF
+#define L2CAP_MIN_TXW		1
+#define L2CAP_MAX_TXW		32
 
 #define L2CAP_CONN_TIMEOUT	(HZ * 40)
 
@@ -47,6 +49,10 @@
 	__u8  mode;
 };
 
+#define L2CAP_MODE_BASIC	0x00
+#define L2CAP_MDOE_RET		0x01
+#define L2CAP_MODE_FLOW		0x02
+
 #define L2CAP_CONNINFO	0x02
 struct l2cap_conninfo {
 	__u16 hci_handle;
@@ -129,8 +135,10 @@
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
@@ -144,7 +152,8 @@
 #define L2CAP_CONF_QOS		0x03
 #define L2CAP_CONF_RFC		0x04
 
-#define L2CAP_CONF_MAX_SIZE	22
+#define SET_BIT(x, v) ((x) |= 1 << (v))
+#define HAS_BIT(x, v) (((x) & (1 << (v))) != 0)
 
 struct l2cap_disconn_req {
 	__le16     dcid;
@@ -220,6 +229,31 @@
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
+	
 	__u8		ident;
 
 	struct l2cap_conn	*conn;
--- linux-2.6.14-mh2/net/bluetooth/l2cap.c	2006-01-20 12:05:17.000000000 +0100
+++ linux-2.6.14-mr/net/bluetooth/l2cap.c	2006-02-09 11:26:17.000000000 +0100
@@ -850,7 +850,7 @@
 		opts.imtu     = l2cap_pi(sk)->imtu;
 		opts.omtu     = l2cap_pi(sk)->omtu;
 		opts.flush_to = l2cap_pi(sk)->flush_to;
-		opts.mode     = 0x00;
+		opts.mode     = L2CAP_MODE_BASIC;
 
 		len = min_t(unsigned int, len, sizeof(opts));
 		if (copy_to_user(optval, (char *) &opts, len))
@@ -1236,74 +1236,105 @@
 	return NULL;
 }
 
-static inline int l2cap_get_conf_opt(void **ptr, int *type, int *olen, unsigned long *val)
-{
-	struct l2cap_conf_opt *opt = *ptr;
-	int len;
-
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
-
-	case 2:
-		*val = __le16_to_cpu(*((__le16 *) opt->val));
-		break;
-
-	case 4:
-		*val = __le32_to_cpu(*((__le32 *) opt->val));
-		break;
-
-	default:
-		*val = (unsigned long) opt->val;
-		break;
-	}
-
-	BT_DBG("type 0x%2.2x len %d val 0x%lx", *type, opt->len, *val);
-	return len;
-}
 
 static inline void l2cap_parse_conf_req(struct sock *sk, void *data, u16 len)
 {
-	int type, hint, olen; 
-	unsigned long val;
-	void *ptr = data;
-
+	struct l2cap_pinfo *cap = l2cap_pi(sk);
+	int type, hint; 
+	u8 *ptr = data;
+	u8 options = 0; /* bit flag that indicates which options are set */
+	u8 result[5]; /* result codes for all 4 possible options plus result[0] */
+	unsigned int i;
+	
 	BT_DBG("sk %p len %d", sk, len);
 
+	for (i = 0; i < len; ++i)
+		printk("%02X ", ptr[i]);
+	printk("\n");
+
+	result[0] = L2CAP_CONF_SUCCESS;
+	
 	while (len >= L2CAP_CONF_OPT_SIZE) {
-		len -= l2cap_get_conf_opt(&ptr, &type, &olen, &val);
 		u8 req_len = *(u8*)(ptr + 1);
 
+		/* Bail out if req length > packet length */
+		if (len < req_len) return;
+
+		len -= req_len + 2;
+		type = *(u8*)(ptr + 0);
+
 		hint  = type & 0x80;
 		type &= 0x7f;
 
 		BT_DBG("Type: %d len: %d", type, req_len);
+		
 		switch (type) {
 		case L2CAP_CONF_MTU:
-			l2cap_pi(sk)->conf_mtu = val;
+			if (HAS_BIT(options, L2CAP_CONF_MTU)) break;
+			if (req_len != 2) {
+				result[0] = L2CAP_CONF_REJ;
+				break;
+			}
+			cap->conf_mtu = __le16_to_cpup((__le16*)(ptr + 2));
+			SET_BIT(options, L2CAP_CONF_MTU);
 			break;
 
+		/* Flush TO not supported yet */
 		case L2CAP_CONF_FLUSH_TO:
-			l2cap_pi(sk)->flush_to = val;
+			if (HAS_BIT(options, L2CAP_CONF_FLUSH_TO)) break;
+#if 0
+			if (req_len != 2) {
+				result[0] = L2CAP_CONF_REJ;
+				break;
+			}
+			cap->flush_to = __le16_to_cpup((__le16*)(ptr + 2));
+#endif
+			result[0] = L2CAP_CONF_UNKNOWN;
+			result[L2CAP_CONF_FLUSH_TO] = L2CAP_CONF_UNKNOWN;
+			SET_BIT(options, L2CAP_CONF_FLUSH_TO);
 			break;
 
+		/* QoS not supported yet */
 		case L2CAP_CONF_QOS:
+			if (HAS_BIT(options, L2CAP_CONF_QOS)) break;
+#if 0
+			if (req_len != 22) {
+				result[0] = L2CAP_CONF_REJ;
+				break;
+			}
+#endif
+			result[0] = L2CAP_CONF_UNKNOWN;
+			result[L2CAP_CONF_QOS] = L2CAP_CONF_UNKNOWN;
+			SET_BIT(options, L2CAP_CONF_QOS);
 			break;
 
+		case L2CAP_CONF_RFC: {
+			if (HAS_BIT(options, L2CAP_CONF_RFC)) break;
+			if (req_len != 9) {
+				result[0] = L2CAP_CONF_REJ;
+				break;
+			}
+			cap->conf_mode = *(__u8*)(ptr + 2);
+			cap->conf_txw  = *(__u8*)(ptr + 3);
+			cap->conf_maxt = *(__u8*)(ptr + 4);
+			cap->conf_ret_to = __le16_to_cpup((__le16*)(ptr + 5));
+			cap->conf_mon_to = __le16_to_cpup((__le16*)(ptr + 7));
+			cap->conf_mps    = __le16_to_cpup((__le16*)(ptr + 9));
+			SET_BIT(options, L2CAP_CONF_RFC);
+			break;
+		}
+	
 		default:
+			result[0] = L2CAP_CONF_REJ;
 			if (hint)
 				break;
 
 			/* FIXME: Reject unknown option */
 			break;
 		}
+
+		/* Go to start of (possible) next request */
+		ptr += req_len;
 	}
 }
 
@@ -1361,16 +1392,15 @@
 static inline int l2cap_conf_output(struct sock *sk, void **ptr)
 {
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
-	int result = 0;
+	int result = L2CAP_CONF_SUCCESS;
 
 	/* Configure output options and let the other side know
 	 * which ones we don't like. */
 	if (pi->conf_mtu < pi->omtu) {
 		l2cap_add_conf_opt(ptr, L2CAP_CONF_MTU, 2, pi->omtu);
 		result = L2CAP_CONF_UNACCEPT;
-	} else {
+	} else
 		pi->omtu = pi->conf_mtu;
-	}
 
 	BT_DBG("sk %p result %d", sk, result);
 	return result;
@@ -1548,7 +1578,7 @@
 	l2cap_parse_conf_req(sk, req->data, cmd_len - sizeof(*req));
 
 	if (flags & 0x0001) {
-		/* Incomplete config. Send empty response. */
+		/* Incomplete config (not supported). Send empty response. */
 		l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP,
 				l2cap_build_conf_rsp(sk, rsp, NULL), rsp);
 		goto unlock;

--=-L09hnqOG/YqzE00A6xL4--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
