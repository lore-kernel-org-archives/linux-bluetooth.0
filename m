Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Alignment issue
From: Marcel Holtmann <marcel@holtmann.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Daryl Van Vorst <daryl@wideray.com>,
   "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1092306935.15466.74.camel@hades.cambridge.redhat.com>
References: <001201c47fc2$7093e4a0$1301010a@baked>
	 <1092252699.4564.238.camel@pegasus>
	 <1092299689.4622.8.camel@imladris.demon.co.uk>
	 <1092302834.28711.72.camel@pegasus>
	 <1092304890.15466.44.camel@hades.cambridge.redhat.com>
	 <1092306154.28711.85.camel@pegasus>
	 <1092306935.15466.74.camel@hades.cambridge.redhat.com>
Content-Type: text/plain
Message-Id: <1092308407.28711.99.camel@pegasus>
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
Date: Thu, 12 Aug 2004 13:00:07 +0200

Hi David,

> > btw what is the status of BlueZ for Fedora Core. Currently I know the
> > status of them for Debian and SuSE. Are there any extra patches that I
> > must know of? 
> 
> We have a patch to make various daemons build PIE and we mangle the
> defaults in some config files -- other than that nothing interesting. I
> went through it all quite recently and made sure you had the one or two
> other patches that made sense.

I am not familiar with PIE. Is it correct that it stands for "position
independent executables"?

Do you have a link to the source and binary RPM's for me?

> > How do you split the bluez-utils into different packages?
> 
> We have these packages:
> 	bluez-bluefw-1.0-5.ppc.rpm
> 	bluez-hcidump-1.10-1.ppc.rpm
> 	bluez-libs-2.9-1.ppc.rpm
> 	bluez-libs-devel-2.9-1.ppc.rpm
> 	bluez-pin-0.23-2.ppc.rpm
> 	bluez-utils-2.9-1.ppc.rpm
> 	bluez-utils-cups-2.9-1.ppc.rpm

Looks fine so far. I hope you checked the new --enable commands in
bluez-utils-2.9, because I made many stuff optional.

The bluez-bluefw is deprecated. Please use bluez-firmware instead and
enable bcm203x program in bluez-utils if you need it (for 2.4 kernels
only). Splitting up a bluez-utils-bcm203x could be useful.

> We do split the bluez-utils init scripts up, as discussed a few weeks
> ago. I have patches outstanding for initscripts which make 'ifup bnep0'
> responsible for starting pand, to make it just like a normal interface
> -- even pppd is started that way, not by an initscript.

Actually even Debian and SuSE ship other init scripts and that is fine
for me. Do you think a --disable-initscripts option would make the life
of the package maintainers easier?

> > > Autocrap considered harmful; I'd rather let the compiler do it.
> > 
> > Actually I meant to let autoconf compile some test code, then run it and
> > analyse that result.
> 
> /me shudders. Autocrap considered harmful. You break cross-compilation
> if you try to do that. I'd much prefer just to write portable code.

You are right. I forgot to think about cross-compilation.

> > For now I will use memmove, but we need clarification on this. I lost my
> > Sun Ultra system, so I can't do any tests.
> 
> We keep our compiler-dudes in the US mostly so they're sleeping. I'll
> poke one when they wake up.

That would be great.

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
