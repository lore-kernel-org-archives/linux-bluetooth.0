Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] RFCOMM connection loss on SCO disconnect
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <C70061B183DE09419568AB2060C52A952465AC@arion.intra.local>
References: <C70061B183DE09419568AB2060C52A952465AC@arion.intra.local>
Content-Type: text/plain
Message-Id: <1111481265.22872.96.camel@pegasus>
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
Date: Tue, 22 Mar 2005 09:47:45 +0100

Hi Victor,

> In the attachment there is complete log (right from the establishment of
> the very first connection), looks like the phone issues DISC for RFCOMM.
> This happens only if SCO connection is there. Disabling SCO ( when we
> ignore connect request) "fixes" the problem, but unfortunatelly this is
> not acceptable. I'm going to check if it can be fixed in some way or
> another...

if the phone says DISC we can't do anything. Maybe that is their way of
interpreting the handsfree profile. I think you have to live with it and
simply reconnect the RFCOMM channel after the disconnect.

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
