Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45479372.7060404@xmission.com>
Date: Tue, 31 Oct 2006 11:18:26 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <45451325.2050703@xmission.com>
	<1162201020.24333.24.camel@localhost>
In-Reply-To: <1162201020.24333.24.camel@localhost>
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

Marcel

ok... more details worked out and just a couple points missing. I added
details for if the user has a working input device but may want to
connect another bt device. This might be nice early in the install for a
bt mouse for example so keyboard shortcuts don't have to be used for the
whole install.

These are the steps an installer will need to fully install a Linux
desktop using a Bluetooth keyboard and mouse only. Every distribution
needs to implement this kind of workflow in their installer. When the
user is asked a question, it should be easy for them to use just the
keyboard or just the mouse (if only one is present) to answer.

1. Enumerate input devices (scan /sys/class/input), go to 3 if none.
2. Ask user if they need to pair any bluetooth input devices. If no, end.
3. Start hcid and hidd
4. run hid2hci to put any hid mode dongle in hci mode
5. Tell user to make devices discoverable
6. Enumerate input devices again
7. Inquiry (Call org.bluez.Adapter.DiscoverDevices())
8. Connect to mouse (api details)
9. Connect to keyboard (api details)
10. Enumerate devices.
11. No devices present still, including plain usb? Jump to 5.
12. Ask user if any remaining devices need to be paired. If yes, jump to 5
13. (Later) copy pairing info from ramdisk to the root of the new system

I think steps 8 & 9 change as we implement dbus pathways. Before dbus,
it would be done by executing
 hidd --search
but eventually could be dbus signals to hidd to search for each type of
device.

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
