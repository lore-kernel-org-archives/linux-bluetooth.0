Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4721E348.2060403@hccnet.nl>
Date: Fri, 26 Oct 2007 14:53:28 +0200
From: Remy Bosch <reboli@hccnet.nl>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <4720C85B.1090300@hccnet.nl> <1193352494.6184.290.camel@violet>
In-Reply-To: <1193352494.6184.290.camel@violet>
Content-Type: multipart/mixed; boundary="------------010500000503030602040805"
Subject: Re: [Bluez-users] Audio gaps with bcm2035 and Hama receiver
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------010500000503030602040805
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Marcel Holtmann wrote:
> Hi Remy,
>
> try the version from CVS or wait until I release a new one. These issues
> should be fixed now.
>
> Regards
>
> Marcel
>   

You mean that the issue was resolved after 3.21? Just installed the 3.21
lib. The utils package of that version won't compile atm.
I have gentoo-2007.0
Got ebuild attached in case on know what to do with it.


Remy

--------------010500000503030602040805
Content-Type: text/plain;
 name="bluez-utils-3.21.ebuild"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bluez-utils-3.21.ebuild"

# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bluez-utils/bluez-utils-3.20.ebuild,v 1.2 2007/10/06 00:41:02 betelgeuse Exp $

inherit autotools eutils

DESCRIPTION="Bluetooth Tools and System Daemons for Linux"
HOMEPAGE="http://bluez.sourceforge.net/"
SRC_URI="http://bluez.sourceforge.net/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~sh ~sparc ~x86"

IUSE="alsa cups debug examples gstreamer hal old-daemons test-programs usb"

DEPEND="
	>=net-wireless/bluez-libs-${PV}
	alsa? ( media-libs/alsa-lib )
	gstreamer? (
		>=media-libs/gstreamer-0.10
		>=media-libs/gst-plugins-base-0.10 )
	hal? ( sys-apps/hal )
	usb? ( dev-libs/libusb )
	cups? ( net-print/cups )
	sys-fs/udev
	dev-libs/glib
	sys-apps/dbus"

src_unpack() {
	unpack ${A}
	# bundled glib
	cd "${S}"
	rm -r eglib/{*.c,*.h}  || die
	if use cups; then
		epatch "${FILESDIR}/3.11/cups-location.patch"
		eautoreconf
	fi
}

src_compile() {
	# the order is the same as ./configure --help

	# we don't need the other daemons either with the new
	# service architechture
	# hcid has in integrated sdpd now that we use

	# These are currently under work and don't work properly:
	# --enable-sync
	# --enable-obex

	econf \
		$(use_enable debug) \
		--enable-inotify \
		$(use_enable hal) \
		$(use_enable usb) \
		$(use_enable alsa) \
		--enable-glib  \
		$(use_enable gstreamer) \
		--disable-obex \
		--enable-network \
		--enable-serial \
		--enable-input \
		--enable-audio \
		--disable-sync \
		$(use_enable examples echo) \
		--enable-hcid \
		$(use_enable test-programs test) \
		$(use_enable old-daemons sdpd) \
		$(use_enable old-daemons hidd) \
		$(use_enable old-daemons pand) \
		$(use_enable cups) \
		--enable-configfiles \
		--disable-initscripts \
		--disable-pcmciarules \
		--enable-bccmd \
		--enable-avctrl \
		--enable-hid2hci \
		--enable-dfutool \
		--localstatedir=/var \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog README || die

	# a very simple example daemon
	dobin daemon/passkey-agent || die

	newinitd "${FILESDIR}/3.11/bluetooth-init.d" bluetooth || die
	newconfd "${FILESDIR}/3.11/bluetooth-conf.d" bluetooth || die

	if use old-daemons; then
		sed -re 's/^(Autostart=)true/\1false/' \
			-i "${D}/etc/bluetooth/input.service" || die
		newconfd "${FILESDIR}/3.11/conf.d-hidd" hidd || die
		newinitd "${FILESDIR}/3.11/init.d-hidd" hidd || die
	fi

	# bug #84431
	insinto /etc/udev/rules.d/
	newins "${FILESDIR}/${PN}-3.10.1-udev.rules" 70-bluetooth.rules || die
	newins "${S}/scripts/bluetooth.rules" 70-bluetooth-pcmcia.rules || die

	exeinto /lib/udev/
	newexe "${FILESDIR}/${PN}-3.10.1-udev.script" bluetooth.sh || die
	doexe  "${S}/scripts/bluetooth_serial" || die
}

pkg_postinst() {
	udevcontrol reload_rules && udevtrigger

	elog
	elog "To use dial up networking you must install net-dialup/ppp."
	elog ""
	elog "Since 3.0 bluez has changed the passkey handling to use a dbus based"
	elog "API so please remember to update your /etc/bluetooth/hcid.conf."
	elog "For a password agent, there is for example net-wireless/bluez-gnome"
	elog "for gnome and net-wireless/kdebluetooth for kde."
	elog ""
	elog "Since 3.10.1 we don't install the old style daemons any more but rely"
	elog "on the new service architechture:"
	elog "	http://wiki.bluez.org/wiki/Services"
	elog ""
	elog "3.15 adds support for the audio service. See"
	elog "http://wiki.bluez.org/wiki/HOWTO/AudioDevices for configuration help."
	elog ""
	elog "Edit /etc/bluetooth/*.service to enable the services."
	elog "Use the old-daemons use flag to get the old daemons like hidd"
	elog "installed. Please note that the init script doesn't stop the old"
	elog "daemons after you update it so it's recommended to run:"
	elog "  /etc/init.d/bluetooth stop"
	elog "before updating your configuration files or you can manually kill"
	elog "the extra daemons you previously enabled in /etc/conf.d/bluetooth."
	elog ""
	elog "If you want to use rfcomm as a normal user, you need to add the user"
	elog "to the uucp group."
	elog ""
	if use old-daemons; then
		elog "The hidd init script was installed because you have the old-daemons"
		elog "use flag on. It is not started by default via udev so please add it"
		elog "to the required runleves using rc-update <runlevel> add hidd. If"
		elog "you need init scripts for the other daemons, please file requests"
		elog "to https://bugs.gentoo.org."
	else
		elog "The bluetooth service should be started automatically by udev"
		elog "when the required hardware is inserted next time."
	fi
}

--------------010500000503030602040805
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--------------010500000503030602040805
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--------------010500000503030602040805--
