Return-Path: <Steven.Singer@csr.com>
Message-ID: <40BC67F0.3030608@csr.com>
Date: Tue, 01 Jun 2004 12:26:40 +0100
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: cijoml@volny.cz, BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] CSR firmware
References: <200405290256.06151.cijoml@volny.cz>
    <1085820898.3932.6.camel@pegasus> <200405291108.06457.cijoml@volny.cz>
    <1085901284.12117.118.camel@pegasus>
In-Reply-To: <1085901284.12117.118.camel@pegasus>
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-users.lists.sourceforge.net>

Michal Semler wrote:
> have anybody downloaded firmware from csr dongle? I would like to make 
> research if is possible to change vendor ID in it and then flash it back. I 
> think it is possibly way to upgrade firmware in old dongles.

The vendor ID used for firmware upgrade is the USB vendor ID. That's
controllable with a PS key.

However, this doesn't help you as, as Marcel correctly pointed out:

Marcel Holtmann wrote:
: The problem is not the vendor ID. It is the digital signature of the
: firmware file. You can download everything you want onto your dongle,
: but it can happen that the boot loader don't boot the other firmware. In
: that case it will stay in DFU mode. The boot loader can only be changed
: over a SPI connection.

The firmware downloaded to the module is followed by a digital signature.
This uses a public key encryption method to verify that the firmware is
intact and suitable for the module.

The boot loader contains the manufacturer's public key. The manufacturer
signs the main firmware with their private key and appends the signature
to the firmware.

Any change anywhere in the firmware will change the signature and the
boot loader will refuse to run the firmware.

Changing the public key in the boot loader requires upgrading the boot
loader. This cannot be done over DFU. It can be done over SPI. It's not
clear, however, that this is a good thing. Not all firmware runs on all
modules. Even if it does, it may require special PS key settings. The
manufacturer is meant to test the firmware with the module and work out
the correct PS key settings. When they're happy, they package the
firmware and the PS settings into a DFU file and sign the whole lot with
their key. This is meant to prevent the end user from downloading
firmware that might damage their module, render it inoperative or even
crash it so bad that it can't be DFU'd any more.

For example, one of the things that can be in a DFU file is a short
program that controls how the module flashes its lights. Consider the
consequences of downloading firmware with a light flashing program onto
a module where those I/O lines are use to control an external power
amplifier for the radio.

> Can somebody give me help how download it? I have now access to 14 different 
> csr based dongles from different wendors, which have same firmware version. 
> So I'll try find differences in firmware.

There should be no difference in the firmware itself. There'll be a
block of words which differs for each signing key used.

What you may find, however, is that firmware from more than one
manufacturer uses the same signing key and hence has the same signature.
This may happen for two reasons:

  1) The dongle OEMs have obtained their modules from the same module
     manufacturer and it's the module manufacturer who has signed the
     firmware. In this case firmware for one OEM should run on the other
     OEM's module (provided the OEMs haven't tweaked the hardware too
     much).

  2) The module manufactuers have used firmware pre-signed by CSR.
     They're not supposed to do this, but if they're using our reference
     design then there's less chance that they'll need radically
     different PS key settings and so there's more chance that vanilla
     firmware will just work.

It might be worth gathering to gather information about which products
are signed with which keys. Something like:

  Group 1. Key: CSR
  CSR Casira
  FooCorp BT-USB-1
  FooCorp BT-USB-2
  BarCorp USB-BT-A

  Group 2. Key: module manufacturer Baz
  BlechCorp BUD-341AX
  QuuxCorp BTD-29314

  Others. (no shared keys)
  DougCorp ZZ9ZZA

You should also subdivide groups according to other things that might
affect whether firmware from one device in the group will run on
another, such as chip version, flash memory size and radio power
class.

>> That means, that if I download from dongle original firmware and then flash 
>> other one into dongle and it will not work I can't flash original fw back?
> 
> this is not quite right. It can happen that the boot loader will load
> your current firmware, but in case of a DFU download it will not accept
> its own firmware. Now your dongle will stay in DFU mode and it is
> useless. The only way to get the firmware back it through SPI.

Let me clarify further.

If you download firmware that fails the signature check then the module
will stay in DFU mode. You should then be able to use DFU to download
firmware that passes the signature check (such as an unmodified version
of the firmware you uploaded from the module).

Provided the DFU tool you're using on the host can cope with the dongle
already being in DFU mode at the start of the operation then it should
be OK.

The real problem, as I suggested above, is firmware that has the right
signature but is not designed for that module. In this case, the boot
loader thinks everything is OK and passes control to the firmware. The
firmware then crashes and control goes back to the boot loader and so
on. Neither the firmware nor the boot loader is running for long enough
to establish USB communications with the host. This is what signatures
are meant to prevent.

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
