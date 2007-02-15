Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Thomas Kear <thomas.kear@gmail.com>
To: bluez-users@lists.sourceforge.net
Date: Thu, 15 Feb 2007 18:15:25 +1300
MIME-Version: 1.0
Message-Id: <200702151815.29078.thomas.kear@gmail.com>
Subject: [Bluez-users] SCO headset/headsetd issue
Reply-To: thomas.kear@gmail.com,
        BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1501652536=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1501652536==
Content-Type: multipart/signed; boundary="nextPart1185579.ousoezjZJn";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1185579.ousoezjZJn
Content-Type: multipart/mixed;
  boundary="Boundary-01=_tx+0FhG6geAfsY9"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_tx+0FhG6geAfsY9
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I can't get my headset (Sony Ericsson HBH-IV835) to work with headsetd.

Installed libsbc/plugz from svn using instructions here:=20
http://bluetooth-alsa.sourceforge.net/build.html (I wrote ebuilds to check=
=20
out and compile the two apps so I had a record of the files installed but=20
otherwise the process was identical, have attached these just in case).

Rest of my system:
gentoo/amd64 2006.1
bluez 3.9
kernel 2.6.20-gentoo
CSR USB Bluetooth 1.2 dongle

This setup used to work with btsco, but the kernel module for it won't comp=
ile=20
on 2.6.20.  Devices are definately paired, service discovery is working, et=
c.

~/.asoundrc:
pcm.headset {
        @args [BDADDR TIMEOUT]
        @args.BDADDR {
            type string
        }
        @args.TIMEOUT {
            type integer
            default 6000
        }
        type        sco
        bdaddr      00:18:13:7e:bc:7a
        timeout     $TIMEOUT
}
ctl.headset {
        type sco
}

Results when trying to play audio through headset

$ mplayer -ao alsa:device=3Dheadset $random_video_file
MPlayer 1.0rc1-4.1.1 (C) 2000-2006 MPlayer Team
[...]
alsa-init: playback open error: Connection timed out
Could not open/initialize audio device -> no sound.
Audio: no sound
Starting playback...
(video plays at this point, with no audio)

$ headsetd -n
headsetd[3540]: Bluetooth headset daemon version 0.5
	headsetd[3540]: Configuration phase ended: target bdaddr is=20
00:18:13:7E:BC:7A, timeout is 6000 ms
headsetd[3540]: Changing state: Idle-->Paging
headsetd[3540]: Changing state: Paging-->Connecting
headsetd[3540]: Changing state: Connecting-->Ready
headsetd[3540]: Changing state: Ready-->Opening
headsetd[3540]: unable to open SCO channel to headset: Connection timed out
headsetd[3540]: Changing state: Opening-->ZombieAppl
headsetd[3540]: Appli closed socket
headsetd[3540]: Changing state: ZombieAppl-->Idle


I have reset my headset, deleted the contents of /var/lib/bluetooth on the =
pc,=20
re-paired continuosly, but get the same result each time.

What have I overlooked?

--Boundary-01=_tx+0FhG6geAfsY9
Content-Type: text/plain;
  charset="utf-8";
  name="plugz-9999.ebuild"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="plugz-9999.ebuild"

# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gimp/gimp-9999.ebuild,v 1.7 2007/01/28 11:50:58 hanno Exp $

inherit alternatives cvs eutils fdo-mime flag-o-matic

ECVS_SERVER="bluetooth-alsa.cvs.sourceforge.net:/cvsroot/bluetooth-alsa"
ECVS_MODULE="plugz"
ECVS_AUTH="pserver"
ECVS_USER="anonymous"

S=${WORKDIR}/${ECVS_MODULE}

DESCRIPTION="Bluetooth headset userspace utilities"
HOMEPAGE="http://bluetooth-alsa.sourceforge.net"
SRC_URI=""

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~amd64"

DEPEND="media-libs/alsa-lib
	media-sound/alsa-headers
	sys-apps/dbus
	>=net-wireless/bluez-libs-3.5
	dev-libs/dbus-glib"

src_compile() {
	libtoolize --copy --force
	./bootstrap
	./configure --prefix=/usr --sysconfdir=/etc
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR=${D}
	insinto /usr/share/${P}
	doins alsa-plugins/a2dpd/sample.a2dprc alsa-plugins/asound.conf
}

--Boundary-01=_tx+0FhG6geAfsY9
Content-Type: text/plain;
  charset="utf-8";
  name="libsbc-9999.ebuild"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="libsbc-9999.ebuild"

# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gimp/gimp-9999.ebuild,v 1.7 2007/01/28 11:50:58 hanno Exp $

inherit alternatives cvs eutils fdo-mime flag-o-matic

ECVS_SERVER="sbc.cvs.sourceforge.net:/cvsroot/sbc"
ECVS_MODULE="sbc"
ECVS_AUTH="pserver"
ECVS_USER="anonymous"

S=${WORKDIR}/${ECVS_MODULE}

DESCRIPTION="Bluetooth low-complexity subband codec"
HOMEPAGE="http://sbc.sourceforge.net"
SRC_URI=""

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~amd64"

DEPEND="media-libs/alsa-lib
	media-sound/alsa-headers
	sys-apps/dbus
	>=net-wireless/bluez-libs-3.5
	dev-libs/dbus-glib"

src_compile() {
	./bootstrap-configure --prefix=/usr
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR=${D}
}

--Boundary-01=_tx+0FhG6geAfsY9--

--nextPart1185579.ousoezjZJn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.2 (GNU/Linux)

iD8DBQBF0+xx8/Qi7qeDfygRAq0GAJ9BVzMf0ruacSmE+ZEhV+SfyddEUACfSyfL
+asjk4pWAsCkdSVpLnzHQoo=
=JGfF
-----END PGP SIGNATURE-----

--nextPart1185579.ousoezjZJn--


--===============1501652536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1501652536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1501652536==--
