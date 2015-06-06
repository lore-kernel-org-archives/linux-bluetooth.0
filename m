Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH] Bluetooth: Fix potential NULL dereference
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1433604913.4256.4.camel@gmail.com>
Date: Sat, 6 Jun 2015 17:46:45 +0200
Cc: JAGANATH KANAKKASSERY <jaganath.k@samsung.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <B04557E4-0D7F-44DA-A8A3-D9BD821687D5@holtmann.org>
References: <1937969015.163941431584025200.JavaMail.weblogic@ep2mlwas03a> <8D659FE1-24A7-43CF-9A85-F4C2C2A32DB9@holtmann.org> <1433604913.4256.4.camel@gmail.com>
To: chanyeol <chanyeol.park@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chanyeol,

>>>>> addr can be NULL and it should not be dereferenced before NULL 
>>>>> checking.
>>>>> 
>>>>> Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
>>>>> ---
>>>> 
>>>> if we start changing things here, then we better change the code 
>>>> into something that all the other socket handling code is doing 
>>>> anyway>y. So do the min comparison and copy the data into a local 
>>>> copy of the sockaddr_rc.
>>>> 
>>>> And on a side note, I wonder if addr can actually be NULL. It 
>>>> might be interesting to check the generic socket code if this 
>>>> really can happe>n if you provide no address structure to the 
>>>> bind() system call or if this gets filtered out by the core 
>>>> socket code.
>>> 
>>> I checked generic socket code and it looks like addr will never be 
>>> NULL when user space calls bind.
>>> But this can be called from kernel_bind() also which I think will 
>>> never be called for RFCOMM.
>>> So this patch is not required? 
>> 
>> that is what I thought. However converting it to the same handling 
>> using min and copying into local storage might be a good idea.
> Could you tell us why this is good idea? I failed to find it in git
> history/mailing list.
> 
> In addition to RFCOMM connect that you mentioned, I found out SCO
> connect/bind still use the old style in Bluetooth unlikely HCI,L2CAP.

it avoids any kind of leakage and allows for an easy extension of the socket data structures if we ever have to.

Regards

Marcel

