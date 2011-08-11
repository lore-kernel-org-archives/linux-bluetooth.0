Return-Path: <cyrus@holtmann.org>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
 linux-bluetooth@vger.kernel.org
Message-Id: <A943531F-02F0-4809-A45F-03FE4923B6EF@openbossa.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1313022419.3373.137.camel@aeonflux>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH v2 11/16] Bluetooth: Add 'eir_len' param to mgmt_device_found()
Date: Thu, 11 Aug 2011 14:12:21 -0300
References: <1311623405-31108-1-git-send-email-andre.guedes@openbossa.org> <1311623405-31108-12-git-send-email-andre.guedes@openbossa.org> <1312984225.3373.118.camel@aeonflux> <CAJdJm_PWZzbLvLyrr7NyXgemd_GcWH4A9=F5w93cN9qHHb_dig@mail.gmail.com> <1312989466.3373.126.camel@aeonflux> <7E90DB69-1056-4706-9531-BA4D12199A27@openbossa.org> <CAJdJm_Mg4e1bLqYFmQxSctWT6y+GMg2xtJLwavtYoM5yWYJPcw@mail.gmail.com> <1313022419.3373.137.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel/Lizardo,

On Aug 10, 2011, at 9:26 PM, Marcel Holtmann wrote:

> Hi Anderson,
>
>>> The advertising report event has the 'Length' field to inform the
>>> 'Data' field length, so I believe it has a variable length.
>>> According to its description, the 'Length' field may vary from 0x00
>>> to 0x1F (31) bytes.
>>
>> You are right. Although the section 11 gives the impression the size
>> is always 31, this is not what happens on actual hardware, which
>> usually sends only the significant bytes (and the length is know from
>> the "Length" field.
>>
>>> The only drawback I see so far is copying extra ~200 bytes each time
>>> we get a advertising report data.
>>
>> I agree. If this event is being sent on each adv. data report event,
>> it will be more than 6 times the amount of data (with non-significant
>> bytes containing only zeroes) sent to userspace.
>
> if we wanna save bytes copied and send to userspace, then we might  
> even
> fix this for BR/EDR. Since while it is fixed there only a fraction is
> used there most of the times.

IMO changing the struct device_found is another issue (this would
require userspace changes too).

The point in adding the eir_len parameter is to avoid:
     * preparing (memset and copy EIR from adv report) a 240-bytes
       temporary buffer to pass to mgmt_device_found()
     * to memcpy() ~200 useless bytes to ev.eir in mgmt_device_found()

For each advertising data we gather from the LE scan (which can be
a lot) we would need to do that.

BR,

Andre.
