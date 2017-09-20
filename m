Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: btattach and 3wire doesn't work
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAO1O6sdMd30Nr8SK4XDcv91=x0eMgOKuYyjmJ89f_N5hdM--vg@mail.gmail.com>
Date: Wed, 20 Sep 2017 18:54:12 +0200
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Message-Id: <292E97AC-D1B0-440E-BA2D-6C50395C0675@holtmann.org>
References: <CAO1O6sewvkB=j5cfSXMbjHsZi3BmyD=CqcCFpKypQ6HEvmj99g@mail.gmail.com>
 <5467450F-B5AA-4BD5-874F-2ABC7F05D821@holtmann.org>
 <CAO1O6sc321z7A+Fubffjx2N8tUp6zCDRogNKybW1aaRV0cEthw@mail.gmail.com>
 <5D4329D8-61EB-420B-8985-E4204D272E65@holtmann.org>
 <CAO1O6sdMd30Nr8SK4XDcv91=x0eMgOKuYyjmJ89f_N5hdM--vg@mail.gmail.com>
To: Emil Lenngren <emil.lenngren@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Emil,

>>>>> I'm trying to use the new btattach utility to attach a controller
>>>>> which uses the 3-wire UART protocol. The older hciattach works great
>>>>> but btattach doesn't.
>>>>> This is the command I use including the output:
>>>>> 
>>>>> # btattach -B /dev/ttyS1 -P 3wire -S 500000
>>>>> Attaching Primary controller to /dev/ttyS1
>>>>> Switched line discipline from 0 to 15
>>>>> Failed to get device id: Protocol driver not attached
>>>>> No controller attached
>>>>> 
>>>>> By reading the source at
>>>>> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/tools/btattach.c
>>>>> I see that it differs a bit from hciattach. Notably, it calls the
>>>>> HCIUARTGETDEVICE ioctl function directly after the HCIUARTSETPROTO
>>>>> ioctl call. The hciattach utility does not use HCIUARTGETDEVICE at
>>>>> all.
>>>>> 
>>>>> The cause of the problem is that when using 3wire, the hci does not
>>>>> get registered immediately (which btattach thinks) but instead after
>>>>> the handshake is complete.
>>>>> 
>>>>> If I run btattach in gdb and break before the HCIUARTGETDEVICE ioctl
>>>>> call, wait a few seconds and then resume, it works as expected. What
>>>>> is the purpose of HCIUARTGETDEVICE? I see it's only being used when
>>>>> the Raw option is used (which is by the way not mentioned in the Usage
>>>>> docs).
>>>>> 
>>>>> Another issue I have is that hciattach/btattach only support a few
>>>>> different baud rates. I want to use 750000 bit/s. Is there a purpose
>>>>> of only allowing some? Currently I use hciattach with a dummy baud
>>>>> rate followed by
>>>>> https://gist.github.com/lategoodbye/f2d76134aa6c404cd92c and that
>>>>> works.
>>>> 
>>>> which hardware is this? I always wanted to fix some of the 3-wire support to make sure it fully works with btattach and everything is done inside the kernel correctly. Including proper support for hdev->setup for vendor firmware loading etc.
>>> 
>>> 
>>> The hardware is an nRF52 device running a generic 3wire
>>> implementation. So no custom setup needed here.
>>> The 3wire support otherwise in the kernel seems to work very nice as
>>> long as I've been testing this. The only thing I miss myself is the
>>> lack of the CRC check defined optionally by the 3wire specification.
>> 
>> who is providing a 3-wire HCI controller firmware for the nRF52? I know with Zephyr and Mynewt you can turn them into a generic HCI controller, but we have not gotten around to add 3-wire support to Zephyr yet.
> 
> I have written my own implementation according to the Core v5.0
> specification. I thought it was more nice to have a 3wire interface
> rather than h4 since that adds better error checking, automatic resync
> upon chip reset etc.

any chance you want to open source that and share it. Or consider porting the 3-wire support into Zephyr?

Anyway, have you tried —noflowctrl option with btattach. If I remember correctly then 3-wire is requiring that flow control is turned off.

Regards

Marcel

