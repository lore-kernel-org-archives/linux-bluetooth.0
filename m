Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: Re: bluez & qos
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <AFE91B59A185A5439840B43AB7919047A83CA5@mchp997a.mch.sbs.de>
References: <AFE91B59A185A5439840B43AB7919047A83CA5@mchp997a.mch.sbs.de>
Content-Type: text/plain
Message-Id: <1102523782.9988.80.camel@pegasus>
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
Date: Wed, 08 Dec 2004 17:36:22 +0100

Hi Matthias,

> Basically I want to do the same like Jean Tourrilhes two years ago,
> hoping that chips / firmware have better QoS support meanwhile: 
> "... I"m trying to get the latency under control. I"m using BNEP with a mix
> of TCP/IP traffic, ..."
> 
> I searched the mailing archiv for QoS and found a lot of firmware specific
> discussion. 
> 
> What I couldnt find, but what I would need first is a kind of QoS-Howto,
> explaining generally how to realize QoS with Bluez, i.e. how to control the
> maximum poll interval.
> It would be great to have some examplary code, that adjusts
> the poll interval with the HCI_QoS_Setup command or sth. like that.

I don't know of any public example for QoS.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
