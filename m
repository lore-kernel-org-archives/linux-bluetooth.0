Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Fix potential NULL dereference
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=windows-1252
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1937969015.163941431584025200.JavaMail.weblogic@ep2mlwas03a>
Date: Thu, 14 May 2015 08:34:23 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <8D659FE1-24A7-43CF-9A85-F4C2C2A32DB9@holtmann.org>
References: <1937969015.163941431584025200.JavaMail.weblogic@ep2mlwas03a>
To: jaganath.k@samsung.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

>>> addr can be NULL and it should not be dereferenced before NULL checking.
>>> 
>>> Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
>>> ---
>> 
>> if we start changing things here, then we better change the code into something that all the other socket handling code is doing anyway>y. So do the min comparison and copy the data into a local copy of the sockaddr_rc.
>> 
>> And on a side note, I wonder if addr can actually be NULL. It might be interesting to check the generic socket code if this really can happe>n if you provide no address structure to the bind() system call or if this gets filtered out by the core socket code.
> 
> I checked generic socket code and it looks like addr will never be NULL when user space calls bind.
> But this can be called from kernel_bind() also which I think will never be called for RFCOMM.
> So this patch is not required? 

that is what I thought. However converting it to the same handling using min and copying into local storage might be a good idea. The more pieces in HCI, L2CAP, SCO and RFCOMM sockets that are similar, the better.

Regards

Marcel

