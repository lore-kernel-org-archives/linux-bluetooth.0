Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <d89ddf300909151000w572c840fo2a59afd0b950230c@mail.gmail.com>
References: <5d223510909040942u7ee2ae0ds96e1321b1fab24b9@mail.gmail.com>
	 <e0ab60670909141117t697926f6gf309b1f24052162b@mail.gmail.com>
	 <d89ddf300909141347s27d3437ft7d93c9dd16e89bfe@mail.gmail.com>
	 <e0ab60670909150614r30dbfac3qba7ae141cf2d0356@mail.gmail.com>
	 <d89ddf300909151000w572c840fo2a59afd0b950230c@mail.gmail.com>
Date: Tue, 15 Sep 2009 15:14:29 -0300
Message-ID: <e0ab60670909151114k402c4a33p74c5017d2376315@mail.gmail.com>
Subject: Re: choppy audio on ARM
From: Douglas Lopes Pereira <douglaslopespereira@gmail.com>
To: Brad Midgley <bmidgley@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brad

On Tue, Sep 15, 2009 at 2:00 PM, Brad Midgley <bmidgley@gmail.com> wrote:
> Douglas,
>
> run "lsusb" from a shell after the adapters are all connected.
>
> Brad
>
> On Tue, Sep 15, 2009 at 7:14 AM, Douglas Lopes Pereira
> <douglaslopespereira@gmail.com> wrote:
>> Hi Brad,
>>
>> On Mon, Sep 14, 2009 at 5:47 PM, Brad Midgley <bmidgley@gmail.com> wrote:
>>> Douglas
>>>
>>>> - Connecting bluetooth dongle over USB Hub:
>>>>
>>>> usb 1-1: new high speed USB device using orion-ehci and address 19
>>>> usb 1-1: configuration #1 chosen from 1 choice
>>>> hub 1-1:1.0: USB hub found
>>>> hub 1-1:1.0: 4 ports detected
>>>> usb 1-1.3: new full speed USB device using orion-ehci and address 20
>>>> usb 1-1.3: configuration #1 chosen from 1 choice
>>>>
>>>> - Connecting bluetooth directly on Sheeva Plug:
>>>>
>>>> usb 1-1: new full speed USB device using orion-ehci and address 14
>>>> usb 1-1: configuration #1 chosen from 1 choice
>>>
>>> "lsusb" in both cases should shed more light on the topology and where
>>> full speed links creep in.
>>>
>>> --
>>> Brad Midgley
>>>
>>
>> Could you elaborate a little bit more on that?
>>
>> Thank you.
>>
>
>
>
> --
> Brad Midgley
>

This is the output from lsusb. No interesting information in my point of view:

- Connecting bluetooth directly on Sheeva Plug:

Bus 001 Device 014: ID 0a12:0001 Cambridge Silicon Radio, Ltd
Bluetooth Dongle (HCI mode)
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

- Connecting bluetooth dongle over USB Hub:

Bus 001 Device 008: ID 0a12:0001 Cambridge Silicon Radio, Ltd
Bluetooth Dongle (HCI mode)
Bus 001 Device 002: ID 05e3:0606 Genesys Logic, Inc. USB 2.0 Hub /
D-Link DUB-H4 USB 2.0 Hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

Can you or someone else cite differences between EHCI driver handling
the usb dongle over the usb hub or directly connected?

Thank you for your patience and attention.

Douglas
