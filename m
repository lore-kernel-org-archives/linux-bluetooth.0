Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] can't establish a connection
From: Marcel Holtmann <marcel@holtmann.org>
To: ben4fun <ben_4_fun@freenet.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1092728742.12606.5.camel@localhost>
References: <1091742606.6143.17.camel@localhost>
	 <1091747064.6143.25.camel@localhost> <1091748133.20839.63.camel@pegasus>
	 <200408060216.05030.cijoml@volny.cz>  <1091810383.4570.14.camel@localhost>
	 <1092727197.12606.1.camel@localhost>  <1092728177.31651.6.camel@pegasus>
	 <1092728742.12606.5.camel@localhost>
Content-Type: text/plain
Message-Id: <1092729673.31651.11.camel@pegasus>
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
Date: Tue, 17 Aug 2004 10:01:13 +0200

Hi Ben,

> > install a kernel where this problem is fixed.
> > 
> Thanks marcel for your quick answer as usual. I have the 2.6.8-0rc2.1mdk kernel, 
> what kernel would be the good?

that kernel may work, but it is not a vanilla kernel, so I can't tell
you if all patches are included or not. However you can also try to
compile a kernel without CONFIG_BT_HCIUSB_SCO option set. May this
helps.

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
