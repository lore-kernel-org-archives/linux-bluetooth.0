Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] CSR firmware
From: Marcel Holtmann <marcel@holtmann.org>
To: Steven Singer <steven.singer@csr.com>
Cc: cijoml@volny.cz, BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <40BC8DC7.70809@csr.com>
References: <200405290256.06151.cijoml@volny.cz>
	 <1085820898.3932.6.camel@pegasus> <200405291108.06457.cijoml@volny.cz>
	 <1085901284.12117.118.camel@pegasus> <40BC67F0.3030608@csr.com>
	 <1086090904.4702.16.camel@pegasus>  <40BC8DC7.70809@csr.com>
Content-Type: text/plain
Message-Id: <1086101484.4702.47.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 01 Jun 2004 16:51:24 +0200

Hi Steven,

> > What we need to know is the public key of the boot loader, so we can
> > check the signature of the firmware file. Actually I don't know how to
> > do that, because we don't get access to the boot loader over USB or
> > UART.
> 
> I don't know of a way for you to get the public key out of the boot
> loader.

maybe over SPI, but then I don't need it anymore, because I can simply
replace the boot loader ;)

> > Is it easy to check if a firmware don't uses a signature? Will CSR
> > publish their public key?
> 
> There's not much point in us publishing our public key if you can't
> read it out of the loader to check.

The only point is to check if a firmware is signed with your key.

> It's been pointed out to me that as well as trashing the module or
> compromising the radio performance, putting the wrong firmware onto a
> module could compromise the USB performance and might take down the
> USB bus or the host itself (for example, some modules have I/O lines
> connected to the USB bus, some have them connected to an external radio
> amplifier, I can't imagine a host would take too kindly to having its
> USB lines toggled at 1600 Hz).
> 
> CSR is certainly not prepared to handle the volume of support calls
> that incorrect firmware is likely to generate and I suspect that the
> BlueZ developers, the Linux USB developers and Microsoft (if people
> plug their mutilated dongles into Windows PCs) are unwilling to handle
> the calls either.
> 
> Signing is meant to prevent these problems. Just because some module
> manufacturers have failed to implement it correctly does not mean that
> taking firmware from one of these modules (or another manufacturer's
> web site) and putting on another is a good thing.
> 
> It might be worth building a list of good module manufacturers/OEMs
> who regularly release up to date, tested and signed firmware.
> 
> [I know this is a change of position from my last mail, but the more
> I think about this, the less comfortable I am about putting firmware
> on modules it wasn't designed for.]

But the problem is that some manufacturers are very lazy. With the HCI
16.x firmware you reached a point, where I would say, that your firmware
can be used without any problems. Also for newer profiles like HID and
A2DP, but earlier versions had problems. One of the most annoying thing
is if you can't use a Bluetooth HID device, because the latency is too
bad. If you use an USB dongle, I would simply say that you should buy a
new one, but in case of a notebook you really got into troubles. I've
seen that Sony provides an update for some of their notebooks and it
should be possible to extract the DFU file, but in the case of some IBM
notebooks you are lost.

However right now there is no easy way to download a new DFU file into a
CSR dongle. So even if the module/dongle/notebook manufacturer gives you
the right firmware file, you can do an update with Linux. Actually I had
written some code for it, but non of it is public at the moment and I
don't wanna publish it.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
