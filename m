Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAKvrXUr+Q6AKcsQS+z8VwH--wtotawuiNz8j4RJy+D3Q7fGZ7Q@mail.gmail.com>
References: <CAKvrXUr+Q6AKcsQS+z8VwH--wtotawuiNz8j4RJy+D3Q7fGZ7Q@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 22 Dec 2016 11:03:13 +0200
Message-ID: <CABBYNZLHK_H=augA1hd3R4aXEZLL435D8=CsuMUCUf_WC6bEUA@mail.gmail.com>
Subject: Re: HoG uHID device not destroyed on disconnect
To: Juha Kuikka <juha.kuikka@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Juha,

On Thu, Dec 22, 2016 at 8:06 AM, Juha Kuikka <juha.kuikka@gmail.com> wrote:
> Hi,
>
> It seems that when an HID-over-GATT (HoG) device connects an uHID
> devive is created for it. I would expect it to get destroyed upon
> disconnect but it seems to linger around.
>
> This can be demonstrated using bluetoothctl. Here I am using a
> Microsoft Arc Touch Mouse.
>
> Paired and connected:
>
> [bluetooth]# pair C9:33:31:6B:03:A9
> Attempting to pair with C9:33:31:6B:03:A9
> [CHG] Device C9:33:31:6B:03:A9 Connected: yes
> [CHG] Device C9:33:31:6B:03:A9 UUIDs: 00001800-0000-1000-8000-00805f9b34fb
> [CHG] Device C9:33:31:6B:03:A9 UUIDs: 00001801-0000-1000-8000-00805f9b34fb
> [CHG] Device C9:33:31:6B:03:A9 UUIDs: 0000180a-0000-1000-8000-00805f9b34fb
> [CHG] Device C9:33:31:6B:03:A9 UUIDs: 0000180f-0000-1000-8000-00805f9b34fb
> [CHG] Device C9:33:31:6B:03:A9 UUIDs: 00001812-0000-1000-8000-00805f9b34fb
> [CHG] Device C9:33:31:6B:03:A9 ServicesResolved: yes
> [CHG] Device C9:33:31:6B:03:A9 Paired: yes
> [NEW] Primary Service
>         /org/bluez/hci0/dev_C9_33_31_6B_03_A9/service0008
>         00001801-0000-1000-8000-00805f9b34fb
>         Generic Attribute Profile
> [NEW] Characteristic
>         /org/bluez/hci0/dev_C9_33_31_6B_03_A9/service0008/char0009
>         00002a05-0000-1000-8000-00805f9b34fb
>         Service Changed
> [NEW] Descriptor
>         /org/bluez/hci0/dev_C9_33_31_6B_03_A9/service0008/char0009/desc000b
>         00002902-0000-1000-8000-00805f9b34fb
>         Client Characteristic Configuration
> [NEW] Primary Service
>         /org/bluez/hci0/dev_C9_33_31_6B_03_A9/service000c
>         0000180a-0000-1000-8000-00805f9b34fb
>         Device Information
> [NEW] Characteristic
>         /org/bluez/hci0/dev_C9_33_31_6B_03_A9/service000c/char000d
>         00002a29-0000-1000-8000-00805f9b34fb
>         Manufacturer Name String
> [NEW] Characteristic
>         /org/bluez/hci0/dev_C9_33_31_6B_03_A9/service000c/char000f
>         00002a50-0000-1000-8000-00805f9b34fb
>         PnP ID
> [NEW] Primary Service
>         /org/bluez/hci0/dev_C9_33_31_6B_03_A9/service0011
>         0000180f-0000-1000-8000-00805f9b34fb
>         Battery Service
> [NEW] Characteristic
>         /org/bluez/hci0/dev_C9_33_31_6B_03_A9/service0011/char0012
>         00002a19-0000-1000-8000-00805f9b34fb
>         Battery Level
> [NEW] Descriptor
>         /org/bluez/hci0/dev_C9_33_31_6B_03_A9/service0011/char0012/desc0014
>         00002902-0000-1000-8000-00805f9b34fb
>         Client Characteristic Configuration
> Pairing successful
> [CHG] Device C9:33:31:6B:03:A9 Modalias: usb:v045Ep0804d0001
> [Arc Touch BT Mouse]# connect C9:33:31:6B:03:A9
> Attempting to connect to C9:33:31:6B:03:A9
> Connection successful
>
> And here it is disconnected:
>
> [CHG] Device C9:33:31:6B:03:A9 ServicesResolved: no
> [CHG] Device C9:33:31:6B:03:A9 Connected: no
>
> After disconnection, the HID device is still present:
>
> $ ls -l /sys/class/hidraw/ /dev/hidraw*
> crw------- 1 root root 244, 0 Dec 21 21:45 /dev/hidraw0
>
> /sys/class/hidraw/:
> total 0
> lrwxrwxrwx 1 root root 0 Dec 21 21:52 hidraw0 ->
> ../../devices/virtual/misc/uhid/0005:0000:0000.0019/hidraw/hidraw0
>
> The zero VID&PID of the HID device differ from the modalias due to
> another bug I just posted about.
>
> If I Remove() the the device, the HID device gets destroyed but it
> lingers until then.
>
> This behavior seems to be caused by the fact that the HoG service is
> kept alive between connections and the lifetime of the included
> bt_uhid is not limited between connections.

This is actually on purpose so we don't keep creating more and more
device nodes every time the device reconnects, but we should
definitely fix the problem with DIS and HoG.


-- 
Luiz Augusto von Dentz
