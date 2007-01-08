Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Luca Capello <luca@pca.it>
To: bluez-devel@lists.sourceforge.net
Date: Tue, 09 Jan 2007 00:31:12 +0100
Message-ID: <878xgd3xkv.fsf@tora.pca.it>
References: <200701081837.04388.dgollub@suse.de>
	<20070108184701.GA12689@jh-mbp>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] Should hcid wait for dbus daemon?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1010358922=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

<#secure method=pgpmime mode=sign>
--===============1010358922==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

<#secure method=pgpmime mode=sign>
--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello!

NB, I'm not deeply involved in bluetooth neither dbus development,
just a "power user".  If my thoughts are wrong, just discard them.

On Mon, 08 Jan 2007 19:47:01 +0100, Johan Hedberg wrote:
> On Mon, Jan 08, 2007, Daniel Gollub wrote:
>> If the hcid would wait for the dbus daemon this wouldn't be a
>> problem. At least hcid can handle a dbus daemon restart, maybe we
>> can enhance this.
>
> Sounds like a useful feature.

Shouldn't be the contrary?  I mean, on a clean Debian etch, every
dbus-dependent service is started by dbus:
=3D=3D=3D=3D=3D
root@gismo:/home/luca# ls -l /etc/dbus-1/eventd.d/
total 16
=2Drwxr-xr-x 1 root root 1901 2006-11-11 15:38 20hal
=2Drwxr-xr-x 1 root root 1091 2006-10-24 15:22 24dhcdbd
lrwxrwxrwx 1 root root   25 2007-01-07 21:53 25avahi-daemon -> \
 ../../init.d/avahi-daemon
=2Drwxr-xr-x 1 root root 1766 2006-11-30 22:22 25NetworkManager
=2Drwxr-xr-x 1 root root 1684 2006-11-30 22:22 26NetworkManagerDispatcher

root@gismo:/home/luca# invoke-rc.d dbus start
Starting system message bus: dbus.
Starting Hardware abstraction layer: hald.
Starting DHCP D-Bus daemon: dhcdbd.
Starting network connection manager: NetworkManager.
Starting Avahi mDNS/DNS-SD Daemon: avahi-daemon.
Starting network events dispatcher: NetworkManagerDispatcher.

root@gismo:/home/luca#
=3D=3D=3D=3D=3D

Just my 0.02=E2=82=AC...

Thx, bye,
Gismo / Luca

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFotRDVAp7Xm10JmkRAnv4AJ0ezzP9lwAFjGBKWHsS1NK9BtX2fgCfZo4u
Bf7cuz/zbqE/27WXZyIiVQw=
=kJ1J
-----END PGP SIGNATURE-----
--=-=-=--


--===============1010358922==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1010358922==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1010358922==--
