Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] dual boot keyboard wont connect
From: Marcel Holtmann <marcel@holtmann.org>
To: Walt <idunno2468@hotmail.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <412E57F2.6040303@hotmail.com>
References: <412E57F2.6040303@hotmail.com>
Content-Type: text/plain
Message-Id: <1093558926.2581.72.camel@pegasus>
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
Date: Fri, 27 Aug 2004 00:22:06 +0200

Hi Walter,

> I dual boot with windows xp, and use the MS wireless desktop bluetooth.  
> When I switch to windows, i get a message about a bluetooth device 
> requesting authorization.  I have to manually remove the device, hold 
> the reset button on the keyboard, and then rescan for the keyboard.  
> When I switch back to linux, all I get is the following in my log:
> localhost hcid[8848]: link_key_request (sba=00:50:F2:7D:43:AF, 
> dba=00:50:F2:80:32:90)
> I hold the reset, then hidd -connect 00:50:F2:80:32:90.  The mouse works 
> great through all of this.
> 
> My guess is that the keyboard requires authentication: in windows i must 
> type in a set of numbers and press enter or it doesnt work. At least, 
> thats the only difference that I can see with the way it connects.

actually dual booting with a Bluetooth keyboard is not really possible
unless you store the link key on the Bluetooth dongle. Do you enabled
the auth option in hcid.conf?

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
