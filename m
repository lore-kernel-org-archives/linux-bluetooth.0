Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Connection with a phone stays open after
	closingRFCOMM channel
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <C70061B183DE09419568AB2060C52A9518E71C@arion.intra.local>
References: <C70061B183DE09419568AB2060C52A9518E71C@arion.intra.local>
Content-Type: text/plain
Message-Id: <1109582825.17256.51.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 28 Feb 2005 10:27:05 +0100

Hi Victor,

> The log is below. The prog. on laptop listens on the HF channel,
> receives connection, sends 3 AT's, receiving responses, closes the
> channel, exits. On closing channel SE630 changes icon from HF to BT
> connected.

please try 2.6.11-rc5 and check what is in

	/proc/bluetooth/rfcomm/{dlc|sock}

Maybe the phones implementation is bad, but actually we can also close
the DLCI 0 at this time if no other RFCOMM channel is connected.

I don't have a SE 630 for testing and so it might be hard to get this
fixed this easy. However send me the application that you are using.

> > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
>   0000: 42 e4 11 de 0f 00 01                              B......

We don't decode this event :(

> < HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
>     handle 41 ptype 0xcc18
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
>   0000: 29 00 18 cc                                       )...

Something with the decoder is wrong here. Please send me the binary dump
created with "hcidump -w <file>".

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
