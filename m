Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030805101803.0c38f768@unixmail.qualcomm.com>
Date: Tue, 05 Aug 2003 10:44:31 -0700
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>, BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] HCI USB driver and SCO support
In-Reply-To: <1059787251.22190.17.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 06:20 PM 8/1/2003, Marcel Holtmann wrote:
>Hi Max,
>
>the patch from Jonathan Paisley is working fine. I have tested it on
>2.4.18 to 2.4.21 and we can safely use two ISOC TX and RX URB's by
>default. 
Yep, I was going to apply his patch.

>But the configuration of the ISOC endpoint must be adjusted on
>demand. It depends on the voice setting and number of SCO connections,
>otherwise you won't hear any sound. At the moment we don't have access
>to these information from within the driver, so I started to extend the
>HCI core.
>
>The first patch introduces hdev->notify and reads the voice setting on
>device init and stores them in hdev->voice_setting for later use. With
>these modification a driver can be notified about added or deleted
>connections (ACL + SCO) and if the voice setting was changed.
I like the idea in general.

HCI_CONN_ADD should be something like HCI_NOTIFY_CONN_ADD.

>The second patch is for the HCI USB driver and it shows how to use
>hdev->notify. It also contains Jonathans modifications to use two ISOC
>TX and RX URB's and it keeps track of the number of ACL and SCO
>connections.
There is no need to count number of connections in the drivert. Core already 
has that counter (conn_hash.num). We just need to extend it to count ACL and 
SCO separately.

>In the next step, we must choose the correct ISOC configuration. The
>default one should be 0, because we don't use any SCO channel. It is
>also a good idea to start the ISOC and BULK transfers only if they are
>needed.
I think that's the way to go. Driver shouldn't start any BULK or ISOC transfers 
until core tells it so.

btw This stuff should go into 2.6 and not 2.4. 

Max
