Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Detect the type of remote device
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <421CC068.3050202@futurlink.com>
References: <421CC068.3050202@futurlink.com>
Content-Type: text/plain
Message-Id: <1109242332.5645.14.camel@notepaq>
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
Date: Thu, 24 Feb 2005 11:52:12 +0100

Hi Pedro,

> While using the BlueZ API's we have discovered that it's difficult to
> find which kind of device (brand and model) we are talking to. We are
> writing an application that delivers an image to any device passing
> by, taking into account its screen width, height and color depth, but
> without any prior knowledge of the device.
> 
> Using WAP we have access to the HTTP headers from where you can parse
> the User Agent Profile (UAProf), but we have not found any similar
> function in Bluetooth. In fact, there is the PnPInformation Profile,
> but nowadays is supported in very few devices.
> 
> Is there any function or mechanism to retrieve the UAProf data (or
> anything similar) using the BlueZ library?

actually the PnP stuff is available in Bluetooth and it is called Device
ID, but there are not a lot of devices that supports this.

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
