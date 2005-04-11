Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Reopening RFCOMM socket
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <C70061B183DE09419568AB2060C52A95324E4F@arion.intra.local>
References: <C70061B183DE09419568AB2060C52A95324E4F@arion.intra.local>
Content-Type: text/plain
Message-Id: <1113224551.9655.43.camel@pegasus>
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
Date: Mon, 11 Apr 2005 15:02:31 +0200

Hi Victor,

> In the quoted message below you say "If no other session is active the
> underlaying ACL link will be terminated." It looks as if it does not
> happen immediatelly. So there is a chance that if you open a new RFCOMM
> socket very fast it will not bring down ACL link and will actually reuse
> it? Cause I have a problem with Motorola V3, I bring down HF RFCOMM
> socket (the only one active at the time) and then open DUN channel and
> start pppd over it. And unless I see HCI disconnect for a underlaying
> ACL link in hcidump log after closing HF RFCOMM, DUN RFCOMM becomes very
> slow (takes much time to push/pull a packet to/from the phone). May be
> some flow control issues?

the ACL has a disconnect timeout of 2 seconds if we created that link
and 4 seconds if the remote side connected to us. This is needed,
because the only expensive thing with Bluetooth is the creation of the
ACL links and we want to avoid it as often as possible.

Please send in the part of "hcidump -X -V" for the V3. I really think
that this is a phone problem. Maybe their RFCOMM credits handling is
broken and they only reset it after a HCI disconnect.

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
