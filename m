Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluez+2.6+Logitech bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: fd@cisco.com
Cc: de Laurent <de_laurent@o2.pl>,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1084692905.12711.75.camel@metal.cisco.com>
References: <20040515163903.CB06543F94@rekin8.go2.pl>
	 <1084692905.12711.75.camel@metal.cisco.com>
Content-Type: text/plain
Message-Id: <1084708620.4184.4.camel@pegasus>
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
Date: Sun, 16 May 2004 13:57:00 +0200

Hi Fred,

> I think this is normal. When you boot, the USB/BT hub (the mouse base
> station) acts as a dumb RF<->HID in plain USB mode. I.e. Linux
> recognizes the base station as a USB hub with plain USB keyboard and
> mouse attached to it.
> 
> When you switch over to HCI mode with hid2hci, the USB hub, mouse and
> keyboards disappear and a USB/BT dongle appears instead (i.e. a HCI
> "hub"). The USB/BT piece is not connected to any device yet. You
> normally have to pair the keyboard and mouse and start bthid to do the
> HCI<->HID conversion in order to make Linux see your BT devices... You
> can't type these commands since the kernel can't see your keyboard
> during that phase :-) It's a catch chicken and egg problem.
> 
> Try connecting a secondary keyboard for the initial pairing and make
> sure you start bthid automatically after hid2hci next time (you don't
> have to pair each time).

actually this isn't a chicken and egg problem. You only must ensure that
the hidd is correctly started. When you then run hid2hci the mouse and
keyboard will be disconnected and they will reconnect, but now the BlueZ
is running the HID profile.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
