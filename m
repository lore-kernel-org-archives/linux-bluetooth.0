Return-Path: <SRS0+7abe75bf9b19a3b2e46b+354+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Subject: RE: [Bluez-devel] Alignment issue
From: David Woodhouse <dwmw2@infradead.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Daryl Van Vorst <daryl@wideray.com>,
   "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1092308407.28711.99.camel@pegasus>
References: <001201c47fc2$7093e4a0$1301010a@baked>
	 <1092252699.4564.238.camel@pegasus>
	 <1092299689.4622.8.camel@imladris.demon.co.uk>
	 <1092302834.28711.72.camel@pegasus>
	 <1092304890.15466.44.camel@hades.cambridge.redhat.com>
	 <1092306154.28711.85.camel@pegasus>
	 <1092306935.15466.74.camel@hades.cambridge.redhat.com>
	 <1092308407.28711.99.camel@pegasus>
Content-Type: text/plain
Message-Id: <1092310391.15466.178.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Thu, 12 Aug 2004 12:33:11 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

On Thu, 2004-08-12 at 13:00 +0200, Marcel Holtmann wrote:
> I am not familiar with PIE. Is it correct that it stands for "position
> independent executables"?

Indeed -- and that's about as much as I know too, I'm afraid. It's to
allow random load addresses, to reduce the chance of successful buffer
overflow attacks -- if the executable is loaded at a random address, you
don't have known functions at known addresses which the shellcode can
call. I think.

> Do you have a link to the source and binary RPM's for me?

http://download.fedora.redhat.com/pub/fedora/linux/core/development/i386/SRPMS/
http://download.fedora.redhat.com/pub/fedora/linux/core/development/i386/Fedora/RPMS/

> Looks fine so far. I hope you checked the new --enable commands in
> bluez-utils-2.9, because I made many stuff optional.

Briefly. I think I enabled everything, and made a note to look closer at
the firmware stuff.

> The bluez-bluefw is deprecated. Please use bluez-firmware instead and
> enable bcm203x program in bluez-utils if you need it (for 2.4 kernels
> only). Splitting up a bluez-utils-bcm203x could be useful.

I looked very briefly at that -- does it also support loading firmware
in the PCMCIA cards? Is this the future instead of request_firmware()?
Why so?

> Actually even Debian and SuSE ship other init scripts and that is fine
> for me. Do you think a --disable-initscripts option would make the life
> of the package maintainers easier?

I don't think it makes a lot of difference, to be honest -- although if
so many distributions are shipping separate initscripts perhaps we
should collaborate a bit more closely?

> > /me shudders. Autocrap considered harmful. You break cross-compilation
> > if you try to do that. I'd much prefer just to write portable code.
> 
> You are right. I forgot to think about cross-compilation.

Users of autoconf often do -- when porting the distro to embedded
machines and trying to cross-build it, autoconf was the single largest
problem I encountered. 

-- 
dwmw2
