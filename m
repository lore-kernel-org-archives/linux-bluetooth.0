Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <59A504D3.6070809@mail.zabtrans.ru>
References: <59A504D3.6070809@mail.zabtrans.ru>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 29 Aug 2017 10:00:09 +0300
Message-ID: <CABBYNZ+NLeJZDXa3agFfwZ1TSFU27RGwcjGgn-zvN_zi+Oi_TQ@mail.gmail.com>
Subject: Re: Not set name from main.conf
To: ProklovAV@mail.zabtrans.ru
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Aleksandr,

On Tue, Aug 29, 2017 at 9:08 AM, =D0=9F=D1=80=D0=BE=D0=BA=D0=BB=D0=BE=D0=B2=
 =D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B0=D0=BD=D0=B4=D1=80 =D0=92=D0=B0=D0=BB=
=D0=B5=D1=80=D1=8C=D0=B5=D0=B2=D0=B8=D1=87
<ProklovAV@mail.zabtrans.ru> wrote:
>  Hello All,
>
> I set name in main.conf file, in log bluetoothd i see:
>>
>> bluetoothd[25627]: src/main.c:parse_config() name=3DPuppyBT
>> bluetoothd[25627]: src/adapter.c:btd_adapter_new() System name: PuppyBT
>
>
> and later in the log:
>
>> bluetoothd[25627]: src/adapter.c:local_name_changed_callback() Name:
>> PuppyBT
>> bluetoothd[25627]: src/adapter.c:local_name_changed_callback() Short nam=
e:
>> bluetoothd[25627]: src/adapter.c:local_name_changed_callback() Current
>> alias: PuppyBT
>> bluetoothd[25627]: plugins/hostname.c:property_changed() static hostname=
:
>> pra
>> bluetoothd[25627]: plugins/hostname.c:property_changed() pretty hostname=
:
>> bluetoothd[25627]: plugins/hostname.c:update_name() name: pra
>> bluetoothd[25627]: src/adapter.c:adapter_set_name() name: pra
>> bluetoothd[25627]: src/adapter.c:adapter_set_name() alias: pra
>> bluetoothd[25627]: src/adapter.c:set_name() sending set local name comma=
nd
>> for index 0
>> bluetoothd[25627]: plugins/hostname.c:property_changed() chassis: laptop
>> bluetoothd[25627]: plugins/hostname.c:update_class() major: 0x01 minor:
>> 0x03
>> bluetoothd[25627]: src/adapter.c:local_name_changed_callback() Name: pra
>> bluetoothd[25627]: src/adapter.c:local_name_changed_callback() Short nam=
e:
>> bluetoothd[25627]: src/adapter.c:local_name_changed_callback() Current
>> alias: pra
>
>
> How to correctly set the device name?

You should probably disable the hostname plugin if you don't want it
to set the name and alias, alternatively, you can set a different
alias using the Alias property with bluetoothctl or your own tool.

>
> Bluez version 5.45
>
> ---------------------
> Best regards,
> Aleksandr Proklov
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Luiz Augusto von Dentz
