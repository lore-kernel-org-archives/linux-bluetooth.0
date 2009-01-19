Return-Path: <cyrus@holtmann.org>
Message-ID: <49750C60.4090001@powercraft.nl>
Date: Tue, 20 Jan 2009 00:27:28 +0100
From: Jelle de Jong <jelledejong@powercraft.nl>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Sony BD Remote Control still does not make input event, what part
 of the driver is driver missing?
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I thought I gave my Sony PS3 Bluetooth remote an other try, see all my
previous messages trials and bug reports back in the mail archive.

The device still does not create an input event that can be used out of
the box. What parts are missing to get this working?

The device connects with the gnome bluetooth tool, you see the connect
icon go on very short then the connect icons goes away. hcitool con also
does not show the device and there is no input event created.

What is going on here? And what need to be done here.

Best regards,

Jelle de Jong

# bluez build on 2009-01-17
apt-show-versions | fgrep bluez
bluez-gnome 1.9git newer than version in archive
bluez-utils 4.27git newer than version in archive

apt-show-versions | fgrep /experimental
xserver-common/experimental uptodate 2:1.5.3-1
xserver-xorg/experimental uptodate 1:7.4~4
xserver-xorg-core/experimental uptodate 2:1.5.3-1
xserver-xorg-input-evdev/experimental uptodate 1:2.1.0-1
xserver-xorg-input-kbd/experimental uptodate 1:1.3.1-2
xserver-xorg-input-mouse/experimental uptodate 1:1.3.0-2
xserver-xorg-input-synaptics/experimental uptodate 0.15.0+git20080820-1
xserver-xorg-video-intel/experimental uptodate 2:2.6.0-1

bluetoothd[2466]: Agent registered for hci0 at :1.23:/org/bluez/agent/hci0
bluetoothd[2466]: Agent registered for hci1 at :1.23:/org/bluez/agent/hci1
bluetoothd[2466]: Removing device /org/bluez/2466/hci1/dev_00_1E_3D_15_0A_4F
bluetoothd[2466]: input_remove: path
/org/bluez/2466/hci1/dev_00_1E_3D_15_0A_4F
bluetoothd[2466]: Unregistered interface org.bluez.Input on path
/org/bluez/2466/hci1/dev_00_1E_3D_15_0A_4F
bluetoothd[2466]: Discovery session 0xb8dba410 with :1.25 activated
bluetoothd[2466]: session_ref(0xb8dba410): ref=1
bluetoothd[2466]: session_unref(0xb8dba410): ref=0
bluetoothd[2466]: Discovery session 0xb8dba410 with :1.25 deactivated
bluetoothd[2466]: Stopping discovery
bluetoothd[2466]: create_device(00:1E:3D:15:0A:4F)
bluetoothd[2466]: adapter_create_device(00:1E:3D:15:0A:4F)
bluetoothd[2466]: Creating device /org/bluez/2466/hci1/dev_00_1E_3D_15_0A_4F
bluetoothd[2466]: adapter_get_device(00:1E:3D:15:0A:4F)
bluetoothd[2466]: Probe drivers for
/org/bluez/2466/hci1/dev_00_1E_3D_15_0A_4F
bluetoothd[2466]: hid_device_probe: path
/org/bluez/2466/hci1/dev_00_1E_3D_15_0A_4F
bluetoothd[2466]: Registered interface org.bluez.Input on path
/org/bluez/2466/hci1/dev_00_1E_3D_15_0A_4F


ls -hal /dev/input/by-path/
total 0
drwxr-xr-x 2 root root 160 2009-01-15 12:40 .
drwxr-xr-x 3 root root 300 2009-01-15 12:40 ..
lrwxrwxrwx 1 root root   9 2009-01-15 12:40
pci-0000:00:1d.3-usb-0:acl0007618A1AAA-event- -> ../event8
lrwxrwxrwx 1 root root   9 2009-01-15 12:40
pci-0000:00:1d.3-usb-0:acl111111111795- -> ../mouse1
lrwxrwxrwx 1 root root   9 2009-01-15 12:40
pci-0000:00:1d.3-usb-0:acl111111111795-event- -> ../event7
lrwxrwxrwx 1 root root   9 2009-01-15 12:39
platform-i8042-serio-0-event-kbd -> ../event0
lrwxrwxrwx 1 root root   9 2009-01-15 12:39
platform-i8042-serio-1-event-mouse -> ../event2
lrwxrwxrwx 1 root root   9 2009-01-15 12:39 platform-i8042-serio-1-mouse
-> ../mouse0

hcitool con
Connections:
	> ACL 00:07:61:8A:1A:AA handle 12 state 1 lm MASTER AUTH ENCRYPT
	> ACL 11:11:11:11:17:95 handle 11 state 1 lm MASTER

hcitool scanning
Scanning ...
	00:1E:3D:15:0A:4F	BD Remote Control



