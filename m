Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2 09/16] Bluetooth: Prepare for full support discovery procedures
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=us-ascii
From: Andre Guedes <andre.guedes@openbossa.org>
In-Reply-To: <1313022292.3373.135.camel@aeonflux>
Date: Fri, 9 Sep 2011 17:43:23 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <81818DFE-DD03-43DB-A44C-E00A4B319079@openbossa.org>
References: <1311623405-31108-1-git-send-email-andre.guedes@openbossa.org> <1311623405-31108-10-git-send-email-andre.guedes@openbossa.org> <1312984092.3373.116.camel@aeonflux> <59EF67F7-A9E0-4C6D-963E-C4EF90F611FC@openbossa.org> <1313022292.3373.135.camel@aeonflux>
To: Marcel Holtmann <marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Aug 10, 2011, at 9:24 PM, Marcel Holtmann wrote:
>>> I don't think this is a good idea. You keep forgetting if you actually
>>> have LE switched on or not.
>>> 
>>> I think we should keep it like this and just keep a global hci_dev  
>>> state
>>> which discovery procedure to use. Depending on if the device is just
>>> really LE-Only, it is dual-stack, but LE got switched off (we will  
>>> need
>>> this eventually for testing) or it is just only BR/EDR.
>> 
>> I agree. What really matters for the discovery procedure is the
>> operation mode not the device type. The term "device type" was
>> misused here.
>> 
>> About the global hci_dev state, IMO we may not need it. By looking
>> at the controller's LMP features we are able to infer what is the
>> controller's operation mode.
> 
> you need to look at the extended features page 1, but yes, if you have
> that available, the it might be as simple as have the global state.
> 
> It really depends on how often you have to check. Maybe it is worth to
> just have a simple operation mode variable compared to always have to
> access multiple bits in the features array. Depends on how often you
> need to use it.

Yes, sure. Since we don't check these bits so often, we can check the
LMP features instead of having the global variable. This way we keep
it simple.

BR,

Andre.
