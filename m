Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Message-ID: <002501c4d73d$2cd35200$1a01010a@baked>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0026_01C4D6FA.1EB01200"
Subject: [Bluez-devel] Qualification testing.
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
Date: Tue, 30 Nov 2004 16:32:01 -0800

This is a multi-part message in MIME format.

------=_NextPart_000_0026_01C4D6FA.1EB01200
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Marcel,

Another round of qualification testing has begun. The results so far seem
much less painful this time. :)

So far there is one definite failure. There are a couple others which are
being debated. All of these have appeared because the tests have changed
slightly since (or weren't required) the last time we tested.

Test COS/CFD/BV-12 fails because the IUT does not send result=3 in an l2cap
config response upon reception of an unknown option. Apparently we didn't
have to do this test last time. And it's clear in the code why it fails:
l2cap.c: /* FIXME: Reject unknown option */

I noticed in the spec that the response must contain the offending options:

"On an unknown option failure (Result=0x0003), the option types not
understood
by the recipient of the Request must be included in the Response.
Note that hints (defined in Section 6 on page 297), those options in the
Request that are skipped if not understood, must not be included in the
Response and must not be the sole cause for rejecting the Request."

I've been staring at the code pondering how to fix this cleanly. I've
attached an attempt at fixing it. The fix is not quite complete because I
believe it has a buffer overflow vulnerability. It is not fully tested
either. But I figured it was best to run it by you before going too far
because more than likely you'll want to change something. ;)

BTW - We're using 2.4.21-mh10.

-Daryl.

------=_NextPart_000_0026_01C4D6FA.1EB01200
Content-Type: application/octet-stream;
	name="l2cap_diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="l2cap_diff"

--- linux-2.4.21/net/bluetooth/l2cap.c	2004-10-19 11:14:43.000000000 =
-0700=0A=
+++ linux-2.4.21_mods/net/bluetooth/l2cap.c	2004-11-30 =
16:28:37.000000000 -0800=0A=
@@ -81,6 +81,8 @@=0A=
 static int l2cap_send_req(struct l2cap_conn *conn, __u8 code, __u16 =
len, void *data);=0A=
 static int l2cap_send_rsp(struct l2cap_conn *conn, __u8 ident, __u8 =
code, __u16 len, void *data);=0A=
 =0A=
+static void l2cap_add_conf_opt(void **ptr, __u8 type, __u8 len, =
unsigned long val);=0A=
+=0A=
 /* ----- L2CAP timers ------ */=0A=
 static void l2cap_sock_timeout(unsigned long arg)=0A=
 {=0A=
@@ -1235,11 +1237,12 @@=0A=
 	return len;=0A=
 }=0A=
 =0A=
-static inline void l2cap_parse_conf_req(struct sock *sk, void *data, =
int len)=0A=
+static inline int l2cap_parse_conf_req(struct sock *sk, void *data, int =
len, void **rsp_ptr)=0A=
 {=0A=
 	int type, hint, olen; =0A=
 	unsigned long val;=0A=
 	void *ptr =3D data;=0A=
+	int result =3D 0;=0A=
 =0A=
 	BT_DBG("sk %p len %d", sk, len);=0A=
 =0A=
@@ -1265,10 +1268,13 @@=0A=
 			if (hint)=0A=
 				break;=0A=
 =0A=
-			/* FIXME: Reject unknown option */=0A=
+			/* Reject unknown option */=0A=
+			l2cap_add_conf_opt(rsp_ptr, type, olen, val);=0A=
+			result =3D L2CAP_CONF_UNKNOWN_OPT;=0A=
 			break;=0A=
 		};=0A=
 	}=0A=
+	return result;=0A=
 }=0A=
 =0A=
 static void l2cap_add_conf_opt(void **ptr, __u8 type, __u8 len, =
unsigned long val)=0A=
@@ -1341,16 +1347,16 @@=0A=
 	return result;=0A=
 }=0A=
 =0A=
-static int l2cap_build_conf_rsp(struct sock *sk, void *data, int =
*result)=0A=
+static int l2cap_build_conf_rsp(struct sock *sk, void *data, void =
**ptr, int *result, int conf_output)=0A=
 {=0A=
-	l2cap_conf_rsp *rsp =3D (l2cap_conf_rsp *) data;=0A=
-	void *ptr =3D rsp->data;=0A=
+  	l2cap_conf_rsp *rsp =3D (l2cap_conf_rsp *) data;=0A=
+	//	void *ptr =3D rsp->data;=0A=
 	u16 flags =3D 0;=0A=
 =0A=
 	BT_DBG("sk %p complete %d", sk, result ? 1 : 0);=0A=
 =0A=
-	if (result)=0A=
-		*result =3D l2cap_conf_output(sk, &ptr);=0A=
+	if (result && conf_output)=0A=
+		*result =3D l2cap_conf_output(sk, ptr);=0A=
 	else	=0A=
 		flags |=3D 0x0001;=0A=
 =0A=
@@ -1358,7 +1364,7 @@=0A=
 	rsp->result =3D __cpu_to_le16(result ? *result : 0);=0A=
 	rsp->flags  =3D __cpu_to_le16(flags);=0A=
 =0A=
-	return ptr - data;=0A=
+	return *ptr - data;=0A=
 }=0A=
 =0A=
 static inline int l2cap_connect_req(struct l2cap_conn *conn, =
l2cap_cmd_hdr *cmd, __u8 *data)=0A=
@@ -1493,6 +1499,7 @@=0A=
 	__u8 rsp[64];=0A=
 	struct sock *sk;=0A=
 	int result;=0A=
+	void *ptr =3D ((l2cap_conf_rsp *)rsp)->data;=0A=
 =0A=
 	dcid  =3D __le16_to_cpu(req->dcid);=0A=
 	flags =3D __le16_to_cpu(req->flags);=0A=
@@ -1502,16 +1509,22 @@=0A=
 	if (!(sk =3D l2cap_get_chan_by_scid(&conn->chan_list, dcid)))=0A=
 		return -ENOENT;=0A=
 =0A=
-	l2cap_parse_conf_req(sk, req->data, cmd->len - L2CAP_CONF_REQ_SIZE);=0A=
+	result =3D l2cap_parse_conf_req(sk, req->data, cmd->len - =
L2CAP_CONF_REQ_SIZE, &ptr);=0A=
+=0A=
+	if (result) {=0A=
+		/* Unknown option */=0A=
+		l2cap_send_rsp(conn, cmd->ident, L2CAP_CONF_RSP, =
l2cap_build_conf_rsp(sk, rsp, &ptr, &result, 0), rsp);=0A=
+		goto unlock;=0A=
+	}=0A=
 =0A=
 	if (flags & 0x0001) {=0A=
 		/* Incomplete config. Send empty response. */=0A=
-		l2cap_send_rsp(conn, cmd->ident, L2CAP_CONF_RSP, =
l2cap_build_conf_rsp(sk, rsp, NULL), rsp);=0A=
+		l2cap_send_rsp(conn, cmd->ident, L2CAP_CONF_RSP, =
l2cap_build_conf_rsp(sk, rsp, &ptr, NULL, 0), rsp);=0A=
 		goto unlock;=0A=
 	}=0A=
 =0A=
 	/* Complete config. */=0A=
-	l2cap_send_rsp(conn, cmd->ident, L2CAP_CONF_RSP, =
l2cap_build_conf_rsp(sk, rsp, &result), rsp);=0A=
+	l2cap_send_rsp(conn, cmd->ident, L2CAP_CONF_RSP, =
l2cap_build_conf_rsp(sk, rsp, &ptr, &result, 1), rsp);=0A=
 =0A=
 	if (result)=0A=
 		goto unlock;=0A=
--- linux-2.4.21/include/net/bluetooth/l2cap.h	2004-08-26 =
11:39:27.000000000 -0700=0A=
+++ linux-2.4.21_mods/include/net/bluetooth/l2cap.h	2004-11-30 =
15:43:17.000000000 -0800=0A=
@@ -151,6 +151,7 @@=0A=
 =0A=
 #define L2CAP_CONF_SUCCESS	0x00=0A=
 #define L2CAP_CONF_UNACCEPT	0x01=0A=
+#define L2CAP_CONF_UNKNOWN_OPT  0x03=0A=
 =0A=
 typedef struct {=0A=
 	__u8       type;=0A=

------=_NextPart_000_0026_01C4D6FA.1EB01200--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
