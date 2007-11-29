Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Brad Smith <bgsmith@bendcable.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1196056187.4217.54.camel@aeonflux>
References: <1196009038.14897.6.camel@pico> <1196056187.4217.54.camel@aeonflux>
Date: Wed, 28 Nov 2007 19:03:46 -0800
Message-Id: <1196305426.23029.12.camel@pico>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Lost connections - mouse and keyboard
Reply-To: bgsmith@bendcable.com,
        BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0728648393=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--===============0728648393==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-+eLrffJxoA9s9RbaTd/V"


--=-+eLrffJxoA9s9RbaTd/V
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Thank you for the reply Marvel.  I use the gnome bluetooth client which
apparently does manage bluetooth devices using bluetooth-input-service.
I  still have the problem of the devices disappearing if idle for too
long such as when i lock the desktop or log out for  a long period.
Sometimes I can re-enable the devices, but sometimes I cannot.  This is
frustrating.=20

I see a the following several times in the system log if i restart
bluetooth:
Nov 28 18:53:39 pico kernel: WARNING: at drivers/hid/hid-core.c:784
implement() (Tainted: P       )
Nov 28 18:53:39 pico kernel:=20
Nov 28 18:53:39 pico kernel: Call Trace:
Nov 28 18:53:39 pico kernel:  [<ffffffff811d8549>] hid_output_report
+0x1c5/0x232
Nov 28 18:53:39 pico kernel:  [<ffffffff811ddaf1>] hid_submit_ctrl
+0x60/0x24b
Nov 28 18:53:39 pico kernel:  [<ffffffff811dde45>] usbhid_submit_report
+0x169/0x19e
Nov 28 18:53:39 pico kernel:  [<ffffffff811e030b>] hiddev_ioctl
+0x368/0x919
Nov 28 18:53:39 pico kernel:  [<ffffffff810f54c5>] inode_has_perm
+0x65/0x72
Nov 28 18:53:39 pico kernel:  [<ffffffff81120c17>] __up_read+0x19/0x7f
Nov 28 18:53:39 pico kernel:  [<ffffffff8125eecc>] do_page_fault
+0x490/0x7e4
Nov 28 18:53:39 pico kernel:  [<ffffffff810a7399>] do_ioctl+0x55/0x6b
Nov 28 18:53:39 pico kernel:  [<ffffffff810a75f2>] vfs_ioctl+0x243/0x25c
Nov 28 18:53:39 pico kernel:  [<ffffffff810a7664>] sys_ioctl+0x59/0x79
Nov 28 18:53:39 pico kernel:  [<ffffffff8100bd45>] tracesys+0xd5/0xda

Brad


On Mon, 2007-11-26 at 06:49 +0100, Marcel Holtmann wrote:
> Hi Brad,
>=20
> > I have a Logitech mouse and keyboard that use bluetooth (dinovo).  I
> > have enabled bluetooth on this Fedora 8 system and both work well with
> > two problems.
> >=20
> > (1) When I lock the system and return later the mouse no longer works.
> > I have to open a terminal window and issue an hidd --connect command.
> >=20
> > (2) When I log out, both the mouse and keyboard stop working.  I have t=
o
> > connect a USB mouse and USB keyboard to enter the authentication
> > information.  Once logged in the bluetooth devices usually work,
> > although I sometimes have to issue an hidd --connect command to enable
> > the keyboard.
> >=20
> > Any suggestions on resolving these issues would be appreciated.
>=20
> not using hidd and using bluetoothd-input-service instead is one thing.
> For input devices to re-connect you have to have a daemon running that
> handles this. The input service is the best way to achieve this. Check
> the BlueZ wiki for details.

--=-+eLrffJxoA9s9RbaTd/V
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHTiwSkkegtSoBeLkRAgbNAJ4+Yv3xeQv9AUta/8mzXSxQ92k5ggCgrSJS
QJf+af4SwRpzwQulqGG97Rg=
=rMEV
-----END PGP SIGNATURE-----

--=-+eLrffJxoA9s9RbaTd/V--



--===============0728648393==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
--===============0728648393==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0728648393==--
