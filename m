Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <54D4ADB5.2040201@mozilla.com>
References: <54CB81F5.3000401@mozilla.com>
	<E422020A-9686-42FB-BB9A-2FEACDF59529@holtmann.org>
	<54D0881B.2020009@mozilla.com>
	<17F6E0D4-FB7F-4DB5-ABC2-A3A8268D7748@holtmann.org>
	<54D4ADB5.2040201@mozilla.com>
Date: Fri, 6 Feb 2015 16:56:50 +0200
Message-ID: <CABBYNZ+Nr7aOvDwd5OhC3XOivBg29kVHx0puuqKTBSMBRu8-yw@mail.gmail.com>
Subject: Re: Extending BlueZ's HAL protocol
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Thomas Zimmermann <tzimmermann@mozilla.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>, Shawn Huang <shuang@mozilla.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Thomas,

On Fri, Feb 6, 2015 at 2:04 PM, Thomas Zimmermann
<tzimmermann@mozilla.com> wrote:
> Hi Marcel
>
>> can you tell me what's your chipset manufacturer? I mean there is almost=
 no chance that you are running on a Bluetooth chip that can not be easily =
supported with BlueZ. All of them talk HCI and the only difference is some =
minimal firmware loading, UART baudrate setting or other tiny details. Supp=
orting a Bluetooth chip with BlueZ is most likely a lot easier than with Bl=
uedroid.
>
> Usually Qualcomm, but we try to support any chipset. Using BlueZ is not
> just a technical issue though. I'd guess that there are possibly other
> requirements (legal, partners, etc). Our plan is to provide BlueZ as a
> drop-in replacement at some later point.
>
>>
>> You also realize that you can run Bluedroid on top of Bluetooth HCI User=
 Channel feature in the kernel. That way you use the kernel side HCI infras=
tructure and existing drivers. At that point tools like hcidump, btmon and =
even hcitool will just work as usual. It is a pretty nifty trick actually. =
There is a libbt-vendor from Intel that will allow you to run Bluedroid on =
top of Bluetooth kernel subsystem using HCI User Channel. It is only a few =
hundred lines of code.
>
> TBH I wouldn't rely on devices to have Bluetooth support enabled in the
> kernel. My understanding is that Bluedroid is completely independent
> from the kernel, so why should OEMs enable the kernel's BT module as well=
?

Only, and really only, in the context of Android, many other Linux
based OSes, which includes Chrome OS, Tizen, Ubuntu, etc, are using
the Bluetooth kernel modules so chances are that there is already some
support in the kernel. I must say that if you stay with Bluedroid's
camp you are just contributing to the fragmentation of Bluetooth
hardware adaptation in Linux, after this why would anyone here bother
helping you? Marcel already pointed out what are the benefits of using
the User Channel, together with the idea of supporting any Linux based
platform, regardless what you run on userspace, should already be
enough arguments to convince any OEM.

>>
>> Or have you actually tried to use the vendor provided libbt-vendor and h=
ook it into BlueZ via /dev/vhci. That should actually work easily. So like =
a tiny libhybris for Bluetooth. I say tiny since all Bluetooth chips talk H=
CI and it will be pretty much super simple.
>>
>>> I think we somehow have to make our Bluedroid daemon call
>>> |config_hci_snoop_log|. One idea is the proposed opcode for vendor
>>> extensions (Mozilla would be the vendor in our case). The other idea
>>> would be to write our own |bluetooth-snoop|, which uses a different
>>> channel to instruct the Bluedroid daemon to call |config_hci_snoop_log|=
.
>> We could potentially add such an opcode that does emulate this piece of =
HAL detail. We did not add it since for us running HCI tracing / snooping i=
n the same core process was never a viable option.
>>
>> If you would try to use HCI User Channel or wrap libbt-vendor into a /de=
v/vhci as mentioned above, then you would actually not have to and could ju=
st run bluetoothd-snoop like we do.
>
> Thanks so far for all the information you provided. I think we'll have
> to explore the possible options for the best solution; ideally something
> that's compatible with BlueZ's daemon.
>
> Best regards
> Thomas
>
>>
>> Regards
>>
>> Marcel
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Luiz Augusto von Dentz
