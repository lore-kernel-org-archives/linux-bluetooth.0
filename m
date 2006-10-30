Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <45451325.2050703@xmission.com>
References: <45451325.2050703@xmission.com>
Date: Mon, 30 Oct 2006 10:37:00 +0100
Message-Id: <1162201020.24333.24.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] hid flowchart workup
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

Hi Brad,

> I thought I would work up the HID flowchart while it was still fresh.
> Found it's gone a bit cold already. Maybe Albert could pipe in with some
> references for example code. Do we need code references for the methods
> used before and after dbus changes to hidd?

just to fill in the gap where this comes from. We were discussing what
is needed to make it possible to fully install a Linux desktop using a
Bluetooth keyboard and mouse only. So every distribution needs to
implement this kind of work flow in their installer.

> This is what I pieced together:
> 
> 1. Enumerate input devices
>  (is there a better method than scanning /dev/input/ for mouse*? what
> about keyboard?)

Don't know yet, but basically you look at /sys/class/input for the
information about attached input devices.

> 2. Any present? Skip to end
> 3. Start hcid and hidd
> 4. HID -> HCI
>   (I can't put together from my notes what this HID->HCI step meant...)

These are HID proxy capable dongles. They can be either pretend to be a
Bluetooth USB dongle or a USB mouse/keyboard combo.

> 5. Tell user to make devices discoverable
> 6. Enumerate input devices again
> 7. Inquiry (api details)

Call org.bluez.Adapter.DiscoverDevices().

> 8. Connect to mouse (api details)
> 9. Connect to keyboard (api details)
> 10. Enumerate devices.
> 11. No devices present still? Jump to 5.
>   (Is it no devices or is the test for both keyboard and mouse present?)

If you attach a USB keyboard or mouse in that time, then this is also
fine and will end this process.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
