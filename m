Return-Path: <ashuang@gmail.com>
Message-ID: <ef9938ec041019171179f1e8d0@mail.gmail.com>
Date: Tue, 19 Oct 2004 20:11:15 -0400
From: Albert Huang <ashuang@gmail.com>
Reply-To: albert@csail.mit.edu
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-devel] how to do inquiry with RSSI in bluetooth 1.2 devices?
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <ef9938ec04101916584d188ffc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_950_14668459.1098231075742"
References: <ef9938ec041012125930f0b8e3@mail.gmail.com>
	 <1097658003.4643.17.camel@notepaq>
	 <ef9938ec04101511326a6342c3@mail.gmail.com>
	 <1097928625.4911.30.camel@pegasus>
	 <ef9938ec04101914447e122c22@mail.gmail.com>
	 <1098222911.23046.5.camel@pegasus>
	 <ef9938ec04101916584d188ffc@mail.gmail.com>
List-ID: <bluez-devel.lists.sourceforge.net>

------=_Part_950_14668459.1098231075742
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> Attached is a patch for bluez-libs.  Two functions are added.

please ignore previous message.  That patch doesn't follow the
naming/tabbing conventions in the rest of bluez-libs.  Attached is a
patch that does.

-albert

------=_Part_950_14668459.1098231075742
Content-Type: text/x-patch; name="libs-inquiry-mode-ash-2.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="libs-inquiry-mode-ash-2.diff"

Index: src/hci.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/bluez/libs/src/hci.c,v
retrieving revision 1.44
diff -u -r1.44 hci.c
--- src/hci.c=096 Oct 2004 17:39:54 -0000=091.44
+++ src/hci.c=0920 Oct 2004 00:08:41 -0000
@@ -1295,3 +1295,57 @@
=20
 =09return 0;
 }
+
+int hci_read_inquiry_mode(int dd, uint8_t *mode, int to)
+{
+=09struct hci_request rq;
+=09read_inquiry_mode_rp rp;
+
+=09memset(&rq, 0, sizeof(rq));
+=09rq.ogf =3D OGF_HOST_CTL;
+=09rq.ocf =3D OCF_READ_INQUIRY_MODE;
+=09rq.event =3D EVT_CMD_COMPLETE;
+=09rq.cparam =3D 0;
+=09rq.clen =3D 0;
+=09rq.rparam =3D &rp;
+=09rq.rlen =3D READ_INQUIRY_MODE_RP_SIZE;
+
+=09if( hci_send_req( dd, &rq, to ) < 0 )
+=09=09return -1;
+
+=09if (rp.status) {
+=09=09errno =3D EIO;
+=09=09return -1;
+=09}
+
+=09*mode =3D rp.mode;
+=09return 0;
+}
+
+int hci_write_inquiry_mode(int dd, uint8_t mode, int to)
+{
+=09write_inquiry_mode_cp cp;
+=09struct hci_request rq;
+=09write_inquiry_mode_rp rp;
+=09cp.mode =3D mode;
+
+=09memset(&cp, 0, sizeof(cp));
+=09memset(&rq, 0, sizeof(rq));
+=09rq.ogf =3D OGF_HOST_CTL;
+=09rq.ocf =3D OCF_WRITE_INQUIRY_MODE;
+=09rq.event =3D EVT_CMD_COMPLETE;
+=09rq.cparam =3D &cp;
+=09rq.clen =3D WRITE_INQUIRY_MODE_CP_SIZE;
+=09rq.rparam =3D &rp;
+=09rq.rlen =3D EVT_CMD_COMPLETE_SIZE + WRITE_INQUIRY_MODE_RP_SIZE;
+
+=09if( hci_send_req( dd, &rq, to ) < 0 )
+=09=09return -1;
+
+=09if (rp.status) {
+=09=09errno =3D EIO;
+=09=09return -1;
+=09}
+
+=09return 0;
+}
Index: include/hci_lib.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/bluez/libs/include/hci_lib.h,v
retrieving revision 1.25
diff -u -r1.25 hci_lib.h
--- include/hci_lib.h=0924 Apr 2004 12:09:55 -0000=091.25
+++ include/hci_lib.h=0920 Oct 2004 00:08:41 -0000
@@ -88,6 +88,8 @@
 int hci_switch_role(int dd, bdaddr_t peer, int role, int to);
 int hci_park_mode(int dd, uint16_t handle, uint16_t max_interval, uint16_t=
 min_interval, int to);
 int hci_exit_park_mode(int dd, uint16_t handle, int to);
+int hci_read_inquiry_mode(int dd, uint8_t *mode, int to);
+int hci_write_inquiry_mode(int dd, uint8_t mode, int to);
=20
 int hci_for_each_dev(int flag, int(*func)(int s, int dev_id, long arg), lo=
ng arg);
 int hci_get_route(bdaddr_t *bdaddr);

------=_Part_950_14668459.1098231075742--
