Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH] monitor: Add option to disable SCO packets
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZLBRUsej-4GWuFSQ_HyvB3x43d9iiC7_5jsYTm=uKn5aQ@mail.gmail.com>
Date: Tue, 19 Jun 2018 16:19:07 +0200
Cc: =?utf-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        =?utf-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>
Message-Id: <4AD21309-9D8E-49AA-926B-09ADC0607131@holtmann.org>
References: <20180618165739.13126-1-jprvita@endlessm.com>
 <259476D2-706B-4FA2-86DE-3A6BDCC6B7EC@holtmann.org>
 <CA+A7VXVT3e832EEF4TQusdM_hsH-wVw_DZyfwC5xxEzC09Vquw@mail.gmail.com>
 <CABBYNZLBRUsej-4GWuFSQ_HyvB3x43d9iiC7_5jsYTm=uKn5aQ@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

>>> I am confused. I assumed I made SCO off by default.
>>> 
>> 
>> Dumping the contents for SCO packets is OFF by default (enabled by
>> -S), that is, the hex dump part on the output bellow:
>> 
>>  SCO Data RX: Handle 257 flags 0x00 dlen 48
>> 
>>                                                               #3537
>> [hci0] 16.106123
>>        23 00 2b 00 20 00 06 00 0f 00 21 00 15 00 05 00  #.+. .....!.....
>>        1d 00 13 00 ff ff 15 00 1b 00 f8 ff f1 ff 0f 00  ................
>>        0f 00 fc ff f3 ff f8 ff f8 ff fa ff 02 00 00 00  ................
>> 
>> But without -S we still log the header / flags part for each packet:
>> 
>>  SCO Data RX: Handle 258 flags 0x00 dlen 48
>> 
>>                                                               #3541
>> [hci0] 14.128754
>> 
>>> Anyhow, I don’t want to see tons of independent options. Since next thing is you tell me that AVDTP media channel is also something you want to filter out. So then we better find a generic way to apply filters and also notifications about “dropped x packets due to filter” kinda hints.
>>> 
> 
> We might look at doing this kind of filtering using BPF instead which
> perhaps could be loaded from a file.

doing this BPF would be best.

>> My argument behind filtering out SCO is because AFAIU it is only data,
>> not signaling. On a quick look I had assumed there was no easy way to
>> separate AVDTP signaling from data, but on a second look is actually
>> quite obvious, so you are right, that would be an obvious next step
>> :-)
>> 
>> Maybe we could hide the SCO and AVDTP media channels by default? In
>> this case we could print a notification when the program starts that
>> these channels are being suppressed, and / or every time the channel
>> is established. That would be reflected on the package count printed
>> with the timestamp, and I'm not sure if that would be a problem: is
>> that number reflecting how many packets have been exchanged or
>> printed?
>> 
>> As much as I like the idea of a generic configurable filter, I can't
>> look into that atm.
> 
> BPF already works with Bluetooth socket so perhaps we just need a way
> to load the filter from file.
> 
> @Marcel: We never applied the patch below, are you okay with it:
> 
> https://www.spinics.net/lists/linux-bluetooth/msg71245.html

I somehow never saw that patch. Can you re-send it to the mailing list.

Regards

Marcel

