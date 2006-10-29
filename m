Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45451325.2050703@xmission.com>
Date: Sun, 29 Oct 2006 13:46:29 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] hid flowchart workup
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

Hey

Hello from the plane! Just crossed Greenland.

I thought I would work up the HID flowchart while it was still fresh.
Found it's gone a bit cold already. Maybe Albert could pipe in with some
references for example code. Do we need code references for the methods
used before and after dbus changes to hidd?

This is what I pieced together:

1. Enumerate input devices
 (is there a better method than scanning /dev/input/ for mouse*? what
about keyboard?)
2. Any present? Skip to end
3. Start hcid and hidd
4. HID -> HCI
  (I can't put together from my notes what this HID->HCI step meant...)
5. Tell user to make devices discoverable
6. Enumerate input devices again
7. Inquiry (api details)
8. Connect to mouse (api details)
9. Connect to keyboard (api details)
10. Enumerate devices.
11. No devices present still? Jump to 5.
  (Is it no devices or is the test for both keyboard and mouse present?)

Brad

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
