Return-Path: <SRS0+7abe75bf9b19a3b2e46b+354+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Subject: RE: [Bluez-devel] Alignment issue
From: David Woodhouse <dwmw2@infradead.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Daryl Van Vorst <daryl@wideray.com>,
   "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1092306154.28711.85.camel@pegasus>
References: <001201c47fc2$7093e4a0$1301010a@baked>
	 <1092252699.4564.238.camel@pegasus>
	 <1092299689.4622.8.camel@imladris.demon.co.uk>
	 <1092302834.28711.72.camel@pegasus>
	 <1092304890.15466.44.camel@hades.cambridge.redhat.com>
	 <1092306154.28711.85.camel@pegasus>
Content-Type: text/plain
Message-Id: <1092306935.15466.74.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Thu, 12 Aug 2004 11:35:36 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

On Thu, 2004-08-12 at 12:22 +0200, Marcel Holtmann wrote:
> btw what is the status of BlueZ for Fedora Core. Currently I know the
> status of them for Debian and SuSE. Are there any extra patches that I
> must know of? 

We have a patch to make various daemons build PIE and we mangle the
defaults in some config files -- other than that nothing interesting. I
went through it all quite recently and made sure you had the one or two
other patches that made sense.

> How do you split the bluez-utils into different packages?

We have these packages:
	bluez-bluefw-1.0-5.ppc.rpm
	bluez-hcidump-1.10-1.ppc.rpm
	bluez-libs-2.9-1.ppc.rpm
	bluez-libs-devel-2.9-1.ppc.rpm
	bluez-pin-0.23-2.ppc.rpm
	bluez-utils-2.9-1.ppc.rpm
	bluez-utils-cups-2.9-1.ppc.rpm

We do split the bluez-utils init scripts up, as discussed a few weeks
ago. I have patches outstanding for initscripts which make 'ifup bnep0'
responsible for starting pand, to make it just like a normal interface
-- even pppd is started that way, not by an initscript.

> > Autocrap considered harmful; I'd rather let the compiler do it.
> 
> Actually I meant to let autoconf compile some test code, then run it and
> analyse that result.

/me shudders. Autocrap considered harmful. You break cross-compilation
if you try to do that. I'd much prefer just to write portable code.

> For now I will use memmove, but we need clarification on this. I lost my
> Sun Ultra system, so I can't do any tests.

We keep our compiler-dudes in the US mostly so they're sleeping. I'll
poke one when they wake up.

-- 
dwmw2
