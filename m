Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Reply-To: ProklovAV@mail.zabtrans.ru
Subject: Re: Problem with StopDiscovery() via dbus-send
References: <5B7F662D.5010903@mail.zabtrans.ru>
 <CABBYNZ+ee5BTR_gqjP3XJFMCfoSxGZNCVBuDA3mraS0hN5LkNg@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
From: =?UTF-8?B?0J/RgNC+0LrQu9C+0LIg0JDQu9C10LrRgdCw0L3QtNGAINCS0LDQu9C10YA=?=
         =?UTF-8?B?0YzQtdCy0LjRhw==?= <ProklovAV@mail.zabtrans.ru>
Message-ID: <5B833EBD.8050003@mail.zabtrans.ru>
Date: Mon, 27 Aug 2018 07:58:53 +0800
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+ee5BTR_gqjP3XJFMCfoSxGZNCVBuDA3mraS0hN5LkNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

24.08.2018 16:19, Luiz Augusto von Dentz пишет:

>> May be possible to set a default pin code via /etc/bluetooth/main.conf
>> if it is available, do not make a request for a pin from the command line? I
>> think that then #bluetoothctl pair 11:22:33:44:55:66 will be able to work
>> fine.
>
> That is something I had in mind, lets see if I can come up with something.
>

Yes. Non-interactive mode needed.
But I think in bluez 3 was main.conf parameter to specify the default 
PIN code.
