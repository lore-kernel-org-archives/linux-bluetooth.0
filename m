Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Daryl Van Vorst <daryl@wideray.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <001501c3457d$18b63a10$1a01010a@baked>
References: <001501c3457d$18b63a10$1a01010a@baked>
Message-Id: <1057911516.1026.7.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: Qualification testing - rfcomm
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 11 Jul 2003 10:18:29 +0200
Content-Type: multipart/mixed; boundary="=-Gc/TFHh6MU3e9mS3psbQ"


--=-Gc/TFHh6MU3e9mS3psbQ
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

Hi Daryl,

> TP/RFC/BV-12-C:
> "Verify that the IUT handles aggregate flow control correctly when the
> Tester, acting as a device conforming to Bleutooth version 1.0B, controls
> the data flow using the Flow Control on/off commands FCon and FCoff. The
> IUT's device role is of no importance."
> 
> The command and console output:
> 
> root@jack-00000000:~>./rctest -s -P 1 -b 20 00:A0:96:1F:83:71
> rctest[362]: Connected
> rctest[362]: Sending ...
> rfcomm_recv_mcc: Unknown control type 0x18
> rfcomm_recv_mcc: Unknown control type 0x28
> 
> The IUT does not respond to FCoff with FCoff, and continues sending data. It
> also does not respond to FCon with FCon. 

we don't have support for flow control on the entire RFCOMM session. But
it seems that the FCOFF and FCON should be supported. The attached patch
implements support for it, but I am not quite sure if it is the right
way to do this.

Regards

Marcel


--=-Gc/TFHh6MU3e9mS3psbQ
Content-Disposition: attachment; filename=patch-fcoff-fcon
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; NAME=patch-fcoff-fcon; CHARSET=ISO-8859-15

--- bt-2.4/net/bluetooth/rfcomm/core.c	Thu Jul 10 21:16:52 2003
+++ marcel-2.4/net/bluetooth/rfcomm/core.c	Fri Jul 11 10:04:37 2003
@@ -853,6 +853,50 @@
 	return rfcomm_send_frame(s, buf, ptr - buf);
 }
=20
+static int rfcomm_send_fcoff(struct rfcomm_session *s, int cr)
+{
+	struct rfcomm_hdr *hdr;
+	struct rfcomm_mcc *mcc;
+	u8 buf[16], *ptr =3D buf;
+
+	BT_DBG("%p cr %d", s, cr);
+
+	hdr =3D (void *) ptr; ptr +=3D sizeof(*hdr);
+	hdr->addr =3D __addr(s->initiator, 0);
+	hdr->ctrl =3D __ctrl(RFCOMM_UIH, 0);
+	hdr->len  =3D __len8(sizeof(*mcc));
+
+	mcc =3D (void *) ptr; ptr +=3D sizeof(*mcc);
+	mcc->type =3D __mcc_type(cr, RFCOMM_FCOFF);
+	mcc->len  =3D __len8(0);
+
+	*ptr =3D __fcs(buf); ptr++;
+
+	return rfcomm_send_frame(s, buf, ptr - buf);
+}
+
+static int rfcomm_send_fcon(struct rfcomm_session *s, int cr)
+{
+	struct rfcomm_hdr *hdr;
+	struct rfcomm_mcc *mcc;
+	u8 buf[16], *ptr =3D buf;
+
+	BT_DBG("%p cr %d", s, cr);
+
+	hdr =3D (void *) ptr; ptr +=3D sizeof(*hdr);
+	hdr->addr =3D __addr(s->initiator, 0);
+	hdr->ctrl =3D __ctrl(RFCOMM_UIH, 0);
+	hdr->len  =3D __len8(sizeof(*mcc));
+
+	mcc =3D (void *) ptr; ptr +=3D sizeof(*mcc);
+	mcc->type =3D __mcc_type(cr, RFCOMM_FCON);
+	mcc->len  =3D __len8(0);
+
+	*ptr =3D __fcs(buf); ptr++;
+
+	return rfcomm_send_frame(s, buf, ptr - buf);
+}
+
 static int rfcomm_send_test(struct rfcomm_session *s, int cr, u8 *pattern,=
 int len)
 {
 	struct socket *sock =3D s->sock;
@@ -1351,6 +1395,20 @@
 		rfcomm_recv_msc(s, cr, skb);
 		break;
=20
+	case RFCOMM_FCOFF:
+		if (cr) {
+			set_bit(RFCOMM_TX_THROTTLED, &s->flags);
+			rfcomm_send_fcoff(s, 0);
+		}
+		break;
+
+	case RFCOMM_FCON:
+		if (cr) {
+			clear_bit(RFCOMM_TX_THROTTLED, &s->flags);
+			rfcomm_send_fcon(s, 0);
+		}
+		break;
+
 	case RFCOMM_TEST:
 		if (cr)
 			rfcomm_send_test(s, 0, skb->data, skb->len);
@@ -1533,6 +1591,9 @@
 	struct list_head *p, *n;
=20
 	BT_DBG("session %p state %ld", s, s->state);
+
+	if (test_bit(RFCOMM_TX_THROTTLED, &s->flags))
+		return;
=20
 	list_for_each_safe(p, n, &s->dlcs) {
 		d =3D list_entry(p, struct rfcomm_dlc, list);

--=-Gc/TFHh6MU3e9mS3psbQ--
