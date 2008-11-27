Return-Path: <cyrus@holtmann.org>
Message-ID: <492ED29E.1060702@parrot.com>
Date: Thu, 27 Nov 2008 18:02:22 +0100
From: Matthieu CASTET <matthieu.castet@parrot.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: btusb and HCI_RAW
References: <491868E6.6000406@parrot.com> <F9029075-34B5-4DE1-98EA-E990C82C7495@holtmann.org>
In-Reply-To: <F9029075-34B5-4DE1-98EA-E990C82C7495@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,


Marcel Holtmann a écrit :
> Hi Matthieu,
> 
>> with HCI_RAW, application can bypass the bluez stack and send raw stuff
>> to dongle.
>>
>> This seems not possible anymore with btusb because it uses
>> "hdev->conn_hash" to check if ACLDATA/SCODATA should be send/received.
>>
>> These checks make the HCI_RAW mode a bit useless (ie not working for acl
>> and sco).
>>
>> Can we make the HCI_RAW work like before with acl and sco data ?
>> For example we can ignore theses check in HCI_RAW mode and send a notify
>> event when we turn on/off HCI_RAW mode.
> 
> we could, but that will cost a lot of CPU power. The SCO data packets
> are just not an option here. Also without a full blown Bluetooth stack,
> you don't know with alternate setting to use.
But hci_usb wasn't doing that (ie always use max alternate setting +
submit sco/alc urb), and I wasn't under the impression that it costs too
much CPU power.


> So this is a little bit
> pointless here and before just worked by pure luck. Why do you want this
> support in the first place?
>
This can be helpful to test userspace bluetooth stack or do some fuzzing.

What is the goal of HCI_RAW ?
With btusb it seems useless in the tx path.


Matthieu
