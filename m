Return-Path: <ashuang@gmail.com>
Message-ID: <ef9938ec04101916584d188ffc@mail.gmail.com>
Date: Tue, 19 Oct 2004 19:58:29 -0400
From: Albert Huang <ashuang@gmail.com>
Reply-To: albert@csail.mit.edu
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-devel] how to do inquiry with RSSI in bluetooth 1.2 devices?
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1098222911.23046.5.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_942_27123090.1098230309430"
References: <ef9938ec041012125930f0b8e3@mail.gmail.com>
	 <1097658003.4643.17.camel@notepaq>
	 <ef9938ec04101511326a6342c3@mail.gmail.com>
	 <1097928625.4911.30.camel@pegasus>
	 <ef9938ec04101914447e122c22@mail.gmail.com>
	 <1098222911.23046.5.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

------=_Part_942_27123090.1098230309430
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> You should re-read the HCI part of the Bluetooth specification, because
> the OGF and OCF values are packed in a specific format. If the latest
> version of hcidump shows unknown then you should think about an error on
> your side, because I already added full Bluetooth 1.2 support.

Attached is a patch for bluez-libs.  Two functions are added.

int hci_read_inquiry_mode(int dd, uint8_t *mode, int to);
int hci_write_inquiry_mode(int dd, uint8_t mode, int to);

Thanks for all your help!

-albert

------=_Part_942_27123090.1098230309430
Content-Type: text/x-patch; name="libs-inquiry-mode-ash.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="libs-inquiry-mode-ash.diff"

Index: include/hci_lib.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/bluez/libs/include/hci_lib.h,v
retrieving revision 1.25
diff -u -r1.25 hci_lib.h
--- include/hci_lib.h=0924 Apr 2004 12:09:55 -0000=091.25
+++ include/hci_lib.h=0919 Oct 2004 23:49:21 -0000
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
Index: src/hci.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/bluez/libs/src/hci.c,v
retrieving revision 1.44
diff -u -r1.44 hci.c
--- src/hci.c=096 Oct 2004 17:39:54 -0000=091.44
+++ src/hci.c=0919 Oct 2004 23:49:22 -0000
@@ -1295,3 +1295,54 @@
=20
 =09return 0;
 }
+
+int hci_read_inquiry_mode(int dd, uint8_t *mode, int to)
+{
+    struct hci_request req;
+    read_inquiry_mode_rp rp;
+
+    req.ogf =3D OGF_HOST_CTL;
+    req.ocf =3D OCF_READ_INQUIRY_MODE;
+    req.event =3D EVT_CMD_COMPLETE;
+    req.cparam =3D 0;
+    req.clen =3D 0;
+    req.rparam =3D &rp;
+    req.rlen =3D READ_INQUIRY_MODE_RP_SIZE;
+
+    if( hci_send_req( dd, &req, to ) < 0 )
+        return -1;
+
+    if (rp.status) {
+        errno =3D EIO;
+        return -1;
+    }
+
+    *mode =3D rp.mode;
+    return 0;
+}
+
+int hci_write_inquiry_mode(int dd, uint8_t mode, int to)
+{
+    write_inquiry_mode_cp wim_cp;
+    struct hci_request req;
+    write_inquiry_mode_rp rp;
+    wim_cp.mode =3D mode;
+
+    req.ogf =3D OGF_HOST_CTL;
+    req.ocf =3D OCF_WRITE_INQUIRY_MODE;
+    req.event =3D EVT_CMD_COMPLETE;
+    req.cparam =3D &wim_cp;
+    req.clen =3D WRITE_INQUIRY_MODE_CP_SIZE;
+    req.rparam =3D &rp;
+    req.rlen =3D EVT_CMD_COMPLETE_SIZE + WRITE_INQUIRY_MODE_RP_SIZE;
+
+    if( hci_send_req( dd, &req, to ) < 0 )
+        return -1;
+
+    if (rp.status) {
+        errno =3D EIO;
+        return -1;
+    }
+
+    return 0;
+}

------=_Part_942_27123090.1098230309430--
