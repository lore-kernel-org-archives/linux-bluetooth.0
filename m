Return-Path: <cyrus@holtmann.org>
From: "Kling, Andreas" <Andreas.Kling@peiker.de>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Fri, 18 Jan 2013 13:51:25 +0100
Subject: RE: bluez: atomic operations
Message-ID: <sig.67305293e9.B3F251FD87EC894A88C2221EEEBDF54807096F7F43@Exchange>
References: <B3F251FD87EC894A88C2221EEEBDF54807096F7F3B@Exchange>,<1358400337.3059.11.camel@aeonflux>
In-Reply-To: <1358400337.3059.11.camel@aeonflux>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel

>Hi Andy,
>
>> using gcc atomic buildins breaks support for older gcc/platforms.
>>
>> src/bluetoothd-adapter.o: In function `btd_adapter_unref':
>> adapter.c:(.text+0x63f8): undefined reference to `__sync_sub_and_fetch_4=
'
>>
>> I suggest to use glib g_atomic_* group of functions.
>> They fall back to traditional locking if buildins are not available.
>
>the GLib atomic API functions are not really stable. The GLib people for
>some reason decided to break their own API/ABI guarantee. So we moved
>away from using them. And I have no intention to get back to them.
>
>Long term, we are moving away from GLib and want to switch to ELL. So
>that means gcc atomics are required. My advise would be to get a modern
>platform and not rely on workarounds.
>
>Regards
>
>Marcel

many thanks for your answer.

unfortunately a modern platform is not an option for me, hopefully changes =
some day.
so I will maintain another local patch (yieha) :P

ELL? sounds interesting... will have a look at it.

regards

andy=
