Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Limit communication to serveral devices
From: Marcel Holtmann <marcel@holtmann.org>
To: Philip Lawatsch <philip@lawatsch.at>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <412CED9A.2070405@lawatsch.at>
References: <412C9803.6080306@lawatsch.at> <1093443880.537.0.camel@pegasus>
	 <412CED9A.2070405@lawatsch.at>
Content-Type: text/plain
Message-Id: <1093464960.537.14.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 25 Aug 2004 22:16:00 +0200

Hi Philip,

> > you must change the code of the accept routine in the RFCOMM server
> > program that you are using.
> 
> This is not quite what I want. I'd like to limit this at lowest layer 
> possible. Actually I'm starting to wonder that there seems to be 
> _nothing_ to that, which, at least I think so, poses a potential 
> security risk.

you can of course limit this at HCI level, but then you must change the
kernel code. There is somekind of filter on the HCI hardware level, but
I am not quite sure if it can be used for that. Check the HCI part of
the Bluetooth specification.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
