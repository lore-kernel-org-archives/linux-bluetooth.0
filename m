Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJKFGv9zfiCKzA1d-e-Yc-iPocUyXPkw+30tWXQpYBEYw@mail.gmail.com>
References: <CA+ZaN3-y6UppvKOYPtJ7eGzD-zN5Cf8DW754FxU_Q9BaW+RKpA@mail.gmail.com>
 <CA+ZaN3-KHcWw+-yz1Qg8Xd2ctysYZWx=4pZSbyfYp=KmVBzC6Q@mail.gmail.com> <CABBYNZJKFGv9zfiCKzA1d-e-Yc-iPocUyXPkw+30tWXQpYBEYw@mail.gmail.com>
From: Seulki Shin <sskcorea@gmail.com>
Date: Fri, 1 Jul 2016 16:37:55 +0900
Message-ID: <CA+ZaN39ovR=zp3_ZShJWBJGk1V8M_YT7FG0xrQaYdZOHBf=Vpg@mail.gmail.com>
Subject: Re: bug report - bluetoothctl ble connection
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

Thanks for reply.
You are always very helpful and I appreciate that.

>>> ......
>>>
>>>> ACL Data RX: Handle 128 flags 0x02 dlen 22                  [hci0] 132.295271
>>>       ATT: Read Response (0x0b) len 17
>>>         Value: 506f6c6172204837203844323236443146
>>> ......
>
> Well this is a response to a read, if there is something wrong with
> the value then either the attribute handle is not correct or it is the
> remote fault.
>
I don't think remote device has a problem because I had tested this
device with prior version of bluez (5.29 and 5.39) and there was no
problem.

Thanks anyway,
Seulki
