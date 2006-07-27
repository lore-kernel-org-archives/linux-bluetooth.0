Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Anselm Martin Hoffmeister <anselm@hoffmeister-online.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1153932509.13885.74.camel@panic>
References: <1153857069.6181.26.camel@anselm.venusberg.augustinnetz.de>
	<1153932509.13885.74.camel@panic>
Date: Thu, 27 Jul 2006 16:51:21 +0200
Message-Id: <1154011882.6222.10.camel@anselm.venusberg.augustinnetz.de>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] HIDclient: Using a Bluez PC as
	virtual	Bluetooth	keyboard and mouse
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Am Mittwoch, den 26.07.2006, 18:48 +0200 schrieb Collin R. Mulliner:
> Cool, but do I read right - it only supports REPORT mode? 
> 
> My HID keyboard (http://www.mulliner.org/bluetooth/xkbdbthid.php) so far
> only supports BOOT mode... I allways wanted to implement report mode.

It is a matter of choice. The boot mode is not at all BAD, and in
reality, iirc, the "report mode" report can look exactly like the "boot
mode" reports. The difficulty with boot mode though is that a given
device can only be keyboard OR mouse, so for mimicking both from the
same computer, you would need two connections. This again will hinder
you from using the standard "ports" for the HID protocol (namely the
0x11/0x13 pair) for both those devices, and most probably one of the two
will not work with the more braindead implementations out there. Let us
name the Widcomm stack which sometimes behaves oddly, for my
understanding.

That is the reason why I chose the "report mode" - it gives me the
opportunity to deliver both mouse and keyboard data over the same data
channel.

Looking at the code you will find that I use two different reports
though, with ID "1" for mouse reports and ID "2" for keyboard reports.
Moving the mouse, you generate a "1" record, which only contains mouse
information, and vice versa, and those two reports are iirc fairly
similar to the boot protocol reports. You will find more detailed
information in the Bluetooth HID spec, and, most probably also in the
USB HID spec. If you intend to make my hidclient code boot-mode
compatible, you could drop either keyboard or mouse functions, set the
appropriate flags in the SDP information (is_bootmode_device or
similar), and change the details of the report that are not exactly boot
mode. That is why I hand out a hex mode report descriptor - so that it
can be adapted to the developer's needs.

Let's say you wish to add joystick support. Yes, that would be possible:
Go into the input event handling subroutine, implement some code that
reads the Linux joystick events and generates a "joystick report" -
which would be defined in the HID descriptor as well. Not too much magic
needed ;-) You might to implement a logic to recognize switching between
the two modes - I cannot tell you out of my head. A boot-mode-only thing
would of course live without that logic.

If you want to implement report mode for your Xkbdbt, you will need a
proper report descriptor, the rest is mostly straightforward. If you
want me to have a look over your code, feel free to write PM or ask
questions on the list.

Regards
Anselm

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
