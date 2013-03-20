Return-Path: <cyrus@holtmann.org>
Message-ID: <5149FC3A.4070208@thinkpenguin.com>
Date: Wed, 20 Mar 2013 14:13:14 -0400
From: Christopher Waid <chris@thinkpenguin.com>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode) causing
 crashes
References: <514763A7.4020800@thinkpenguin.com> <20130318191335.GA11242@kroah.com>
In-Reply-To: <20130318191335.GA11242@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-usb-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 03/18/2013 03:13 PM, Greg KH wrote:
> On Mon, Mar 18, 2013 at 02:57:43PM -0400, Christopher Waid wrote:
>> Bus 001 Device 007: ID 0a12:0001 Cambridge Silicon Radio, Ltd
>> Bluetooth Dongle (HCI mode)
>>
>> Code for a CSR bluetooth chipset appears broken in recent kernel
>> releases. After a device is paired the kernel panics. This has been
>> tested with a dozen USB dongles / systems and is consistently a
>> problem. On the rare occasion it might not cause a kernel panic
>> although it will definitely still crash after a few minutes. This
>> does not happen with older kernel releases.
> What kernel version is crashing, and what is the exact text of the
> kernel panic?

It goes black and disappears off the screen with a lot of other text so 
I'm unsure.

It has done it with various kernel versions including 3.2 and 3.8. I 
tested it with the mainline kernel 3.8:

Linux penguin 3.8.0-030800-generic #201302181935 SMP Tue Feb 19 00:36:19
UTC 2013 x86_64 x86_64 x86_64 GNU/Linux




>
>> Please let me know how I can help solve this issue. We have lots of
>> dongles and can try and get any information needed to fix it.
> You might want to ask the Linux bluetooth developers (now added to the
> cc of this response.)
>
> thanks,
>
> greg k-h

