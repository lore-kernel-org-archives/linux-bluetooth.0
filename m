Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Need help with PAND between 2  linux boxes
From: Marcel Holtmann <marcel@holtmann.org>
To: Paul Ionescu <i_p_a_u_l@yahoo.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <pan.2004.08.14.22.56.57.538948@yahoo.com>
References: <pan.2004.08.14.22.56.57.538948@yahoo.com>
Content-Type: text/plain
Message-Id: <1092645247.4375.86.camel@pegasus>
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
Date: Mon, 16 Aug 2004 10:34:07 +0200

Hi Paul,

> I have two linux boxes with FedoraCore 2 installed on both.
> Both of them have USB bluetooth adapters.
> I have tried to connect them in a NAP - PANU config, as indicated in
> http://bluez.sourceforge.net/contrib/HOWTO-PAN, but something is not
> working and I can't figure out what.
> Here are the details:
> service bluetooth start
> Then I check with hciconfig that both BT are UP.
> Then, on both computers I modprobe bnep.
> (one note here, ifconfig -a does not show any bnep0 at this moment)
> On both of them launch
> hcidump in separate windows to see what is going on. 
> 
> On one I launch 
> pand --listen --role NAP -n --master
> and on the other
> pand -c 00:20:E0:73:EB:F7 -n --role PANU
> 
> and after some messages in hcidump on both sides, I receive:
> pand[1431]: Bluetooth PAN daemon
> pand[1431]: Connecting to 00:20:E0:73:EB:F7
> pand[1431]: Connect to 00:20:E0:73:EB:F7 failed. Function not implemented(38)

try it without the --master and --role parameters. I think you forgot to
enable the role switch (rswitch) on both sides.

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
