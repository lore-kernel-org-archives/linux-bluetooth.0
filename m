Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44A9923A.4050200@runbox.com>
Date: Mon, 03 Jul 2006 22:55:06 +0100
From: Tom K <tomk@runbox.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] hcid fails to start after upgrade to
	bluez-libs/bluez-utils 3.1 (Continued)
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

Apologies for the second thread - I had some system problems which 
delayed my list subscription request.

On 7/3/06, Claudio Takahasi <cktakahasi@gm...> wrote:
 > Hi Tom,
 >

Many thanks for your reply, Claudio.

 > Which D-Bus version are you running?
 >

Version 0.62.

 > Check if the BlueZ D-Bus configuration file(bluez-hcid.conf) is in the
 > following directory:
 > /etc/dbus-1/system.d/

Yes, it's there.

 >
 > After upgrade bluez-utils you need restart dbus-daemon to load the
 > bluez-hcid.conf file.

I probably didn't do that the first time. I've done it now, though, and 
things aren't good. I've removed the pin_helper and auth lines from 
hcid.conf, as per the original error message, and added the passkey 
line. Starting from a reboot, here are the relevant log entries.

Module loading:
Bluetooth: Core ver 2.8
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: HCI USB driver ver 2.9
usbcore: registered new driver hci_usb

hcid starting:
hcid[2126]: Bluetooth HCI daemon
hcid[2126]: Register path:/org/bluez fallback:1
hcid[2126]: Device hci0 has been added
hcid[2126]: Can't read version info for hci0: Connection timed out (110)
hcid[2126]: Register path:/org/bluez/hci0 fallback:0
hci_cmd_task: hci0 command tx timeout
hcid[2126]: HCI dev 0 up
hcid[2126]: Starting security manager 0

USB disconnect/reconnect:
usb 1-1.1: USB disconnect, address 3
usb 1-1.1: new full speed USB device using uhci_hcd and address 5
usb 1-1.1: configuration #1 chosen from 1 choice

hcid restarting:
hcid[2126]: Can't write inquiry mode for hci0: Connection timed out (110)
hcid[2126]: HCI dev 0 down
hcid[2126]: Stoping security manager 0
hcid[2126]: Device hci0 has been disabled
hcid[2126]: HCI dev 0 unregistered
hcid[2126]: Unregister path:/org/bluez/hci0
hcid[2126]: Device hci0 has been removed
hcid[2126]: HCI dev 0 registered
hcid[2126]: Device hci0 has been added
hcid[2126]: Register path:/org/bluez/hci0 fallback:0
hci_cmd_task: hci0 command tx timeout
hcid[2126]: Sending read scan enable command failed: Connection timed 
out (110)
hcid[2126]: HCI dev 0 up
hcid[2126]: Starting security manager 0


USB disconnect/reconnect:
usb 1-1.1: USB disconnect, address 5
usb 1-1.1: new full speed USB device using uhci_hcd and address 6
usb 1-1.1: configuration #1 chosen from 1 choice

etc.

The hcid and USB logs above alternated continuously, with the USB 
address incrementing each time, until I halted hcid.

I then unplugged the dongle, unloaded the module, and started again, 
with more success this time. Again, here are the logs.

Module:
Bluetooth: Core ver 2.8
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: HCI USB driver ver 2.9
usbcore: registered new driver hci_usb

hcid & USB:
hcid[14066]: Bluetooth HCI daemon
hcid[14066]: Register path:/org/bluez fallback:1
hcid[14066]: Device hci0 has been added
hcid[14066]: Can't write inquiry mode for hci0: Connection timed out (110)
hcid[14066]: Register path:/org/bluez/hci0 fallback:0
hci_cmd_task: hci0 command tx timeout
hcid[14066]: Sending read scan enable command failed: Connection timed 
out (110)
usb 1-1.1: USB disconnect, address 66
hcid[14066]: Can't read address for hci0: Connection timed out (110)
hcid[14066]: HCI dev 0 up
hcid[14066]: Starting security manager 0
hcid[14066]: Can't open device hci0: No such device (19)
hcid[14066]: Can't open device hci0
hcid[14066]: HCI dev 0 down
hcid[14066]: Device hci0 has been disabled
hcid[14076]: Can't open device hci0: No such device (19)
hcid[14066]: HCI dev 0 unregistered
hcid[14066]: Unregister path:/org/bluez/hci0
usb 1-1.1: new full speed USB device using uhci_hcd and address 67
usb 1-1.1: configuration #1 chosen from 1 choice

There were no further USB disconnects. hciconfig showed the device down, 
but I was able to bring it up, and then use it as normal.

Regards
Tom K.

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
