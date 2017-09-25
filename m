Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Reply-To: ProklovAV@mail.zabtrans.ru
Subject: Re: Problem with StopDiscovery() via dbus-send
References: <59BB4845.60808@mail.zabtrans.ru>
 <CABBYNZLAqZqsavif1mfWR6vM_u6i1Eo_P1ogK5=6APD56ey3jQ@mail.gmail.com>
 <59BB90DD.1040408@mail.zabtrans.ru>
 <CABBYNZJQRH75iaddKeNFJXqSwWqAxhRjLYHddAuMhxVq_T1V+A@mail.gmail.com>
 <59BF3492.3080503@mail.zabtrans.ru>
 <CABBYNZLyL4r1b=Kv77uB7dND2M6MUzQ_H3sdDdi-daR1YtHyGw@mail.gmail.com>
To: linux-bluetooth@vger.kernel.org
From: =?UTF-8?B?0J/RgNC+0LrQu9C+0LIg0JDQu9C10LrRgdCw0L3QtNGAINCS0LDQu9C10YA=?=
         =?UTF-8?B?0YzQtdCy0LjRhw==?= <ProklovAV@mail.zabtrans.ru>
Message-ID: <59C85B29.4050802@mail.zabtrans.ru>
Date: Mon, 25 Sep 2017 09:26:01 +0800
MIME-Version: 1.0
In-Reply-To: <CABBYNZLyL4r1b=Kv77uB7dND2M6MUzQ_H3sdDdi-daR1YtHyGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


>>> 15.09.2017 16:46, Luiz Augusto von Dentz пишет:
>>>>
>>>> Ive just a set of patches adressing race condition with StartDiscovery
>>>> and StopDiscovery, please have a try. Also it is not a good idea to
>>>> mix usage of D-Bus with btmgmt, they might not play well together
>>>> especially when it comes to discovery.
>>>>
>>>
>
> May be add time delay after the StarDiscovery (for example 60 sec) and bluetoothd automatically turn off the Discovery process?  I do not know when it would be required to start the process for a time longer than 60 seconds.
>
> This will help solve the problem with the call StartDiscovery through the script via dbus-send. My method through power off, power on not help me, after power off founded adapters deleted from dbus tree.
>
> My script is finished at 80%. It remains only to make the Discovery and network connection via bluetooth (GN, PANU, PAN).


Dear Luiz Augusto von Dentz, please consider the possibility of 
implementing this option.
