Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CA+ZaN3-y6UppvKOYPtJ7eGzD-zN5Cf8DW754FxU_Q9BaW+RKpA@mail.gmail.com>
References: <CA+ZaN3-y6UppvKOYPtJ7eGzD-zN5Cf8DW754FxU_Q9BaW+RKpA@mail.gmail.com>
From: Seulki Shin <sskcorea@gmail.com>
Date: Wed, 29 Jun 2016 16:09:06 +0900
Message-ID: <CA+ZaN3-KHcWw+-yz1Qg8Xd2ctysYZWx=4pZSbyfYp=KmVBzC6Q@mail.gmail.com>
Subject: Re: bug report - bluetoothctl ble connection
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* test envrionment:
Fedora release 22 (Twenty Two)
Kernel 4.1.15-00035-gd1a75bb on an armv7l (ttyAMA3)
[root@localhost ~]# bluetoothctl -v
5.39

> Hi Bluez,
>
> I found a pairing/connection bug in bluetoothctl.
>
> * Steps to reproduce:
>
> [bluetoothctl] scan on
> [bluetoothctl] pair ble_device
> [bluetoothctl] connect ble_device
> [bluetoothctl] exit
>
> Right after exiting from bluetoothctl, Disconnect happens like below.
>
> < HCI Command: Disconnect (0x01|0x0006) plen 3                [hci0] 156.978499
>         Handle: 128
>         Reason: Remote User Terminated Connection (0x13)
>> HCI Event: Command Status (0x0f) plen 4                     [hci0] 156.995345
>       Disconnect (0x01|0x0006) ncmd 1
>         Status: Success (0x00)
>> HCI Event: Disconnect Complete (0x05) plen 4                [hci0] 157.005387
>         Status: Success (0x00)
>         Handle: 128
>         Reason: Connection Terminated By Local Host (0x16)
> @ Device Disconnected: 00:22:D0:8D:22:6D (1) reason 2
>
> * My observation1:
> This is not the case of the hcitool. It works.
>
> * My observation2:
> Right after receiving GATT services, bluez does some more work.
> But the Value doesn't look like normal.
>
> ......
>
>> ACL Data RX: Handle 128 flags 0x02 dlen 22                  [hci0] 132.295271
>       ATT: Read Response (0x0b) len 17
>         Value: 506f6c6172204837203844323236443146
> ......
>
> * I attached full hci logs.
>
> Thanks,
> Seulki
