Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] RFCOMM bug?
From: Marcel Holtmann <marcel@holtmann.org>
To: Andy Ross <andy@plausible.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <40329CA6.7080302@mdolabs.com>
References: <40329CA6.7080302@mdolabs.com>
Content-Type: text/plain
Message-Id: <1077060827.2665.137.camel@pegasus>
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
Date: Wed, 18 Feb 2004 00:33:47 +0100

Hi Andy,

> I'm having some trouble with the bluez implementation as distributed
> with fedora.  I thought for a long time that this was a bug on the
> device (Ericsson P900 / Symbian 7.0) side of the connection, but it's
> now looking like a kernel issue on the linux box.
> 
> The app on the other side is a simple RFCOMM echoer.  It reads a byte
> at a time and writes it back out to the socket.  I'm connecting to it
> with a "cat /dev/rfcomm1", while I do a "echo a > /dev/rfcomm1" from
> another shell.  What comes back is an unending spew of bytes, mostly
> (but oddly not entirely) derived from the "a\r\n" that went out the
> terminal initially.
> 
> FWIW, I see almost identical behavior when connecting to the "modem"
> device on the phone.  The AT command work (in the sense that I can see
> the desired output appear on the socket), but come back as part of an
> infinite garbage stream.

set the RFCOMM terminal device into raw mode and everything works fine.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
