Return-Path: <cyrus@holtmann.org>
Message-ID: <515C7BD4.9000906@thinkpenguin.com>
Date: Wed, 03 Apr 2013 14:58:28 -0400
From: Christopher Waid <chris@thinkpenguin.com>
MIME-Version: 1.0
To: Gustavo Padovan <gustavo@padovan.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode) causing
 crashes
References: <514763A7.4020800@thinkpenguin.com> <20130318191335.GA11242@kroah.com> <5149FC3A.4070208@thinkpenguin.com> <20130320185719.GC7522@joana> <514A2DDE.8060801@thinkpenguin.com>
In-Reply-To: <514A2DDE.8060801@thinkpenguin.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 03/20/2013 05:45 PM, Christopher Waid wrote:
> On 03/20/2013 02:57 PM, Gustavo Padovan wrote:
>> * Christopher Waid <chris@thinkpenguin.com> [2013-03-20 14:13:14 -0400]:
>>
>>> On 03/18/2013 03:13 PM, Greg KH wrote:
>>>> On Mon, Mar 18, 2013 at 02:57:43PM -0400, Christopher Waid wrote:
>>>>> Bus 001 Device 007: ID 0a12:0001 Cambridge Silicon Radio, Ltd
>>>>> Bluetooth Dongle (HCI mode)
>>>>>
>>>>> Code for a CSR bluetooth chipset appears broken in recent kernel
>>>>> releases. After a device is paired the kernel panics. This has been
>>>>> tested with a dozen USB dongles / systems and is consistently a
>>>>> problem. On the rare occasion it might not cause a kernel panic
>>>>> although it will definitely still crash after a few minutes. This
>>>>> does not happen with older kernel releases.
>>>> What kernel version is crashing, and what is the exact text of the
>>>> kernel panic?
>>> It goes black and disappears off the screen with a lot of other text
>>> so I'm unsure.
>> This text you are seeing in probably the crash dump of the failure, 
>> could you
>> try to take a picture of the screen so we can check if there is some 
>> useful
>> information there.
>>
>> Also if the kernel doesn't panic instantly you could check if there 
>> is some
>> issue in the kernel log after pairing and save it somewhere so we can 
>> take a
>> look. Use the 3.8 kernel.
>>
>
> I'm attaching kern.log and a picture of the screen when it crashes / 
> dumps.
>

I was wondering if anybody had a chance to look into this. I don't seem 
to be on the mailing list even though I attempted to subscribe.

