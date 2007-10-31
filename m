Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Wed, 31 Oct 2007 11:55:32 +0100 (CET)
From: Peter Wippich <pewi@gw-instruments.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <56C8D22F4B7F104DBE581411F10682E9268D56@beyondsoft.dyndns.org>
Message-ID: <Pine.LNX.4.63.0710311140480.25155@redbean.intranet.gw-instruments.de>
References: <307f591f0710301305n410b8ebds4fa399dd0a518840@mail.gmail.com>
	<56C8D22F4B7F104DBE581411F10682E9268D56@beyondsoft.dyndns.org>
MIME-Version: 1.0
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


Dear, 

what Paul likes to do is a fast inquiry. The time a Bluetooth device does 
an Inquiry can be set by an HCI command. So first of all I think he should 
use the HCI layer directly, not the libraries on top of it.

If you want to use multiple dongles there is a concurrency problem. 
In theory it should be possible to synchronize multiple dongles, but in 
practice you need access to the baseband / link manger layer, which you 
usualy don't have. It is part of the dongle firmware and this is not 
disclosed by the chip manufacturers. 

You can also build your own RF / basband Hardware and write a specialized 
baseband firmware for this. Don't name the resulting device Bluetooth or 
use the Bluetooth Logo on it because it will for sure not be possible to 
get such a beast through Bluetooth qualification. 

However, this stuff is completly off topic and not related to BlueZ at 
all. 

Ciao, 

Peter 

On Wed, 31 Oct 2007, Matthias Becker wrote:

> A scan takes about 10 seconds. Only the name resolution takes that long.
> Names can be resolved in parallel using many adapters.
> 
>  
> 
> Von: bluez-devel-bounces@lists.sourceforge.net
> [mailto:bluez-devel-bounces@lists.sourceforge.net] Im Auftrag von Paul
> Huber
> Gesendet: Dienstag, 30. Oktober 2007 21:06
> An: bluez-devel@lists.sourceforge.net
> Betreff: [Bluez-devel] multi-frequency scanning & possible contract work
> 
>  
> 
> I need to use a directional antenna focused on an area about 6 meters x
> 6 meters that can scan for Bluetooth mobile phones as they pass through
> the area, and identify them very quickly.  It's for a new startup
> business that's focusing on a retail application running on an embedded
> Linux box. 
> 
> The problem with the usual usb Bluetooth dongle and a normal scan is
> that in a busy area with hundreds of Bluetooth phones nearby, the scan
> can take a very long time, like several minutes, and will pick up lots
> of phones of people all over the store.  We just want to detect them
> when they come in through the entrance.  So, we're going to use a
> directional antenna that focuses just on a 6 meter x 6 meter space in
> front of the entrance so it doesn't pick up phones outside that area. 
> 
> However there's still a problem that a traditional Bluetooth scan takes
> 15+ seconds to pickup devices, and that's too long.  The shopper may
> pass through the detection area in only a couple seconds.  So we need to
> be able to do the scans very quickly. 
> 
> I don't know that much about the underlying technology, but I understand
> that a typical Bluetooth scan consists of scanning across several
> frequencies and hopping from frequency to frequency to find phones on
> each frequency.  Therefore, my question is this: instead of having 1
> bluetooth dongle that's hopping across several frequencies, can we hook
> up multiple bluetooth dongles to the same antenna, and have each one
> locked onto just one frequency to make the process go faster?  In other
> words, can we balance the 15 second scanning process across 5 Bluetooth
> dongles so we can do the same scan in only 3 seconds? 
> 
> If not, does anybody else have any suggestions for how to accomplish the
> end goal of being able to very rapidly detect phones as they pass
> through an area?
> 
> We do have a little bit of funding, so if something like the
> multi-dongle approach method i mentioned works, and it requires some
> special coding or mods to bluez, we could compensate a developer for
> helping out with this. 
> 
> Thanks
> 
> 


|       Peter Wippich                   Voice: +49 30 46776411          |
|       G&W Instruments GmbH            fax:   +49 30 46776419          |
|       Gustav-Meyer-Allee 25, Geb. 12  Email: pewi@gw-instruments.de   |
|       D-13355 Berlin  / Germany                                       |


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
