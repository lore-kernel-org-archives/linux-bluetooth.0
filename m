Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
References: <4f787a1b-848b-be07-bdd0-198892c56120@aramar.de>
In-Reply-To: <4f787a1b-848b-be07-bdd0-198892c56120@aramar.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Sun, 20 May 2018 15:14:20 +0300
Message-ID: <CABBYNZ+HQ2CeuHLrx1w5k6BK-AV8SYbdE_-TOej522cwf-BtUg@mail.gmail.com>
Subject: Re: KORG nanoKONTROL Studio ... again
To: Robert.Schneider@aramar.de
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Robert,
On Sat, May 19, 2018 at 4:43 PM Robert Schneider
<Robert.Schneider@aramar.de>
wrote:

> After pausing for some time and waiting for Ubuntu 18.04, I thought I
give MIDI
> over Bluetooth to my KORG nanoKONTROL Studio another try. However, to no
avail.

> Still I cannot make the device show up in the MIDI device list.

> Here are some outputs from bluetoothctl. If anyone can help, I'd
appreciate that.

> Regards, Robert

> The devices shows up:

> [bluetooth]# devices
> Device 60:F1:89:28:DA:1F nanoKONTROL Studio

> The info says:

> [bluetooth]# info 60:F1:89:28:DA:1F
> Device 60:F1:89:28:DA:1F (public)
>       Name: nanoKONTROL Studio
>       Alias: nanoKONTROL Studio
>       Appearance: 0x0080
>       Icon: computer
>       Paired: no
>       Trusted: yes
>       Blocked: no
>       Connected: no
>       LegacyPairing: no
>       UUID: Generic Access Profile (00001800-0000-1000-8000-00805f9b34fb)
>       UUID: Generic Attribute Profile
(00001801-0000-1000-8000-00805f9b34fb)
>       UUID: Device Information (0000180a-0000-1000-8000-00805f9b34fb)
>       UUID: Vendor specific (03b80e5a-ede8-4b33-a751-6ce34ec4c700)
>       UUID: Vendor specific (d0611e78-bbb4-4591-a5f8-487910ae4366)

 From the looks of it seems the device is not using the standard MIDI
service but vendor specific ones which don't have support.

> connect says:

> [bluetooth]# connect 60:F1:89:28:DA:1F
> Attempting to connect to 60:F1:89:28:DA:1F
> [CHG] Device 60:F1:89:28:DA:1F Connected: yes
> Connection successful
> [NEW] Primary Service
>       /org/bluez/hci0/dev_60_F1_89_28_DA_1F/service000c
>       00001801-0000-1000-8000-00805f9b34fb
>       Generic Attribute Profile
> [NEW] Characteristic
>       /org/bluez/hci0/dev_60_F1_89_28_DA_1F/service000c/char000d
>       00002a05-0000-1000-8000-00805f9b34fb
>       Service Changed
> [NEW] Descriptor
> /org/bluez/hci0/dev_60_F1_89_28_DA_1F/service000c/char000d/desc000f
>       00002902-0000-1000-8000-00805f9b34fb
>       Client Characteristic Configuration
> [NEW] Primary Service
>       /org/bluez/hci0/dev_60_F1_89_28_DA_1F/service0010
>       0000180a-0000-1000-8000-00805f9b34fb
>       Device Information
> [NEW] Characteristic
>       /org/bluez/hci0/dev_60_F1_89_28_DA_1F/service0010/char0011
>       00002a29-0000-1000-8000-00805f9b34fb
>       Manufacturer Name String
> [NEW] Characteristic
>       /org/bluez/hci0/dev_60_F1_89_28_DA_1F/service0010/char0013
>       00002a24-0000-1000-8000-00805f9b34fb
>       Model Number String
> [NEW] Primary Service
>       /org/bluez/hci0/dev_60_F1_89_28_DA_1F/service0015
>       d0611e78-bbb4-4591-a5f8-487910ae4366
>       Vendor specific
> [NEW] Characteristic
>       /org/bluez/hci0/dev_60_F1_89_28_DA_1F/service0015/char0016
>       8667556c-9a37-4c91-84ed-54ee27d90049
>       Vendor specific
> [NEW] Descriptor
> /org/bluez/hci0/dev_60_F1_89_28_DA_1F/service0015/char0016/desc0018
>       00002902-0000-1000-8000-00805f9b34fb
>       Client Characteristic Configuration
> [NEW] Primary Service
>       /org/bluez/hci0/dev_60_F1_89_28_DA_1F/service0019
>       03b80e5a-ede8-4b33-a751-6ce34ec4c700
>       Vendor specific
> [NEW] Characteristic
>       /org/bluez/hci0/dev_60_F1_89_28_DA_1F/service0019/char001a
>       7772e5db-3868-4112-a1a9-f2669d106bf3
>       Vendor specific
> [NEW] Descriptor
> /org/bluez/hci0/dev_60_F1_89_28_DA_1F/service0019/char001a/desc001c
>       00002902-0000-1000-8000-00805f9b34fb
>       Client Characteristic Configuration
> [CHG] Device 60:F1:89:28:DA:1F ServicesResolved: yes

> Now info says:

> [nanoKONTROL Studio]# info 60:F1:89:28:DA:1F
> Device 60:F1:89:28:DA:1F (public)
>       Name: nanoKONTROL Studio
>       Alias: nanoKONTROL Studio
>       Appearance: 0x0080
>       Icon: computer
>       Paired: no
>       Trusted: yes
>       Blocked: no
>       Connected: yes
>       LegacyPairing: no
>       UUID: Generic Access Profile (00001800-0000-1000-8000-00805f9b34fb)
>       UUID: Generic Attribute Profile
(00001801-0000-1000-8000-00805f9b34fb)
>       UUID: Device Information (0000180a-0000-1000-8000-00805f9b34fb)
>       UUID: Vendor specific (03b80e5a-ede8-4b33-a751-6ce34ec4c700)
>       UUID: Vendor specific (d0611e78-bbb4-4591-a5f8-487910ae4366)


> --
> To unsubscribe from this list: send the line "unsubscribe
linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
