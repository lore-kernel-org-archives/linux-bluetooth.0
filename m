Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Adpat PAN profile to Samba Server
From: Marcel Holtmann <marcel@holtmann.org>
To: taylor <taylor@ms.usi.com.tw>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <001101c47e79$57380c10$df0618ac@USI08844>
References: <004a01c47dd4$45be1380$df0618ac@USI08844>
	 <1092071688.4564.20.camel@pegasus>
	 <001101c47e79$57380c10$df0618ac@USI08844>
Content-Type: text/plain
Message-Id: <1092124245.4564.54.camel@pegasus>
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
Date: Tue, 10 Aug 2004 09:50:45 +0200

Hi Taylor,

>    My plan is that:
> a. Set up an PAN master profile at Linux Site, then Configure interface of
> Samba Service as this PAN
> b. User(Linux or Window) access this Samba service if he/she have jointed
> this PAN group.
>    I am not sure if this usage could work, I still try to set up this usage.
> Have somebody ever do that as far as you know?
> If my understanding is right for Bluetooth PAN Profile, I think this usage
> is possible.

the BlueZ BNEP device work the same as a Linux network card and so you
can run every IP based service on it. Go ahead and do it.

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
