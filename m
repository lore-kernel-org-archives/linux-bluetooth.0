Return-Path: <pkg-bluetooth-maintainers-bounces@lists.alioth.debian.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20060905103207.GC30274@esaurito.net>
References: <20060903124043.2028.48247.reportbug@forza>
	<1157367160.32195.54.camel@aeonflux.holtmann.net>
	<20060904100025.GA17058@esaurito.net>
	<1157371912.32195.69.camel@aeonflux.holtmann.net>
	<20060905103207.GC30274@esaurito.net>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 13:07:31 +0200
Message-Id: <1157454451.4206.17.camel@localhost>
Mime-Version: 1.0
Subject: Bug#385857: [Bluez-devel] Bug#385857: [Pkg-bluetooth-maintainers]
	Bug#385857: please upgrade to bluez-utils and bluez-libs 3.4
Cc: Flavio Stanchina <flavio@stanchina.net>, 385857@bugs.debian.org,
        bluez-devel@lists.sf.net
Reply-To: Marcel Holtmann <marcel@holtmann.org>, 385857@bugs.debian.org
List-Unsubscribe: <http://lists.alioth.debian.org/mailman/listinfo/pkg-bluetooth-maintainers>,
	<mailto:pkg-bluetooth-maintainers-request@lists.alioth.debian.org?subject=unsubscribe>
List-Archive: <http://lists.alioth.debian.org/pipermail/pkg-bluetooth-maintainers>
List-Post: <mailto:pkg-bluetooth-maintainers@lists.alioth.debian.org>
List-Help: <mailto:pkg-bluetooth-maintainers-request@lists.alioth.debian.org?subject=help>
List-Subscribe: <http://lists.alioth.debian.org/mailman/listinfo/pkg-bluetooth-maintainers>,
	<mailto:pkg-bluetooth-maintainers-request@lists.alioth.debian.org?subject=subscribe>
Sender: pkg-bluetooth-maintainers-bounces@lists.alioth.debian.org
Errors-To: pkg-bluetooth-maintainers-bounces@lists.alioth.debian.org
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Filippo,

> > > > > bluez-libs compiled out of the box by just unpacking and moving the
> > > > > debian directory over, but bluez-utils needs some work:
> > > > > 
> > > > > * remove bluez-bcm203x package (bcm203x firmware loader removed upstream)
> > > > 
> > > > Not needed at all. You don't wanna support a 2.4 kernel and even if you
> > > > really want to, you won't find any of these devices anymore. For all 2.6
> > > > kernels the bcm203x kernel module takes care of loading the firmware.
> > > 
> > > I'm going to drop it after etch release when we'll discontinue support for 2.4
> > > kernels.
> > 
> > You can drop it now actually. A Liunx 2.4 kernel user and owner of this
> > device is a really really unlikely combination. I mean it. It would take
> > me at least a couple of hours to find my dongle.
> 
> good luck with finding your dongle :)
> anyway, as rare as it is etch is going to support 2.4 kernels.

your choice, but it is no longer part of bluez-utils.

> > > > This package has to die and from an USB and udev perspective it was a
> > > > really nasty hack.
> > > > 
> > > > > * remove 000_rfcomm_conf_example.patch: the example is already commented
> > > > > * remove 004_rfcomm_usage.patch: applied upstream
> > > > 
> > > > Sometimes it is a good idea to feed patches back to upstream so I don't
> > > > have to extract them from the packages.
> > > 
> > > yep, I'm used to do it, I must have overlooked these patches.
> > 
> > Do you have any other patches that are not upstream?
> 
> I'm looking at them one by one, bluez debian packages are maintained with svn.
> You can browse the patches for bluez-utils at
> http://svn.debian.org/wsvn/pkg-bluetooth/bluez-utils/trunk/debian/patches/?rev=0&sc=0
> 
> you might be interested in:
> 
> http://svn.debian.org/wsvn/pkg-bluetooth/bluez-utils/trunk/debian/patches/007_hcid_typo.patch?op=file&rev=0&sc=0
> which fixes a small typo in hcid
> 
> http://svn.debian.org/wsvn/pkg-bluetooth/bluez-utils/trunk/debian/patches/008_pand_man.patch?op=file&rev=0&sc=0
> addition for pand manpage referring /etc/bluetooth/pan/dev-up execution

These two patches were already in the CVS.

> http://svn.debian.org/wsvn/pkg-bluetooth/bluez-utils/trunk/debian/patches/006_xsims.patch?op=file&rev=0&sc=0
> more compatible usage of test in bluetooth.init and hsplay

Added this one. This will get you down to two.

> > And please drop your passkey agent think completely. This will be
> > distribution specific and can't be a solution. It is better to put the
> > passkey-agent.c example in the docs directory as an example and mention
> > it in a README.Debian.
> > 
> > That said. I am missing a package for bluez-gnome which contains the
> > graphical passkey agent. New version is coming up also this week. It
> > will fix a small glitch with the status icon.
> 
> indeed, how about this plan:
> 
> - I will add to bluez-utils a default non-interactive passkey agent (more or less
>   like now but less hackish) which uses /etc/bluetooth/passkeys/<bt_addr> like
>   now

Doesn't make sense, because it is distro specific and you duplicate
functionality that is already present. Don't do this. This stuff must
die. I am serious about it.

> - bluez-gnome will provide the graphical passkey agent which takes over the
>   non-interactive one

Make sure you deprecate bluez-pin, because that one is no longer working
or even useful at all.

> Marcel: can agents be "stackable", that is, if two agents are registered and
> first one doesn't supply an answer, the second will?

The default passkey agent (like bt-applet) is not stackable. There
should be only one default passkey agent and that one should be provided
by the Desktop environment (like GNOME, KDE etc.). However you can have
multiple device specific agents for connection wizards or other
situations where you expect a PIN request.

Regards

Marcel




_______________________________________________
Pkg-bluetooth-maintainers mailing list
Pkg-bluetooth-maintainers@lists.alioth.debian.org
http://lists.alioth.debian.org/mailman/listinfo/pkg-bluetooth-maintainers
