Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] hcitool scan ...
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200411291136.23173.wim.delvaux@adaptiveplanet.com>
References: <200411291050.14799.wim.delvaux@adaptiveplanet.com>
	 <200411291116.13406.wim.delvaux@adaptiveplanet.com>
	 <1101724371.7463.24.camel@pegasus>
	 <200411291136.23173.wim.delvaux@adaptiveplanet.com>
Content-Type: text/plain
Message-Id: <1101724777.7463.31.camel@pegasus>
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
Date: Mon, 29 Nov 2004 11:39:37 +0100

Hi Wim,

> > > > > how is it possible that not all devices show up when doing a scan ?
> > > > > I have 3 devices, Ipaq, Desktop and Phone and only phone shows up
> > > > > even if ipaq and desktop have a running PAN connection ?
> > > >
> > > > maybe because of the running PAN connection.
> > >
> > >  is that so ? does a bt connecter refuse to present itself when it has
> > >  a connection ?
> >
> > this depends on the Bluetooth chip and its firmware. Check this with
> > hcitool and hciconfig.
> 
>   sorry for my BT ignorance but what option should I use and which
>  parameter presents Chip and Firmware ?

	hciconfig -a
	hciconfig hci0 revision
	hcitool info <bdaddr>

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
