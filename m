Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: RE: [Bluez-users] it is possible to change the N inquiry <256
From: Marcel Holtmann <marcel@holtmann.org>
To: 0|20c|=|ima|2U <matrix230@yahoo.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040812092026.8225.qmail@web51805.mail.yahoo.com>
References: <20040812092026.8225.qmail@web51805.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1092303053.28711.75.camel@pegasus>
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
Date: Thu, 12 Aug 2004 11:30:53 +0200

Hi Shukri,

> what I'm trying to do is that I want to speed up the discovery
> process.  As stated by Somil before, the device inquires 256 times or
> for 2.56 s using one Train and then switches to a different Train.
> There are two Inquiry Train (called as Train A or Train B).
>  
> What I'm trying to do is, i want to reduce the no. of times that the
> train must be repeated before switches to another train. For e.g. :
>  
> AAAAAAAAAAA.....[256x]..BBBBB...[256x]... (train A repeat 256 times
> then see train B)
> ABABABABAB........... (this is what happen when we change Ninquiry=1)
>  
> this can speed up the discovery process. are there any command or some
> modification in the source code that we can alter to reduce the no. of
> Ninquiry of train A & B? ~:)
>  
> I've done the simulation under network simulator by changing value of
> Ninquiry=1, and i found that the discovery process can be speed up.

you are asking the wrong group of people. We build only a Bluetooth
software stack above the HCI layer. Get in contact with the chip
manufacturers and ask them.

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
