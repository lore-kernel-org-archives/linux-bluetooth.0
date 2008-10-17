Return-Path: <cyrus@holtmann.org>
Message-ID: <2411f6b20810162244r2daf27bexb1edda4c97637030@mail.gmail.com>
Date: Fri, 17 Oct 2008 11:14:36 +0530
From: "Joey Krane" <linuxbsd2004@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Bluetooth headset pairing with F10 beta
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I inserted my Belkin USB bluetooth adapter (F8T001 Ver. 2) to Fedora
10 beta (with all updates as of 10 Oct)

<snip>
Oct 16 12:24:00 localhost kernel: usb 3-1: new full speed USB device
using ohci_hcd and address 3
Oct 16 12:24:00 localhost kernel: usb 3-1: configuration #1 chosen from 1 choice
Oct 16 12:24:00 localhost kernel: usb 3-1: New USB device found,
idVendor=050d, idProduct=0081
Oct 16 12:24:00 localhost kernel: usb 3-1: New USB device strings:
Mfr=0, Product=0, SerialNumber=0
Oct 16 12:24:01 localhost kernel: Bluetooth: Core ver 2.13
Oct 16 12:24:01 localhost kernel: NET: Registered protocol family 31
Oct 16 12:24:01 localhost kernel: Bluetooth: HCI device and connection
manager initialized
Oct 16 12:24:01 localhost kernel: Bluetooth: HCI socket layer initialized
Oct 16 12:24:01 localhost kernel: Bluetooth: Generic Bluetooth USB
driver ver 0.3
Oct 16 12:24:01 localhost kernel: usbcore: registered new interface driver btusb
Oct 16 12:27:48 localhost bluetoothd[2692]: Bluetooth daemon
Oct 16 12:27:48 localhost bluetoothd[2692]: Starting SDP server
Oct 16 12:27:48 localhost kernel: Bluetooth: L2CAP ver 2.11
Oct 16 12:27:48 localhost kernel: Bluetooth: L2CAP socket layer initialized
Oct 16 12:27:48 localhost bluetoothd[2692]: Parsing
/etc/bluetooth/input.conf failed: No such file or directory
Oct 16 12:27:48 localhost bluetoothd[2692]: Parsing
/etc/bluetooth/audio.conf failed: No such file or directory
Oct 16 12:27:48 localhost kernel: Bluetooth: SCO (Voice Link) ver 0.6
Oct 16 12:27:48 localhost kernel: Bluetooth: SCO socket layer initialized
Oct 16 12:27:48 localhost bluetoothd[2692]: Parsing
/etc/bluetooth/network.conf failed: No such file or directory
Oct 16 12:27:49 localhost kernel: Bluetooth: BNEP (Ethernet Emulation) ver 1.3
Oct 16 12:27:49 localhost kernel: Bluetooth: BNEP filters: protocol multicast
Oct 16 12:27:49 localhost kernel: Bridge firewalling registered
Oct 16 12:27:49 localhost bluetoothd[2692]: bridge pan0 created
Oct 16 12:27:49 localhost bluetoothd[2692]: HCI dev 0 registered
Oct 16 12:27:49 localhost kernel: pan0: Dropping NETIF_F_UFO since no
NETIF_F_HW_CSUM feature.
Oct 16 12:27:49 localhost bluetoothd[2692]: HCI dev 0 up
Oct 16 12:27:49 localhost bluetoothd[2692]: Registered interface
org.bluez.Service on path /org/bluez/hci0
Oct 16 12:27:49 localhost kernel: Bluetooth: RFCOMM socket layer initialized
Oct 16 12:27:49 localhost kernel: Bluetooth: RFCOMM TTY layer initialized
Oct 16 12:27:49 localhost kernel: Bluetooth: RFCOMM ver 1.10
Oct 16 12:27:49 localhost bluetoothd[2692]: Registered interface
org.bluez.SerialProxyManager on path /org/bluez/hci0
Oct 16 12:27:49 localhost bluetoothd[2692]: Registered interface
org.bluez.NetworkPeer on path /org/bluez/hci0
Oct 16 12:27:49 localhost bluetoothd[2692]: Registered interface
org.bluez.NetworkHub on path /org/bluez/hci0
Oct 16 12:27:49 localhost bluetoothd[2692]: Registered interface
org.bluez.NetworkRouter on path /org/bluez/hci0
Oct 16 12:27:49 localhost bluetoothd[2692]: Adapter /org/bluez/hci0
has been enabled
</snip>

Then the bluetooth icon appeared on the GNOME task bar. I clicked
"Setup new device" and it showed me only the mac id of the device
(Jabra BT125 headset). On selecting it and clicking Forward,  the
window closed and nothing happened (I tried this about 3 times).  Here
are the logs,

<snip>
Oct 16 12:27:49 localhost bluetoothd[2692]: Starting security manager 0
Oct 16 12:27:58 localhost bluetoothd[2692]: Discovery session
0x7f5c0ea096f0 with :1.49 activated
Oct 16 12:28:07 localhost bluetoothd[2692]: Discovery session
0x7f5c0ea096f0 with :1.49 deactivated
Oct 16 12:28:32 localhost bluetoothd[2692]: Discovery session
0x7f5c0e9fadd0 with :1.50 activated
Oct 16 12:28:41 localhost bluetoothd[2692]: Discovery session
0x7f5c0e9fadd0 with :1.50 deactivated
Oct 16 12:28:53 localhost bluetoothd[2692]: Discovery session
0x7f5c0e9fadd0 with :1.51 activated
Oct 16 12:29:00 localhost bluetoothd[2692]: Discovery session
0x7f5c0e9fadd0 with :1.51 deactivated
Oct 16 12:31:14 localhost bluetoothd[2692]: Discovery session
0x7f5c0e9fadd0 with :1.52 activated
Oct 16 12:31:20 localhost bluetoothd[2692]: Discovery session
0x7f5c0e9fadd0 with :1.52 deactivated
Oct 16 12:33:07 localhost bluetoothd[2692]: Discovery session
0x7f5c0ea06ba0 with :1.53 activated
Oct 16 12:33:14 localhost bluetoothd[2692]: Discovery session
0x7f5c0ea06ba0 with :1.53 deactivated
</snip>

Then, I opened a terminal and ran these,

<snip>
[root@localhost jk]# hcitool scan
Scanning ...
    00:1D:82:3C:62:E2    Jabra BT125
[root@localhost jk]# hcitool cc 00:1D:82:3C:62:E2
[root@localhost jk]#
</snip>

Then, I ran "Setup new device" again and this time, it showed me the
name "Jabra BT125" instead of the mac id. On selecting the device and
clicking "Forward", I get a next screen that says "Please enter PIN
0000". After wating a few seconds it said something about "connected"
I dont remember the exact message.

<snip>
Oct 16 12:33:15 localhost bluetoothd[2692]: link_key_request
(sba=00:0A:3A:50:1F:2D, dba=00:1D:82:3C:62:E2)
Oct 16 12:33:15 localhost bluetoothd[2692]: pin_code_request
(sba=00:0A:3A:50:1F:2D, dba=00:1D:82:3C:62:E2)
Oct 16 12:33:15 localhost bluetoothd[2692]: link_key_notify
(sba=00:0A:3A:50:1F:2D, dba=00:1D:82:3C:62:E2)
Oct 16 12:33:19 localhost bluetoothd[2692]: Registered interface
org.bluez.Input on path /org/bluez/hci0/dev_00_1D_82_3C_62_E2
Oct 16 12:33:19 localhost bluetoothd[2692]: Registered interface
org.bluez.Headset on path /org/bluez/hci0/dev_00_1D_82_3C_62_E2
</snip>

Here's additional info

<snip>
[root@localhost jk]# rpm -q kernel
kernel-2.6.27-0.352.rc7.git1.fc10.x86_64
kernel-2.6.27-3.fc10.x86_64
[root@localhost jk]# rpm -q bluez
bluez-4.13-2.fc10.x86_64
[root@localhost jk]#
</snip>

I haven't really figured out how to use this device yet. But i'm so
thrilled that I got this far which I couldn't with Fedora 9!

I would like to use this device in Skype and Ekiga. Any hints?

Thanks!
Steve
