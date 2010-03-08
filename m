Return-Path: <cyrus@holtmann.org>
Subject: Re: RFC: QuIC's AMP + eL2CAP Technical Plans
From: Marcel Holtmann <marcel@holtmann.org>
To: David Vrabel <david.vrabel@csr.com>
Cc: tmonahan@codeaurora.org, linux-bluetooth@vger.kernel.org
In-Reply-To: <4B94E5FA.1020202@csr.com>
References: <5a628eb7dc7c4773fbc9478499fde70b.squirrel@www.codeaurora.org>
	 <1267753300.29510.25.camel@localhost.localdomain>
	 <4B94E5FA.1020202@csr.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 08 Mar 2010 10:22:52 -0800
Message-ID: <1268072572.3712.24.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> > The block-based flow control is a missing piece, but the AMP type
> > extension has been merged upstream. We can create HCI_BREDR and
> > HCI_80211 controllers now. The AMP controllers are for now forced to be
> > raw devices, but that can be changed easily once we have the controller
> > init for AMP up and ready.
> 
> Why HCI_80211 and not HCI_AMP?  The stack shouldn't care what the AMP's
> radio actually is and with some devices (e.g., standard SDIO ones) it's
> not even possible to tell what the radio is.

we will be adding a HCI_UWB once that specification gets ratified. And
the controller type is an official piece of information inside the AMP
manager. That part needs to know which type of AMP it is. Also the
driver actually should know what type of AMP it is.

I see your point that for fully generic HCI transports they might not
know the type upfront and we need to handle that. We will cross that
bridge when we come to it. Right now we just got started.

Regards

Marcel


