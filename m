Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Reply-To: ProklovAV@mail.zabtrans.ru
Subject: Re: Problem with StopDiscovery() via dbus-send
References: <5B7F662D.5010903@mail.zabtrans.ru>
 <CABBYNZ+ee5BTR_gqjP3XJFMCfoSxGZNCVBuDA3mraS0hN5LkNg@mail.gmail.com>
 <5B833EBD.8050003@mail.zabtrans.ru>
 <CABBYNZKeotBdqAzsKkw-jN4tmcpBdYPC34C-71S4gzCkcdDM3g@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
From: =?UTF-8?B?0J/RgNC+0LrQu9C+0LIg0JDQu9C10LrRgdCw0L3QtNGAINCS0LDQu9C10YA=?=
         =?UTF-8?B?0YzQtdCy0LjRhw==?= <ProklovAV@mail.zabtrans.ru>
Message-ID: <5B84B663.2010906@mail.zabtrans.ru>
Date: Tue, 28 Aug 2018 10:41:39 +0800
MIME-Version: 1.0
In-Reply-To: <CABBYNZKeotBdqAzsKkw-jN4tmcpBdYPC34C-71S4gzCkcdDM3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

27.08.2018 15:24, Luiz Augusto von Dentz пишет:
> Afaik that only works for legacy pairing, normally devices without any
> input/output should rely on just works pairing which is what you would
> usually see in headset, etc, though that are not always pairable so
> you have to switch it on with a button or something like it.

Now my pair process with non-android phone:
#bluetoothctl
[bluetooth] pair 11:22:33:44:55:66

I intering pin code in command shell: 1234
Phone shows a window for entering the code.
I intering pin code on phone. Device pair.

Step with the input of the code in the terminal can be skipped if the 
code is given in main.conf

the reverse process, when the code transmits the phone to the computer, 
I have not considered so far. I think this through the script will be 
difficult to implement.
