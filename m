Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Daryl Van Vorst <daryl@wideray.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000501c356b7$2887faf0$1a01010a@baked>
References: <000501c356b7$2887faf0$1a01010a@baked>
Message-Id: <1059601432.1832.9.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] RE: Rfcomm qualification
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
Date: 30 Jul 2003 23:43:46 +0200
Content-Type: multipart/mixed; boundary="=-UW9uMmbqek0geYa1tbLC"


--=-UW9uMmbqek0geYa1tbLC
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

Hi Daryl,

> Will making the default value of credits zero break other things?

I got some time to test this and it brings our RFCOMM code back to the
behavior of 1.0b. The session wide credits value is useless and the dlc
credits value must be zero in the initial place. But we must make sure
that we request 1.1 credit based flow control for outgoing connections.
The attached patch should solve all problems.

Max, please review the patch to make sure I don't forget anything.

Regards

Marcel


--=-UW9uMmbqek0geYa1tbLC
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; NAME=patch; CHARSET=ISO-8859-15

diff -Nru a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
--- a/include/net/bluetooth/rfcomm.h	Wed Jul 30 23:33:57 2003
+++ b/include/net/bluetooth/rfcomm.h	Wed Jul 30 23:33:57 2003
@@ -166,9 +166,7 @@
 	atomic_t         refcnt;
 	int              initiator;
=20
-	/* Default DLC parameters */
-	uint   mtu;
-	uint   credits;
+	uint             mtu;
=20
 	struct list_head dlcs;
 };
diff -Nru a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
--- a/net/bluetooth/rfcomm/core.c	Wed Jul 30 23:33:57 2003
+++ b/net/bluetooth/rfcomm/core.c	Wed Jul 30 23:33:57 2003
@@ -202,7 +202,7 @@
 	d->mtu        =3D RFCOMM_DEFAULT_MTU;
 	d->v24_sig    =3D RFCOMM_V24_RTC | RFCOMM_V24_RTR | RFCOMM_V24_DV;
=20
-	d->credits    =3D RFCOMM_MAX_CREDITS;
+	d->credits    =3D 0;
 	d->rx_credits =3D RFCOMM_DEFAULT_CREDITS;
 }
=20
@@ -310,7 +310,6 @@
 	rfcomm_dlc_link(s, d);
=20
 	d->mtu     =3D s->mtu;
-	d->credits =3D s->credits;
=20
 	if (s->state =3D=3D BT_CONNECTED)
 		rfcomm_send_pn(s, 1, d);
@@ -474,9 +473,8 @@
 	s->state =3D state;
 	s->sock  =3D sock;
=20
-	s->mtu     =3D RFCOMM_DEFAULT_MTU;
-	s->credits =3D RFCOMM_MAX_CREDITS;
-=09
+	s->mtu =3D RFCOMM_DEFAULT_MTU;
+
 	list_add(&s->list, &session_list);
=20
 	/* Do not increment module usage count for listeting sessions.
@@ -746,7 +744,7 @@
 	pn->ack_timer   =3D 0;
 	pn->max_retrans =3D 0;
=20
-	if (d->credits) {
+	if (cr || d->credits) {
 		pn->flow_ctrl =3D cr ? 0xf0 : 0xe0;
 		pn->credits =3D RFCOMM_DEFAULT_CREDITS;
 	} else {
@@ -1140,18 +1138,16 @@
=20
 	if (cr) {
 		if (pn->flow_ctrl =3D=3D 0xf0) {
+			d->credits =3D RFCOMM_MAX_CREDITS;
 			d->tx_credits =3D pn->credits;
-		} else {
+		} else
 			set_bit(RFCOMM_TX_THROTTLED, &d->flags);
-			d->credits =3D 0;
-		}
 	} else {
 		if (pn->flow_ctrl =3D=3D 0xe0) {
+			d->credits =3D RFCOMM_MAX_CREDITS;
 			d->tx_credits =3D pn->credits;
-		} else {
+		} else
 			set_bit(RFCOMM_TX_THROTTLED, &d->flags);
-			d->credits =3D 0;
-		}
 	}
=20
 	d->priority =3D pn->priority;

--=-UW9uMmbqek0geYa1tbLC--
