Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] sdptool get <service record> output incomplete?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <C70061B183DE09419568AB2060C52A9518EE80@arion.intra.local>
References: <C70061B183DE09419568AB2060C52A9518EE80@arion.intra.local>
Content-Type: text/plain; charset=iso-8859-13
Message-Id: <1109772675.8284.5.camel@pegasus>
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
Date: Wed, 02 Mar 2005 15:11:15 +0100

Hi Victor,

> Is it the case that not all the attribute records are reported by
> sdptool? Below are the outputs: first of hcidump for the request from
> the phone for services supported (cut version showing only HF part)
> and the second one of =B4spdtool get <HF service record>=A1, attribute
> 0x311 is missing from sdptool output (marked unknown, but in reality
> it is SUPPORTED_FEATURES )?

maybe this is simply unknown at the moment. Do you use the latest utils
version? What about using the --tree option?

If it is missing, send in a patch for it.

> hcidump gives:
>=20
> =20
>=20
> HCI sniffer - Bluetooth packet analyzer ver 1.18
>=20
> device: hci0 snap_len: 1028 filter: 0xffffffff
>=20
> > ACL data: handle 41 flags 0x02 dlen 17

Please stop posting HTML emails to the mailing list. The newlines got
messed up and it makes everything hard to read. Good old plain ASCII is
just enough.

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
