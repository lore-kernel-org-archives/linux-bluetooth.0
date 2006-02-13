Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] L2CAP Flow Control
From: Martin =?ISO-8859-1?Q?R=F6hricht?= <ml@felicis.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1139482797.2349.32.camel@localhost.localdomain>
References: <1139482797.2349.32.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-PV9zgmuBa+fx0dimKr8F"
Message-Id: <1139854227.16687.36.camel@localhost.localdomain>
Mime-Version: 1.0
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
Date: Mon, 13 Feb 2006 19:10:27 +0100


--=-PV9zgmuBa+fx0dimKr8F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Status update to L2CAP Flow Control work.

In the function l2cap_parse_conf_req() I changed the result array to
have a size of 128 instead of 5, because we have to respond to each
request no matter which possible option is used. Currently the standard
defines 4 options (0x01 to 0x04) but in case the remote device sends a
request for option 0x42 we have to create an unknown option response
with the value of 0x42 as a parameter (that's why we need to keep track
of all incoming options). 128 reflects the maximum possible options
because the option type field is 8 bits long (256 in decimal) where the
most significant bit determines if the option is to be recognized as a
hint. The result value for each option is stored in result[OPTION] and
the overall result value of the request is stored in result[0] (nice
effect, that no option will ever have 0x00 as its option type value).
For a reasonable initialization we chose to use 255:
	memset(result, 255, sizeof(result));
as this can never be used in a real request and 0 would have stated
SUCCESS for every single of the 127 possible options.
The default case for us is now an unknown option, therefore the use of
L2CAP_CONF_QOS and L2CAP_CONF_FLUSH_TO are currently commented out and
can be extended whenever somebody works on these parts.

Then I introduced a new function called =BBl2cap_check_conf_opt()=AB for th=
e
purpose of validity checks against all values that have been written to
the conf_* variables. This function will return a result code for this
one option that it has to check. MTU currently lacks completion but RFC
is already in progress. In case one value is not acceptable, we need to
generate a response with the values that would have been accepted if
sent in the original request. So in case we will end with
L2CAP_CONF_UNACCEPT we do not want to write or have written any value to
our outgoing channel configuration. That's why we will use the conf_*
variables as long as we do not know that the request is perfectly valid
(SUCCESS). So this function makes some basic checks even if I do not
know where I can retrieve acceptable values for the Retransmission
Timeout, the Monitor Timeout or the MPS/PDU size. That's definitely an
issue that needs to be solved. Perhaps somebody with more insight comes
with an idea?

Once the check function returned and we parsed each option of the
request, we need to differentiate between the major result code
result[0] and create corresponding response packets. For the case
everything is fine (L2CAP_CONF_SUCCESS) we write the conf_* values to
the corresponding o* variables.

So the next step is to rewrite the functions that create a response
packet as we would run into trouble again within the function
l2cap_add_conf_opt() on Big Endian machines. It becomes a bit more fuzzy
to keep track of different options that must be handled within one
request/response in a generic way that offers us enough power to create
the responses individualy.

That's it for today.

Martin

--=-PV9zgmuBa+fx0dimKr8F
Content-Disposition: attachment; filename=patch-2.6.14-mr
Content-Type: text/plain; name=patch-2.6.14-mr; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- linux-2.6.14-mh2/net/bluetooth/l2cap.c	2006-01-20 12:05:17.000000000 +0100
+++ linux-2.6.14-mr/net/bluetooth/l2cap.c	2006-02-10 16:04:49.000000000 +0100
@@ -1236,75 +1236,194 @@
 	return NULL;
 }
 
-static inline int l2cap_get_conf_opt(void **ptr, int *type, int *olen, unsigned long *val)
+static int l2cap_check_conf_opt(struct sock *sk, int option)
 {
-	struct l2cap_conf_opt *opt = *ptr;
-	int len;
-
-	len = L2CAP_CONF_OPT_SIZE + opt->len;
-	*ptr += len;
+        int result = L2CAP_CONF_SUCCESS;
+        struct l2cap_pinfo *pi = l2cap_pi(sk);
 
-	*type = opt->type;
-	*olen = opt->len;
+        switch (option) {
+                case L2CAP_CONF_MTU:
+                        break;
+                case L2CAP_CONF_FLUSH_TO:
+                        break;
+                case L2CAP_CONF_QOS:
+                        break;
+                case L2CAP_CONF_RFC:
+                        if (pi->conf_mode == L2CAP_MODE_BASIC) {
+                                pi->omode = L2CAP_MODE_BASIC;
+                                break;
+                        }
+                        /* Retransmission Mode not supported yet */
+                        if (pi->conf_mode != L2CAP_MODE_FLOW) {
+                                pi->conf_mode = L2CAP_MODE_FLOW;
+                                result = L2CAP_CONF_UNACCEPT;
+                        }
+                        if (pi->conf_txw < 1 || pi->conf_txw > 32) {
+                                pi->conf_txw = 32;
+                                result = L2CAP_CONF_UNACCEPT;
+                        }
+                        if (pi->conf_maxt < 1) {
+                                pi->conf_maxt = 400;
+                                result = L2CAP_CONF_UNACCEPT;
+                        }
+                        if (pi->conf_ret_to < 100) {
+                                pi->conf_ret_to = 100;
+                                result = L2CAP_CONF_UNACCEPT;
+                        }
+                        if (pi->conf_mon_to < 100) {
+                                pi->conf_mon_to = 100;
+                                result = L2CAP_CONF_UNACCEPT;
+                        }
+                        /* MPS/PDU check */
+                        break;
+        }
 
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
+        return result;
 }
 
 static inline void l2cap_parse_conf_req(struct sock *sk, void *data, u16 len)
 {
-	int type, hint, olen; 
-	unsigned long val;
-	void *ptr = data;
-
-	BT_DBG("sk %p len %d", sk, len);
-
-	while (len >= L2CAP_CONF_OPT_SIZE) {
-		len -= l2cap_get_conf_opt(&ptr, &type, &olen, &val);
-		u8 req_len = *(u8*)(ptr + 1);
-
-		hint  = type & 0x80;
-		type &= 0x7f;
-
-		BT_DBG("Type: %d len: %d", type, req_len);
-		switch (type) {
-		case L2CAP_CONF_MTU:
-			l2cap_pi(sk)->conf_mtu = val;
-			break;
-
-		case L2CAP_CONF_FLUSH_TO:
-			l2cap_pi(sk)->flush_to = val;
-			break;
-
-		case L2CAP_CONF_QOS:
-			break;
-
-		default:
-			if (hint)
-				break;
-
-			/* FIXME: Reject unknown option */
-			break;
+        struct l2cap_pinfo *cap = l2cap_pi(sk);
+        int type, hint;
+        u8 *ptr = data;
+        u8 options = 0; /* bit flag that indicates which options are set */
+        u8 result[128]; /* collected result codes */
+        unsigned int i;
+
+        BT_DBG("sk %p len %d", sk, len);
+
+        for (i = 0; i < len; ++i)
+                printk("%02X ", ptr[i]);
+        printk("\n");
+
+        memset(result, 255, sizeof(result));
+        result[0] = L2CAP_CONF_SUCCESS;
+
+        while (len >= L2CAP_CONF_OPT_SIZE) {
+                u8 req_len = *(u8*)(ptr + 1);
+
+                /* Bail out if req length > packet length */
+                if (len < req_len) return;
+
+                len -= req_len + 2;
+                type = *(u8*)(ptr + 0);
+
+                hint  = type & 0x80;
+                type &= 0x7f;
+
+                BT_DBG("Type: %d len: %d", type, req_len);
+
+                switch (type) {
+                case 0:
+                        result[0] = L2CAP_CONF_REJ;
+                        break;
+                case L2CAP_CONF_MTU:
+                        if (HAS_BIT(options, L2CAP_CONF_MTU)) break;
+                        if (req_len != 2) {
+                                result[0] = L2CAP_CONF_REJ;
+                                break;
+                        }
+                        cap->conf_mtu = __le16_to_cpup((__le16*)(ptr + 2));
+                        SET_BIT(options, L2CAP_CONF_MTU);
+			result[L2CAP_CONF_MTU] = l2cap_check_conf_opt(sk, L2CAP_CONF_MTU);
+                        if (result[L2CAP_CONF_MTU] == L2CAP_CONF_UNACCEPT)
+                                result[0] = L2CAP_CONF_UNACCEPT;
+                        break;
+
+                /* Flush TO not supported yet */
+#if 0
+                case L2CAP_CONF_FLUSH_TO:
+                        if (HAS_BIT(options, L2CAP_CONF_FLUSH_TO)) break;
+                        if (req_len != 2) {
+                                result[0] = L2CAP_CONF_REJ;
+                                break;
+                        }
+                        cap->flush_to = __le16_to_cpup((__le16*)(ptr + 2));
+                        result[0] = L2CAP_CONF_UNKNOWN;
+                        result[L2CAP_FLUSH_TO] = L2CAP_CONF_UNKNOWN;
+                        SET_BIT(options, L2CAP_CONF_FLUSH_TO);
+                        break;
+#endif
+
+                /* QoS not supported yet */
+#if 0
+                case L2CAP_CONF_QOS:
+                        if (HAS_BIT(options, L2CAP_CONF_QOS)) break;
+                        if (req_len != 22) {
+                                result[0] = L2CAP_CONF_REJ;
+                                break;
+                        }
+                        result[0] = L2CAP_CONF_UNKNOWN;
+                        result[L2CAP_CONF_QOS] = L2CAP_CONF_UNKNOWN;
+                        SET_BIT(options, L2CAP_CONF_QOS);
+                        break;
+#endif
+
+                case L2CAP_CONF_RFC: {
+                        if (HAS_BIT(options, L2CAP_CONF_RFC)) break;
+                        if (req_len != 9) {
+                                result[0] = L2CAP_CONF_REJ;
+                                break;
+                        }
+                        cap->conf_mode = *(__u8*)(ptr + 2);
+                        cap->conf_txw  = *(__u8*)(ptr + 3);
+                        cap->conf_maxt = *(__u8*)(ptr + 4);
+                        cap->conf_ret_to = __le16_to_cpup((__le16*)(ptr + 5));
+                        cap->conf_mon_to = __le16_to_cpup((__le16*)(ptr + 7));
+                        cap->conf_mps    = __le16_to_cpup((__le16*)(ptr + 9));
+                        SET_BIT(options, L2CAP_CONF_RFC);
+			result[L2CAP_CONF_RFC] = l2cap_check_conf_opt(sk, L2CAP_CONF_RFC);
+                        if (result[L2CAP_CONF_RFC] == L2CAP_CONF_UNACCEPT)
+                                result[0] = L2CAP_CONF_UNACCEPT;
+                        break;
+                }
+
+                default:
+			result[0] = L2CAP_CONF_UNKNOWN;
+                        result[type] = L2CAP_CONF_UNKNOWN;
+                        if (hint)
+                                break;
+
+                        break;
+                }
+
+                /* Go to start of (possible) next request */
+                ptr += req_len;
+        }
+        if (result[0] == L2CAP_CONF_UNKNOWN) {
+                for (i = 1; i < sizeof(result); ++i) {
+                        if (result[i] == L2CAP_CONF_UNKNOWN) {
+                                /* create response packet with option type i */
+                        }
+                }
+        }
+        if (result[0] == L2CAP_CONF_UNACCEPT) {
+                for (i = 1; i < sizeof(result); ++i) {
+                        if (result[i] == L2CAP_CONF_UNACCEPT) {
+                                /* create response packet with option type i */
+                        }
 		}
-	}
+        }
+        if (result[0] == L2CAP_CONF_SUCCESS) {
+                for (i = 1; i < sizeof(result); ++i) {
+                        if (result[i] == L2CAP_CONF_SUCCESS) {
+                                switch (i) {
+                                        case L2CAP_CONF_MTU:
+                                                cap->omtu = cap->conf_mtu;
+                                                break;
+                                        case L2CAP_CONF_RFC:
+                                                cap->omode = cap->conf_mode;
+                                                cap->otxw = cap->conf_txw;
+                                                cap->omaxt = cap->conf_maxt;
+                                                cap->oret_to = cap->conf_ret_to;
+                                                cap->omon_to = cap->conf_mon_to;
+                                                cap->omps = cap->conf_mps;
+                                                break;
+                                }
+                                /* create response packet for option type i */
+                        }
+                }
+        }
 }
 
 static void l2cap_add_conf_opt(void **ptr, u8 type, u8 len, unsigned long val)
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

--=-PV9zgmuBa+fx0dimKr8F--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
