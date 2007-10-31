Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <307f591f0710301305n410b8ebds4fa399dd0a518840@mail.gmail.com>
References: <307f591f0710301305n410b8ebds4fa399dd0a518840@mail.gmail.com>
Date: Wed, 31 Oct 2007 17:52:22 +0100
Message-Id: <1193849542.32459.74.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] multi-frequency scanning & possible contract work
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Paul,

> I need to use a directional antenna focused on an area about 6 meters
> x 6 meters that can scan for Bluetooth mobile phones as they pass
> through the area, and identify them very quickly.  It's for a new
> startup business that's focusing on a retail application running on an
> embedded Linux box. 

the use of an directional antenna with a Bluetooth chip is illegal as
far as I know. You really wanna check the regulations here.

> The problem with the usual usb Bluetooth dongle and a normal scan is
> that in a busy area with hundreds of Bluetooth phones nearby, the scan
> can take a very long time, like several minutes, and will pick up lots
> of phones of people all over the store.  We just want to detect them
> when they come in through the entrance.  So, we're going to use a
> directional antenna that focuses just on a 6 meter x 6 meter space in
> front of the entrance so it doesn't pick up phones outside that area. 

You can use the RSSI value to pick only the phones in range. This needs
some manual tuning, but works pretty well so far. And if you simply not
use the name resolving, then you will see immediately devices in range
and also devices passing by. The bluetooth-proximity example from the
bluez-gnome package does this.

> However there's still a problem that a traditional Bluetooth scan
> takes 15+ seconds to pickup devices, and that's too long.  The shopper
> may pass through the detection area in only a couple seconds.  So we
> need to be able to do the scans very quickly. 
> 
> I don't know that much about the underlying technology, but I
> understand that a typical Bluetooth scan consists of scanning across
> several frequencies and hopping from frequency to frequency to find
> phones on each frequency.  Therefore, my question is this: instead of
> having 1 bluetooth dongle that's hopping across several frequencies,
> can we hook up multiple bluetooth dongles to the same antenna, and
> have each one locked onto just one frequency to make the process go
> faster?  In other words, can we balance the 15 second scanning process
> across 5 Bluetooth dongles so we can do the same scan in only 3
> seconds? 

If you keep calling it scanning, then you have no clue how Bluetooth
actually works. So you might wanna get one of the Bluetooth books that
describe the basics behind this technology. And your math will not work
out that easily. It is not that simple.

> We do have a little bit of funding, so if something like the
> multi-dongle approach method i mentioned works, and it requires some
> special coding or mods to bluez, we could compensate a developer for
> helping out with this. 

Just a warning up-front. If you don't use the D-Bus API and wanna use
the HCI raw socket, you have to make your code public and put it under
GPL license.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
