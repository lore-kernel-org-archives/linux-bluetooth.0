Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] CSR firmware
From: Marcel Holtmann <marcel@holtmann.org>
To: Steven Singer <steven.singer@csr.com>
Cc: cijoml@volny.cz, BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <40BC67F0.3030608@csr.com>
References: <200405290256.06151.cijoml@volny.cz>
	 <1085820898.3932.6.camel@pegasus> <200405291108.06457.cijoml@volny.cz>
	 <1085901284.12117.118.camel@pegasus>  <40BC67F0.3030608@csr.com>
Content-Type: text/plain
Message-Id: <1086090904.4702.16.camel@pegasus>
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
Date: Tue, 01 Jun 2004 13:55:04 +0200

Hi Steven,

thanks again for a detailed explanation. Hopefully the next guy who is
asking such questions will read the mailing list archive first ;)

> What you may find, however, is that firmware from more than one
> manufacturer uses the same signing key and hence has the same signature.
> This may happen for two reasons:
> 
>   1) The dongle OEMs have obtained their modules from the same module
>      manufacturer and it's the module manufacturer who has signed the
>      firmware. In this case firmware for one OEM should run on the other
>      OEM's module (provided the OEMs haven't tweaked the hardware too
>      much).
> 
>   2) The module manufactuers have used firmware pre-signed by CSR.
>      They're not supposed to do this, but if they're using our reference
>      design then there's less chance that they'll need radically
>      different PS key settings and so there's more chance that vanilla
>      firmware will just work.
> 
> It might be worth gathering to gather information about which products
> are signed with which keys. Something like:
> 
>   Group 1. Key: CSR
>   CSR Casira
>   FooCorp BT-USB-1
>   FooCorp BT-USB-2
>   BarCorp USB-BT-A
> 
>   Group 2. Key: module manufacturer Baz
>   BlechCorp BUD-341AX
>   QuuxCorp BTD-29314
> 
>   Others. (no shared keys)
>   DougCorp ZZ9ZZA
> 
> You should also subdivide groups according to other things that might
> affect whether firmware from one device in the group will run on
> another, such as chip version, flash memory size and radio power
> class.

I like this idea and once I started adding code to btdfu that is capable
of decoding the CSR firmware structure. However I never finished it,
because the need for it was not really there.

What we need to know is the public key of the boot loader, so we can
check the signature of the firmware file. Actually I don't know how to
do that, because we don't get access to the boot loader over USB or
UART.

Is it easy to check if a firmware don't uses a signature? Will CSR
publish their public key?

> If you download firmware that fails the signature check then the module
> will stay in DFU mode. You should then be able to use DFU to download
> firmware that passes the signature check (such as an unmodified version
> of the firmware you uploaded from the module).
> 
> Provided the DFU tool you're using on the host can cope with the dongle
> already being in DFU mode at the start of the operation then it should
> be OK.
> 
> The real problem, as I suggested above, is firmware that has the right
> signature but is not designed for that module. In this case, the boot
> loader thinks everything is OK and passes control to the firmware. The
> firmware then crashes and control goes back to the boot loader and so
> on. Neither the firmware nor the boot loader is running for long enough
> to establish USB communications with the host. This is what signatures
> are meant to prevent.

I really see what I wrote. Actually I haven't used the DFU tool for that
operation, because I was writing my own DFU download part for btdfu. I
uploaded the existing firmware and then I started to download it back to
the dongle with my own software. After the download process finished the
DFU rejects this firmware. So it stays in DFU mode and was unable to get
back into a working state.

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
