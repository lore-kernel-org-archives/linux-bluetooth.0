Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Re: Qualification testing - rfcomm
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Daryl Van Vorst <daryl@wideray.com>
Cc: "'Max Krasnyansky'" <maxk@qualcomm.com>, "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000c01c35071$0c788f60$1a01010a@baked>
References: <000c01c35071$0c788f60$1a01010a@baked>
Message-Id: <1058892812.2755.26.camel@pegasus>
Mime-Version: 1.0
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
Date: 22 Jul 2003 18:53:15 +0200
Content-Type: multipart/mixed; boundary="=-idlPQs6G5So4nzE23PVJ"


--=-idlPQs6G5So4nzE23PVJ
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

Hi Daryl,

> > > @@ -1533,6 +1591,9 @@
> > >  	struct list_head *p, *n;
> > > 
> > >  	BT_DBG("session %p state %ld", s, s->state);
> > > +
> > > +	if (test_bit(RFCOMM_TX_THROTTLED, &s->flags))
> > > +		return;
> > > 
> > >  	list_for_each_safe(p, n, &s->dlcs) {
> > >  		d = list_entry(p, struct rfcomm_dlc, list);
> > This part is not ok. We still have to check for timeout. Rest 
> > of patch is fine.
> 
> Ok. I'll see if it's not too late to stop testing it. :)

it should not make any difference for the test case, but here is the
complete version of the new patch.

Regards

Marcel


--=-idlPQs6G5So4nzE23PVJ
Content-Disposition: attachment; filename=patch-fcoff-fcon-2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; NAME=patch-fcoff-fcon-2; CHARSET=ISO-8859-15

diff -urN linux-2.4.22-pre7/net/bluetooth/rfcomm/core.c linux-2.4.22-pre7-m=
h/net/bluetooth/rfcomm/core.c
--- linux-2.4.22-pre7/net/bluetooth/rfcomm/core.c	Tue Jul 22 18:33:43 2003
+++ linux-2.4.22-pre7-mh/net/bluetooth/rfcomm/core.c	Tue Jul 22 18:37:59 20=
03
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
@@ -1540,6 +1598,9 @@
 			__rfcomm_dlc_close(d, ETIMEDOUT);
 			continue;
 		}
+
+		if (test_bit(RFCOMM_TX_THROTTLED, &s->flags))
+			continue;
=20
 		if ((d->state =3D=3D BT_CONNECTED || d->state =3D=3D BT_DISCONN) &&
 				d->mscex =3D=3D RFCOMM_MSCEX_OK)

--=-idlPQs6G5So4nzE23PVJ--
