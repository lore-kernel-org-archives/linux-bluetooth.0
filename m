Return-Path: <cyrus@holtmann.org>
Message-ID: <4c1d386f9f85e1ec7542f30dd7e8d65a.squirrel@www.codeaurora.org>
In-Reply-To: <4C607D4C.8090407@csr.com>
References: <5a628eb7dc7c4773fbc9478499fde70b.squirrel@www.codeaurora.org>
    <1267753300.29510.25.camel@localhost.localdomain>
    <4B94E5FA.1020202@csr.com>
    <1268072572.3712.24.camel@localhost.localdomain>
    <4fed618ae82fc803133cc742bbd2eeb6.squirrel@www.codeaurora.org>
    <4C607B43.2050207@csr.com> <4C607D4C.8090407@csr.com>
Date: Mon, 9 Aug 2010 17:21:40 -0500 (CDT)
Subject: Re: RFC: QuIC's AMP + eL2CAP Technical Plans
From: "Tim Monahan-Mitchell" <tmonahan@codeaurora.org>
To: "David Vrabel" <david.vrabel@csr.com>
Cc: tmonahan@codeaurora.org, "Marcel Holtmann" <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org
Reply-To: tmonahan@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, David.

> David Vrabel wrote:
>> Tim Monahan-Mitchell wrote:
>>>
>>> If the HCI_80211 symbol in hci.h is changed instead to HCI_AMP, where
>>> should the 0x01 value for '802.11 AMP Controller' (listed in
>>> Bluetooth.org's Assigned Number listing for Controller_Type) go?e
>>
>> I don't think it needs to go anywhere, the actual values aren't
>> important from the point of view of the AMP manager.
>
> I may have misunderstood your question.  There will need to be an
> additional "controller_type" field which will get filled in when the
> local amp info is read from the controller.
>
> There will also need to be a table somewhere mapping controller types to
> dedicated amp link key length and KeyID.  The will be filled in from the
> assigned numbers and will be a very short table one 1 entry for now.
>
> I do not think we need #define for the various AMP controller types.

I would think such a set of #defines are needed, so that everyone is on
the same page?

Put another way, if one device has an AMP of type 802.11, and a remote has
an AMP of type HCI_UWB, it would seem the AMP Manager needs to know not to
try to converse via AMP with that peer, no?

Also have a look at the Core Spec, under 'READ LOCAL AMP INFO COMMAND'.
The 'Controller_Type' list (of which there is only 802.11 now) will
grow...

Controller Type appears elsewhere in the A2MP protocol...

Sorry if I'm not following you completely.

-- 
Regards,
Tim Monahan-Mitchell
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.


