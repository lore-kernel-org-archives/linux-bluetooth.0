Return-Path: <cyrus@holtmann.org>
Message-ID: <4fed618ae82fc803133cc742bbd2eeb6.squirrel@www.codeaurora.org>
In-Reply-To: <1268072572.3712.24.camel@localhost.localdomain>
References: <5a628eb7dc7c4773fbc9478499fde70b.squirrel@www.codeaurora.org>
    <1267753300.29510.25.camel@localhost.localdomain>
    <4B94E5FA.1020202@csr.com>
    <1268072572.3712.24.camel@localhost.localdomain>
Date: Mon, 9 Aug 2010 16:30:05 -0500 (CDT)
Subject: Re: RFC: QuIC's AMP + eL2CAP Technical Plans
From: "Tim Monahan-Mitchell" <tmonahan@codeaurora.org>
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: "David Vrabel" <david.vrabel@csr.com>,
 tmonahan@codeaurora.org,
 linux-bluetooth@vger.kernel.org
Reply-To: tmonahan@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David and Marcel,

I added on to this thread in regards to today's patch of "Bluetooth: HCI
devices are either BR/EDR or AMP radios" (09-Aug-2010).

>> > The block-based flow control is a missing piece, but the AMP type
>> > extension has been merged upstream. We can create HCI_BREDR and
>> > HCI_80211 controllers now. The AMP controllers are for now forced to
>> be
>> > raw devices, but that can be changed easily once we have the
>> controller
>> > init for AMP up and ready.
>>
>> Why HCI_80211 and not HCI_AMP?  The stack shouldn't care what the AMP's
>> radio actually is and with some devices (e.g., standard SDIO ones) it's
>> not even possible to tell what the radio is.
>
> we will be adding a HCI_UWB once that specification gets ratified. And
> the controller type is an official piece of information inside the AMP
> manager. That part needs to know which type of AMP it is. Also the
> driver actually should know what type of AMP it is.
>
> I see your point that for fully generic HCI transports they might not
> know the type upfront and we need to handle that. We will cross that
> bridge when we come to it. Right now we just got started.
>
> Regards
>
> Marcel

If the HCI_80211 symbol in hci.h is changed instead to HCI_AMP, where
should the 0x01 value for '802.11 AMP Controller' (listed in
Bluetooth.org's Assigned Number listing for Controller_Type) go?

Thanks,
Tim Monahan-Mitchell
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
