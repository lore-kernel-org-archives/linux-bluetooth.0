Return-Path: <cyrus@holtmann.org>
Message-ID: <54D4ADB5.2040201@mozilla.com>
Date: Fri, 06 Feb 2015 13:04:05 +0100
From: Thomas Zimmermann <tzimmermann@mozilla.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ development <linux-bluetooth@vger.kernel.org>,
 Shawn Huang <shuang@mozilla.com>
Subject: Re: Extending BlueZ's HAL protocol
References: <54CB81F5.3000401@mozilla.com> <E422020A-9686-42FB-BB9A-2FEACDF59529@holtmann.org> <54D0881B.2020009@mozilla.com> <17F6E0D4-FB7F-4DB5-ABC2-A3A8268D7748@holtmann.org>
In-Reply-To: <17F6E0D4-FB7F-4DB5-ABC2-A3A8268D7748@holtmann.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel

> can you tell me what's your chipset manufacturer? I mean there is almost no chance that you are running on a Bluetooth chip that can not be easily supported with BlueZ. All of them talk HCI and the only difference is some minimal firmware loading, UART baudrate setting or other tiny details. Supporting a Bluetooth chip with BlueZ is most likely a lot easier than with Bluedroid.

Usually Qualcomm, but we try to support any chipset. Using BlueZ is not
just a technical issue though. I'd guess that there are possibly other
requirements (legal, partners, etc). Our plan is to provide BlueZ as a
drop-in replacement at some later point.

>
> You also realize that you can run Bluedroid on top of Bluetooth HCI User Channel feature in the kernel. That way you use the kernel side HCI infrastructure and existing drivers. At that point tools like hcidump, btmon and even hcitool will just work as usual. It is a pretty nifty trick actually. There is a libbt-vendor from Intel that will allow you to run Bluedroid on top of Bluetooth kernel subsystem using HCI User Channel. It is only a few hundred lines of code.

TBH I wouldn't rely on devices to have Bluetooth support enabled in the
kernel. My understanding is that Bluedroid is completely independent
from the kernel, so why should OEMs enable the kernel's BT module as well?

>
> Or have you actually tried to use the vendor provided libbt-vendor and hook it into BlueZ via /dev/vhci. That should actually work easily. So like a tiny libhybris for Bluetooth. I say tiny since all Bluetooth chips talk HCI and it will be pretty much super simple.
>
>> I think we somehow have to make our Bluedroid daemon call
>> |config_hci_snoop_log|. One idea is the proposed opcode for vendor
>> extensions (Mozilla would be the vendor in our case). The other idea
>> would be to write our own |bluetooth-snoop|, which uses a different
>> channel to instruct the Bluedroid daemon to call |config_hci_snoop_log|.
> We could potentially add such an opcode that does emulate this piece of HAL detail. We did not add it since for us running HCI tracing / snooping in the same core process was never a viable option.
>
> If you would try to use HCI User Channel or wrap libbt-vendor into a /dev/vhci as mentioned above, then you would actually not have to and could just run bluetoothd-snoop like we do.

Thanks so far for all the information you provided. I think we'll have
to explore the possible options for the best solution; ideally something
that's compatible with BlueZ's daemon.

Best regards
Thomas

>
> Regards
>
> Marcel
>
