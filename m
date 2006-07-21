Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Martin =?ISO-8859-1?Q?R=F6hricht?= <ml@felicis.org>
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="=-R0me10r6CIaRHkvRsgRA"
Date: Fri, 21 Jul 2006 16:54:30 +0200
Message-Id: <1153493670.18235.53.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-devel] L2CAP Flow Control 5th stage
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


--=-R0me10r6CIaRHkvRsgRA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello together,

this is an update on my attempt to implement L2CAP flow control for the
BlueZ stack. I attached the current patch from my snapshot. Be aware
that this patch is far from being complete. Instead I'd like to present
some results of my coding in the past. So the current patch compiles and
should still work with devices that do not want to use flow control. But
this code is not meant to be tested in binary mode ;-)

I already implemented the whole configuration procedure in the past. I
consider this part as being done in terms of functionality. This time
I'd like to emphasize more on the real flow control procedural work that
I currently work on. For the beginning I started working on the
reception of I- and S-Frames.

Whenever we get a frame from the layer beneath us, l2cap_recv_acldata()
is called. Within this function the protocol specific headers of the ACL
layer is extracted, error checks are performed and finally the ACL
information payload, which consists of a plain L2CAP frame, is being
passed to l2cap_recv_frame() in form of a socket buffer.=20
l2cap_recv_frame() decides whether we are using a signalling channel, a
connectionless channel or a data channel. We are only concerned for the
latter one as flow control mode can only be used in therein.

(1) l2cap_data_channel()
I did not change any of the old functionality that is used for B-Frames.
But when a link is configured to be used in flow control mode I-Frames
and S-Frames are used instead of B-Frames, so I added some functionality
there. First of all, we check if the frame that is being sent is valid.
This check is performed in l2cap_invalid_frame_detection(). If this
check fails the frame is dropped. The next check is based on the frame's
type itself -- the last bit shows whether we are getting an I-Frame or a
S-Frame. In both cases we are checking the ReqSeq value and in case of
an I-Frame also the TxSeq value. Further more we need to make sure that
segmented I-Frames that form one SDU are reassembled and passed to the
upper layer. This is done in l2cap_reassembly().

(2) l2cap_invalid_frame_detection()
This is an easy to follow function. The first check ensures if the
length field within the L2CAP header is true -- so it must be the same
as the length of the socket buffer (the whole frame) excluding the l2cap
header. All the other checks are the ones mentioned in the check list of
the specification on page 40 (section 3.3.6 Invalid frame detection).
Worth being mentioned is only that check number six is not implemented
yet within this function: =C2=BBI-Frame with SAR bits that do not correspon=
d
to a normal sequence of either unsegmented or start, continuation, end
for the given CID=C2=AB -- this check is done later within the reassembly
function. We are not making use of any error reporting technique yet.
But interesting is the use of the crc16() function of the crc16 module.
I assume this should do the trick as the generator polynomial is the
same. Unfortunately this would require to have the crc16 module loaded
to use BlueZ in the future.

(3) l2cap_process_txseq()
The TxSeq is extracted and checked for validity. In case a frame gets
lost in L2CAP flow control mode, the specification forces us not to make
use of any retransmission nor can we use a special buffer for
out-of-sequence frames. Instead those frames considered lost are just
ignored and the ExpectedTxSeq value is based upon the last I-Frame
received. Duplicated I-Frames are dropped as well es invalid frames.
Unfortunately the specification mentions that the ReqSeq value shall be
processed according to Section 8.5.4 in case of a duplicated I-Frame,
but I didn't figure out what that means practically in this case ...

(4) l2cap_process_reqseq()
This function is alike the above one. First there is a "magical
byte-check" which only checks whether we have either an I-Frame (last
bit is a 0) or we are getting an S-Frame where the last four bits must
be of the form 0001. The next check is concerned about the ReqSeq
sequence error. If something went wrong the specification indicates:
=C2=BBThe L2CAP entity shall close the channel as a consequence of an ReqSe=
q
Sequence error.=C2=AB -- so do we.
In case everything went fine, one of the two timers will be started --
but the timer stuff hasn't been finished yet.

(5) l2cap_reassembly()
This function is currently the most interesting one. Whenever a SDU is
segmented into more than one I-Frames we will reassemble those segments
here. In case of an unsegmented I-Frame the already complete SDU is
passed to the application via sock_queue_rcv_skb() -- I assume this is
the function to be used for this action ... is that right?
In case of segmentation we have to perform some more logic and to be a
bit careful. The logic means we are going to allocate a new socket
buffer which we provide per socket (l2cap_pi(sk)->sdu) with the length
that is provided within the SDU length field of the first segmented
I-Frame. We memcpy the current frame into this new skb data field. In
case we receive a frame with the continuation or end flags set, we make
two error checks. If both went well we memcpy this frame into the sdu
skb. Just in case the SAR_END flag is set and(!) the sdu length matches
the length of all the frames that were put into this sdu, we are passing
the SDU to the above layer.
It is important to make sure this technique works also when one or more
frames get lost. Therefore I provided the last mentioned mechanism and
to avoid unnecessary memory consumption I made sure to free the
currently allocated sdu memory block when we receive a new frame with
SAR_START flags set. So I think this should already work for the cases
that the start frame is lost, onw or more of the continuation frames are
lost or even if the end frame is lost. But maybe somebody wants to dive
into this error checking once more?!

That's basically it. I didn't do anything regarding timer control
mechanism nor did I investigate the send mechanism closer. But to give
some interested developers the chance to take a look into my code, make
some proposals or find bugs, I post this message here.

Martin

--=-R0me10r6CIaRHkvRsgRA
Content-Disposition: attachment; filename=patch-2006-07-21
Content-Type: text/x-patch; name=patch-2006-07-21; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -uNr linux-2.6.17-mh4/include/net/bluetooth/l2cap.h linux-2.6.17-mr/include/net/bluetooth/l2cap.h
--- linux-2.6.17-mh4/include/net/bluetooth/l2cap.h	2006-07-21 15:57:42.000000000 +0200
+++ linux-2.6.17-mr/include/net/bluetooth/l2cap.h	2006-07-21 15:54:07.000000000 +0200
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
+#define L2CAP_DEFAULT_MPS 	65531
+#define L2CAP_MAX_MPS		65531
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
@@ -76,32 +92,38 @@
 
 /* L2CAP structures */
 struct l2cap_hdr {
-	__u16      len;
-	__u16      cid;
+	__le16     len;
+	__le16     cid;
 } __attribute__ ((packed));
 #define L2CAP_HDR_SIZE		4
 
 struct l2cap_cmd_hdr {
 	__u8       code;
 	__u8       ident;
-	__u16      len;
+	__le16     len;
 } __attribute__ ((packed));
 #define L2CAP_CMD_HDR_SIZE	4
 
 struct l2cap_cmd_rej {
-	__u16      reason;
+	__le16     reason;
+	__le16     data[0];
 } __attribute__ ((packed));
 
+/* command reject reasons */
+#define L2CAP_CMD_NOT_UNDERSTOOD 	0x0000
+#define L2CAP_MTU_EXCEEDED 		0x0001
+#define L2CAP_INVALID_CID 		0x0002
+
 struct l2cap_conn_req {
-	__u16      psm;
-	__u16      scid;
+	__le16     psm;
+	__le16     scid;
 } __attribute__ ((packed));
 
 struct l2cap_conn_rsp {
-	__u16      dcid;
-	__u16      scid;
-	__u16      result;
-	__u16      status;
+	__le16     dcid;
+	__le16     scid;
+	__le16     result;
+	__le16     status;
 } __attribute__ ((packed));
 
 /* connect result */
@@ -117,20 +139,22 @@
 #define L2CAP_CS_AUTHOR_PEND  0x0002
 
 struct l2cap_conf_req {
-	__u16      dcid;
-	__u16      flags;
+	__le16     dcid;
+	__le16     flags;
 	__u8       data[0];
 } __attribute__ ((packed));
 
 struct l2cap_conf_rsp {
-	__u16      scid;
-	__u16      flags;
-	__u16      result;
+	__le16     scid;
+	__le16     flags;
+	__le16     result;
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
@@ -146,34 +170,47 @@
 
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
-	__u16      dcid;
-	__u16      scid;
+	__le16     dcid;
+	__le16     scid;
 } __attribute__ ((packed));
 
 struct l2cap_disconn_rsp {
-	__u16      dcid;
-	__u16      scid;
+	__le16     dcid;
+	__le16     scid;
 } __attribute__ ((packed));
 
 struct l2cap_info_req {
-	__u16       type;
-	__u8        data[0];
+	__le16      type;
 } __attribute__ ((packed));
 
 struct l2cap_info_rsp {
-	__u16       type;
-	__u16       result;
+	__le16      type;
+	__le16      result;
 	__u8        data[0];
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
@@ -205,33 +242,94 @@
 
 struct l2cap_pinfo {
 	struct bt_sock	bt;
-	__u16		psm;
+	__le16		psm;
+	__le16		sport;
 	__u16		dcid;
 	__u16		scid;
 
 	__u16		imtu;
 	__u16		omtu;
 	__u16		flush_to;
+	__u8		mode;
 
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
 
-	__u8		ident;
+	/* Configuration Request RFC Options */
+	__u8		conf_mode;
+	__u8		conf_txw;
+	__u8		conf_maxt;
+	__u16		conf_ret_to;
+	__u16		conf_mon_to;
+	__u16		conf_mps;
+
+	/* incoming RFC Options */
+	__u8		itxw;
+	__u8		imaxt;
+	__u16		iret_to;
+	__u16		imon_to;
+	__u16		imps;
+
+	/* outgoing RFC Options */
+	__u8		otxw;
+	__u8		omaxt;
+	__u16		oret_to;
+	__u16		omon_to;
+	__u16		omps;
+
+	/* flow control mode */
+	__le16		tx_seq;
+	__le16		next_txseq;
+	__le16		exp_ackseq;
+	__le16		req_seq;
+	__le16		exp_txseq;
+	__le16		buffer_seq;
+	__u16		sdu_len;
+	struct sk_buff	*sdu;
 
-	__u16		sport;
+	__u8		ident;
 
+	struct timer_list	ret_timer;
+	struct timer_list	mon_timer;
 	struct l2cap_conn	*conn;
 	struct sock		*next_c;
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
+
+/* RFC definitions */
+#define L2CAP_MAX_DATA_LEN	65531
+#define L2CAP_CONTROL_SIZE	2
+#define L2CAP_FCS_SIZE		2
+
+#define L2CAP_SAR_UNSEGMENTED	0x0000
+#define L2CAP_SAR_START		0x4000
+#define L2CAP_SAR_END		0x8000
+#define L2CAP_SAR_CONTINUE	0xC000
+#define L2CAP_SAR_MASK		0xC000
+#define L2CAP_TXSEQ_MASK	0x007E
+#define L2CAP_REQSEQ_MASK	0x3F00
+
+#define L2CAP_GET_TXSEQ(control)	((__le16_to_cpu(control) & L2CAP_TXSEQ_MASK) >> 1)
+#define L2CAP_GET_REQSEQ(control)	((__le16_to_cpu(control) & L2CAP_REQSEQ_MASK) >> 8)
+#define L2CAP_GET_SAR(control)		(__le16_to_cpu(control) & L2CAP_SAR_MASK)
 
 void l2cap_load(void);
 
diff -uNr linux-2.6.17-mh4/net/bluetooth/l2cap.c linux-2.6.17-mr/net/bluetooth/l2cap.c
--- linux-2.6.17-mh4/net/bluetooth/l2cap.c	2006-07-21 15:57:27.000000000 +0200
+++ linux-2.6.17-mr/net/bluetooth/l2cap.c	2006-07-21 15:59:14.000000000 +0200
@@ -41,11 +41,13 @@
 #include <linux/skbuff.h>
 #include <linux/list.h>
 #include <linux/device.h>
+#include <linux/crc16.h>
 #include <net/sock.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <asm/unaligned.h>
+#include <asm/bitops.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -105,6 +107,42 @@
 	sk->sk_timer.data = (unsigned long)sk;
 }
 
+static void l2cap_start_ret_timer(struct sock *sk, u16 timeout)
+{
+	if (timeout <= jiffies) return;
+	mod_timer(&l2cap_pi(sk)->ret_timer, timeout);
+}
+
+static void l2cap_start_mon_timer(struct sock *sk, u16 timeout)
+{
+	if (timeout <= jiffies) return;
+	mod_timer(&l2cap_pi(sk)->mon_timer, timeout);
+}
+
+static void l2cap_retransmission_timer(unsigned long data)
+{
+	struct sock *sk = (struct sock *)data;
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
+
+	pi->exp_ackseq = (pi->exp_ackseq + 1) % 64;
+	if (pi->exp_ackseq == pi->next_txseq) {
+		l2cap_start_mon_timer(sk, pi->imon_to * HZ / 1000);
+	} else {
+		l2cap_start_ret_timer(sk, pi->iret_to * HZ / 1000);
+		/* FIXME: "transmit any i-frames awaiting transmission
+		 * 	   according to section 8.5.1" */
+	}
+
+}
+
+static void l2cap_monitor_timer(unsigned long data)
+{
+	/*
+	struct sock *sk = (struct sock *)data;
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	*/
+}
+
 /* ---- L2CAP channels ---- */
 static struct sock *__l2cap_get_chan_by_dcid(struct l2cap_chan_list *l, u16 cid)
 {
@@ -500,16 +538,35 @@
 		sk->sk_type = parent->sk_type;
 		pi->imtu = l2cap_pi(parent)->imtu;
 		pi->omtu = l2cap_pi(parent)->omtu;
+		pi->mode = l2cap_pi(parent)->mode;
 		pi->link_mode = l2cap_pi(parent)->link_mode;
 	} else {
 		pi->imtu = L2CAP_DEFAULT_MTU;
 		pi->omtu = 0;
+		pi->mode = L2CAP_MODE_BASIC;
 		pi->link_mode = 0;
 	}
 
 	/* Default config options */
 	pi->conf_mtu = L2CAP_DEFAULT_MTU;
 	pi->flush_to = L2CAP_DEFAULT_FLUSH_TO;
+	pi->conf_mode = L2CAP_MODE_FLOW;
+	pi->conf_txw = L2CAP_DEFAULT_TXW;
+	pi->conf_maxt = L2CAP_DEFAULT_MAXT;
+	pi->conf_ret_to = L2CAP_DEFAULT_RETTO;
+	pi->conf_mon_to = L2CAP_DEFAULT_MONTO;
+	pi->conf_mps = L2CAP_DEFAULT_MPS;
+
+	pi->next_txseq = 0;
+	pi->exp_ackseq = 0;
+
+	init_timer(&l2cap_pi(sk)->ret_timer);
+	l2cap_pi(sk)->ret_timer.function = l2cap_retransmission_timer;
+	l2cap_pi(sk)->ret_timer.data = (unsigned long)l2cap_pi(sk);
+
+	init_timer(&l2cap_pi(sk)->mon_timer);
+	l2cap_pi(sk)->mon_timer.function = l2cap_monitor_timer;
+	l2cap_pi(sk)->mon_timer.data = (unsigned long)l2cap_pi(sk);
 }
 
 static struct proto l2cap_proto = {
@@ -995,7 +1052,7 @@
 		opts.imtu     = l2cap_pi(sk)->imtu;
 		opts.omtu     = l2cap_pi(sk)->omtu;
 		opts.flush_to = l2cap_pi(sk)->flush_to;
-		opts.mode     = 0x00;
+		opts.mode     = l2cap_pi(sk)->mode;
 
 		len = min_t(unsigned int, len, sizeof(opts));
 		if (copy_to_user(optval, (char *) &opts, len))
@@ -1227,102 +1284,214 @@
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
-		*val = *((u8 *) opt->val);
+	switch (option) {
+	case L2CAP_CONF_MTU:
+		if (pi->conf_mtu < L2CAP_MIN_MTU)
+			result = L2CAP_CONF_UNACCEPT;
 		break;
-
-	case 2:
-		*val = __le16_to_cpu(*((u16 *)opt->val));
+	case L2CAP_CONF_FLUSH_TO:
 		break;
-
-	case 4:
-		*val = __le32_to_cpu(*((u32 *)opt->val));
+	case L2CAP_CONF_QOS:
 		break;
-
-	default:
-		*val = (unsigned long) opt->val;
+	case L2CAP_CONF_RFC:
+		if (pi->conf_mode == L2CAP_MODE_BASIC) {
+			pi->mode = L2CAP_MODE_BASIC;
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
 
-static inline void l2cap_parse_conf_req(struct sock *sk, void *data, int len)
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
+	int i = 0;
 
 	BT_DBG("sk %p len %d", sk, len);
 
+	for (i = 0; i < len; ++i)
+		printk("%02X ", ptr[i]);
+	printk("\n");
+
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
+		case 0:
+			result[0] = L2CAP_CONF_REJ;
+			break;
 		case L2CAP_CONF_MTU:
-			l2cap_pi(sk)->conf_mtu = val;
+			printk("-> configure MTU\n");
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
+
 			break;
 
 		case L2CAP_CONF_FLUSH_TO:
-			l2cap_pi(sk)->flush_to = val;
+			if (test_bit(L2CAP_CONF_FLUSH_TO, &options))
+				break;
+			if (req_len != 2) {
+				result[0] = L2CAP_CONF_REJ;
+				break;
+			}
+			pi->flush_to = __le16_to_cpup((__le16 *)(ptr + 2));
+			set_bit(L2CAP_CONF_FLUSH_TO, &options);
+			result[L2CAP_CONF_FLUSH_TO] = l2cap_check_conf_opt(sk, L2CAP_CONF_FLUSH_TO);
+			if (result[L2CAP_CONF_FLUSH_TO] == L2CAP_CONF_UNACCEPT)
+				result[0] = L2CAP_CONF_UNACCEPT;
+
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
+			printk("-> unknown option %d\n", type);
+			result[0] = L2CAP_CONF_UNKNOWN;
+			result[type] = L2CAP_CONF_UNKNOWN;
+			/* TODO: hints are not supported yet */
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
-		*((u8 *) opt->val)  = val;
-		break;
-
-	case 2:
-		*((u16 *) opt->val) = __cpu_to_le16(val);
-		break;
-
-	case 4:
-		*((u32 *) opt->val) = __cpu_to_le32(val);
+	switch (type) {
+	case L2CAP_CONF_MTU:
+		*((__le16 *) opt->val) = cpu_to_le16(*(__le16 *) data);
 		break;
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
 
@@ -1330,59 +1499,194 @@
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
+					pi->mode = pi->conf_mode;
+					pi->otxw  = pi->conf_txw;
+					pi->omaxt = pi->conf_maxt;
+					pi->oret_to = pi->conf_ret_to;
+					pi->omon_to = pi->conf_mon_to;
+					pi->omps = pi->conf_mps;
+					len = 9;
+					rfc->mode = pi->mode;
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
@@ -1478,7 +1782,7 @@
 	struct l2cap_conn_rsp *rsp = (struct l2cap_conn_rsp *) data;
 	u16 scid, dcid, result, status;
 	struct sock *sk;
-	u8 req[128];
+	u16 info;
 
 	scid   = __le16_to_cpu(rsp->scid);
 	dcid   = __le16_to_cpu(rsp->dcid);
@@ -1498,12 +1802,12 @@
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
@@ -1522,9 +1826,12 @@
 {
 	struct l2cap_conf_req *req = (struct l2cap_conf_req *) data;
 	u16 dcid, flags;
-	u8 rsp[64];
+	u8 rsp[128];
 	struct sock *sk;
-	int result;
+	/* collected result codes for theor. max 128 possible options
+	 * result[0] indicates the general result code for all options */
+	u8 result[L2CAP_MAX_OPTS];
+	int temp_len, i;
 
 	dcid  = __le16_to_cpu(req->dcid);
 	flags = __le16_to_cpu(req->flags);
@@ -1534,20 +1841,25 @@
 	if (!(sk = l2cap_get_chan_by_scid(&conn->chan_list, dcid)))
 		return -ENOENT;
 
-	l2cap_parse_conf_req(sk, req->data, cmd->len - sizeof(*req));
+	l2cap_parse_conf_req(sk, req->data, cmd->len - sizeof(*req), result);
 
 	if (flags & 0x0001) {
 		/* Incomplete config. Send empty response. */
 		l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP,
-				l2cap_build_conf_rsp(sk, rsp, NULL), rsp);
+				l2cap_build_conf_rsp(sk, rsp, 0, NULL), rsp);
 		goto unlock;
 	}
 
 	/* Complete config. */
+	temp_len = l2cap_build_conf_rsp(sk, rsp, 1, result);
 	l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP,
-			l2cap_build_conf_rsp(sk, rsp, &result), rsp);
+			temp_len, rsp);
+
+	for (i = 0; i < temp_len; ++i)
+		printk("%02X ", rsp[i]);
+	printk("\n");
 
-	if (result)
+	if (result[0])
 		goto unlock;
 
 	/* Output config done */
@@ -1569,9 +1881,14 @@
 
 static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd, u8 *data)
 {
-	struct l2cap_conf_rsp *rsp = (struct l2cap_conf_rsp *)data;
-	u16 scid, flags, result;
+	struct l2cap_conf_rsp *rsp = (struct l2cap_conf_rsp *) data;
+	u16 scid, flags, result, len;
 	struct sock *sk;
+	struct l2cap_pinfo *pi;
+	u8 type;
+	u8 *ptr = rsp->data;
+	/* length of all options in config data field */
+	len = __le16_to_cpu(cmd->len) - sizeof(*rsp);
 
 	scid   = __le16_to_cpu(rsp->scid);
 	flags  = __le16_to_cpu(rsp->flags);
@@ -1581,23 +1898,96 @@
 
 	if (!(sk = l2cap_get_chan_by_scid(&conn->chan_list, scid)))
 		return 0;
+	pi = l2cap_pi(sk);
 
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
+				pi->mode = *(u8 *)(ptr + 2);
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
+				l2cap_build_conf_req(sk, req), req);
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
@@ -1699,11 +2089,38 @@
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
+
+	/* build configuration request */
+	l2cap_pi(sk)->conf_state |= L2CAP_CONF_REQ_SENT;
+	l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
+			l2cap_build_conf_req(sk, req), req);
+
+	bh_unlock_sock(sk);
 
 	return 0;
 }
@@ -1733,7 +2150,7 @@
 
 		switch (cmd.code) {
 		case L2CAP_COMMAND_REJ:
-			/* FIXME: We should process this */
+			err = l2cap_command_rej(conn, &cmd, data);
 			break;
 
 		case L2CAP_CONN_REQ:
@@ -1797,6 +2214,192 @@
 	kfree_skb(skb);
 }
 
+static int l2cap_invalid_frame_detection(struct sock *sk, struct sk_buff *skb)
+{
+	int err = 0;
+	u16 len, cid, control, sdu_len, fcs;
+
+	/* value of length field in frame */
+	len = get_unaligned((u16 *) skb->data);
+	cid = get_unaligned((u16 *) (skb->data + 2));
+
+	if (len != (skb->len - L2CAP_HDR_SIZE))
+		err = -1;
+
+	/* contains an unknown (reserved) cid */
+	if (cid < 0x003F)
+		err = -2;
+
+	/* contains an fcs error */
+	fcs = get_unaligned((u16 *) (skb->tail - 2));
+	if (unlikely(fcs != crc16(0, skb->data, skb->len - 2))) {
+		err = -3;
+	}
+
+	/* contains a length > max possible mps */
+	if (len > L2CAP_MAX_DATA_LEN)
+		err = -4;
+
+	control = get_unaligned((u16 *) (skb->data + L2CAP_HDR_SIZE));
+	sdu_len = get_unaligned((u16 *) (skb->data + L2CAP_HDR_SIZE + L2CAP_CONTROL_SIZE));
+
+	if (control & 0x01) {
+		/* i-frame that has fewer than 8 octets */
+		if (skb->len < 8)
+			err = -5;
+		if ((L2CAP_SAR_MASK & control) == L2CAP_SAR_START) {
+			/* contains a length > max possible mps (with SAR) */
+			if (len > L2CAP_MAX_DATA_LEN - 2)
+				err = -4;
+			/* i-frame with SAR=01 with < 10 octets */
+			if (skb->len < 10)
+				err = -6;
+			/* requested sdu len is bigger than configured mps */
+			if (sdu_len > l2cap_pi(sk)->imps)
+				err = -7;
+		}
+	} else {
+		/* s-frame with length != 4 */
+		if (len != 4) err = -8;
+	}
+
+	if (!err)
+		BT_DBG("err %d", err);
+
+	return err;
+}
+
+static int l2cap_process_txseq(struct sock *sk, struct sk_buff *skb, u16 control)
+{
+	int err = 0;
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	u16 txseq = L2CAP_GET_TXSEQ(control);
+
+	if (txseq == pi->exp_txseq) {
+		pi->exp_txseq = (pi->exp_txseq + 1) % 64;
+	} else if (((txseq - pi->buffer_seq + 64) % 64) < pi->itxw) {
+		/* out-of-sequence i-frame */
+		pi->exp_txseq = (txseq + 1) % 64;
+	} else if ((txseq >= pi->buffer_seq) && (txseq <= pi->exp_txseq - 1)) {
+		/* duplicated i-frame */
+		err = -1;
+	} else {
+		/* invalid txseq */
+		err = -2;
+	}
+
+	BT_DBG("err %d", err);
+
+	return err;
+}
+
+static int l2cap_process_reqseq(struct sock *sk, struct sk_buff *skb, u16 control)
+{
+	struct l2cap_pinfo *pi;
+	u16 reqseq;
+
+	pi = l2cap_pi(sk);
+	reqseq = L2CAP_GET_REQSEQ(control);
+
+	/* accept only i-frame or s-frame with S bits set to 00 (RR) */
+	if (!(((control & 0x01) == 0x00) || ((control & 0x0F) == 0x01)))
+		return -1;
+
+	/* reqseq sequence error */
+	if ((reqseq - pi->exp_ackseq + 64) % 64 <=
+	    (pi->next_txseq - pi->exp_ackseq + 64) % 64) {
+		/* close channel -> send disconnect request */
+		struct l2cap_disconn_req req;
+		struct l2cap_conn *conn = l2cap_pi(sk)->conn;
+		sk->sk_state = BT_DISCONN;
+		sk->sk_err   = ECONNRESET;
+		l2cap_sock_set_timer(sk, HZ * 5);
+		req.dcid = __cpu_to_le16(l2cap_pi(sk)->dcid);
+		req.scid = __cpu_to_le16(l2cap_pi(sk)->scid);
+		l2cap_send_cmd(conn, l2cap_get_ident(conn),
+				L2CAP_DISCONN_REQ, sizeof(req), &req);
+		return -2;
+	}
+
+	pi->exp_ackseq = reqseq;
+
+	if (reqseq != pi->next_txseq)
+		l2cap_start_ret_timer(sk, pi->iret_to * HZ / 1000);
+	else
+		l2cap_start_mon_timer(sk, pi->imon_to * HZ / 1000);
+
+	/* FIXME: transmit any I-Frames awaiting transmission */
+
+	return 0;
+}
+
+static int l2cap_reassembly(struct sock *sk, struct sk_buff *skb, u16 control)
+{
+	u16 sdu_len = 0;
+
+	/* remove header, control and fcs from i-frame */
+	skb_pull(skb, L2CAP_HDR_SIZE + L2CAP_CONTROL_SIZE);
+	skb_trim(skb, skb->len - L2CAP_FCS_SIZE);
+
+	switch (L2CAP_GET_SAR(control)) {
+	case L2CAP_SAR_UNSEGMENTED:
+		l2cap_pi(sk)->buffer_seq = l2cap_pi(sk)->exp_txseq;
+		if (!sock_queue_rcv_skb(sk, skb))
+			return -1;
+		break;
+	case L2CAP_SAR_START:
+		sdu_len = get_unaligned((u16 *) skb->data);
+		/* remove sdu len field */
+		skb_pull(skb, 2);
+
+		/* in case a SAR_END frame got lost make sure to free the
+		 * allocated buffer space of the last sdu */
+		kfree_skb(l2cap_pi(sk)->sdu);
+		l2cap_pi(sk)->sdu = NULL;
+		l2cap_pi(sk)->sdu_len = 0;
+			
+		/* allocate skb for complete new sdu */
+		if (!(l2cap_pi(sk)->sdu = bt_skb_alloc(sdu_len, GFP_ATOMIC)))
+			return -2;
+
+		memcpy(skb_put(l2cap_pi(sk)->sdu, skb->len), skb->data, skb->len);
+		l2cap_pi(sk)->sdu_len = sdu_len - skb->len;
+		l2cap_pi(sk)->buffer_seq = l2cap_pi(sk)->exp_txseq;
+		break;
+	default:
+		/* continuation or end of sdu frame */
+		if (!l2cap_pi(sk)->sdu_len) {
+			BT_ERR("Unexpected continuation frame (len %d)", skb->len);
+			return -3;
+		}
+
+		if (skb->len > l2cap_pi(sk)->sdu_len) {
+			BT_ERR("Fragment is too long (len %d, expected %d)",
+					skb->len, l2cap_pi(sk)->sdu_len);
+			kfree_skb(l2cap_pi(sk)->sdu);
+			l2cap_pi(sk)->sdu = NULL;
+			l2cap_pi(sk)->sdu_len = 0;
+			return -4;
+		}
+
+		memcpy(skb_put(l2cap_pi(sk)->sdu, skb->len), skb->data, skb->len);
+		l2cap_pi(sk)->sdu_len -= skb->len;
+		l2cap_pi(sk)->buffer_seq = l2cap_pi(sk)->exp_txseq;
+
+		/* last frame for sdu */
+		if ((L2CAP_GET_SAR(control) == L2CAP_SAR_END) && 
+				(l2cap_pi(sk)->sdu_len == 0)) {
+			if (!sock_queue_rcv_skb(sk, l2cap_pi(sk)->sdu))
+				return -5;
+			kfree_skb(l2cap_pi(sk)->sdu);
+			l2cap_pi(sk)->sdu = NULL;
+			l2cap_pi(sk)->sdu_len = 0;
+		}
+	}
+
+	return 0;
+}
+
 static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk_buff *skb)
 {
 	struct sock *sk;
@@ -1807,19 +2410,43 @@
 		goto drop;
 	}
 
-	BT_DBG("sk %p, len %d", sk, skb->len);
+	BT_DBG("sk %p len %d mode %d", sk, skb->len, l2cap_pi(sk)->mode);
 
 	if (sk->sk_state != BT_CONNECTED)
 		goto drop;
 
+	/* s-frame or i-frame */
+	if (l2cap_pi(sk)->mode == L2CAP_MODE_FLOW) {
+		u16 control;
+
+		if (l2cap_invalid_frame_detection(sk, skb))
+			goto drop;
+
+		control = get_unaligned((u16 *) (skb->data + L2CAP_HDR_SIZE));
+
+		if (control & 0x01) {
+			/* process i-frame */
+			if (l2cap_process_txseq(sk, skb, control))
+				goto drop;
+			if (l2cap_process_reqseq(sk, skb, control))
+				goto drop;
+			if (l2cap_reassembly(sk, skb, control))
+				goto drop;
+		} else {
+			/* process s-frame */
+			if (l2cap_process_reqseq(sk, skb, control))
+				goto drop;
+		}
+
+		goto done;
+	}
+
+	skb_pull(skb, L2CAP_HDR_SIZE);
+	/* b-frame with too large information payload */
 	if (l2cap_pi(sk)->imtu < skb->len)
 		goto drop;
 
-	/* If socket recv buffers overflows we drop data here
-	 * which is *bad* because L2CAP has to be reliable.
-	 * But we don't have any other choice. L2CAP doesn't
-	 * provide flow control mechanism. */
-
+	/* ordinary b-frame */
 	if (!sock_queue_rcv_skb(sk, skb))
 		goto done;
 
@@ -1865,7 +2492,6 @@
 	struct l2cap_hdr *lh = (void *) skb->data;
 	u16 cid, psm, len;
 
-	skb_pull(skb, L2CAP_HDR_SIZE);
 	cid = __le16_to_cpu(lh->cid);
 	len = __le16_to_cpu(lh->len);
 
@@ -1873,10 +2499,12 @@
 
 	switch (cid) {
 	case 0x0001:
+		skb_pull(skb, L2CAP_HDR_SIZE);
 		l2cap_sig_channel(conn, skb);
 		break;
 
 	case 0x0002:
+		skb_pull(skb, L2CAP_HDR_SIZE);
 		psm = get_unaligned((u16 *) skb->data);
 		skb_pull(skb, 2);
 		l2cap_conless_channel(conn, psm, skb);

--=-R0me10r6CIaRHkvRsgRA
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-R0me10r6CIaRHkvRsgRA
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-R0me10r6CIaRHkvRsgRA--
