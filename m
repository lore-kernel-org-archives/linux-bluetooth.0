Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Emulator
From: Marcel Holtmann <marcel@holtmann.org>
To: Lalith Chakravarthi <lalithvc@yahoo.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040227045005.36897.qmail@web40710.mail.yahoo.com>
References: <20040227045005.36897.qmail@web40710.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1077882697.2843.30.camel@pegasus>
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
Date: Fri, 27 Feb 2004 12:51:37 +0100

Hi Lalith,

> I want to know how to get the emulator working. I dont have any real
> bluetooth hardware. I want to simulate both a local device and a remote
> device. I could emulate two local devices with 
> 
> >>hciemu localhost:10
> >>hciemu localhost:20
> 
> But I want to know how to emulate a remote device and establish a link
> between them... I would like to have the exact commands for doing so
> and to send/recieve files between them. And since I am more of a
> beginner, could you add some more details in it?

I haven't used the emulator, but you should get two Bluetooth devices if
you call hciconfig. And with the device addresses you can create any
connection between them that you want.

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
