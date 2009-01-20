Return-Path: <cyrus@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <3AD63C7D-CB02-4F0A-99A2-C38C84607FE9@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: sreevani medhahal <sreevani.medhahal@gmail.com>
In-Reply-To: <c2a31c480901200525q59b1ab02q554b54ceb4515e47@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: Patching 2.6.24
Date: Tue, 20 Jan 2009 16:23:00 +0100
References: <20090115073034.99AEF1059C@ws1-3.us4.outblaze.com> <1232292040.5095.18.camel@californication> <c2a31c480901200525q59b1ab02q554b54ceb4515e47@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sreevani,

>>>> Is it possible to pull in just the Bluetooth changes in kernel  
>>>> 2.6.27 to 2.6.24? Does it have any other dependencies? I am  
>>>> trying to use 2.6.24 with BlueZ 4.17.
>>
>>> I have 2.6.24 down as release in January 2008. In Linus years this  
>>> is an
>>> ancient kernel. Please just try to forward port any patches you have
>>> with 2.6.24 to 2.6.28 and use just a recent kernel. In the long-term
>>> this is the only way to keep you sane. Backporting changes to older
>>> kernels are always tricky. Sure it can be done, but nobody with a  
>>> sane
>>> mind is doing it for free.
>
> after  attempting to  patching the 2.6.27 bluetooth changes on to
> 2.6.24[ie., drivers/bluetooth & net/bluetooth] & used the latest BlueZ
> . Tested the same with headsets for music & voice(worked fine),but the
> HID device didnt not work. We need to work with bluetooth on 2.6.24 as
> there is a dependancy on  the others drivers present in kernel 2.6.24.
> For HID over Bluetooth to work does it have a dependancy on other
> kernel drivers/modules(apart from drivers/bluetooth & net/bluetooth
> modules). Any clues in this regard will be helpful.

let me be just quite blunt here. The assumption that you have to stay  
with 2.6.24 is something you put yourself onto. In many cases it is as  
simple to forward other drivers than insisting on backporting changes.

If you blindly copy the directories over you will end up in trouble.  
It might work, but in many cases it will not since the subystems  
Bluetooth depends on changed quite a bit during the last two years.

For HID, we have introduced a full blown HID subsystem and HID bus  
during the time and Bluetooth depends on it. No idea why it doesn't  
work, but as I said, backports are painful and introduce the same  
risks of breaking things than moving forward with a more recent kernel.

Nobody says you should use bleeding edge 2.6.28, but at least one  
kernel where the -stable maintainers still bother to update it.

Regards

Marcel

