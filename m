Return-Path: <Steven.Singer@csr.com>
Message-ID: <40BC8DC7.70809@csr.com>
Date: Tue, 01 Jun 2004 15:08:07 +0100
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: cijoml@volny.cz, BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] CSR firmware
References: <200405290256.06151.cijoml@volny.cz>
    <1085820898.3932.6.camel@pegasus> <200405291108.06457.cijoml@volny.cz>
    <1085901284.12117.118.camel@pegasus> <40BC67F0.3030608@csr.com>
    <1086090904.4702.16.camel@pegasus>
In-Reply-To: <1086090904.4702.16.camel@pegasus>
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-users.lists.sourceforge.net>

Marcel Holtmann wrote:
>                                    [...] Hopefully the next guy who is
> asking such questions will read the mailing list archive first ;)

But that trick never works.

>> It might be worth gathering to gather information about which products
>> are signed with which keys. Something like:
[...]
> What we need to know is the public key of the boot loader, so we can
> check the signature of the firmware file. Actually I don't know how to
> do that, because we don't get access to the boot loader over USB or
> UART.

I don't know of a way for you to get the public key out of the boot
loader.

> Is it easy to check if a firmware don't uses a signature? Will CSR
> publish their public key?

There's not much point in us publishing our public key if you can't
read it out of the loader to check.

It's been pointed out to me that as well as trashing the module or
compromising the radio performance, putting the wrong firmware onto a
module could compromise the USB performance and might take down the
USB bus or the host itself (for example, some modules have I/O lines
connected to the USB bus, some have them connected to an external radio
amplifier, I can't imagine a host would take too kindly to having its
USB lines toggled at 1600 Hz).

CSR is certainly not prepared to handle the volume of support calls
that incorrect firmware is likely to generate and I suspect that the
BlueZ developers, the Linux USB developers and Microsoft (if people
plug their mutilated dongles into Windows PCs) are unwilling to handle
the calls either.

Signing is meant to prevent these problems. Just because some module
manufacturers have failed to implement it correctly does not mean that
taking firmware from one of these modules (or another manufacturer's
web site) and putting on another is a good thing.

It might be worth building a list of good module manufacturers/OEMs
who regularly release up to date, tested and signed firmware.

[I know this is a change of position from my last mail, but the more
I think about this, the less comfortable I am about putting firmware
on modules it wasn't designed for.]

	- Steven
-- 



**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

This footnote also confirms that this email message has been swept by
MIMEsweeper for the presence of computer viruses.

www.mimesweeper.com
**********************************************************************
