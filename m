Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] RFCOMM connection loss on SCO disconnect
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Cc: victor.shcherbatyuk@tomtom.com
In-Reply-To: <Pine.LNX.4.44.0503180007380.11381-300000@antilope>
References: <Pine.LNX.4.44.0503180007380.11381-300000@antilope>
Content-Type: text/plain
Message-Id: <1111160332.9600.21.camel@pegasus>
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
Date: Fri, 18 Mar 2005 16:38:52 +0100

Hi Victor,

> I have the following problem. A device running bluez is configured to be 
> HF. 
> At the moment of incoming call, the deivece is connected to the phone (AG) 
> on RFCOMM channel, while listening on SCO channel. From this moment 
> there are two scenarios. 
> 1) With the phones supporting in-band ringing, the phone opens SCO 
> channel to the device and starting to send a ring tone over SCO while 
> sending RING over RFCOMM
> 2) With the phones not supporting in-band ringing, RING is sent over 
> RFCOMM, and when we pick-up, SCO channel is open from the phone to the 
> device.
> 
> The problem comes when I hang up from the calling side after a 
> conversation is finished. The phones 2) close? SCO channel, and leave 
> RFCOMM channel open, while the phones 1) close SCO channel and then the 
> device sends disconnect for the RFCOMM channel handle, breaking RFCOMM 
> link. ( I might be mistaking interpretating the log... ) I do not really 
> expect the RFCOMM to be disconnected, as I still need to be able to send 
> some ATs to the  phone....
> 
> This behaviour seems inconsistent, I tried to figure out what is going on 
> from the logs, but it is kind of tricky (at least for me ;) ). I've 
> included logs for both of the cases (nokia.txt for the type 1) phones, and 
> sony.txt for the type 2 phonnes). Both logs start at the moment of 
> incoming call when RFCOMM links are already established, and finish after 
> I hang-up. I skipped most of the SCO packets cause there are a lot ( -- 
> denotes skip )
> 
> May be you can comment on this, cause I do not see at the moment what is 
> the cause of the problem.

if you don't catch the initial L2CAP connection setup then you should
add a --psm=3 to hcidump so it assumes that every unknown L2CAP cids are
RFCOMM connections. Redo this for the Nokia logfile or send in the
binary dumps.

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
