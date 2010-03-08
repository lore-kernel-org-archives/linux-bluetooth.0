Return-Path: <cyrus@holtmann.org>
Message-ID: <b07645c41093608ae0c82fda60b26804.squirrel@www.codeaurora.org>
In-Reply-To: <4B94E5FA.1020202@csr.com>
References: <5a628eb7dc7c4773fbc9478499fde70b.squirrel@www.codeaurora.org>
    <1267753300.29510.25.camel@localhost.localdomain>
    <4B94E5FA.1020202@csr.com>
Date: Mon, 8 Mar 2010 06:52:32 -0800 (PST)
Subject: Re: RFC: QuIC's AMP + eL2CAP Technical Plans
From: tmonahan@codeaurora.org
To: "David Vrabel" <david.vrabel@csr.com>
Cc: "Marcel Holtmann" <marcel@holtmann.org>, tmonahan@codeaurora.org,
	linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, David,

>> The block-based flow control is a missing piece, but the AMP type
>> extension has been merged upstream. We can create HCI_BREDR and
>> HCI_80211 controllers now. The AMP controllers are for now forced to be
>> raw devices, but that can be changed easily once we have the controller
>> init for AMP up and ready.
>
> Why HCI_80211 and not HCI_AMP?  The stack shouldn't care what the AMP's
> radio actually is and with some devices (e.g., standard SDIO ones) it's
> not even possible to tell what the radio is.

One answer is, the "Read Local AMP Info Command" requires the Controller
Type. The value appears in some other AMP HCI commands as well.

Regards,
Tim

