Return-Path: <James@superbug.demon.co.uk>
Message-ID: <3F0B3BE8.10008@superbug.demon.co.uk>
Date: Tue, 08 Jul 2003 22:47:20 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: Daryl Van Vorst <daryl@wideray.com>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>, "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>
Subject: Re: [Bluez-devel] Qualification testing - rfcomm
References: <001501c3457d$18b63a10$1a01010a@baked>
In-Reply-To: <001501c3457d$18b63a10$1a01010a@baked>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Daryl Van Vorst wrote:
> Marcel,
> 
> Finally got some results on those latest rfcomm changes for qualification.
> Looks like there are a few more problems. :(  But we're close. :)
> 
> TP/RFC/BV-09-C:
> "Verify that the IUT handles flow control correctly when the Tester, acting
> as a device conforming to Bluetooth version 1.0B, controls the data flow
> using the Modem Status Command. The IUT's device role is of no importance."
> 
> The command and console output:
> 
> root@jack-00000000:~>./rctest -s -P 1 -b 20 00:A0:96:1F:83:71
> rctest[351]: Connected
> rctest[351]: Sending ...
> rctest[351]: Send failed. Resource temporarily unavailable(11)
> 
> The IUT sends data in 5 frames, then stops for aboue 20s, then sends 5 more,
> then stops, etc. Technically, this test passed because we did stop sending
> data after the tester send MSC stop to the IUT. But something's clearly not
> right.
> 
> There is an hcidump of the session attached.
> 
> TP/RFC/BV-12-C:
> "Verify that the IUT handles aggregate flow control correctly when the
> Tester, acting as a device conforming to Bleutooth version 1.0B, controls
> the data flow using the Flow Control on/off commands FCon and FCoff. The
> IUT's device role is of no importance."
> 
> The command and console output:
> 
> root@jack-00000000:~>./rctest -s -P 1 -b 20 00:A0:96:1F:83:71
> rctest[362]: Connected
> rctest[362]: Sending ...
> rfcomm_recv_mcc: Unknown control type 0x18
> rfcomm_recv_mcc: Unknown control type 0x28
> 
> The IUT does not respond to FCoff with FCoff, and continues sending data. It
> also does not respond to FCon with FCon. 
> 
> There is an hcidump of the session attached.
> 
> -Daryl.

Any chance of doing some tests with SCO ?
It might help us with some of the currently problems there are with SCO 
and usb dongles.
Cheers
James
