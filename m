Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <420CFEAD.2000202@uni-paderborn.de>
From: Matthias Schnelte <schnelte@uni-paderborn.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Several bluetooth dongles at time
References: <50142.195.22.30.15.1108037990.squirrel@195.22.30.15> <1108039290.15974.33.camel@pegasus>
In-Reply-To: <1108039290.15974.33.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Fri, 11 Feb 2005 18:51:25 +0000

>>2) Can i have multiple connections on the same rfcomm channel? So more
>>than one mobile can connect to my server at time or only one device per
>>channel and i have to open more than one channel?
> 
> One connection per RFCOMM channel. On the RFCOMM level there is no
> further multiplexing.
So, if I have two phones that provide one service each, but both on the 
same rfcomm channel i will not be able to connect to both of them, right?
Why is that? I mean, it is all brought done to l2cap connections and 
l2cap is not limited in that case.
Hmm, so the only solution is to use l2cap instead of rfcomm, right?

Matthias


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
