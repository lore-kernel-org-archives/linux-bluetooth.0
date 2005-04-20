Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain
Message-Id: <1114018227.2469.206.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Comment about bdaddr and pskey tools
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
Date: Wed, 20 Apr 2005 19:30:27 +0200

Hi Folks,

today Marco Trudel convinced me to write a tool for changing the boot
mode of CSR based HID proxy dongles. For example the D-Link DBT-120 with
the Apple firmware update. Actually he offered me money for it and now I
can go and buy myself another Bluetooth toy :)

Speaking of which, it is always possible to make donations. It must not
be money, because I also like to get my hands on old Bluetooth devices
and especially phones. For example if you have a Nokia 6310i or an Sony
Ericsson T610 that you don't need/use anymore I am happy to play with
it. Contact me or take a look at this page:

	http://www.bluez.org/sponsors.html

Now back to the tools ...

The bluez-utils CVS contains now a tool called pskey. This tool is
capable of reading and writing the SCO mapping value and the value of
the boot mode. Be careful, because you can render your device useless.

And while I was at coding CSR based stuff, I added support for changing
the BD_ADDR for these devices to bdaddr.

Both utilities are marked with noinst and this is how it should be,
because they are development tools and none of them should end up in any
distribution. Developers know how to deal with source code.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
