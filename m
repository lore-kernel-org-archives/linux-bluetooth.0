Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Need help with PAND between 2  linux boxes
From: Marcel Holtmann <marcel@holtmann.org>
To: Paul Ionescu <i_p_a_u_l@yahoo.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040816125631.54878.qmail@web50202.mail.yahoo.com>
References: <20040816125631.54878.qmail@web50202.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1092666785.4375.150.camel@pegasus>
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
Date: Mon, 16 Aug 2004 16:33:05 +0200

Hi Paul,

> Now it worked just fine.
> Many thanks for the quick help.

you are welcome.

> Now, regarding the docs, I have read the comment in
> hcid.conf, but "master - become master on incoming
> connections, and deny role switch on outgoing
> connections" seemed fine from my point of view.
> I interpreted like "I will be master for all incoming
> conections, and I will deny role switch for all
> outgoing connection" which seemed fine from my point
> of view.

And if both sides do it this way it can't work. Think about it and you
understand it. Remember that the connection initiator is the master in
the first place.

> I could not see what I was wrong from
> http://bluez.sourceforge.net/contrib/HOWTO-PAN.
> and not even from 
> http://fedoranews.org/contributors/muhammad_al_ismail/bluetooth/
> which claims to be a FC2 setup.

I don't wrote these two. Contact the authors.

> And now I have another question:
> After using the pand, I finished the transfers, I
> shutted down the bluetooth service, ifconfig bnep0
> down, and I wanted to "rmmod bnep".
> But rmmod bnep gives:
> ERROR: Module bnep is in use
> And indeed is in use by "ps xa|grep bnep" :
> 2660 ?        SW<    0:00 [kbnepd bnep0]
> 
> Is this normal ?

Yes, because "ifconfig bnep0 down" doesn't kill the BNEP connection
between these two devices. Try to run "pand -K".

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
