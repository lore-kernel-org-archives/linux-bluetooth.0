Return-Path: <ianwmorrison@gmail.com>
MIME-Version: 1.0
References: <20180527190457.2632-1-hdegoede@redhat.com>
In-Reply-To: <20180527190457.2632-1-hdegoede@redhat.com>
From: Ian W MORRISON <ianwmorrison@gmail.com>
Date: Tue, 29 May 2018 22:34:38 +1000
Message-ID: <CAFXWsS9ZP_+0jgkNqct_Lby-vTN+Sn3bV+VL7VShU3WvW79=+Q@mail.gmail.com>
Subject: Re: [PATCH 00/13] Bluetooth: Add RTL8723BS support
To: Hans de Goede <hdegoede@redhat.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	martin.blumenstingl@googlemail.com, Rob Herring <robh@kernel.org>, jeremy@jcline.org,
	"bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>, linux-serial@vger.kernel.org,
	linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 28 May 2018 at 05:05, Hans de Goede <hdegoede@redhat.com> wrote:

> Here is a series of patches adding support for RTL8723BS' bluetooth
> component through serdev enumration.


Hi All,

I've tested this series on six (6) different Intel based devices which use
the RTL8723BS chip and Bluetooth worked without issue. I added the patch
series to the v4.17-rc7 kernel and used both an Ubuntu and Lubuntu 18.04
user space together with the firmware as referenced by Martin in the
original RFC ([0] https://github.com/lwfinger/rtl8723bs_bt in [RFC v1 0/8]
Realtek Bluetooth serdev support (H5 protocol)).

Besides the successful pairing of a Bluetooth mouse I ran some additional
confirmatory commands and include the output below.

I offer my
Tested-by: Ian W MORRISON <ianwmorrison@gmail.com>
if it helps.

Best regards,
Ian

root@lubuntu:~# tree -d /sys/bus/acpi/devices/OBDA8723:00
/sys/bus/acpi/devices/OBDA8723:00
=E2=94=9C=E2=94=80=E2=94=80 physical_node -> ../../../../platform/80860F0A:=
00/serial0/serial0-0
=E2=94=9C=E2=94=80=E2=94=80 power
=E2=94=94=E2=94=80=E2=94=80 subsystem -> ../../../../../bus/acpi

3 directories
root@lubuntu:~# tree -ndL 4
/sys/devices/platform/80860F0A:00/serial0/serial0-0
/sys/devices/platform/80860F0A:00/serial0/serial0-0
=E2=94=9C=E2=94=80=E2=94=80 bluetooth
=E2=94=82   =E2=94=94=E2=94=80=E2=94=80 hci0
=E2=94=82       =E2=94=9C=E2=94=80=E2=94=80 device -> ../../../serial0-0
=E2=94=82       =E2=94=9C=E2=94=80=E2=94=80 hci0:2
=E2=94=82       =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 0005:046D:B010.0007
=E2=94=82       =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 device -> ../../hci=
0
=E2=94=82       =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 power
=E2=94=82       =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 subsystem -> ../../=
../../../../../../class/bluetooth
=E2=94=82       =E2=94=9C=E2=94=80=E2=94=80 power
=E2=94=82       =E2=94=9C=E2=94=80=E2=94=80 rfkill1
=E2=94=82       =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 device -> ../../hci=
0
=E2=94=82       =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 power
=E2=94=82       =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 subsystem -> ../../=
../../../../../../class/rfkill
=E2=94=82       =E2=94=94=E2=94=80=E2=94=80 subsystem -> ../../../../../../=
../class/bluetooth
=E2=94=9C=E2=94=80=E2=94=80 driver -> ../../../../../bus/serial/drivers/hci=
_uart_h5
=E2=94=9C=E2=94=80=E2=94=80 firmware_node ->
../../../../LNXSYSTM:00/LNXSYBUS:00/80860F0A:00/OBDA8723:00
=E2=94=9C=E2=94=80=E2=94=80 power
=E2=94=94=E2=94=80=E2=94=80 subsystem -> ../../../../../bus/serial

18 directories
root@lubuntu:~#

root@lubuntu:~# modinfo btrtl
filename:
/lib/modules/4.17.0-041700rc7-linuxium/kernel/drivers/bluetooth/btrtl.ko
firmware:       rtl_bt/rtl8822b_config.bin
firmware:       rtl_bt/rtl8822b_fw.bin
firmware:       rtl_bt/rtl8821a_config.bin
firmware:       rtl_bt/rtl8821a_fw.bin
firmware:       rtl_bt/rtl8761a_config.bin
firmware:       rtl_bt/rtl8761a_fw.bin
firmware:       rtl_bt/rtl8723ds_config.bin
firmware:       rtl_bt/rtl8723ds_fw.bin
firmware:       rtl_bt/rtl8723bs_config.bin
firmware:       rtl_bt/rtl8723bs_fw.bin
firmware:       rtl_bt/rtl8723b_config.bin
firmware:       rtl_bt/rtl8723b_fw.bin
firmware:       rtl_bt/rtl8723a_fw.bin
license:        GPL
version:        0.1
description:    Bluetooth support for Realtek devices ver 0.1
author:         Daniel Drake <drake@endlessm.com>
srcversion:     9C1AD30DDA9DA320E135F91
depends:        bluetooth
retpoline:      Y
intree:         Y
name:           btrtl
vermagic:       4.17.0-041700rc7-linuxium SMP mod_unload
signat:         PKCS#7
signer:
sig_key:
sig_hashalgo:   md4
root@lubuntu:~#

root@lubuntu:~# dmesg | grep Bluetooth
[   23.511094] Bluetooth: Core ver 2.22
[   23.511140] Bluetooth: HCI device and connection manager initialized
[   23.511148] Bluetooth: HCI socket layer initialized
[   23.511153] Bluetooth: L2CAP socket layer initialized
[   23.511170] Bluetooth: SCO socket layer initialized
[   23.686184] Bluetooth: HCI UART driver ver 2.3
[   23.686189] Bluetooth: HCI UART protocol H4 registered
[   23.686191] Bluetooth: HCI UART protocol BCSP registered
[   23.686234] Bluetooth: HCI UART protocol LL registered
[   23.686236] Bluetooth: HCI UART protocol ATH3K registered
[   23.686266] Bluetooth: HCI UART protocol Three-wire (H5) registered
[   23.686356] Bluetooth: HCI UART protocol Intel registered
[   23.686530] Bluetooth: HCI UART protocol Broadcom registered
[   23.686532] Bluetooth: HCI UART protocol QCA registered
[   23.686534] Bluetooth: HCI UART protocol AG6XX registered
[   23.686536] Bluetooth: HCI UART protocol Marvell registered
[   24.348107] Bluetooth: hci0: rtl: examining hci_ver=3D06 hci_rev=3D000b
lmp_ver=3D06 lmp_subver=3D8723
[   24.357025] Bluetooth: hci0: rom_version status=3D0 version=3D1
[   24.357032] Bluetooth: hci0: rtl: loading rtl_bt/rtl8723bs_fw.bin
[   24.375237] Bluetooth: hci0: rtl: loading rtl_bt/rtl8723bs_config.bin
[   24.400183] Bluetooth: hci0: cfg_sz 55, total size 24263
[   24.518884] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   24.518888] Bluetooth: BNEP filters: protocol multicast
[   24.518896] Bluetooth: BNEP socket layer initialized
[   59.619637] Bluetooth: hci0: last event is not cmd complete (0x0f)
[   69.137958] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[   69.137967] Bluetooth: HIDP socket layer initialized
[   70.602740] input: Bluetooth Mouse M557 as
/devices/platform/80860F0A:00/serial0/serial0-0/bluetooth/hci0/hci0:2/0005:=
046D:B010.0007/input/input11
[   70.605395] hid-generic 0005:046D:B010.0007: input,hidraw4: BLUETOOTH
HID v10.01 Mouse [Bluetooth Mouse M557] on 28:c2:dd:a0:eb:84
root@lubuntu:~#
