Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Elimar Riesebieter <riesebie@lxtec.de>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>,
   debian-powerpc <debian-powerpc@lists.debian.org>
Subject: Re: [Bluez-users] Apple bluetooth mouse
Message-ID: <20031230221526.GD946@samweis.home.lxtec.de>
References: <20031228012502.GA16798@samweis.home.lxtec.de> <20031228170349.GA1460@samweis.home.lxtec.de> <m3fzf47oa3.fsf@neo.loria> <20031230182456.GA3035@samweis.home.lxtec.de> <1072813766.2542.28.camel@pegasus> <20031230205918.GA946@samweis.home.lxtec.de> <1072818406.2542.33.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xA/XKXTdy9G3iaIz"
In-Reply-To: <1072818406.2542.33.camel@pegasus>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 30 Dec 2003 23:15:26 +0100


--xA/XKXTdy9G3iaIz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Dec 2003 the mental interface of=20
Marcel Holtmann told:

> Hi Elimar,
>=20
> > Neither OHCI nor EHCI was enabled in my kernel. Changed that and the
> > mouse works like a charm at console and X ;-)
> >=20
> > Thank you for that hint!
> >=20
> > But anyway: hcitool inq like shown at
> > http://www.holtmann.org/linux/bluetooth/hid.html tells:
> > Inquiring ...
> > Inquiry failed.: No such device
>=20
> 	T:  Bus=3D02 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D  2 Spd=3D12  =
MxCh=3D 0
> 	D:  Ver=3D 1.10 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
> 	P:  Vendor=3D05ac ProdID=3D1000 Rev=3D 9.01
> 	C:* #Ifs=3D 2 Cfg#=3D 1 Atr=3Dc0 MxPwr=3D100mA
> 	I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D03(HID  ) Sub=3D01 Prot=3D01 Drive=
r=3Dhid
> 	E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms
> 	I:  If#=3D 1 Alt=3D 0 #EPs=3D 1 Cls=3D03(HID  ) Sub=3D01 Prot=3D02 Drive=
r=3Dhid
> 	E:  Ad=3D82(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms
>=20
> this looks like a Bluetooth HID proxy device from CSR. You can use the
> hid2hci program to switch it into HCI mode. However it seems that Apple
> is using its own vendor id, so you must change this in the source code.

Where in the source code? This should be a useful info for Benjamin
Herrenschmidt as well.

I found hid2hci In the CVS sourcecode from bluez-utils2.
hid2hci -(0|1) gives me=20
No devices in H(CI|DI) mode found ;-(

HANN

Elimar

--=20
  Learned men are the cisterns of knowledge,=20
  not the fountainheads ;-)

--xA/XKXTdy9G3iaIz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQE/8fj+3Ig8bsVPf7ARAt+lAKC6z7+EhRzR1uu3oAahDPALxAasbQCfWlj/
kxFFbfj+/BgXnzc0JskDhZE=
=0VyV
-----END PGP SIGNATURE-----

--xA/XKXTdy9G3iaIz--


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
