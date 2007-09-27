Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46FBC1AE.4020404@idlum.be>
Date: Thu, 27 Sep 2007 16:43:58 +0200
From: Pierre-Yves Paulus <py@idlum.be>
MIME-Version: 1.0
To: Cornelia Huck <cornelia.huck@de.ibm.com>
References: <46F92364.3080603@idlum.be>	<46F952BD.4010009@redhat.com>	<46FA5E2E.3010300@idlum.be>
	<20070927085658.1c66f1c8@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20070927085658.1c66f1c8@gondolin.boeblingen.de.ibm.com>
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, Chuck Ebbert <cebbert@redhat.com>
Subject: Re: [Bluez-devel] Warnings and Oops on 2.6.23-rc6 while activily
 using rfcomm links (mm/slab.c)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello,

>>> Please use CONFIG_SLUB and turn on SLUB debugging. Something is very wr=
ong
>>> somewhere...
>> I did so, on 2.6.23-rc8. I also did include CONFIG_DEBUG_DRIVER and =

>> CONFIG_DEBUG_KOBJECT, following Cornelia Huck's advice.
> =

> Did you see any messages (from the driver core) surrounding
> kobject_move() usage or the kref badness messages? I'm asking because
> refcounting/lifetime issues may be the reason for your problems...

I just figured out how to get KERN_DEBUG to the serial console for =

capture...

Here is what I got (same kernel config as before) so far:

Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.8
DEV: registering device: ID =3D 'acl00E0033364E5'
kobject acl00E0033364E5: registering. parent: hci1, set: devices
PM: Adding info for bluetooth:acl00E0033364E5
bus bluetooth: add device acl00E0033364E5
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.4/1-1.4.1/1-1.4.1:1.0/hci1/a=
cl00E0033364E5'
DEV: registering device: ID =3D 'acl0060574FEB37'
kobject acl0060574FEB37: registering. parent: hci2, set: devices
PM: Adding info for bluetooth:acl0060574FEB37
bus bluetooth: add device acl0060574FEB37
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl0060574FEB37'
DEV: registering device: ID =3D 'acl0017B066F14B'
kobject acl0017B066F14B: registering. parent: hci1, set: devices
PM: Adding info for bluetooth:acl0017B066F14B
bus bluetooth: add device acl0017B066F14B
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.4/1-1.4.1/1-1.4.1:1.0/hci1/a=
cl0017B066F14B'
DEV: registering device: ID =3D 'acl000AD9D7A99A'
kobject acl000AD9D7A99A: registering. parent: hci2, set: devices
PM: Adding info for bluetooth:acl000AD9D7A99A
bus bluetooth: add device acl000AD9D7A99A
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl000AD9D7A99A'
bus bluetooth: remove device acl0060574FEB37
PM: Removing info for bluetooth:acl0060574FEB37
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl0060574FEB37'
kobject acl0060574FEB37: cleaning up
bus bluetooth: remove device acl0017B066F14B
PM: Removing info for bluetooth:acl0017B066F14B
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.4/1-1.4.1/1-1.4.1:1.0/hci1/a=
cl0017B066F14B'
kobject acl0017B066F14B: cleaning up
bus bluetooth: remove device acl000AD9D7A99A
PM: Removing info for bluetooth:acl000AD9D7A99A
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl000AD9D7A99A'
kobject acl000AD9D7A99A: cleaning up
bus bluetooth: remove device acl00E0033364E5
PM: Removing info for bluetooth:acl00E0033364E5
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.4/1-1.4.1/1-1.4.1:1.0/hci1/a=
cl00E0033364E5'
kobject acl00E0033364E5: cleaning up
DEV: registering device: ID =3D 'acl00126253F906'
kobject acl00126253F906: registering. parent: hci2, set: devices
PM: Adding info for bluetooth:acl00126253F906
bus bluetooth: add device acl00126253F906
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl00126253F906'
bus bluetooth: remove device acl00126253F906
PM: Removing info for bluetooth:acl00126253F906
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl00126253F906'
kobject acl00126253F906: cleaning up
DEV: registering device: ID =3D 'acl00E0033364E5'
kobject acl00E0033364E5: registering. parent: hci1, set: devices
PM: Adding info for bluetooth:acl00E0033364E5
bus bluetooth: add device acl00E0033364E5
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.4/1-1.4.1/1-1.4.1:1.0/hci1/a=
cl00E0033364E5'
bus bluetooth: remove device acl00E0033364E5
PM: Removing info for bluetooth:acl00E0033364E5
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.4/1-1.4.1/1-1.4.1:1.0/hci1/a=
cl00E0033364E5'
kobject acl00E0033364E5: cleaning up
DEV: registering device: ID =3D 'acl006057BB4D92'
kobject acl006057BB4D92: registering. parent: hci2, set: devices
PM: Adding info for bluetooth:acl006057BB4D92
bus bluetooth: add device acl006057BB4D92
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl006057BB4D92'
bus bluetooth: remove device acl006057BB4D92
PM: Removing info for bluetooth:acl006057BB4D92
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl006057BB4D92'
kobject acl006057BB4D92: cleaning up
DEV: registering device: ID =3D 'acl000AD9D7A99A'
kobject acl000AD9D7A99A: registering. parent: hci2, set: devices
PM: Adding info for bluetooth:acl000AD9D7A99A
bus bluetooth: add device acl000AD9D7A99A
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl000AD9D7A99A'
DEV: registering device: ID =3D 'rfcomm0'
kobject rfcomm0: registering. parent: tty, set: devices
PM: Adding info for No Bus:rfcomm0
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm0'
DEVICE: moving 'rfcomm0' to 'acl000AD9D7A99A'
fill_kobj_path: path =3D '/class/tty/rfcomm0'
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm0'
DEV: registering device: ID =3D 'acl0017B066F14B'
kobject acl0017B066F14B: registering. parent: hci1, set: devices
PM: Adding info for bluetooth:acl0017B066F14B
bus bluetooth: add device acl0017B066F14B
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.4/1-1.4.1/1-1.4.1:1.0/hci1/a=
cl0017B066F14B'
DEV: registering device: ID =3D 'acl0060574FEB37'
kobject acl0060574FEB37: registering. parent: hci2, set: devices
PM: Adding info for bluetooth:acl0060574FEB37
bus bluetooth: add device acl0060574FEB37
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl0060574FEB37'
DEV: registering device: ID =3D 'acl00E0033364E5'
kobject acl00E0033364E5: registering. parent: hci1, set: devices
PM: Adding info for bluetooth:acl00E0033364E5
bus bluetooth: add device acl00E0033364E5
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.4/1-1.4.1/1-1.4.1:1.0/hci1/a=
cl00E0033364E5'
DEV: registering device: ID =3D 'rfcomm1'
kobject rfcomm1: registering. parent: tty, set: devices
PM: Adding info for No Bus:rfcomm1
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm1'
DEVICE: moving 'rfcomm1' to 'acl0017B066F14B'
fill_kobj_path: path =3D '/class/tty/rfcomm1'
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm1'
DEV: registering device: ID =3D 'rfcomm2'
kobject rfcomm2: registering. parent: tty, set: devices
PM: Adding info for No Bus:rfcomm2
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm2'
DEVICE: moving 'rfcomm2' to 'acl00E0033364E5'
fill_kobj_path: path =3D '/class/tty/rfcomm2'
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm2'
DEV: registering device: ID =3D 'rfcomm3'
kobject rfcomm3: registering. parent: tty, set: devices
PM: Adding info for No Bus:rfcomm3
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm3'
DEVICE: moving 'rfcomm3' to 'acl0060574FEB37'
fill_kobj_path: path =3D '/class/tty/rfcomm3'
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm3'
bus bluetooth: remove device acl000AD9D7A99A
PM: Removing info for bluetooth:acl000AD9D7A99A
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl000AD9D7A99A'
hcidump[12817]: segfault at 080a1798 eip 0805f3c7 esp bf8fd9e0 error 4
DEVICE: moving 'rfcomm0' to '<NULL>'
fill_kobj_path: path =3D '/class/tty/rfcomm0'
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm0'
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl000AD9D7A99A'
kobject acl000AD9D7A99A: cleaning up
DEV: Unregistering device. ID =3D 'rfcomm0'
PM: Removing info for No Bus:rfcomm0
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm0'
kobject rfcomm0: cleaning up
device_create_release called for rfcomm0
bus bluetooth: remove device acl0060574FEB37
PM: Removing info for bluetooth:acl0060574FEB37
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl0060574FEB37'
DEVICE: moving 'rfcomm3' to '<NULL>'
fill_kobj_path: path =3D '/class/tty/rfcomm3'
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm3'
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl0060574FEB37'
kobject acl0060574FEB37: cleaning up
DEV: Unregistering device. ID =3D 'rfcomm3'
PM: Removing info for No Bus:rfcomm3
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm3'
kobject rfcomm3: cleaning up
device_create_release called for rfcomm3
DEV: registering device: ID =3D 'acl00126253F906'
kobject acl00126253F906: registering. parent: hci2, set: devices
PM: Adding info for bluetooth:acl00126253F906
bus bluetooth: add device acl00126253F906
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl00126253F906'
DEV: registering device: ID =3D 'rfcomm0'
kobject rfcomm0: registering. parent: tty, set: devices
PM: Adding info for No Bus:rfcomm0
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm0'
DEVICE: moving 'rfcomm0' to 'acl00126253F906'
fill_kobj_path: path =3D '/class/tty/rfcomm0'
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm0'
DEV: registering device: ID =3D 'acl0060574FEB37'
kobject acl0060574FEB37: registering. parent: hci2, set: devices
PM: Adding info for bluetooth:acl0060574FEB37
bus bluetooth: add device acl0060574FEB37
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl0060574FEB37'
DEV: registering device: ID =3D 'acl000AD9D7A99A'
kobject acl000AD9D7A99A: registering. parent: hci2, set: devices
PM: Adding info for bluetooth:acl000AD9D7A99A
bus bluetooth: add device acl000AD9D7A99A
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl000AD9D7A99A'
DEV: registering device: ID =3D 'rfcomm3'
kobject rfcomm3: registering. parent: tty, set: devices
PM: Adding info for No Bus:rfcomm3
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm3'
DEVICE: moving 'rfcomm3' to 'acl000AD9D7A99A'
fill_kobj_path: path =3D '/class/tty/rfcomm3'
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm3'
bus bluetooth: remove device acl000AD9D7A99A
PM: Removing info for bluetooth:acl000AD9D7A99A
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl000AD9D7A99A'
DEVICE: moving 'rfcomm3' to '<NULL>'
fill_kobj_path: path =3D '/class/tty/rfcomm3'
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm3'
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl000AD9D7A99A'
kobject acl000AD9D7A99A: cleaning up
DEV: Unregistering device. ID =3D 'rfcomm3'
PM: Removing info for No Bus:rfcomm3
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm3'
kobject rfcomm3: cleaning up
device_create_release called for rfcomm3
DEV: registering device: ID =3D 'acl006057BB4D92'
kobject acl006057BB4D92: registering. parent: hci2, set: devices
PM: Adding info for bluetooth:acl006057BB4D92
bus bluetooth: add device acl006057BB4D92
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl006057BB4D92'
bus bluetooth: remove device acl0060574FEB37
PM: Removing info for bluetooth:acl0060574FEB37
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl0060574FEB37'
kobject acl0060574FEB37: cleaning up
DEV: Unregistering device. ID =3D 'rfcomm2'
PM: Removing info for No Bus:rfcomm2
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm2'
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.4/1-1.4.1/1-1.4.1:1.0/hci1/a=
cl00E0033364E5'
kobject rfcomm2: cleaning up
device_create_release called for rfcomm2
bus bluetooth: remove device acl0017B066F14B
PM: Removing info for bluetooth:acl0017B066F14B
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.4/1-1.4.1/1-1.4.1:1.0/hci1/a=
cl0017B066F14B'
DEVICE: moving 'rfcomm1' to '<NULL>'
fill_kobj_path: path =3D '/class/tty/rfcomm1'
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm1'
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.4/1-1.4.1/1-1.4.1:1.0/hci1/a=
cl0017B066F14B'
kobject acl0017B066F14B: cleaning up
DEV: Unregistering device. ID =3D 'rfcomm1'
PM: Removing info for No Bus:rfcomm1
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm1'
kobject rfcomm1: cleaning up
device_create_release called for rfcomm1
DEV: registering device: ID =3D 'acl0060574FEB37'
kobject acl0060574FEB37: registering. parent: hci2, set: devices
PM: Adding info for bluetooth:acl0060574FEB37
bus bluetooth: add device acl0060574FEB37
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl0060574FEB37'
DEV: registering device: ID =3D 'rfcomm1'
kobject rfcomm1: registering. parent: tty, set: devices
PM: Adding info for No Bus:rfcomm1
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm1'
DEVICE: moving 'rfcomm1' to 'acl006057BB4D92'
fill_kobj_path: path =3D '/class/tty/rfcomm1'
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm1'
DEV: registering device: ID =3D 'rfcomm2'
kobject rfcomm2: registering. parent: tty, set: devices
PM: Adding info for No Bus:rfcomm2
kobject_uevent_env
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
BUG kmalloc-128: Poison overwritten
---------------------------------------------------------------------------=
--

INFO: 0xc8340d18-0xc8340d30. First byte 0x6a instead of 0x6b
INFO: Allocated in rfcomm_dev_ioctl+0xbd/0x4e6 [rfcomm] age=3D14954 cpu=3D0 =

pid=3D12789
INFO: Freed in rfcomm_dev_destruct+0x59/0x65 [rfcomm] age=3D2616 cpu=3D0 =

pid=3D12789
INFO: Slab 0xc1106800 used=3D22 fp=3D0xc8340d10 flags=3D0x400000c2
INFO: Object 0xc8340d10 @offset=3D3344 fp=3D0x00000000

Bytes b4 0xc8340d00:  28 32 00 00 27 70 2c 01 5a 5a 5a 5a 5a 5a 5a 5a =

(2..'p,.ZZZZZZZZ
   Object 0xc8340d10:  6b 6b 6b 6b 6b 6b 6b 6b 6a 6b 6b 6b 6b 6b 6b 6b =

kkkkkkkkjkkkkkkk
   Object 0xc8340d20:  6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b =

kkkkkkkkkkkkkkkk
   Object 0xc8340d30:  6a 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b =

jkkkkkkkkkkkkkkk
   Object 0xc8340d40:  6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b =

kkkkkkkkkkkkkkkk
   Object 0xc8340d50:  6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b =

kkkkkkkkkkkkkkkk
   Object 0xc8340d60:  6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b =

kkkkkkkkkkkkkkkk
   Object 0xc8340d70:  6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b =

kkkkkkkkkkkkkkkk
   Object 0xc8340d80:  6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5 =

kkkkkkkkkkkkkkk=A5
  Redzone 0xc8340d90:  bb bb bb bb =

=BB=BB=BB=BB
  Padding 0xc8340db8:  5a 5a 5a 5a 5a 5a 5a 5a =

ZZZZZZZZ
  [<c0158fac>] check_bytes_and_report+0x91/0xb2
  [<c0159214>] check_object+0xc5/0x1c0
  [<c0159e51>] __slab_alloc+0x39e/0x3b1
  [<c016bc39>] ilookup5_nowait+0x33/0x38
  [<c0159fb2>] kmem_cache_alloc+0x48/0x92
  [<c01c6558>] kobject_uevent_env+0xd9/0x3e2
  [<c01c6558>] kobject_uevent_env+0xd9/0x3e2
  [<c0193651>] sysfs_create_group+0x87/0xd6
  [<c0226c99>] bus_add_device+0x16/0x129
  [<c022a03e>] device_pm_add+0x90/0x9a
  [<c0225d9b>] device_add+0x325/0x538
  [<c0226035>] device_create+0x77/0x9a
  [<c020de29>] tty_register_device+0xb5/0xbd
  [<c01c8fa3>] vsnprintf+0x43f/0x47b
  [<d02dd5f5>] rfcomm_dev_ioctl+0x20d/0x4e6 [rfcomm]
  [<d02dc230>] rfcomm_sock_ioctl+0x1e/0x2d [rfcomm]
  [<c0245aee>] sock_ioctl+0x19f/0x1be
  [<c0245c60>] sys_getsockopt+0x60/0x9c
  [<c024594f>] sock_ioctl+0x0/0x1be
  [<c0166255>] do_ioctl+0x19/0x4c
  [<c0166475>] vfs_ioctl+0x1ed/0x204
  [<c01664d8>] sys_ioctl+0x4c/0x64
  [<c0103c72>] syscall_call+0x7/0xb
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
FIX kmalloc-128: Restoring 0xc8340d18-0xc8340d30=3D0x6b

FIX kmalloc-128: Marking all objects used
fill_kobj_path: path =3D '/class/tty/rfcomm2'
DEVICE: moving 'rfcomm2' to 'acl0060574FEB37'
fill_kobj_path: path =3D '/class/tty/rfcomm2'
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm2'
DEV: Unregistering device. ID =3D 'rfcomm1'
PM: Removing info for No Bus:rfcomm1
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm1'
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl006057BB4D92'
kobject rfcomm1: cleaning up
device_create_release called for rfcomm1
bus bluetooth: remove device acl006057BB4D92
PM: Removing info for bluetooth:acl006057BB4D92
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl006057BB4D92'
kobject acl006057BB4D92: cleaning up
DEV: registering device: ID =3D 'acl006057BB4D92'
kobject acl006057BB4D92: registering. parent: hci2, set: devices
PM: Adding info for bluetooth:acl006057BB4D92
bus bluetooth: add device acl006057BB4D92
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl006057BB4D92'
DEV: registering device: ID =3D 'rfcomm1'
kobject rfcomm1: registering. parent: tty, set: devices
PM: Adding info for No Bus:rfcomm1
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm1'
DEVICE: moving 'rfcomm1' to 'acl006057BB4D92'
fill_kobj_path: path =3D '/class/tty/rfcomm1'
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm1'
bus bluetooth: remove device acl0060574FEB37
PM: Removing info for bluetooth:acl0060574FEB37
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl0060574FEB37'
DEVICE: moving 'rfcomm2' to '<NULL>'
fill_kobj_path: path =3D '/class/tty/rfcomm2'
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm2'
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl0060574FEB37'
kobject acl0060574FEB37: cleaning up
DEV: Unregistering device. ID =3D 'rfcomm2'
PM: Removing info for No Bus:rfcomm2
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm2'
kobject rfcomm2: cleaning up
device_create_release called for rfcomm2
bus bluetooth: remove device acl00126253F906
PM: Removing info for bluetooth:acl00126253F906
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl00126253F906'
bus bluetooth: remove device acl006057BB4D92
PM: Removing info for bluetooth:acl006057BB4D92
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl006057BB4D92'
DEVICE: moving 'rfcomm0' to '<NULL>'
fill_kobj_path: path =3D '/class/tty/rfcomm0'
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm0'
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl00126253F906'
kobject acl00126253F906: cleaning up
DEV: Unregistering device. ID =3D 'rfcomm0'
PM: Removing info for No Bus:rfcomm0
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm0'
kobject rfcomm0: cleaning up
device_create_release called for rfcomm0
DEVICE: moving 'rfcomm1' to '<NULL>'
fill_kobj_path: path =3D '/class/tty/rfcomm1'
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm1'
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl006057BB4D92'
kobject acl006057BB4D92: cleaning up
DEV: Unregistering device. ID =3D 'rfcomm1'
PM: Removing info for No Bus:rfcomm1
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm1'
kobject rfcomm1: cleaning up
device_create_release called for rfcomm1
bus bluetooth: remove device acl00E0033364E5
PM: Removing info for bluetooth:acl00E0033364E5
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.4/1-1.4.1/1-1.4.1:1.0/hci1/a=
cl00E0033364E5'
kobject acl00E0033364E5: cleaning up
DEV: registering device: ID =3D 'acl00E0033364E5'
kobject acl00E0033364E5: registering. parent: hci2, set: devices
PM: Adding info for bluetooth:acl00E0033364E5
bus bluetooth: add device acl00E0033364E5
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl00E0033364E5'
DEV: registering device: ID =3D 'acl000AD9D7A99A'
kobject acl000AD9D7A99A: registering. parent: hci1, set: devices
PM: Adding info for bluetooth:acl000AD9D7A99A
bus bluetooth: add device acl000AD9D7A99A
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.4/1-1.4.1/1-1.4.1:1.0/hci1/a=
cl000AD9D7A99A'
DEV: registering device: ID =3D 'acl0017B066F14B'
kobject acl0017B066F14B: registering. parent: hci2, set: devices
PM: Adding info for bluetooth:acl0017B066F14B
bus bluetooth: add device acl0017B066F14B
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl0017B066F14B'
DEV: registering device: ID =3D 'acl0060574FEB37'
kobject acl0060574FEB37: registering. parent: hci1, set: devices
PM: Adding info for bluetooth:acl0060574FEB37
bus bluetooth: add device acl0060574FEB37
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.4/1-1.4.1/1-1.4.1:1.0/hci1/a=
cl0060574FEB37'
bus bluetooth: remove device acl00E0033364E5
PM: Removing info for bluetooth:acl00E0033364E5
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl00E0033364E5'
kobject acl00E0033364E5: cleaning up
bus bluetooth: remove device acl000AD9D7A99A
PM: Removing info for bluetooth:acl000AD9D7A99A
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.4/1-1.4.1/1-1.4.1:1.0/hci1/a=
cl000AD9D7A99A'
kobject acl000AD9D7A99A: cleaning up
bus bluetooth: remove device acl0017B066F14B
PM: Removing info for bluetooth:acl0017B066F14B
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl0017B066F14B'
kobject acl0017B066F14B: cleaning up
bus bluetooth: remove device acl0060574FEB37
PM: Removing info for bluetooth:acl0060574FEB37
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.4/1-1.4.1/1-1.4.1:1.0/hci1/a=
cl0060574FEB37'
kobject acl0060574FEB37: cleaning up
DEV: registering device: ID =3D 'acl006057BB4D92'
kobject acl006057BB4D92: registering. parent: hci2, set: devices
PM: Adding info for bluetooth:acl006057BB4D92
bus bluetooth: add device acl006057BB4D92
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl006057BB4D92'
bus bluetooth: remove device acl006057BB4D92
PM: Removing info for bluetooth:acl006057BB4D92
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl006057BB4D92'
kobject acl006057BB4D92: cleaning up
DEV: registering device: ID =3D 'acl00126253F906'
kobject acl00126253F906: registering. parent: hci1, set: devices
PM: Adding info for bluetooth:acl00126253F906
bus bluetooth: add device acl00126253F906
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.4/1-1.4.1/1-1.4.1:1.0/hci1/a=
cl00126253F906'
bus bluetooth: remove device acl00126253F906
PM: Removing info for bluetooth:acl00126253F906
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.4/1-1.4.1/1-1.4.1:1.0/hci1/a=
cl00126253F906'
kobject acl00126253F906: cleaning up
DEV: registering device: ID =3D 'acl006057BB4D92'
kobject acl006057BB4D92: registering. parent: hci2, set: devices
PM: Adding info for bluetooth:acl006057BB4D92
bus bluetooth: add device acl006057BB4D92
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl006057BB4D92'
DEV: registering device: ID =3D 'acl00126253F906'
kobject acl00126253F906: registering. parent: hci1, set: devices
PM: Adding info for bluetooth:acl00126253F906
bus bluetooth: add device acl00126253F906
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.4/1-1.4.1/1-1.4.1:1.0/hci1/a=
cl00126253F906'
bus bluetooth: remove device acl006057BB4D92
PM: Removing info for bluetooth:acl006057BB4D92
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl006057BB4D92'
kobject acl006057BB4D92: cleaning up
bus bluetooth: remove device acl00126253F906
PM: Removing info for bluetooth:acl00126253F906
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.4/1-1.4.1/1-1.4.1:1.0/hci1/a=
cl00126253F906'
kobject acl00126253F906: cleaning up
DEV: registering device: ID =3D 'acl0017B066F14B'
kobject acl0017B066F14B: registering. parent: hci2, set: devices
PM: Adding info for bluetooth:acl0017B066F14B
bus bluetooth: add device acl0017B066F14B
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl0017B066F14B'
DEV: registering device: ID =3D 'acl000AD9D7A99A'
kobject acl000AD9D7A99A: registering. parent: hci1, set: devices
PM: Adding info for bluetooth:acl000AD9D7A99A
bus bluetooth: add device acl000AD9D7A99A
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.4/1-1.4.1/1-1.4.1:1.0/hci1/a=
cl000AD9D7A99A'
DEV: registering device: ID =3D 'acl00E0033364E5'
kobject acl00E0033364E5: registering. parent: hci2, set: devices
PM: Adding info for bluetooth:acl00E0033364E5
bus bluetooth: add device acl00E0033364E5
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl00E0033364E5'
bus bluetooth: remove device acl000AD9D7A99A
PM: Removing info for bluetooth:acl000AD9D7A99A
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.4/1-1.4.1/1-1.4.1:1.0/hci1/a=
cl000AD9D7A99A'
kobject acl000AD9D7A99A: cleaning up
DEV: registering device: ID =3D 'acl000AD9D7A99A'
kobject acl000AD9D7A99A: registering. parent: hci1, set: devices
PM: Adding info for bluetooth:acl000AD9D7A99A
bus bluetooth: add device acl000AD9D7A99A
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.4/1-1.4.1/1-1.4.1:1.0/hci1/a=
cl000AD9D7A99A'
DEV: registering device: ID =3D 'acl0060574FEB37'
kobject acl0060574FEB37: registering. parent: hci1, set: devices
PM: Adding info for bluetooth:acl0060574FEB37
bus bluetooth: add device acl0060574FEB37
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.4/1-1.4.1/1-1.4.1:1.0/hci1/a=
cl0060574FEB37'
DEV: registering device: ID =3D 'rfcomm0'
kobject rfcomm0: registering. parent: tty, set: devices
PM: Adding info for No Bus:rfcomm0
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm0'
DEVICE: moving 'rfcomm0' to 'acl000AD9D7A99A'
fill_kobj_path: path =3D '/class/tty/rfcomm0'
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm0'
hcid[15013]: segfault at 80000090 eip 080642c5 esp bf930360 error 4
bus bluetooth: remove device acl0060574FEB37
PM: Removing info for bluetooth:acl0060574FEB37
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.4/1-1.4.1/1-1.4.1:1.0/hci1/a=
cl0060574FEB37'
kobject acl0060574FEB37: cleaning up
bus bluetooth: remove device acl00E0033364E5
PM: Removing info for bluetooth:acl00E0033364E5
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl00E0033364E5'
kobject acl00E0033364E5: cleaning up
bus bluetooth: remove device acl0017B066F14B
PM: Removing info for bluetooth:acl0017B066F14B
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl0017B066F14B'
kobject acl0017B066F14B: cleaning up
DEVICE: moving 'rfcomm0' to '<NULL>'
fill_kobj_path: path =3D '/class/tty/rfcomm0'
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm0'
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.4/1-1.4.1/1-1.4.1:1.0/hci1/a=
cl000AD9D7A99A'
DEV: Unregistering device. ID =3D 'rfcomm0'
PM: Removing info for No Bus:rfcomm0
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm0'
kobject rfcomm0: cleaning up
device_create_release called for rfcomm0
bus bluetooth: remove device acl000AD9D7A99A
PM: Removing info for bluetooth:acl000AD9D7A99A
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.4/1-1.4.1/1-1.4.1:1.0/hci1/a=
cl000AD9D7A99A'
kobject acl000AD9D7A99A: cleaning up
DEV: registering device: ID =3D 'acl00126253F906'
kobject acl00126253F906: registering. parent: hci1, set: devices
PM: Adding info for bluetooth:acl00126253F906
bus bluetooth: add device acl00126253F906
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.4/1-1.4.1/1-1.4.1:1.0/hci1/a=
cl00126253F906'
DEV: registering device: ID =3D 'acl0060574FEB37'
kobject acl0060574FEB37: registering. parent: hci2, set: devices
PM: Adding info for bluetooth:acl0060574FEB37
bus bluetooth: add device acl0060574FEB37
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl0060574FEB37'
DEV: registering device: ID =3D 'acl006057BB4D92'
kobject acl006057BB4D92: registering. parent: hci2, set: devices
PM: Adding info for bluetooth:acl006057BB4D92
bus bluetooth: add device acl006057BB4D92
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl006057BB4D92'
DEV: registering device: ID =3D 'acl0017B066F14B'
kobject acl0017B066F14B: registering. parent: hci2, set: devices
PM: Adding info for bluetooth:acl0017B066F14B
bus bluetooth: add device acl0017B066F14B
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl0017B066F14B'
DEV: registering device: ID =3D 'acl000AD9D7A99A'
kobject acl000AD9D7A99A: registering. parent: hci1, set: devices
PM: Adding info for bluetooth:acl000AD9D7A99A
bus bluetooth: add device acl000AD9D7A99A
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.4/1-1.4.1/1-1.4.1:1.0/hci1/a=
cl000AD9D7A99A'
DEV: registering device: ID =3D 'rfcomm0'
kobject rfcomm0: registering. parent: tty, set: devices
PM: Adding info for No Bus:rfcomm0
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm0'
DEVICE: moving 'rfcomm0' to 'acl000AD9D7A99A'
fill_kobj_path: path =3D '/class/tty/rfcomm0'
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm0'
DEV: registering device: ID =3D 'acl00E0033364E5'
kobject acl00E0033364E5: registering. parent: hci2, set: devices
PM: Adding info for bluetooth:acl00E0033364E5
bus bluetooth: add device acl00E0033364E5
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl00E0033364E5'
DEV: registering device: ID =3D 'rfcomm1'
kobject rfcomm1: registering. parent: tty, set: devices
PM: Adding info for No Bus:rfcomm1
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm1'
DEVICE: moving 'rfcomm1' to 'acl0060574FEB37'
fill_kobj_path: path =3D '/class/tty/rfcomm1'
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm1'
DEV: registering device: ID =3D 'rfcomm2'
kobject rfcomm2: registering. parent: tty, set: devices
PM: Adding info for No Bus:rfcomm2
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm2'
DEVICE: moving 'rfcomm2' to 'acl00E0033364E5'
fill_kobj_path: path =3D '/class/tty/rfcomm2'
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm2'
DEV: registering device: ID =3D 'rfcomm3'
kobject rfcomm3: registering. parent: tty, set: devices
PM: Adding info for No Bus:rfcomm3
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm3'
DEVICE: moving 'rfcomm3' to 'acl0017B066F14B'
fill_kobj_path: path =3D '/class/tty/rfcomm3'
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm3'
DEV: registering device: ID =3D 'rfcomm4'
kobject rfcomm4: registering. parent: tty, set: devices
PM: Adding info for No Bus:rfcomm4
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm4'
DEVICE: moving 'rfcomm4' to 'acl006057BB4D92'
fill_kobj_path: path =3D '/class/tty/rfcomm4'
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm4'
DEV: registering device: ID =3D 'rfcomm5'
kobject rfcomm5: registering. parent: tty, set: devices
PM: Adding info for No Bus:rfcomm5
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm5'
DEVICE: moving 'rfcomm5' to 'acl00126253F906'
fill_kobj_path: path =3D '/class/tty/rfcomm5'
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm5'
bus bluetooth: remove device acl000AD9D7A99A
PM: Removing info for bluetooth:acl000AD9D7A99A
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.4/1-1.4.1/1-1.4.1:1.0/hci1/a=
cl000AD9D7A99A'
DEVICE: moving 'rfcomm0' to '<NULL>'
fill_kobj_path: path =3D '/class/tty/rfcomm0'
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm0'
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.4/1-1.4.1/1-1.4.1:1.0/hci1/a=
cl000AD9D7A99A'
kobject acl000AD9D7A99A: cleaning up
DEV: Unregistering device. ID =3D 'rfcomm0'
PM: Removing info for No Bus:rfcomm0
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm0'
kobject rfcomm0: cleaning up
device_create_release called for rfcomm0
bus bluetooth: remove device acl0017B066F14B
PM: Removing info for bluetooth:acl0017B066F14B
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl0017B066F14B'
bus bluetooth: remove device acl00E0033364E5
PM: Removing info for bluetooth:acl00E0033364E5
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl00E0033364E5'
DEVICE: moving 'rfcomm3' to '<NULL>'
fill_kobj_path: path =3D '/class/tty/rfcomm3'
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm3'
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl0017B066F14B'
kobject acl0017B066F14B: cleaning up
DEV: Unregistering device. ID =3D 'rfcomm3'
PM: Removing info for No Bus:rfcomm3
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm3'
kobject rfcomm3: cleaning up
device_create_release called for rfcomm3
DEVICE: moving 'rfcomm2' to '<NULL>'
fill_kobj_path: path =3D '/class/tty/rfcomm2'
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm2'
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl00E0033364E5'
kobject acl00E0033364E5: cleaning up
DEV: Unregistering device. ID =3D 'rfcomm2'
PM: Removing info for No Bus:rfcomm2
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm2'
kobject rfcomm2: cleaning up
device_create_release called for rfcomm2
bus bluetooth: remove device acl0060574FEB37
PM: Removing info for bluetooth:acl0060574FEB37
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl0060574FEB37'
bus bluetooth: remove device acl006057BB4D92
PM: Removing info for bluetooth:acl006057BB4D92
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl006057BB4D92'
DEVICE: moving 'rfcomm1' to '<NULL>'
fill_kobj_path: path =3D '/class/tty/rfcomm1'
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm1'
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl0060574FEB37'
kobject acl0060574FEB37: cleaning up
DEV: Unregistering device. ID =3D 'rfcomm1'
PM: Removing info for No Bus:rfcomm1
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm1'
kobject rfcomm1: cleaning up
device_create_release called for rfcomm1
DEVICE: moving 'rfcomm4' to '<NULL>'
fill_kobj_path: path =3D '/class/tty/rfcomm4'
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm4'
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.5/1-1.5.1/1-1.5.1:1.0/hci2/a=
cl006057BB4D92'
kobject acl006057BB4D92: cleaning up
DEV: Unregistering device. ID =3D 'rfcomm4'
PM: Removing info for No Bus:rfcomm4
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm4'
kobject rfcomm4: cleaning up
device_create_release called for rfcomm4
bus bluetooth: remove device acl00126253F906
PM: Removing info for bluetooth:acl00126253F906
kobject_uevent_env
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.4/1-1.4.1/1-1.4.1:1.0/hci1/a=
cl00126253F906'
DEVICE: moving 'rfcomm5' to '<NULL>'
fill_kobj_path: path =3D '/class/tty/rfcomm5'
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm5'
fill_kobj_path: path =3D =

'/devices/pci0000:00/0000:00:0f.4/usb1/1-1/1-1.4/1-1.4.1/1-1.4.1:1.0/hci1/a=
cl00126253F906'
kobject acl00126253F906: cleaning up
DEV: Unregistering device. ID =3D 'rfcomm5'
PM: Removing info for No Bus:rfcomm5
kobject_uevent_env
fill_kobj_path: path =3D '/class/tty/rfcomm5'
kobject rfcomm5: cleaning up
device_create_release called for rfcomm5


Best Regards,
Pierre-Yves

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
