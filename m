Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Alignment issue
From: Marcel Holtmann <marcel@holtmann.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Daryl Van Vorst <daryl@wideray.com>,
   "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1092310391.15466.178.camel@hades.cambridge.redhat.com>
References: <001201c47fc2$7093e4a0$1301010a@baked>
	 <1092252699.4564.238.camel@pegasus>
	 <1092299689.4622.8.camel@imladris.demon.co.uk>
	 <1092302834.28711.72.camel@pegasus>
	 <1092304890.15466.44.camel@hades.cambridge.redhat.com>
	 <1092306154.28711.85.camel@pegasus>
	 <1092306935.15466.74.camel@hades.cambridge.redhat.com>
	 <1092308407.28711.99.camel@pegasus>
	 <1092310391.15466.178.camel@hades.cambridge.redhat.com>
Content-Type: text/plain
Message-Id: <1092311388.28711.117.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 12 Aug 2004 13:49:48 +0200

Hi David,

> > I am not familiar with PIE. Is it correct that it stands for "position
> > independent executables"?
> 
> Indeed -- and that's about as much as I know too, I'm afraid. It's to
> allow random load addresses, to reduce the chance of successful buffer
> overflow attacks -- if the executable is loaded at a random address, you
> don't have known functions at known addresses which the shellcode can
> call. I think.

is it worth to include such a patch and make it optional?

> > Looks fine so far. I hope you checked the new --enable commands in
> > bluez-utils-2.9, because I made many stuff optional.
> 
> Briefly. I think I enabled everything, and made a note to look closer at
> the firmware stuff.

I put myself an --enable-all option in for testing ;)

> > The bluez-bluefw is deprecated. Please use bluez-firmware instead and
> > enable bcm203x program in bluez-utils if you need it (for 2.4 kernels
> > only). Splitting up a bluez-utils-bcm203x could be useful.
> 
> I looked very briefly at that -- does it also support loading firmware
> in the PCMCIA cards? Is this the future instead of request_firmware()?
> Why so?

The loading of the firmware for the 3Com PCMCIA card and the BlueFRITZ!
USB dongle are done through request_firmware(). The Broadcom based
dongles are an exception. I personal prefer to use the bcm203x kernel
driver for loading the firmware, but this is a 2.6 only feature. You can
also load the firmware with a userspace program. The bluefw was too
messy to stay any time longer and so I rewrote it to only support the
Broadcom dongles and the result is the bcm203x tool.

The bluez-firmware package only contains the Broadcom firmware files and
it will install them by default under /lib/firmware. You need a modified
firmware.agent script that also looks for firmware files in that place.
We agreed on that path, but this change is not upstream at the moment.
Check the Debian packages for an example of a modified script.

> > Actually even Debian and SuSE ship other init scripts and that is fine
> > for me. Do you think a --disable-initscripts option would make the life
> > of the package maintainers easier?
> 
> I don't think it makes a lot of difference, to be honest -- although if
> so many distributions are shipping separate initscripts perhaps we
> should collaborate a bit more closely?

I think it is too late for Debian Sarge and SuSE 9.2 and maybe even for
Fedora Core 3, but actually we should really talk about it.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
