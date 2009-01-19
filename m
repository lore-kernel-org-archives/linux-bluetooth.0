Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1232292253.5095.21.camel@californication>
References: <a172fe730901120058g49333ea7o2e07f34ab0e4f4d6@mail.gmail.com>
	 <a172fe730901120108n27b21584ydec4107cf8b7f469@mail.gmail.com>
	 <1232292253.5095.21.camel@californication>
Date: Mon, 19 Jan 2009 18:23:19 +0800
Message-ID: <a172fe730901190223g3b425950v63075fe91daa402f@mail.gmail.com>
Subject: Re: disconnect incoming ACL connection
From: =?GB2312?B?seXA2g==?= <mykofzone@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
     I try it in kernel 2.6.27.2 (including bluez patch), but this
problem still exist. But when testing another headset, SonyEricsson,
this problem does not appear on both 2.6.18 and 2.6.27. So, i guess
it's not a issue of kernel. BTW, my BlueZ lib/utils is 3.26. Does it
cause this issue? Thanks.

Best Regards
LeiBian

2009/1/18 Marcel Holtmann <marcel@holtmann.org>:
> Hi,
>
>>     I'm debugging Qtopia bluetooth in my EVB, and found this issue:
>>     If it is a incoming HFP connection, after pressed "Disconnect
>> HFP", the Qtopia only release rfcomm device and disconnect rfcomm
>> connection, and the ACL incoming connection can't be
>> disconnected(check this by 'hcitool con'). Is this a bug or something
>> else? Thanks. And happy new year!
>>     My develop environment:
>>     kernel : 2.6.18.8 + some patches
>>     BlueZ : 3.26
>>     BT HW : STLC2500
>>     Headset : iTech
>
> that has been fixed, but I can't remember in which kernel version. I
> think your kernel is just too old.
>
> Regards
>
> Marcel
>
>
>
