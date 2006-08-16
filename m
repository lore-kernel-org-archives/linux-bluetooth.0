Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Wed, 16 Aug 2006 10:39:01 -0300
From: redondos <redondos@gmail.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20060816133901.GA2993@refinery.twat.com.ar>
References: <44E1187E.6030401@mackintoshweb.com>
	<20060815012354.GB15576@refinery.twat.com.ar>
	<44E1A281.3090803@ipb.pt>
	<20060815222203.GI15576@refinery.twat.com.ar>
	<44E2D4D4.6030304@ipb.pt>
MIME-Version: 1.0
In-Reply-To: <44E2D4D4.6030304@ipb.pt>
Subject: Re: [Bluez-users] Totally confused
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0614677593=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--===============0614677593==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16 09:18, Rui Pedro Lopes wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> redondos wrote:
> > Have you tried following the Gentoo wiki? You're probably not using
> > Gentoo, but they are well-known for providing pretty good documentation
> > to the open source community.
> >
> > http://www.gentoo-wiki.com/HOWTO_use_a_bluetooth_headset
> Yap. Actually, I'm using debian...
> >
> > About the PIN code: have you configured a pin helper correctly in
> > hcid.conf? It's pretty simple, you can just write a shell script:
> >
> > #!/bin/sh
> > echo "PIN:1234
> >
> > Make it executable, then edit hcid.conf with the line:
> >
> > pin_helper /path/to/the/script
> Yes, I have tried that. Here is the syslog messages:
>=20
> Aug 16 09:13:20 tash hcid[7714]: Bluetooth HCI daemon
> Aug 16 09:13:20 tash hcid[7714]: Unknown option 'pin_helper' line 27
> Aug 16 09:13:20 tash hcid[7714]: syntax error line 27
> Aug 16 09:13:20 tash sdpd[7716]: Bluetooth SDP daemon
> Aug 16 09:13:20 tash hidd[7718]: Bluetooth HID daemon
> Aug 16 09:13:20 tash hcid[7714]: Register path:/org/bluez fallback:1
> Aug 16 09:13:20 tash hcid[7714]: Device hci0 has been added
> Aug 16 09:13:21 tash hcid[7714]: Starting security manager 0
> Aug 16 09:13:21 tash hcid[7714]: Can't write inquiry mode for hci0:
> Input/output error (5)
> Aug 16 09:13:21 tash hcid[7714]: Register path:/org/bluez/hci0 fallback:0
>=20
>=20
>=20
> Apparently, pin_helper is not available...

I forgot the ';' at the end of the line. Did you add that? Can we see
your hcid.conf at its full extent?

> Here is what the Debian maintainer added to the documentation:
>=20
>=20
> PIN (or passkey) management
> - ---------------------------
> since bluez 3.0 the old pin_helper script has been replaced by
> the dbus interface.  To add a default passkey for every outgoing
> request (e.g. the old /etc/bluetooth/pin file) drop it into
> /etc/bluetooth/passkeys/default. (e.g. echo "1234" >
> /etc/bluetooth/passkeys/default )
> To add a passkey for a specific outgoing connection replace default
> with the device's address. ( /etc/default/passkeys/aa:bb:cc:dd:ee:ff
> will contain passkey for aa:bb:cc:dd:ee:ff ).
> After adding a passkey you should restart bluetooth with
>=20
> /etc/init.d/bluetooth restart
>=20
> and the new passkeys will be registered.
>=20
>=20
> I have also tried that and it is not working... do you think it is a
> Debian problem?

Oh, you're using 3.x. I don't know, haven't played with it yet, sorry.=20

--=20
redondos

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)

iD8DBQFE4x/1JZ/yCc25j3IRAuPdAJ4sL1TxsvcpWCQsWD+3TDTD2mdUNgCdG4dl
jPqHYxBlbHPymjOQchsBfXM=
=5Xpa
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--


--===============0614677593==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0614677593==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0614677593==--
