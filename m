Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] HCI USB driver and SCO support
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5.1.0.14.2.20030805101803.0c38f768@unixmail.qualcomm.com>
References: <5.1.0.14.2.20030805101803.0c38f768@unixmail.qualcomm.com>
Message-Id: <1060121840.935.25.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 06 Aug 2003 00:17:14 +0200
Content-Type: text/plain

Hi Max,

> >the patch from Jonathan Paisley is working fine. I have tested it on
> >2.4.18 to 2.4.21 and we can safely use two ISOC TX and RX URB's by
> >default. 
> Yep, I was going to apply his patch.

but without choosing the correct ISOC alternate setting it is useless :(

> >But the configuration of the ISOC endpoint must be adjusted on
> >demand. It depends on the voice setting and number of SCO connections,
> >otherwise you won't hear any sound. At the moment we don't have access
> >to these information from within the driver, so I started to extend the
> >HCI core.
> >
> >The first patch introduces hdev->notify and reads the voice setting on
> >device init and stores them in hdev->voice_setting for later use. With
> >these modification a driver can be notified about added or deleted
> >connections (ACL + SCO) and if the voice setting was changed.
> I like the idea in general.
> 
> HCI_CONN_ADD should be something like HCI_NOTIFY_CONN_ADD.

I will change this and push it to my Bitkeeper repository.

> >The second patch is for the HCI USB driver and it shows how to use
> >hdev->notify. It also contains Jonathans modifications to use two ISOC
> >TX and RX URB's and it keeps track of the number of ACL and SCO
> >connections.
> There is no need to count number of connections in the drivert. Core already 
> has that counter (conn_hash.num). We just need to extend it to count ACL and 
> SCO separately.

Is it worth to change this? The only driver who needs it at the moment
will be hci_usb.o and it can count the stuff by itself.

> >In the next step, we must choose the correct ISOC configuration. The
> >default one should be 0, because we don't use any SCO channel. It is
> >also a good idea to start the ISOC and BULK transfers only if they are
> >needed.
> I think that's the way to go. Driver shouldn't start any BULK or ISOC transfers 
> until core tells it so.

I have some successful results with starting and stopping ISOC URB's,
but this code was not based on the hdev->notify architecture.

> btw This stuff should go into 2.6 and not 2.4. 

At the moment I switched my development machine back to 2.4, because the
2.6 was out of date (hint) and I have to do the next round of my -mh
patches.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
