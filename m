Return-Path: <SRS0+7abe75bf9b19a3b2e46b+354+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Subject: RE: [Bluez-devel] Alignment issue
From: David Woodhouse <dwmw2@infradead.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Daryl Van Vorst <daryl@wideray.com>,
   "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1092311388.28711.117.camel@pegasus>
References: <001201c47fc2$7093e4a0$1301010a@baked>
	 <1092252699.4564.238.camel@pegasus>
	 <1092299689.4622.8.camel@imladris.demon.co.uk>
	 <1092302834.28711.72.camel@pegasus>
	 <1092304890.15466.44.camel@hades.cambridge.redhat.com>
	 <1092306154.28711.85.camel@pegasus>
	 <1092306935.15466.74.camel@hades.cambridge.redhat.com>
	 <1092308407.28711.99.camel@pegasus>
	 <1092310391.15466.178.camel@hades.cambridge.redhat.com>
	 <1092311388.28711.117.camel@pegasus>
Content-Type: text/plain
Message-Id: <1092312127.15466.211.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Thu, 12 Aug 2004 13:02:07 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

On Thu, 2004-08-12 at 13:49 +0200, Marcel Holtmann wrote:
> is it worth to include such a patch and make it optional?

Yes, I suspect it would. I'll have a look at it when I get a spare
moment and offer you a patch.

> The loading of the firmware for the 3Com PCMCIA card and the BlueFRITZ!
> USB dongle are done through request_firmware(). The Broadcom based
> dongles are an exception. I personal prefer to use the bcm203x kernel
> driver for loading the firmware, but this is a 2.6 only feature.

2.6-only is _fine_. Isn't 2.4 dead yet? I'll make sure we build the
bcm203x driver and just drop bluez-bluefw.

> The bluez-firmware package only contains the Broadcom firmware files and
> it will install them by default under /lib/firmware. You need a modified
> firmware.agent script that also looks for firmware files in that place.
> We agreed on that path, but this change is not upstream at the moment.
> Check the Debian packages for an example of a modified script.

The standard place to put firmware files is /usr/lib/hotplug/firmware
isn't it? Is there a reason for using a different path? Can you
elaborate on the meaning of 'We' in the above context?

> I think it is too late for Debian Sarge and SuSE 9.2 and maybe even for
> Fedora Core 3, but actually we should really talk about it.

OK... well what I've done is split into four separate init scripts, each
of which can be separately enabled or disabled with chkconfig or
whichever pretty tool the user likes for selecting which services are
run in each runlevel. I have removed dund, hidd and pand into their own
scripts. As I said, I'd like to remove the need for running pand as a
daemon like that anyway -- it should be handled by the network
ifup/ifdown scripts like pppd is. I have never really looked at dund but
I suspect the same goes for that. 

-- 
dwmw2
