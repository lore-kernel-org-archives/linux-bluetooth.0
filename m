Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth Access Point elmeg D@VOS-44.dsl
From: Marcel Holtmann <marcel@holtmann.org>
To: Florian <Kimpenhaus@gmx.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <opr4anrqloqdj9uv@mail.gmx.de>
References: <opr3xmdugiqdj9uv@mail.gmx.de>
	 <1077725935.2919.116.camel@pegasus>  <opr3xs5louqdj9uv@mail.gmx.de>
	 <1077734547.2919.147.camel@pegasus>  <opr3xydd1hqdj9uv@mail.gmx.de>
	 <1077740936.2884.2.camel@pegasus>  <opr3x23lc1qdj9uv@mail.gmx.de>
	 <1077747171.2884.5.camel@pegasus>  <opr3x77rphqdj9uv@mail.gmx.de>
	 <1077753099.2754.1.camel@pegasus>  <opr3x8uqadqdj9uv@mail.gmx.de>
	 <1077757118.2754.4.camel@pegasus>  <opr3yb4dsoqdj9uv@mail.gmx.de>
	 <1077758327.2754.9.camel@pegasus>  <opr31ccpcoqdj9uv@mail.gmx.de>
	 <1077895848.2843.50.camel@pegasus>  <opr4anrqloqdj9uv@mail.gmx.de>
Content-Type: text/plain
Message-Id: <1078334647.10857.36.camel@pegasus>
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
Date: Wed, 03 Mar 2004 18:24:07 +0100

Hi Florian,

> > you can use
> >
> > 	dund --nodetach --connect 00:0B:CE:00:01:8E --msdun call lap
> >
> > and create a /etc/ppp/peers/lap file with your PPP settings. But that is
> > now up to you, because I don't know what your AP is expecting.
> 
> at first thanks for your fast help!!!! In the end it works I can connect 
> to the AP
> using PAP and ppp.(little trick - after conection is established I have to 
> use route
> to set a gateway "route add default gw 192.168.1.110" ip the AP gave my 
> dongel)

you can also do this with pppd. Look for "defaultroute".

> I did not belive that I get it working so quick despite the fact that I 
> use Linux
> for about 3 weeks now.
> But I have still some questions.
> 
> When plugging in the dongel  I have to use bluefw 00X/00Y for the firmware 
> to be loaded
> into the dongel. Is it possible to automate this?

Yes. You can use Linux Hotplug for this. Look at the mailing list
archive for more details about it. With 2.6 you can try the bcm203x
kernel driver for the firmware loading.

> Why is the 2nd light on the dongel off when it is connected?

This is dongle specific, so I can't tell you.

> P.S.: As promised I ll write a howto for this AP but I need some more 
> testing time. ;) 

Go ahead and do it.

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
