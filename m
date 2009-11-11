Return-Path: <cyrus@holtmann.org>
Subject: Re: Bluetooth audio via pulse doesn't function unless I chant the
 magic incantations
From: Russ Dill <russ.dill@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1257389371.23167.155.camel@localhost.localdomain>
References: <f9d2a5e10911040014p238a14lb14a1a3d45942e44@mail.gmail.com>
	 <1257341369.23167.149.camel@localhost.localdomain>
	 <f9d2a5e10911041813r36675253n9e0b6b81bd6b1055@mail.gmail.com>
	 <1257389371.23167.155.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-8hsHZ1zY/asw9642x9gT"
Date: Wed, 11 Nov 2009 01:33:24 -0700
Message-ID: <1257928404.1605.17.camel@russ-laptop>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-8hsHZ1zY/asw9642x9gT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2009-11-05 at 02:49 +0000, Bastien Nocera wrote:
> On Wed, 2009-11-04 at 19:13 -0700, Russ Dill wrote:
> > On Wed, Nov 4, 2009 at 6:29 AM, Bastien Nocera <hadess@hadess.net> wrot=
e:
> > > On Wed, 2009-11-04 at 01:14 -0700, Russ Dill wrote:
> > >> I have ubuntu lucid (its just karmic+2.6.32-rc5) and I can only get
> > >> pulseaudio to detect my Sony DR-BT50 headset if I send some dbus
> > >> commands:
> > >>
> > >> addr=3D00:1a:80:67:63:2c
> > >> hci=3D$(dbus-send --print-reply --system --dest=3Dorg.bluez /
> > >> org.bluez.Manager.DefaultAdapter | tail -n 1 | cut -f 2 -d '"')
> > >> dev=3D$(dbus-send --print-reply --system --dest=3Dorg.bluez $hci
> > >> org.bluez.Adapter.FindDevice string:$addr | tail -n 1 | cut -f 2 -d
> > >> '"')
> > >> dbus-send --print-reply --system --dest=3Dorg.bluez $dev org.bluez.A=
udio.Connect
> > >>
> > >> Additionally, the device shows up under the gnome bluetooth-properti=
es
> > >> applet under "Known devices" with the gold star and the keys. The
> > >> connected plug doesn't appear until I exec the above commands.
> > >> Clicking the plug without the above commands does nothing.
> > >
> > > You're using bluez-gnome (or possibly an old version of
> > > gnome-bluetooth). Make sure you use the latest version (2.28.3).
> > >
> > > Cheers
> > >
> >=20
> > Thank you for the awesomeness.
> >=20
> > Next question, I get events from keypresses on the headset via a
> > /dev/input/eventX file, but how do I do things with those events?
>=20
> If you use GNOME, the buttons should be forwarded to X11, and to the
> desktop. So the volume buttons should already work. Check the Sound and
> Keyboard shortcuts preferences.
>=20
> If you're using something else, I'm afraid I wouldn't know...
>=20
> Cheers
>=20

Looking at the spec, yes 0x7e is VENDOR_UNIQUE. It gives a operation
data field length of 5 as spelled out in the spec, it then gives a
company ID of 0x08 0x00 0x46 and then a vendor unique id of 0x00 0x01
for folder+ and 0x00 0x02 for folder -.

Ok, here is my quick and dirty patch for supporting VENDOR_UNIQUE.
audio/control.c doesn't seem to be the right place to store these
quirks. Can we somehow pass it as a uinput message and let some other
software stack layer that has policy files figure it out?

I also don't think KEY_PROG1 and KEY_PROG2 are the right choice, but I'm
not sure what is.

I also noticed that the spec includes info on how to tell the device
that audio is playing or audio is paused. I imagine if this was
implemented, my device would send the correct play/pause keycode.

The patch is mainly a request for comments. It is against bluez-4.51.

--- a/audio/control.c	2009-11-11 00:11:32.000000000 -0700
+++ b/audio/control.c	2009-11-11 01:29:22.000000000 -0700
@@ -193,6 +193,28 @@ static struct {
 	{ NULL }
 };
=20
+struct vendor_keys {
+	const char *name;
+	uint16_t vendorid;
+	uint16_t uinput;
+};
+
+#define COMPANYID_SONY 0x080046
+static struct vendor_keys sony_vendor_keys[] =3D {
+	{ "FOLDER_NEXT",	0x0001,			KEY_PROG1 },
+	{ "FOLDER_PREV",	0x0002,			KEY_PROG2 },
+	{ NULL }
+};
+
+static struct {
+	const char *name;
+	uint32_t companyid;
+	struct vendor_keys *keys;
+} vendor_key_map[] =3D {
+	{ "Sony Corporation", COMPANYID_SONY, sony_vendor_keys },
+	{ NULL }
+};
+
 static GSList *avctp_callbacks =3D NULL;
=20
 static sdp_record_t *avrcp_ct_record()
@@ -348,6 +370,8 @@ static void handle_panel_passthrough(str
 {
 	const char *status;
 	int pressed, i;
+	const char *name =3D NULL;
+	uint16_t uinput =3D 0;
=20
 	if (operand_count =3D=3D 0)
 		return;
@@ -360,17 +384,61 @@ static void handle_panel_passthrough(str
 		pressed =3D 1;
 	}
=20
-	for (i =3D 0; key_map[i].name !=3D NULL; i++) {
-		if ((operands[0] & 0x7F) =3D=3D key_map[i].avrcp) {
-			debug("AVRCP: %s %s", key_map[i].name, status);
-			send_key(control->uinput, key_map[i].uinput, pressed);
-			break;
+	if ((operands[0] & 0x7f) =3D=3D 0x7e) {
+		const struct vendor_keys *map =3D NULL;
+		const char *vendor_name =3D NULL;
+		uint32_t companyid =3D 0;
+		uint16_t vendorid =3D 0;
+
+		if (operand_count !=3D 7) {
+			debug("AVRCP: Incorrect operand_count for "
+				"VENDOR_UNIQUE (%d) %s", operand_count, status);
+			return;
 		}
-	}
+		companyid =3D (operands[2] << 16) | (operands[3] << 8) |
+						operands[4];
+		vendorid =3D (operands[5] << 8) | operands[6];
+		for (i =3D 0; vendor_key_map[i].name !=3D NULL; i++) {
+			if (companyid =3D=3D vendor_key_map[i].companyid) {
+				map =3D vendor_key_map[i].keys;
+				vendor_name =3D vendor_key_map[i].name;
+				break;
+			}
+		}
+		if (map =3D=3D NULL) {
+			debug("AVRCP: Unknown companyid (0x%06x) for "
+				"VENDOR_UNIQUE (%d) %s", companyid,
+				operand_count, status);
+			return;
+		}
+		for (i =3D 0; map[i].name !=3D NULL; i++) {
+			if (vendorid =3D=3D map[i].vendorid) {
+				name =3D map[i].name;
+				uinput =3D map[i].uinput;
+				break;
+			}
+		}
+		if (name =3D=3D NULL)
+			debug("AVRCP: unknown vendor button %s 0x%04X %s",
+						vendor_name, vendorid, status);
=20
-	if (key_map[i].name =3D=3D NULL)
-		debug("AVRCP: unknown button 0x%02X %s",
+	} else {
+		for (i =3D 0; key_map[i].name !=3D NULL; i++) {
+			if ((operands[0] & 0x7F) =3D=3D key_map[i].avrcp) {
+				name =3D key_map[i].name;
+				uinput =3D key_map[i].uinput;
+				break;
+			}
+		}
+		if (name =3D=3D NULL)
+			debug("AVRCP: unknown button 0x%02X %s",
 						operands[0] & 0x7F, status);
+	}
+
+	if (name) {
+		debug("AVRCP: %s %s", name, status);
+		send_key(control->uinput, uinput, pressed);
+	}
 }
=20
 static void avctp_disconnected(struct audio_device *dev)
@@ -585,6 +653,12 @@ static int uinput_create(char *name)
=20
 	for (i =3D 0; key_map[i].name !=3D NULL; i++)
 		ioctl(fd, UI_SET_KEYBIT, key_map[i].uinput);
+	for (i =3D 0; vendor_key_map[i].name !=3D NULL; i++) {
+		const struct vendor_keys *map =3D vendor_key_map[i].keys;
+		int j;
+		for (j =3D 0; map[j].name !=3D NULL; j++)
+			ioctl(fd, UI_SET_KEYBIT, map[j].uinput);
+	}
=20
 	if (ioctl(fd, UI_DEV_CREATE, NULL) < 0) {
 		err =3D errno;


--=-8hsHZ1zY/asw9642x9gT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkr6dtEACgkQfNRrxBinbdt13gCgsT1SKt1vsWSX+wAm2LMMLQd8
hsgAnA1KnmEMwO4uYml2iyvi3f7z6I0z
=xtkx
-----END PGP SIGNATURE-----

--=-8hsHZ1zY/asw9642x9gT--

