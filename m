Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] RE: Rfcomm qualification
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: Daryl Van Vorst <daryl@wideray.com>, BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5.1.0.14.2.20030730162942.053ff898@unixmail.qualcomm.com>
References: <000501c356b7$2887faf0$1a01010a@baked>
	<000501c356b7$2887faf0$1a01010a@baked>
	<5.1.0.14.2.20030730162942.053ff898@unixmail.qualcomm.com>
Message-Id: <1059612533.1832.48.camel@pegasus>
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
Date: 31 Jul 2003 02:48:46 +0200
Content-Type: multipart/mixed; boundary="=-g5TfFJBSO619R8LTuUS+"


--=-g5TfFJBSO619R8LTuUS+
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

Hi Max,

> >The session wide credits value is useless 
> No, it's not. 1.1 spec only mandates send PN for the _first_ DLC
> on that session. Which means that values negotiated in PN request are supposed 
> to be applied to the subsequent DLCs.  So we still need session wide settings.
> We just need to update them when we get PN req/rsp, which don't do.
> 
> Check this out:
> "
> 6.5.1 Initial DLC Negotiation
> The use of credit based flow control is a session characteristic. Thus, it has to
> be negotiated with the PN multiplexor control command (see Section 5.5.3)
> before the first DLC is established.
> After the first successful negotiation and DLC establishment, all DLCs will be
> flow controlled with this scheme. PN negotiation at subsequent DLC establish-ments
> is optional, but recommended, since it also establishes initial credit
> count values on both sides for both sides.
> "

memory malfunction ;) I thought it was a per dlc value.

The attached patch sets the default values for session and dlc credits
to zero and put in RFCOMM_MAX_CREDITS only if we receive a PN with 1.1
flow control.

What do you think?

Regards

Marcel


--=-g5TfFJBSO619R8LTuUS+
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; NAME=patch; CHARSET=ISO-8859-15

diff -Nru a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
--- a/net/bluetooth/rfcomm/core.c	Thu Jul 31 02:41:29 2003
+++ b/net/bluetooth/rfcomm/core.c	Thu Jul 31 02:41:29 2003
@@ -202,7 +202,7 @@
 	d->mtu        =3D RFCOMM_DEFAULT_MTU;
 	d->v24_sig    =3D RFCOMM_V24_RTC | RFCOMM_V24_RTR | RFCOMM_V24_DV;
=20
-	d->credits    =3D RFCOMM_MAX_CREDITS;
+	d->credits    =3D 0;
 	d->rx_credits =3D RFCOMM_DEFAULT_CREDITS;
 }
=20
@@ -475,7 +475,7 @@
 	s->sock  =3D sock;
=20
 	s->mtu     =3D RFCOMM_DEFAULT_MTU;
-	s->credits =3D RFCOMM_MAX_CREDITS;
+	s->credits =3D 0;
 =09
 	list_add(&s->list, &session_list);
=20
@@ -746,7 +746,7 @@
 	pn->ack_timer   =3D 0;
 	pn->max_retrans =3D 0;
=20
-	if (d->credits) {
+	if (cr || d->credits) {
 		pn->flow_ctrl =3D cr ? 0xf0 : 0xe0;
 		pn->credits =3D RFCOMM_DEFAULT_CREDITS;
 	} else {
@@ -1135,11 +1135,15 @@
=20
 static int rfcomm_apply_pn(struct rfcomm_dlc *d, int cr, struct rfcomm_pn =
*pn)
 {
+	struct rfcomm_session *s =3D d->session;
+
 	BT_DBG("dlc %p state %ld dlci %d mtu %d fc 0x%x credits %d",=20
 			d, d->state, d->dlci, pn->mtu, pn->flow_ctrl, pn->credits);
=20
 	if (cr) {
 		if (pn->flow_ctrl =3D=3D 0xf0) {
+			s->credits =3D RFCOMM_MAX_CREDITS;
+			d->credits =3D s->credits;
 			d->tx_credits =3D pn->credits;
 		} else {
 			set_bit(RFCOMM_TX_THROTTLED, &d->flags);
@@ -1147,6 +1151,8 @@
 		}
 	} else {
 		if (pn->flow_ctrl =3D=3D 0xe0) {
+			s->credits =3D RFCOMM_MAX_CREDITS;
+			d->credits =3D s->credits;
 			d->tx_credits =3D pn->credits;
 		} else {
 			set_bit(RFCOMM_TX_THROTTLED, &d->flags);

--=-g5TfFJBSO619R8LTuUS+--
