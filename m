Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Connection with a phone stays open after closing
	RFCOMM channel
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Cc: victor@win.tue.nl
In-Reply-To: <Pine.LNX.4.44.0502271406520.18458-100000@antilope>
References: <Pine.LNX.4.44.0502271406520.18458-100000@antilope>
Content-Type: text/plain
Message-Id: <1109578068.17256.0.camel@pegasus>
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
Date: Mon, 28 Feb 2005 09:07:48 +0100

Hi Victor,

> My prog. listens on a RFCOMM chan. (adv. as HF channel via SDP) of  a 
> laptop, when I 
> connect from my phone to the laptop the chan. is opened, I send some 
> commands to configure the phone and when finished, close the chan. The 
> problem is that L2CAP connection stays open, from the output of hcidump I 
> see that laptop sends DISC request on dlci 6 and receives UA, but then 
> according to protocol it should also then send DISC for dlci 0, and then 
> terminate L2CAP -- it does not happen...
> If I do the same, but initiating connection from laptop - it works fine...
> I'm sure there is no other RFCOMM chan. opened.

sounds like a bug in the phone. Send in the "hcidump -X -V" for it.

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
