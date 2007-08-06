Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Thomas Kear <thomas.kear@gmail.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Mon, 6 Aug 2007 19:57:48 +1200
References: <E1IHxKc-0003YU-HU@mail.sourceforge.net>
In-Reply-To: <E1IHxKc-0003YU-HU@mail.sourceforge.net>
MIME-Version: 1.0
Message-Id: <200708061957.56356.thomas.kear@gmail.com>
Subject: Re: [Bluez-users] how to make the device be discoverable
Reply-To: thomas.kear@gmail.com,
        BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0556421845=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0556421845==
Content-Type: multipart/signed; boundary="nextPart1392980.Z1hRkFBTpI";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1392980.Z1hRkFBTpI
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Mon, 06 Aug 2007, leiyu@kcoe.cn wrote:
> Dear All,
>
> I use bluez in embedded linux, it can use "hcitool scan" command to search
> for other bluetooth device , how to make it be discoverable so that other
> device can discover it? Thanks!
>
> Best regards,
> Leiyu


dbus-send --system --type=3Dmethod_call --print-reply --dest=3Dorg.bluez /o=
rg/bluez/hci0=20
org.bluez.Adapter.SetMode string:discoverable

More or less.

add
discovto 0;

to the 'device' section of hcid.conf to make it permanent, or a non-zero va=
lue=20
to set a time before the device becomes hidden again (i think in minutes, b=
ut=20
not sure)

Thomas

--nextPart1392980.Z1hRkFBTpI
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.5 (GNU/Linux)

iD8DBQBGttSE8/Qi7qeDfygRAsj0AJ98MJNsmtRr6mUYxr3tSBkwignbgACgqbeb
fSTM8u2q4+FZ72x8ME9p9Rs=
=Ui1T
-----END PGP SIGNATURE-----

--nextPart1392980.Z1hRkFBTpI--


--===============0556421845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============0556421845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0556421845==--
