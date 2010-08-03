Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4C518373.6000706@aircable.net>
References: <4C46324D.5070800@aircable.net> <20100721101934.GA12188@jh-x301>
	<4C470E2D.7000607@aircable.net> <AANLkTi=8=BUThjVdc4EN_8uupGKmdgHQzGOe560Cv+pm@mail.gmail.com>
	<AANLkTi=jzZScnCK6rFpKjBJesnw=71y5hNG3kDBhxv1u@mail.gmail.com>
	<4C505806.3040508@aircable.net> <AANLkTikRQfhAKm-UW+on+ZeEp709z_ku_NDjeVD_US1b@mail.gmail.com>
	<AANLkTi=9Top+9kRwtZj-nZw8szQU4ff9CTSNSGuexmEL@mail.gmail.com>
	<4C518373.6000706@aircable.net>
From: Manuel Naranjo <manuel@aircable.net>
Date: Tue, 3 Aug 2010 10:21:23 -0300
Message-ID: <AANLkTi=i8MhyC80qis9TjZBmtNUJDBMNw5g2rjKPQvdj@mail.gmail.com>
Subject: Re: [PATCH][RFC] Fix SDP resolving segfault
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> I will give this a try and let you know. Maybe I can results before the
> Tuesday, but I doubt it.

As I said on IRC it keeps crashing. Here's the log, as you can see the
crash happened in a different place now.

bluetoothd[1842]: src/device.c:btd_device_ref() 0x9411de0: ref=1
bluetoothd[1842]: src/device.c:btd_device_ref() 0x9411de0: ref=2
bluetoothd[1842]: src/device.c:btd_device_ref() 0x9409570: ref=2
bluetoothd[1842]: src/device.c:btd_device_ref() 0x9408b60: ref=2
bluetoothd[1842]: src/adapter.c:create_device() C8:7E:75:D6:B3:B0
bluetoothd[1842]: src/adapter.c:adapter_create_device() C8:7E:75:D6:B3:B0
bluetoothd[1842]: src/device.c:device_create() Creating device
/org/bluez/1842/hci0/dev_C8_7E_75_D6_B3_B0
bluetoothd[1842]: src/device.c:btd_device_ref() 0x93fd258: ref=1
bluetoothd[1842]: src/device.c:btd_device_ref() 0x93fd258: ref=2
bluetoothd[1842]: src/device.c:btd_device_ref() 0x9404dc0: ref=3
bluetoothd[1842]: Discovery session 0x93fb658 with :1.58 activated
bluetoothd[1842]: src/adapter.c:session_ref() 0x93fb658: ref=1
bluetoothd[1842]: src/adapter.c:adapter_get_device() 00:25:47:2D:20:98
bluetoothd[1842]: src/adapter.c:session_unref() 0x93fb658: ref=0
bluetoothd[1842]: src/adapter.c:session_remove() Discovery session
0x93fb658 with :1.58 deactivated
bluetoothd[1842]: src/adapter.c:session_remove() Stopping discovery
bluetoothd[1842]: Stopping discovery
bluetoothd[1842]: /org/bluez/1842/hci0/dev_C8_7E_75_D6_B3_B0: error
updating services: Device or resource busy (16)
bluetoothd[1842]: src/device.c:btd_device_unref() 0x93fd258: ref=1
bluetoothd[1842]: Discovery session 0x93fd4b0 with :1.58 activated
bluetoothd[1842]: src/adapter.c:session_ref() 0x93fd4b0: ref=1
bluetoothd[1842]: /org/bluez/1842/hci0/dev_00_26_E2_3C_5E_05: error
updating services: Host is down (112)
bluetoothd[1842]: src/device.c:btd_device_unref() 0x9404dc0: ref=2
bluetoothd[1842]: src/adapter.c:adapter_get_device() 00:26:E2:3C:5E:05
bluetoothd[1842]: src/adapter.c:session_unref() 0x93fd4b0: ref=0
bluetoothd[1842]: src/adapter.c:session_remove() Discovery session
0x93fd4b0 with :1.58 deactivated
bluetoothd[1842]: src/adapter.c:session_remove() Stopping discovery
bluetoothd[1842]: Stopping discovery
bluetoothd[1842]: /org/bluez/1842/hci0/dev_00_1C_D6_B1_58_1B: error
updating services: Device or resource busy (16)
bluetoothd[1842]: src/device.c:btd_device_unref() 0x9409570: ref=1
bluetoothd[1842]: Discovery session 0x93f9f80 with :1.58 activated
bluetoothd[1842]: src/adapter.c:session_ref() 0x93f9f80: ref=1
bluetoothd[1842]: src/adapter.c:adapter_remove_connection() Removing
temporary device /org/bluez/1842/hci0/dev_00_25_47_2D_20_98
bluetoothd[1842]: src/device.c:device_remove() Removing device
/org/bluez/1842/hci0/dev_00_25_47_2D_20_98
bluetoothd[1842]: src/device.c:btd_device_unref() 0x9411120: ref=1
bluetoothd[1842]: src/device.c:btd_device_unref() 0x9411120: ref=0
bluetoothd[1842]: src/device.c:device_free() 0x9411120
bluetoothd[1842]: src/adapter.c:adapter_get_device() 00:17:D5:65:D0:3D
bluetoothd[1842]: src/adapter.c:session_unref() 0x93f9f80: ref=0
bluetoothd[1842]: src/adapter.c:session_remove() Discovery session
0x93f9f80 with :1.58 deactivated
bluetoothd[1842]: src/adapter.c:session_remove() Stopping discovery
bluetoothd[1842]: Stopping discovery
bluetoothd[1842]: Discovery session 0x9410560 with :1.58 activated
bluetoothd[1842]: src/adapter.c:session_ref() 0x9410560: ref=1
bluetoothd[1842]: src/device.c:device_probe_drivers() Probe drivers
for /org/bluez/1842/hci0/dev_00_17_D5_65_D0_3D
bluetoothd[1842]: serial/manager.c:serial_probe() path
/org/bluez/1842/hci0/dev_00_17_D5_65_D0_3D:
00001105-0000-1000-8000-00805f9b34fb
bluetoothd[1842]: serial/port.c:create_serial_device() Registered
interface org.bluez.Serial on path
/org/bluez/1842/hci0/dev_00_17_D5_65_D0_3D
bluetoothd[1842]: src/device.c:btd_device_unref() 0x9408b60: ref=1
Segmentation fault


-- 
Manuel Francisco Naranjo
Software Department Argentina
Wireless Cables Inc
www.aircable.net
cel: +5493412010019
skype: naranjomanuelfrancisco
