Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] (Newbie) Echo server and transferring raw data
From: Marcel Holtmann <marcel@holtmann.org>
To: john smith <roofass@hotmail.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <BAY22-F14OIvmnGlToQ00029178@hotmail.com>
References: <BAY22-F14OIvmnGlToQ00029178@hotmail.com>
Content-Type: text/plain
Message-Id: <1092252899.4564.244.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 11 Aug 2004 21:34:59 +0200

Hi John,

> I'm pretty new to Bluez and network programming and I'd appreciate if I 
> anybody could give me some pointers on passing raw data between two hosts.
> 
> I've been playing about with hcitools and l2ping and I've got a pand 
> connection happening between two pc's.
> 
> As an exercise I'd just like to send some data between the server and client 
> and maybe build up my own simple application protocol.
> 
> My question is ( and I applogise if this sounds dumb), is there an easy way 
> to do this? I've been looking at the l2ping code and I'm thinking about 
> experimenting with this. Or is it possible to take an Echo program written 
> to use IP sockets and simply substitute in things like 'socket(PF_BLUETOOTH, 
> SOCK_RAW, BTPROTO_L2CAP)'  where appropriate.

take a look at the source code of l2test and rctest. If you want to port
a TCP application then use RFCOMM as layer, because you will need a
stream socket.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
