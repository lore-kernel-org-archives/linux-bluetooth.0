Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH RFC] bluetooth: fix paring problems with 0cf3:0036 and
 certain devices
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180615074526.3982da35@kemnade.info>
Date: Fri, 15 Jun 2018 11:01:26 +0200
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org
Message-Id: <AF751918-A8E5-4315-AF0C-E6A53A282A07@holtmann.org>
References: <20180614193330.28410-1-andreas@kemnade.info>
 <20180614203500.GA7182@x1c> <20180615074526.3982da35@kemnade.info>
To: Andreas Kemnade <andreas@kemnade.info>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andreas,

>>> This is clearly a RFC patch, things should be fixed in a cleaner
>>> way. With the bluetooth usb adapter 0cf3:0036 (Atheros), there are
>>> pairing problems in combination with certain remove devices. The
>>> cause is that smp_resume_cb() gets called after SMP_CMD_IDENT_INFO
>>> arrives in the end of a SC pairing with numerical comparison. so
>>> that there are unexpected packet messages in dmesg and although an
>>> ltk is known, bluetoothd considers the device as unpaired and not
>>> even the ltk is not stored.
>>> 
>>> The patch makes the smp code be more tolerant with the order but
>>> that does not feel like a safe thing to do.
>>> Maybe the pairing result should be given back to userspace without
>>> the irk related stuff.  
>> 
>> This sounds like the well known race between ACL data and HCI events
>> that's inherent with the way the USB HCI transport is designed. So
>> what's happening is that to the host it looks like some packets were
>> delivered over an unencrypted connection even though they in reality
>> came over an encrypted one. 
> 
> That matches what I thought. But then the question arises whether this
> race also can happen the oppositie way, so that the host thinks it gets
> an encrypted packet but that is really an unencrypted one? Ugly.
> 
> But interrupt endpoints are designed for correct timing, so there
> might be something rotten in the adapter.
> 
>> Not enforcing the encrypted connection
>> requirement is not really a solution since it creates a security
>> vulnerabilty. The best option (as far as I know) is to consider
>> switching to some other transport (e.g. H:4 over USB where both ACL
>> data and HCI events share a single "pipe").
>> 
> So can we convince the bluetooth adapter to speak H4? So that we add a
> quirk to use H4 for certain bluetooth adapters?
> 
> A quick grep in the kernel does not show up an easy possibility to do
> so.
> 
> Maybe a fix which would be a bit better would be to not completely
> ignore SMP_CMD_IDENT_ADDR_INFO (where the kernel has no doubt that it
> is encrypted) without SMP_CMD_IDENT_INFO, so userspace
> would not get a pairing timeout but instead a pairing without irk but
> with ltk?

I doubt we can do anything about this. The firmware needs to do this correctly. Can you send a btmon trace when this happens and we can see if this is really the case. If the encryption changed signal comes after the packet, then it is the issue.

Regards

Marcel

