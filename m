Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] getting bluetooth v1.2
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <4247F63F.70206@gmx.ch>
References: <25911.1111942263@www59.gmx.net>
	 <1111943294.9195.250.camel@pegasus>  <4247EEE0.8010002@gmx.ch>
	 <1112011490.9016.27.camel@pegasus>  <4247F63F.70206@gmx.ch>
Content-Type: text/plain
Message-Id: <1112015700.9016.30.camel@pegasus>
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
Date: Mon, 28 Mar 2005 15:15:00 +0200

Hi Marco,

> > check with "hciconfig hci0 revision" as root what BlueCore chip is on it
> > and no, these are not the problematic dongles.
> 
> it's a BlueCore02
> 
> >>so, an update to bt v1.2 wouldn't make sense to me...
> > 
> > What does "lsusb" tells you?
> 
> it think you mean this line:
> Bus 002 Device 008: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle

and if this chip now contains 8 Mbit flash you get a good chance to
upgrade it with HCI 18.x firmware and so get Bluetooth 1.2 support.

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
