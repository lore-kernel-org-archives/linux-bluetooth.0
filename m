Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <d4f1333a0605271008q1d86a4d4h865417a889abf0a2@mail.gmail.com>
References: <d4f1333a0605271008q1d86a4d4h865417a889abf0a2@mail.gmail.com>
Date: Mon, 29 May 2006 15:00:00 +0200
Message-Id: <1148907600.31689.9.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] upgrade to FC5 "breaks" my bluetooth -
	what's	wrong?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Travis,

> I upgraded from FC3 to FC5, and my script which calls hidd --connect
> with the hardware addresses of my keyboard and mouse doesn't work any
> more.  I'm using the Microsloth bluetooth combo (I figure it's okay
> because I'm using it in Linux).  Anyhow, what do I have to do to get
> these guys recognized and talking to Linux?

check /etc/sysconfig/hidd and make sure that the hidd service is enabled
and started. You only need to use "--connect" once. After that the
keyboard will reconnect to your laptop.

> Also, I don't suppose there is any way to use these things before
> Linux boots up, like in grub, correct?  That's kind of a bummer.  I
> guess USB and Bluetooth aren't really replacements for a regular
> keyboard yet.

You need a dongle with HID proxy mode. A USB keyboard is fully supported
by any modern BIOS.

Regards

Marcel




_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
