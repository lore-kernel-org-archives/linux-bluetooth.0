Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth Access Point elmeg D@VOS-44.dsl
From: Marcel Holtmann <marcel@holtmann.org>
To: Florian <Kimpenhaus@gmx.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <opr31ccpcoqdj9uv@mail.gmx.de>
References: <opr3xmdugiqdj9uv@mail.gmx.de>
	 <1077725935.2919.116.camel@pegasus>  <opr3xs5louqdj9uv@mail.gmx.de>
	 <1077734547.2919.147.camel@pegasus>  <opr3xydd1hqdj9uv@mail.gmx.de>
	 <1077740936.2884.2.camel@pegasus>  <opr3x23lc1qdj9uv@mail.gmx.de>
	 <1077747171.2884.5.camel@pegasus>  <opr3x77rphqdj9uv@mail.gmx.de>
	 <1077753099.2754.1.camel@pegasus>  <opr3x8uqadqdj9uv@mail.gmx.de>
	 <1077757118.2754.4.camel@pegasus>  <opr3yb4dsoqdj9uv@mail.gmx.de>
	 <1077758327.2754.9.camel@pegasus>  <opr31ccpcoqdj9uv@mail.gmx.de>
Content-Type: text/plain
Message-Id: <1077895848.2843.50.camel@pegasus>
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
Date: Fri, 27 Feb 2004 16:30:48 +0100

Hi Florian,

> This is how far I get at the moment but I do not know how to
> configure the ppp connection to authenticate my system.
> 
> bash-2.05b# dund --nodetach --connect 00:0B:CE:00:01:8E --msdun
> dund[4386]: DUN daemon ver 1.1
> dund[4386]: Searching for LAP on 00:0B:CE:00:01:8E
> dund[4386]: Connecting to 00:0B:CE:00:01:8E channel 1
> dund[4386]: Connection established
> bash-2.05b# Using interface ppp0
> Connect: ppp0 <--> /dev/rfcomm0
> LCP terminated by peer (peer refused to authenticate)
> Connection terminated.

you can use

	dund --nodetach --connect 00:0B:CE:00:01:8E --msdun call lap

and create a /etc/ppp/peers/lap file with your PPP settings. But that is
now up to you, because I don't know what your AP is expecting.

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
