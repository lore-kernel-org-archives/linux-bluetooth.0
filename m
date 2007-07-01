Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Michael Ellerman <michael@ellerman.id.au>
To: Ranulf Doswell <ralf@ranulf.net>
In-Reply-To: <18a15270706300844t28c3aab6jb24f45453ce1557b@mail.gmail.com>
References: <18a15270706300844t28c3aab6jb24f45453ce1557b@mail.gmail.com>
Date: Sun, 01 Jul 2007 15:36:05 +1000
Message-Id: <1183268165.8189.9.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: cbe-oss-dev@ozlabs.org, bluez-devel@lists.sf.net
Subject: Re: [Bluez-devel] [Cbe-oss-dev] [PATCH] reset unexpected bluetooth
	data	connections
Reply-To: michael@ellerman.id.au,
        BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0804853596=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============0804853596==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-DXk84TY3H6kyk/dPqJMY"


--=-DXk84TY3H6kyk/dPqJMY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2007-06-30 at 16:44 +0100, Ranulf Doswell wrote:
> This is my first patch, so apologies if I've got the protocol wrong!
> I'm not sure if this is the best place to post this patch or even if
> I've done everything correctly (I assume I simply add a signed-off-by
> in my name).=20

Hi Ranulf,

This is one of the places you should send this patch, the other is the
bluetooth list, which I've CC'ed. The main issue is whether your patch
is safe in the general case, or if it's just a PS3 issue.

You do "simply" add a signed-off-by line, as long as you understand what
it means - read Documentation/SubmittingPatches for the full version.
Basically you're saying that you wrote the code and you're allowed to
release it under the GPL v2.

> I came across this bug when getting sixaxis controllers to work under
> Linux on the PS3, although it actually seems to be a generic bluetooth
> problem under Linux.
>=20
> Basically, the problem is that unless the bluetooth connection is
> killed prior to reboot, the PS3 controllers continue sending out data
> which the kernel correctly identifies as not associated with an active
> connection. However, it simply logs the error and continues, so the
> syslog rapidly fills up. It addition, because the device it will not
> attempt to re-initiate a new bluetooth connection, so the only current
> solution is to halt the linux box until the controller times out.=20
>=20
> This one line addition sends the device a reset which causes it to
> switch off.

Cool, do the sixaxis controllers work with this patch applied?


> Signed-off-by: Ranulf Doswell <ralf at ranulf.net>
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 8943c93..77b7eca 100644
> --- a/net/bluetooth/hci_core.c=20
> +++ b/net/bluetooth/hci_core.c
> @@ -1340,6 +1340,12 @@ static inline void hci_acldata_packet(struct hci_d=
ev *hdev, struct sk_buff *skb)
>         } else {
>                 BT_ERR("%s ACL packet for unknown connection handle %d",=20
>                         hdev->name, handle);
> +
> +               // Force the device to reset in the hope that it will the=
n leave us alone.
> +               // This is needed at least for PS3 sixaxis as the control=
lers will keep=20
> +               // sending data until they are forcibly terminated. A reb=
oot doesn't provide
> +               // enough time for the controller's bluetooth stack to ti=
me out.=20
> +               hci_reset_req(hdev, 0);=20

You should use C-style comments, eg. /* .. */, see
Documentation/CodingStyle for more info.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-DXk84TY3H6kyk/dPqJMY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGhz1FdSjSd0sB4dIRAupXAKC7f68xcsb6qgNDHJHGWzVYHZqyEwCfdMNu
QZl93VlXzu1wQekkzs51LKU=
=iF1j
-----END PGP SIGNATURE-----

--=-DXk84TY3H6kyk/dPqJMY--



--===============0804853596==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0804853596==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0804853596==--
