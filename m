Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Apple keyboard
From: Marcel Holtmann <marcel@holtmann.org>
To: Radu Maurer <a400@gmx.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040211151146.GA19818@mail.gmx.de>
References: <20040210175802.GA17705@mail.gmx.de>
	 <1076451979.2777.21.camel@pegasus>  <20040211151146.GA19818@mail.gmx.de>
Content-Type: text/plain
Message-Id: <1076515215.2696.36.camel@pegasus>
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
Date: Wed, 11 Feb 2004 17:00:15 +0100

Hi Radu,

> /var/log/daemon.log sais:
> bthid[19500]: Bluetooth HID service started
> 
> then I try to connect:
> 	bthid -c <Apple Keyboard Address>
> 
> I switch on the keyboard, the green LED on the back side starts to blink.
> 
> after a few seconds I get the message:
> bthid[19500]: Connection failed: Function not implemented (38)

this can be a paring problem, because the Apple HID devices don't allow
unencrypted connections. Run "hcidump -w <file>" so I can see what is on
the HCI layer.

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
