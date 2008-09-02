Return-Path: <cyrus@holtmann.org>
Date: Tue, 2 Sep 2008 22:51:53 +0600
From: "Murat D. Kadirov" <banderols@gmail.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20080902165153.GA5135@darkstar>
References: <42300.41687.qm@web8406.mail.in.yahoo.com>
	<alpine.LNX.1.10.0808290815350.26779@nge2.ngu.pk>
Mime-Version: 1.0
In-Reply-To: <alpine.LNX.1.10.0808290815350.26779@nge2.ngu.pk>
Subject: Re: [Bluez-users] Does not work BT headset
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0295868231=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--===============0295868231==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

08:22 Fri 29 Aug, jayjwa wrote:
>=20
>=20
> On Thu, 28 Aug 2008, pramod gurav wrote:
>=20
> -> Send the output  of
> -> $ hcitool conn
> -> It should show both SCO and ACL connections.
root@darkstar:/etc/bluetooth# hcitool conn
Connections:
:/
For the first time, when I was pair my devices, all was normal.
> ->=20
> -> and have you run=20
> -> $ passkey-agent --default 0000 &
> -> try running this. This is way to set the PIN for authentication.
> ->  And how do you connect before running mplayer?
> -> When you run mplayer it will automatically establish connection. So no=
 need to do it manually if you are doing so.
>=20
> The audio player should make the connection itself, I think. Also, he see=
ms to=20
> have the passkey-agent:
>=20
> -> Aug 27 19:08:10 darkstar hcid[5728]: Default passkey agent (:1.43,
> -> /org/bluez/passkey_agent_5737) registered
>=20
>=20
> I've always used it like so:
>=20
> passkey-agent --default 0000 <bt address of remote device> &

It had a crashing after power on headset:
# ps
=2E.
/usr/lib/bluetooth/add-passkey 00:16:8F:DA:83:75
=2E.

after power on headset proccess 'add-passkey' is down and in
/var/log/syslog appears:

Sep  2 22:42:53 darkstar audio[6044]: Access denied: Authorization agent
does not exist
Sep  2 22:42:54 darkstar hcid[6031]: Got NameOwnerChanged signal for
:1.29 which has no listeners

> Does it work with no remote address specified (could be)?
>=20
>=20
> I think it's the auth-agent that is not running. It may be needed. I alwa=
ys=20
> start this too.
>=20
> auth-agent &
Is it the same 'register-passkeys'? Yes, it running.
>=20
> Here:
>=20
> -> Aug 27 19:12:13 darkstar audio[5741]: Access denied: Authorization age=
nt
> -> does not exist
>=20
>=20
> Is the headset an older Bluetooth 1.* device, or the newer 2.*? If it's 1=
.*,=20
> then it won't work without patching the kernel.
>=20
=46rom documentation to headset: "Bluetooth 2.0 supporting headset and
hands-free profile", dongle support BT 2.0 too.

--=20
Murat D. Kadirov

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAki9bykACgkQG5cKDs7AaqDfTQCfYUEMcRCjm6quBmdc0LT9r+Mn
qmIAn07SOP6J/cA3mz3zTJFnzJLWkEog
=CnEP
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--


--===============0295868231==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============0295868231==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0295868231==--
