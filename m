Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <758C2FAB-DBF1-4B88-866D-F036B23B3C95@gmail.com>
References: <4CF902B9-8221-45E7-9868-52BF18A5EC5D@gmail.com>
 <CAAu3APYsHqAK=Kk-fzQmhhBOfnayTDB_N_Q2yCuOhr+akvxfLg@mail.gmail.com>
 <C1394BB3-3C11-410C-916F-80A7863C0A2B@gmail.com> <969738CC-B335-4E2F-BF3C-441110279871@gmail.com>
 <CAAu3APard0ZM-+++qm8938+iWkUUfNkjvq1M9cLqngtZYJAzRg@mail.gmail.com>
 <F1876BDF-4DC0-4CB0-A20F-2E64E24A3B92@gmail.com> <CABBYNZ+R7dV5i+BQowigf5eddB4yxSki+xLeLFYBrN4Sfe8mJA@mail.gmail.com>
 <4AE62BC6-BD11-44C7-9A0E-BC3159ED80DF@gmail.com> <4C907B25-D8E4-462C-89FA-AB312A27CBE9@gmail.com>
 <CABBYNZK04wxSH78f0maAMHtR-2ra8Kh_nQKkrAY1R8G19ba8TA@mail.gmail.com>
 <5CDE162E-4828-4485-BF95-50C67DB93B77@gmail.com> <CABBYNZKkodmXy+4eRXh_4RA9yci25cEtaNMoywEUk9XZ+GL4LQ@mail.gmail.com>
 <758C2FAB-DBF1-4B88-866D-F036B23B3C95@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 25 May 2017 11:02:15 +0300
Message-ID: <CABBYNZLVjXXmbfTb2Uo9KvE2D83c1PU7f2p=t6JawfeyUfN2+w@mail.gmail.com>
Subject: Re: How to use GattProfile1
To: Krasi Georgiev <krasi.root@gmail.com>
Cc: Barry Byford <31baz66@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Krasi,

On Thu, May 25, 2017 at 10:48 AM, Krasi Georgiev <krasi.root@gmail.com> wrote:
> Just tried it again to double check
>
> connected to the iTag, than turned it off and turned it back on, but nothing in the bluetoothd logs shows that it is trying to reconnect.
>
>
> [bluetooth]# scan on
> Discovery started
> [CHG] Controller B8:27:EB:D5:54:1C Discovering: yes
> [CHG] Device FF:FF:50:00:53:B6 RSSI: -78
> [CHG] Device FF:FF:50:00:53:B6 TxPower: 0
> [CHG] Device FF:FF:50:00:53:B6 AdvertisingFlags: 0x05
> [bluetooth]# devices
> Device 34:31:11:00:CD:7A Samsung Galaxy S IV
> Device 04:52:C7:57:85:84 Bose Mini II SoundLink
> Device FF:FF:50:00:53:B6 iTAG
> [bluetooth]# connect FF:FF:50:00:53:B6
> Attempting to connect to FF:FF:50:00:53:B6
> [CHG] Device FF:FF:50:00:53:B6 Connected: yes
> Connection successful
> [CHG] Device FF:FF:50:00:53:B6 Icon is nil
> [CHG] Device FF:FF:50:00:53:B6 Appearance is nil
> [NEW] Primary Service
>         /org/bluez/hci0/dev_FF_FF_50_00_53_B6/service0006
>         0000180f-0000-1000-8000-00805f9b34fb
>         Battery Service
> [NEW] Characteristic
>         /org/bluez/hci0/dev_FF_FF_50_00_53_B6/service0006/char0007
>         00002a19-0000-1000-8000-00805f9b34fb
>         Battery Level
> [NEW] Primary Service
>         /org/bluez/hci0/dev_FF_FF_50_00_53_B6/service0009
>         00001802-0000-1000-8000-00805f9b34fb
>         Immediate Alert
> [NEW] Characteristic
>         /org/bluez/hci0/dev_FF_FF_50_00_53_B6/service0009/char000a
>         00002a06-0000-1000-8000-00805f9b34fb
>         Alert Level
> [NEW] Primary Service
>         /org/bluez/hci0/dev_FF_FF_50_00_53_B6/service000c
>         0000ffe0-0000-1000-8000-00805f9b34fb
>         Unknown
> [NEW] Characteristic
>         /org/bluez/hci0/dev_FF_FF_50_00_53_B6/service000c/char000d
>         0000ffe1-0000-1000-8000-00805f9b34fb
>         Unknown
> [CHG] Device FF:FF:50:00:53:B6 ServicesResolved: yes
>
> [iTAG            ]# select-attribute 0000180f-0000-1000-8000-00805f9b34fb
> [CHG] Device FF:FF:50:00:53:B6 ServicesResolved: no
> [CHG] Device FF:FF:50:00:53:B6 Connected: no
> [CHG] Device FF:FF:50:00:53:B6 RSSI: -87
> [CHG] Device FF:FF:50:00:53:B6 Appearance: 0x03c1
> [CHG] Device FF:FF:50:00:53:B6 Icon: input-keyboard
> [CHG] Device FF:FF:50:00:53:B6 RSSI: -77
> [bluetooth]# devices
> Device 34:31:11:00:CD:7A Samsung Galaxy S IV
> Device 04:52:C7:57:85:84 Bose Mini II SoundLink
> Device FF:FF:50:00:53:B6 iTAG
> [CHG] Device FF:FF:50:00:53:B6 RSSI: -56
> [CHG] Device FF:FF:50:00:53:B6 RSSI: -75
> [CHG] Device FF:FF:50:00:53:B6 RSSI: -66
> [CHG] Device FF:FF:50:00:53:B6 RSSI: -76
>
>
>
>

May 25 10:38:07 r1 bluetoothd[521]: src/adapter.c:cancel_passive_scanning()
May 25 10:38:07 r1 bluetoothd[521]: src/device.c:att_disconnected_cb()
May 25 10:38:07 r1 bluetoothd[521]: src/device.c:att_disconnected_cb()
Connection timed out (110)
May 25 10:38:07 r1 bluetoothd[521]: src/service.c:change_state()
0x12f5b70: device FF:FF:50:00:53:B6 profile gap-profile state changed:
connected -> disconnecting (0)
May 25 10:38:07 r1 bluetoothd[521]: src/service.c:change_state()
0x12f5b70: device FF:FF:50:00:53:B6 profile gap-profile state changed:
disconnecting -> disconnected (0)
May 25 10:38:07 r1 bluetoothd[521]:
src/gatt-client.c:btd_gatt_client_disconnected() Device disconnected.
Cleaning up.
May 25 10:38:07 r1 bluetoothd[521]: src/device.c:att_disconnected_cb()
Automatic connection disabled

Looks like it is disabling the automatic connection, this is probably
because the only matched service appear to be GAP:

May 25 10:38:07 r1 bluetoothd[521]: src/service.c:change_state()
0x12f5b70: device FF:FF:50:00:53:B6 profile gap-profile state changed:
connected -> disconnecting (0)
May 25 10:38:07 r1 bluetoothd[521]: src/service.c:change_state()
0x12f5b70: device FF:FF:50:00:53:B6 profile gap-profile state changed:
disconnecting -> disconnected (0)

Btw, it appears your kernel is too only since bluetoothd is doing
passive scanning in userspace which was not very reliable, iirc the
passive scanning feature was introduced in 3.17.
