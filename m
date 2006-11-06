Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <454F97A9.5040409@prolly.org>
Date: Mon, 06 Nov 2006 15:14:33 -0500
From: Douglas Ward <douglas.ward@prolly.org>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <20061105104020.38470@gmx.net>
In-Reply-To: <20061105104020.38470@gmx.net>
Subject: Re: [Bluez-devel] Patch for switching a diNovo *Laser* to BT
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

the logitech g15 keyboard is where i started... i've since run out of
time to work on it. I have an mx5000 keyboard which also has an lcd...

g.len@gmx.de wrote:
> Hello,
>
> I found some more information that I mixed up some IDs. 0xc709 should
be the BT dongle in HCI mode not the Mediepad. Sorry.
>
> The following patch is updated to this situation.
>
> BTW, I would like to do some testing with the LCD of the mediapad.
Where would be a good starting point looking for ducmentation / code
examples to communicate with such a device? (I am not asking for the
Logitech-protocol.)
>
> Kind regards,
>
> G.Len
>
> --- hid2hci.c.dinovo.diff       2006-10-01 22:39:55.000000000 +0200
> +++ tools/hid2hci.c     2006-10-01 22:45:50.000000000 +0200
> @@ -223,7 +223,9 @@
>         { HCI, 0x046d, 0xc703, switch_logitech },
>         { HCI, 0x046d, 0xc704, switch_logitech },
>         { HCI, 0x046d, 0xc705, switch_logitech },
>         { HCI, 0x046d, 0xc70a, switch_logitech },       /* Logitech
diNovo mouse */
> +       { HCI, 0x046d, 0xc70b, switch_logitech },       /* Logitech
diNovo Laser keyboard */
> +       { HCI, 0x046d, 0xc70c, switch_logitech },       /* Logitech
diNovo Laser mouse */
>         { HCI, 0x046d, 0xc70e, switch_logitech },       /* logitech
diNovo keyboard */
>         { -1 }
>  };
>

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRU+XqFKDmmHy9Q32AQI7zg//XeezrQlH5SwDGQwNz2s2VEe7tJpGxDD0
O2bkthmNupUBSu/WVAn0d+n20S5Xfjd3MPt/1e4mRexGA4nPHej8oDW4kY76vrNI
0tnU7/YTUicAPOlWFdyP9jD+cZs12AJDNZ5C/Dx8Nbigxi/wMRUGcU28xo/qzWUx
XsJRwe2uwMDgX/glXiQzOtyRqxYZN+YVxECIM2rrhBpJZ2d78rXsRTd62tFExw0g
5MWEHPWjsToT2SOdsNu6xTLBhzXMitoneAp0ro+devGa386B4IhjunYZA0PfqrsA
Z8ztbg3Wc4l4CGSu14WXroMamOrVfscxlVu7jJCudoc9Pc+blQjEsDs9g/lXFxDp
N5qGMaTuIybSOhMleIWiZbmrD3M9mqEJIJTVCDfJKv8FOJNQH9mzPP8uRIR42PS7
CVdU3w/UXPk9T5VcseHZMSk5cWO+2Ign2iSiYFzzZB6v5CiSo6hotZIRJhpLP7Kq
0j+rq7Y5LijhtAe3dsCMASkF7d+mCTtTsraSfMHo1vhdZ4JC0pIk6kkbEBv7+req
64x7U/VjC0QYgMDTYlaiO91f5sfmta0Fmh3U/ZiT+/dQR8D1XBIyHNyr/9615bOv
bamxr740Ay9nyzL+ic5n84K40oYrgwESELe0BGdPQwXWktzV/2N0cP1q4icVXd5e
Fi8aMTxhBDM=
=DzFs
-----END PGP SIGNATURE-----


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
