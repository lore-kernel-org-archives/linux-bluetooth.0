Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] Bluetooth: hci_nokia: select BT_BCM for
 btbcm_set_bdaddr()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170724152734.eftsg7vgouxa4zwz@earth>
Date: Mon, 24 Jul 2017 19:10:14 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <96C957F0-DDCF-458C-8FBE-DE762D37D46E@holtmann.org>
References: <20170722095747.101069-1-marcel@holtmann.org>
 <20170722190323.mt5mrnioql7z2uj2@earth>
 <DC17CA45-3AB5-4272-A12A-1C7BD4811258@holtmann.org>
 <20170722211658.fdfcwoqshtrxqvwj@earth>
 <6FFF415F-F875-481B-A6D6-3DD7159C7DDD@holtmann.org>
 <20170724102357.cj73ujrukrqnl47s@earth>
 <20170724152734.eftsg7vgouxa4zwz@earth>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

>>>>>>> The Nokia devices require the setup of its Public Bluetooth Device
>>>>>>> Address and for that it is required to depend on vendor specific
>>>>>>> commands. For Broadcom based Nokia devices, that is part of btbcm
>>>>>>> module and can be selected via BT_BCM config option.
>>>>>>> 
>>>>>>> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
>>>>>> 
>>>>>> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
>>>>> 
>>>>> btw. we need to also provide the set_bdaddr for TI chips.
>>>> 
>>>> The TI based chip in Nokia N950 has a proper address configured, so
>>>> it works without set_bdaddr (it would still be nice of course). It
>>>> also seems to be missing for hci_ll, though. So the required command
>>>> is completly unknown?
>>> 
>>> are these a TI address or a Nokia address? I doubt Nokia would
>>> have actually shipped any hardware using an IEEE assigned address
>>> to TI.
>> 
>> I can check this later.
> 
> The BD address on my N950 starts with B4:EE:D4, which belongs
> to TI as far as I can see. Note, that N950 is a developer only
> device.

as long as not every N950 now has the same address. But I think if Nokia would have shipped the device then it would have had to be a Nokia address.

Regards

Marcel

