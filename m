Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Marco Trudel" <mtrudel@gmx.ch>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
References: <1112015700.9016.30.camel@pegasus>
Subject: Re: [Bluez-users] getting bluetooth v1.2
Message-ID: <20242.1112026706@www42.gmx.net>
Content-Type: text/plain; charset="us-ascii"
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
Date: Mon, 28 Mar 2005 18:18:26 +0200 (MEST)

so it doesn't mather that i've a silicon dongle?
(i need the bt v1.2 only because the rssi inquiry)
or isn't it a silicon one?

what is now the procedure?
- getting the btdfu program
- fix it (Adam Goode told how)
- download the 18.x firmware. where can i get it?
- install it...

regards
Marco


> Hi Marco,
> 
> > > check with "hciconfig hci0 revision" as root what BlueCore chip is on
> it
> > > and no, these are not the problematic dongles.
> > 
> > it's a BlueCore02
> > 
> > >>so, an update to bt v1.2 wouldn't make sense to me...
> > > 
> > > What does "lsusb" tells you?
> > 
> > it think you mean this line:
> > Bus 002 Device 008: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth
> Dongle
> 
> and if this chip now contains 8 Mbit flash you get a good chance to
> upgrade it with HCI 18.x firmware and so get Bluetooth 1.2 support.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 

-- 
Handyrechnung zu hoch? Tipp: SMS und MMS mit GMX
Seien Sie so frei: Alle Infos unter http://www.gmx.net/de/go/freesms


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
