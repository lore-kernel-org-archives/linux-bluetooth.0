Return-Path: <SRS0+bb95d8377eff4cb4d0f0+262+infradead.org+dwmw2@pentafluge-151130.srs.infradead.org>
Subject: Re: [Bluez-devel] autoconf breaks portability. Film at 11.
From: David Woodhouse <dwmw2@infradead.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1084369703.25099.56.camel@pegasus>
References: <1084268833.11301.0.camel@hades.cambridge.redhat.com>
	 <1084368666.25099.38.camel@pegasus>
	 <1084369122.4426.106.camel@hades.cambridge.redhat.com>
	 <1084369703.25099.56.camel@pegasus>
Content-Type: text/plain
Message-Id: <1084371089.4426.148.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Wed, 12 May 2004 15:11:29 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

On Wed, 2004-05-12 at 15:48 +0200, Marcel Holtmann wrote:
> if you can tell me how to disable C++ and Fortran checking I am glad to
> include it ;)

I sent you proper Makefiles a long time ago. You didn't apply them :)

This is what I get on Fedora Core 2 on both i386 and PPC, btw:

hades /hades/bluez/libs2 $ ./bootstrap
configure.in: installing `./install-sh'
configure.in: installing `./missing'
configure.in:19: installing `./config.guess'
configure.in:19: installing `./config.sub'
configure.in:19: required file `./ltmain.sh' not found
compat/Makefile.am: installing `./depcomp'


> > Btw, swave() in hciattach still uses 10 characters of a 9-char array. 
> 
> Fixed in CVS now.

OK, you can have another one then :)

On PPC, the HCI/LMP version numbers and manufacturer code are
byte-swapped in hciconfig from utils2. hciconfig from bluez-utils-2.7
gives:

        HCI Ver: 1.2 (0x2) HCI Rev: 0x4d9 LMP Ver: 1.2 (0x2) LMP Subver: 0x4d9
        Manufacturer: Cambridge Silicon Radio (10)
 
... while hciconfig from utils2 gives:

        HCI Ver: 1.2 (0x2) HCI Rev: 0xd904  LMP Ver: 1.2 (0x2) LMP Subver: 0xd904
        Manufacturer: not assigned (2560)

-- 
dwmw2
