Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] MS BT Keyboard problem solved
From: Marcel Holtmann <marcel@holtmann.org>
To: Florian Echtler <echtler@fs.tum.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.61.0411011606540.22365@block.bubble>
References: <Pine.LNX.4.61.0411011023040.15228@block.bubble>
	 <1099313202.16247.87.camel@pegasus>
	 <Pine.LNX.4.61.0411011606540.22365@block.bubble>
Content-Type: text/plain
Message-Id: <1099321957.16247.104.camel@pegasus>
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
Date: Mon, 01 Nov 2004 16:12:37 +0100

Hi Florian,

> > this is interesting. May I must include a switch to report mode in the
> > kernel, but I always thought that this is default. Do you own the old or
> > the new Microsoft keyboard?
> Well.. as it is at least 1.5 years old, I suppose it's the old
> one, but I don't know for certain. Any way to find out?

check with "hcitool info ..." if it says that it contains a CSR chip.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
