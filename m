Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <cbf0aec90410291619764dc557@mail.gmail.com>
From: =?ISO-8859-1?Q?Henryk_Pl=F6tz?= <ploetz@gmail.com>
Reply-To: =?ISO-8859-1?Q?Henryk_Pl=F6tz?= <ploetz@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Connection Timeout
In-Reply-To: <1099090255.12760.26.camel@athene.covidimus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1099090255.12760.26.camel@athene.covidimus.net>
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
Date: Sat, 30 Oct 2004 01:19:01 +0200

Moin,

On Fri, 29 Oct 2004 17:50:55 -0500, Stephen Quattlebaum
<stephen@covidimus.net> wrote:

> I just bought a Microsoft BT mouse for a Win XP laptop and decided this
> afternoon to take it for a spin on my Linux box.

I've got one myself and found it significantly more complicated to get
to run under Windows than under Linux.

> "Wireless Transceiver for Bluetooth 2.0"

Interesting. Mine lacks the "2.0" addition, so yours is probably a newer de=
vice.

> usbview shows the dongle with the name "Wireless Radio for Bluetooth",

It says "Wireless Transceiver for Bluetooth" here.

> and its name is in red, which I've been led to believe means that no
> drivers have attached themselves to the device.  I don't know if that's
> important here or not.

Probably not. The aforementioned Microsoft-Dongle as well as my
Laptop's integrated Bluetooth both show red in usbview, and both work
with BlueZ.

> I'd paste in the usbview output but usbview
> appears to not support whatever flavor of cut-and-paste gnome uses.

You did try to simply select in usbview (left mouse button) and paste
in whatever other application (middle mouse button or left and right
mouse buttons simultaneously if you don't have a middle button), did
you? Because that just works for me and my usbview.

> When I plug in the dongle, the mouse just starts working without me
> having to do anything at all (though some of the buttons don't work,
> even the scrollwheel, which is working on another USB mouse attached to
> this system).

This is Not Good[tm]. It probably means that your newer version of the
dongle is capable of handling HID connections itself (until now I
thought only Logitech's would do that) and thus probably spoofing to
be just some random USB mouse to your computer.

> athene bluetooth # hciconfig
> hci0:   Type: USB
>         BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
>         DOWN

This reinforces my belief. You surely can't have a Bluetooth HID
connection when your Bluetooth device is down.

I guess you probably need to do what all those users of the Logitech
Wireless Hub do: Use hid2hci to switch the dongle from "Let's pretend
I was a mouse" mode over to "Yet another boring Bluetooth dongle"

--
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
