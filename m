Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Reply-To: ProklovAV@mail.zabtrans.ru
Subject: Re: Problem with StopDiscovery() via dbus-send
References: <59BB4845.60808@mail.zabtrans.ru>
 <CABBYNZLAqZqsavif1mfWR6vM_u6i1Eo_P1ogK5=6APD56ey3jQ@mail.gmail.com>
To: linux-bluetooth@vger.kernel.org
From: =?UTF-8?B?0J/RgNC+0LrQu9C+0LIg0JDQu9C10LrRgdCw0L3QtNGAINCS0LDQu9C10YA=?=
         =?UTF-8?B?0YzQtdCy0LjRhw==?= <ProklovAV@mail.zabtrans.ru>
Message-ID: <59BB90DD.1040408@mail.zabtrans.ru>
Date: Fri, 15 Sep 2017 16:35:41 +0800
MIME-Version: 1.0
In-Reply-To: <CABBYNZLAqZqsavif1mfWR6vM_u6i1Eo_P1ogK5=6APD56ey3jQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

15.09.2017 14:27, Luiz Augusto von Dentz пишет:
> Hi Aleksandr,
>
> On Fri, Sep 15, 2017 at 6:25 AM, Проклов Александр Валерьевич
> <ProklovAV@mail.zabtrans.ru> wrote:
>>   Hello All,
>>
>> Maybe it's a bug?
>>
>> I'm trying to manage Bluetooth using dbus-send command,
>> I send command for start discovery:
>> dbus-send --system --reply-timeout=5000 --type=method_call --dest=org.bluez
>> /org/bluez/hci0 org.bluez.Adapter1.StartDiscovery
>
> dbus-send disconnects from the bus so the discovery is stopped because
> there is no client to report the devices found.
>

Discovery not stopped, see my log from btmgmt. I not start discovery via 
"btmgmt find". Command "btmgmt stop-find" not help me.

Now i add to code for stop discovery process:
btmgmt power off
sleep 2
btmgmt power on


>>
>> Discovery process NOT stop!!! in btmgmt i see:
>> hci0 type 7 discovering off
>> hci0 type 7 discovering on
>> hci0 type 7 discovering off
>> hci0 type 7 discovering on
>> hci0 type 7 discovering off
>> hci0 type 7 discovering on
>>
>> and it goes on continuously!
>> How can I stop the search process? "StopDiscovery" not work from dbus-send
>> command.
>>
>>
>> ---------------------
>> Best regards,
>> Aleksandr Proklov
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>

