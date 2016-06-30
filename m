Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEZxfGOq_QkN65B=F_u+rb=6+O-4c=0dF0ZaDZ5t9D6nNtY2rw@mail.gmail.com>
References: <CAEZxfGOq_QkN65B=F_u+rb=6+O-4c=0dF0ZaDZ5t9D6nNtY2rw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 30 Jun 2016 14:36:34 +0300
Message-ID: <CABBYNZ+XEFe1wp1Rr5TQ+SRsc0ZTRmZErYpvVQ=Txf2=a+EjGA@mail.gmail.com>
Subject: Re: Notify on succeeds while no apparent descriptor
To: =?UTF-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi François,

On Wed, Jun 29, 2016 at 10:24 AM, François Beaufort
<beaufort.francois@gmail.com> wrote:
> I have a bogus BLE device which exposes "badly" a characteristic
> notification. Even though it doesn't find a characteristic descriptor,
> I'm still able to start notifications and even receive value changed
> events.
>
> For info, Android and macOS raise an exception when trying to start
> notifications. See
> https://github.com/WebBluetoothCG/ble-test-peripheral-android/issues/63
>
> See logs:
>
> < ACL Data TX: Handle 32 flags 0x00 dlen 9
>                                                    [hci0] 403.621325
>       ATT: Find Information Request (0x04) len 4
>         Handle range: 0x002b-0xffff
>> HCI Event: Number of Completed Packets (0x13) plen 5                                                                    [hci0] 403.689256
>         Num handles: 1
>         Handle: 32
>         Count: 1
>> ACL Data RX: Handle 32 flags 0x02 dlen 9                                                                                [hci0] 403.755926
>       ATT: Error Response (0x01) len 4
>         Find Information Request (0x04)
>         Handle: 0x002b
>         Error: Attribute Not Found (0x0a)
>
> ---
>
> [Nexus 5X]# list-attributes
> Primary Service
>         /org/bluez/hci0/dev_46_EE_57_93_31_08/service0001
>         Generic Attribute Profile
> Characteristic
>         /org/bluez/hci0/dev_46_EE_57_93_31_08/service0001/char0002
>         Service Changed
> Primary Service
>         /org/bluez/hci0/dev_46_EE_57_93_31_08/service0028
>         Battery Service
> Characteristic
>         /org/bluez/hci0/dev_46_EE_57_93_31_08/service0028/char0029
>         Battery Level
> [Nexus 5X]# select-attribute
> /org/bluez/hci0/dev_46_EE_57_93_31_08/service0028/char0029
> [Nexus 5X:/service0028/char0029]# notify on
> [CHG] Attribute
> /org/bluez/hci0/dev_46_EE_57_93_31_08/service0028/char0029 Notifying:
> yes
> Notify started
> [CHG] Attribute
> /org/bluez/hci0/dev_46_EE_57_93_31_08/service0028/char0029 Value: 0x32
> [Nexus 5X:/service0028/char0029]# notify off
> [CHG] Attribute
> /org/bluez/hci0/dev_46_EE_57_93_31_08/service0028/char0029 Notifying:
> no
> Notify stopped
> --

Just to make it public what I have stated in the irc, currently we
allow enabling notification even without CCC (out of the spect
unsolicited notification):

commit 46aad83687251bef0fa0ac60583e5898170b0f10
Author: Arman Uguray <armansito@chromium.org>
Date:   Tue Feb 3 19:58:22 2015 -0800
    shared/gatt: Allow register_notify without CCC

    Most OSes allow to register characteristics without a CCC even if they
    do support notification/indication, this is not according to the
    specification and may not even work in practice since there is no way
    to enable notifications/indications without a CCC to write to but there
    has been some applications that do that anyway.

Perhaps Arman had it exactly for these broken application that don't
register a CCC which Im guessing is because the GATT API don't do it
by default (Android?) leaving it up to the app which can screw up we
can observe here.


-- 
Luiz Augusto von Dentz
