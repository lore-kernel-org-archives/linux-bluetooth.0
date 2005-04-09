Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth modem
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <200504091713.36367.r_haertel@gmx.de>
References: <200504091713.36367.r_haertel@gmx.de>
Content-Type: text/plain
Message-Id: <1113062870.9655.2.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 09 Apr 2005 18:07:50 +0200

Hi Ruediger,

> I am interested in using bluetooth to connect to a modem. I found 
> two products:
> - Acer Bluetooth (ww.Acer.de -> Products->Kommunikation)
> - Typhoon Bluetooth modem 
> (http://www.anubisline.com/german/articlec.asp?id=20008&catid=200).
> 
> Has anyone experience with these modems ? Was it difficult to get 
> them working ?

in general I expect something like this will work:

	rfcomm bind 0 <bdaddr> 1

After that you can use /dev/rfcomm0 like you would have used /dev/ttyS0
before.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
