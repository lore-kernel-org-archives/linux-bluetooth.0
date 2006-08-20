Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sun, 20 Aug 2006 12:52:35 +0200
From: Filippo Giunchedi <filippo@esaurito.net>
To: bluez-devel@lists.sf.net, fexpop@onlinehome.de
Message-ID: <20060820105235.GB12991@esaurito.net>
MIME-Version: 1.0
Subject: [Bluez-devel] [fexpop@onlinehome.de: [Pkg-bluetooth-maintainers]
	Bug#379401: bluez-utils: 3.1-2 renders system invisible for
	other BT devices]
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0606752184=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============0606752184==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
Content-Disposition: inline


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,
I'm forwarding this bug upstream also because I've received another private
report with the same problem.
The problem is that [ip]scan isn't enabled on device even if specified into
hcid.conf, but setting it with hciconfig works.
I suspect that this is dongle-specific because on my system it works as
expected.
Any ideas?

thanks,
filippo

----- Forwarded message from Felix Homann <fexpop@onlinehome.de> -----

=46rom: Felix Homann <fexpop@onlinehome.de>
To: Debian Bug Tracking System <submit@bugs.debian.org>
Message-ID: <20060723102323.31430.29519.reportbug@localhost>
X-Mailer: reportbug 3.21.2
Date: Sun, 23 Jul 2006 12:23:23 +0200
Subject: [Pkg-bluetooth-maintainers] Bug#379401: bluez-utils: 3.1-2 renders=
  system invisible for other BT devices
Reply-To: Felix Homann <fexpop@onlinehome.de>, 379401@bugs.debian.org
Sender: pkg-bluetooth-maintainers-bounces@lists.alioth.debian.org

Package: bluez-utils
Version: 3.1-2
Severity: important


Hi,

with bluez-utils 3.1-2 my system is invisible for other devices, it
can't be found. I still can send data from devices that know my dongle's=20
bluetooth address, though.

Kind regards,

Felix

-- System Information:
Debian Release: testing/unstable
  APT prefers unstable
  APT policy: (990, 'unstable'), (500, 'testing'), (500, 'stable'), (1, 'ex=
perimental')
Architecture: i386 (i686)
Shell:  /bin/sh linked to /bin/bash
Kernel: Linux 2.6.17.4-jawaka-splash
Locale: LANG=3DC, LC_CTYPE=3DC (charmap=3DANSI_X3.4-1968)

Versions of packages bluez-utils depends on:
ii  libbluetooth2              3.1-1         Library to use the BlueZ Linux=
 Blu
ii  libc6                      2.3.6-15      GNU C Library: Shared libraries
ii  libdbus-1-2                0.62-4        simple interprocess messaging =
syst
ii  libdbus-glib-1-2           0.62-4        simple interprocess messaging =
syst
ii  libglib2.0-0               2.10.3-3      The GLib library of C routines
ii  libusb-0.1-4               2:0.1.12-2    userspace USB programming libr=
ary
ii  lsb-base                   3.1-10        Linux Standard Base 3.1 init s=
crip
ii  makedev                    2.3.1-82      creates device files in /dev
ii  module-init-tools          3.2.2-3       tools for managing Linux kerne=
l mo
ii  modutils                   2.4.27.0-6    Linux module utilities
ii  sysvinit                   2.86.ds1-14.1 System-V-like init utilities
ii  udev                       0.093-1       /dev/ and hotplug management d=
aemo

bluez-utils recommends no packages.

-- no debconf information


_______________________________________________
Pkg-bluetooth-maintainers mailing list
Pkg-bluetooth-maintainers@lists.alioth.debian.org
http://lists.alioth.debian.org/mailman/listinfo/pkg-bluetooth-maintainers


----- End forwarded message -----
--
Filippo Giunchedi - http://esaurito.net
PGP key: 0x6B79D401
random quote follows:

Machines take me by surprise with great frequency.
-- Alan Turing

--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE6D7zABzeamt51AERAmegAJ0cw58+w64pAysxH0dJYBdR/zzAVACgoBHr
TAfviFl52Fg3snHNbfLMAqI=
=r4Z7
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--


--===============0606752184==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0606752184==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0606752184==--
