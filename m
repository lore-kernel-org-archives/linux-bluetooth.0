Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Bluetooth MIME types and URIs
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
Cc: kde-bluetooth@liste.ferrara.linux.it
In-Reply-To: <e1effdeb05070805454b8960b6@mail.gmail.com>
References: <1120747365.18553.15.camel@pegasus>
	 <200507071900.33313.bluez-devel@schaettgen.de>
	 <1120759981.18553.52.camel@pegasus>
	 <200507080315.50686.bluez-devel@schaettgen.de>
	 <1120804711.18553.100.camel@pegasus>
	 <e1effdeb05070805454b8960b6@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1120834052.18553.123.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 08 Jul 2005 16:47:32 +0200

Hi Claudio,

> Basically two bus type are available: system and session.
> System bus is not able to start applications with user interfaces
> because the dbus-daemon is running with root permissions.

why is activation not working with the system bus. However we might have
to use system and session bus at the same time.

> Use DBUS for request BlueZ services will be nice because it's 
> possible handle security issues and concurrency.

This is the basic idea and it is the reason for putting everything
inside bluetoothd and designing a new kernel interface.

> DBus signal can be used to notify all D-BUS registered applications about
> new devices, new services, connection problems, ...

The new InquiryResult and RemoteName signals are implemented in hcid for
testing. Start "dbus-monitor --system" and call "hcitool scan".

> D-Bus is under development and some changes can occur, but it's
> possible develop some workarround to make the application compliant
> with Dbus 0.34, 0.33 and 0.23.

I already did that, but I am not very happy with it. I actually really
like to see the 1.0 release of their API.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
