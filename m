Return-Path: <cyrus@holtmann.org>
Message-ID: <477AC130.500@boerkel.de>
Date: Tue, 01 Jan 2008 23:39:44 +0100
From: =?ISO-8859-1?Q?Thomas_B=F6rkel?= <thomas@boerkel.de>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <477AA678.4000707@boerkel.de> <477AA8D9.9080804@boerkel.de>
In-Reply-To: <477AA8D9.9080804@boerkel.de>
Subject: Re: [Bluez-users] Trouble with Tecom BT3030 - not recognized
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

HI!

I think, I am a small step further.

I guess, the working Anycom USB-250 device has a firmware onboard, where
as the Tecom BT3030 needs the firmware to be loaded when plugging it in
and this is what not works.

I have firmware loading support in the kernel (standard Gentoo 2.6.23
kernel) active and it works for an ivtv video capture card.

So I tried manually uploading the firmware to the dongle like this:
/etc/init.d/bluetooth stop
bluefw usb 004/003;/etc/init.d/bluetooth start

This worked one time and hciconfig showed the device (so it is not wrecked).

But now this gives me:
bluefw[13626]: Loading firmware to usb device 0a5c:2033
bluefw[13626]: Can't claim interface 0. Device or resource busy (16)

Anyway, normally hotplug should load the firmware into the device. I did
not have the hotplug package installed but now I have and it makes no
difference.

Any ideas?

Thanks!

Thomas



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
