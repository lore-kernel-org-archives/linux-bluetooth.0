Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Pairing multiple devices
From: Marcel Holtmann <marcel@holtmann.org>
To: Alex Eiser <alexe@ed.ca>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <6AC5A768-65C5-11D8-9539-000A959C67D2@ed.ca>
References: <200402230026.24596.pavouk@pavouk.org>
	 <6AC5A768-65C5-11D8-9539-000A959C67D2@ed.ca>
Content-Type: text/plain
Message-Id: <1077521546.2832.62.camel@pegasus>
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
Date: Mon, 23 Feb 2004 08:32:26 +0100

Hi Alex,

> I have several bluetooth devices, which I am having a hard time getting 
> them all connected at the same time.
> 
> The problem is that, one device (a Logitech MS 900) doesn't seem to 
> work if I have encryption and authentication enabled.

and this is correct. Read the HID profile for more details.

> However my apple wireless keyboard does not work with out those options 
> enabled.

The Apple mouse is wrong here, because the HID device must not decide
this. In the case of HID the host stack must trigger the authentication.

> With encryption and authentication on, the mouse does not have a 
> successful pairing. (always failing on the key request)

With auth and encrypt set in hcid.conf or with hciconfig you enable
security mode 3 and this is not what you really want. Disable it and let
the device decide when to ask for authentication.

> Is there a way to specify that a specific connect uses (or doesn't use) 
> encryption and authentication?

See above. You are in security mode 3, but what you want is security
mode 2.

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
