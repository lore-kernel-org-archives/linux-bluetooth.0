Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Apple keyboard
From: Marcel Holtmann <marcel@holtmann.org>
To: Radu Maurer <a400@gmx.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040213225030.GA10502@mail.gmx.de>
References: <20040210175802.GA17705@mail.gmx.de>
	 <1076451979.2777.21.camel@pegasus> <20040211151146.GA19818@mail.gmx.de>
	 <1076515215.2696.36.camel@pegasus> <20040213105035.GA10464@mail.gmx.de>
	 <1076669640.2671.27.camel@pegasus> <20040213113749.GA13481@mail.gmx.de>
	 <1076673365.2671.30.camel@pegasus>  <20040213225030.GA10502@mail.gmx.de>
Content-Type: text/plain
Message-Id: <1076714070.18588.87.camel@pegasus>
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
Date: Sat, 14 Feb 2004 00:14:31 +0100

Hi Radu,
 
> Feb 13 23:20:49 localhost bthid[8705]: Connected: Apple Computer, Inc. Apple Wireless Keyboard (05ac:0209)
> 
> hcidump prints this every time a press a key:
> > ACL data: handle 0x0029 flags 0x02 dlen 15
>     L2CAP(d): cid 0x41 len 11 [psm 19]
> 
> now I wonder: how do I use the keyboard with X11 (and possibly at the
> console), i.e. which device do I have to enter in the "InputDevice"
> section of XFree86Config?

you only have to load the keybdev kernel module.

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
