Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Limit communication to serveral devices
From: Marcel Holtmann <marcel@holtmann.org>
To: Philip Lawatsch <philip@lawatsch.at>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <412C9803.6080306@lawatsch.at>
References: <412C9803.6080306@lawatsch.at>
Content-Type: text/plain
Message-Id: <1093443880.537.0.camel@pegasus>
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
Date: Wed, 25 Aug 2004 16:24:40 +0200

Hi Philip,

> Call me paranoid but I would like to know if there is any way to limit 
> all types of communication to just several devices by checking with the 
> hardware addresses.
> 
> I understand that in principle not being discoverable and the pin 
> challenge should help you with being secure but to me this is not enough.
> 
> I'm currently running 2 class 1 devices to serve my flat with rfcomm for 
> dial in and I for sure do not want anyone besides me to get access to 
> these com ports.
> 
> Is there anything I can do to tighten security and limit all 
> communication to just some devices?

you must change the code of the accept routine in the RFCOMM server
program that you are using.

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
