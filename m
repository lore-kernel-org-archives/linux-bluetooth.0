Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] dund never activates pppd
From: Marcel Holtmann <marcel@holtmann.org>
To: Klaus Holst <klaus@encephalon.dk>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040225180013.GA1700@encephalon.dk>
References: <20040223213658.GA1453@encephalon.dk>
	 <1077573810.2791.161.camel@pegasus> <20040224085351.GA3782@encephalon.dk>
	 <1077624875.2880.44.camel@pegasus> <20040225113847.GB1339@encephalon.dk>
	 <1077716089.2919.86.camel@pegasus>  <20040225180013.GA1700@encephalon.dk>
Content-Type: text/plain
Message-Id: <1077734265.2919.143.camel@pegasus>
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
Date: Wed, 25 Feb 2004 19:37:45 +0100

Hi Klaus,

> > > Actually the dongle (Belkin F8T001) is listed as supported in
> > > http://www.holtmann.org/linux/bluetooth/devices.html.
> > 
> > It is fully supported, but there can be problems with the firmware you
> > are using or with the interop to some other chips. We can't test this,
> > because we have no access to the link manager. From the HCI layer
> > onwards the Broadcom BCM2033 is fully supported.
> > 
> > > However in case I should try to find another dongle, can anyone recommend one 
> > > which is properly supported by linux/bluez and has a reasonable range?
> > 
> > I had the best results with a Bluetooth chip from CSR. 
> 
> I went out to the store where I bought the dongle and returned it. Instead I
> picked up a Belkin F8T003 dongle and now everything works flawlessly :-)!!!

this is another bad story with a Broadcom dongle :(

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
