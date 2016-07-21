Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <A1A3E25C-D17E-4089-A5C7-95D9C36CBB5B@gmail.com>
References: <A1A3E25C-D17E-4089-A5C7-95D9C36CBB5B@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 21 Jul 2016 11:56:48 +0300
Message-ID: <CABBYNZLndEx06DcLTG7e23KLuVU34ZzdusBFAXbKafAXZFXr_w@mail.gmail.com>
Subject: Re: PropertiesChanged callback not being called in Characteristic Object
To: =?UTF-8?Q?Hudo_Assen=C3=A7o?= <hudo.assenco@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hudo,

On Wed, Jul 20, 2016 at 10:38 PM, Hudo Assenço <hudo.assenco@gmail.com> wrote:
> Hi all,
>
> I am trying to debug a problem I am having with an IoT framework (Iotivity). The client side of the framework cannot receive data from the server through bluetooth. After digging the code, I found the problem is the callback responsible for receiving the data is not being called.
>
> The callback is connected to the PropertiesChanged signal after the GattServices discovery happens, here: https://github.com/iotivity/iotivity/blob/1.1-rel/resource/csdk/connectivity/src/bt_le_adapter/linux/client.c#L279
>
> And it is defined here: https://github.com/iotivity/iotivity/blob/1.1-rel/resource/csdk/connectivity/src/bt_le_adapter/linux/client.c#L84
>
> I put some logs to be sure that the right characteristic is being connected, and it is:
> 46:43.819 INFO: BLE_CLIENT: IN CAGattClientSetupCharacteristics
> 46:43.839 INFO: BLE_CLIENT: connecting  CAGattClientOnCharacteristicPropertiesChanged, UUID: e9241982-4580-42c4-8831-95048216b256
>  PATH: /org/bluez/hci0/dev_C7_6A_A9_0B_DD_5F/service000c/char000f
> 46:43.969 INFO: BLE_CLIENT: is g-properties-changed connected: 1

It doesn't seems to be doing anything wrong provided
g-properties-changed is actually doing what its the documentation says
any properties changed signal should be trigger its callback.

> I also monitored the bus with dbus-monitor and I got the signals that I was looking for:
> signal sender=:1.4 -> dest=(null destination) serial=953 path=/org/bluez/hci0/dev_C7_6A_A9_0B_DD_5F/service000c/char000f; interface=org.freedesktop.DBus.Properties; member=PropertiesChanged
>    string "org.bluez.GattCharacteristic1"
>    array [
>       dict entry(
>          string "Value"
>          variant             array of bytes [
>                d8 c6 45 a2 98 02 40 3a 7d 8b e7 b3 6f 69 63 03 72 65 73 11
>             ]
>       )
>    ]
>    array [
>    ]
> signal sender=:1.4 -> dest=(null destination) serial=954 path=/org/bluez/hci0/dev_C7_6A_A9_0B_DD_5F/service000c/char000f; interface=org.freedesktop.DBus.Properties; member=PropertiesChanged
>    string "org.bluez.GattCharacteristic1"
>    array [
>       dict entry(
>          string "Value"
>          variant             array of bytes [
>                3c e1 fe db c0 ff 81 bf 62 64 69 60 65 6c 69 6e 6b 73 83 a4
>             ]
>       )
>    ]
>    array [
>    ]

Well the fact that you are able to see this using dbus-monitor already
indicate that the problem is on the client side, something is probably
preventing it to reach the callback.

> But the “CAGattClientOnCharacteristicPropertiesChanged” callback is never called.
>
> I posted this same issue in their mailing list but had no help. So I though someone here with more experience with bluetooth could help me in debug this problem further. I was looking for a way to check which signal handlers are connected to the dbus object through command line but I couldn’t find.
>
> More info:
> BlueZ 3.37
> Kernel 3.10

I suppose the BlueZ version is 5.37 since 3.37 is ancient, actually
3.37 does not even exists, the Kernel version is also pretty old to
work with LE properly.

-- 
Luiz Augusto von Dentz
