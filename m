Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2 11/16] Bluetooth: Add 'eir_len' param to mgmt_device_found()
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=us-ascii
From: Andre Guedes <andre.guedes@openbossa.org>
In-Reply-To: <1315213416.1979.16.camel@aeonflux>
Date: Tue, 6 Sep 2011 17:06:21 -0300
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
 linux-bluetooth@vger.kernel.org
Message-Id: <A62E7195-906F-4354-9410-338489D4A500@openbossa.org>
References: <1311623405-31108-1-git-send-email-andre.guedes@openbossa.org> <1311623405-31108-12-git-send-email-andre.guedes@openbossa.org> <1312984225.3373.118.camel@aeonflux> <CAJdJm_PWZzbLvLyrr7NyXgemd_GcWH4A9=F5w93cN9qHHb_dig@mail.gmail.com> <1312989466.3373.126.camel@aeonflux> <7E90DB69-1056-4706-9531-BA4D12199A27@openbossa.org> <CAJdJm_Mg4e1bLqYFmQxSctWT6y+GMg2xtJLwavtYoM5yWYJPcw@mail.gmail.com> <1313022419.3373.137.camel@aeonflux> <A943531F-02F0-4809-A45F-03FE4923B6EF@openbossa.org> <1315213416.1979.16.camel@aeonflux>
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sep 5, 2011, at 6:03 AM, Marcel Holtmann wrote:

> Hi Andre,
> 
>>>>> The advertising report event has the 'Length' field to inform the
>>>>> 'Data' field length, so I believe it has a variable length.
>>>>> According to its description, the 'Length' field may vary from 0x00
>>>>> to 0x1F (31) bytes.
>>>> 
>>>> You are right. Although the section 11 gives the impression the size
>>>> is always 31, this is not what happens on actual hardware, which
>>>> usually sends only the significant bytes (and the length is know from
>>>> the "Length" field.
>>>> 
>>>>> The only drawback I see so far is copying extra ~200 bytes each time
>>>>> we get a advertising report data.
>>>> 
>>>> I agree. If this event is being sent on each adv. data report event,
>>>> it will be more than 6 times the amount of data (with non-significant
>>>> bytes containing only zeroes) sent to userspace.
>>> 
>>> if we wanna save bytes copied and send to userspace, then we might  
>>> even
>>> fix this for BR/EDR. Since while it is fixed there only a fraction is
>>> used there most of the times.
>> 
>> IMO changing the struct device_found is another issue (this would
>> require userspace changes too).
> 
> personally I break this one now, instead of later.
> 
>> The point in adding the eir_len parameter is to avoid:
>>     * preparing (memset and copy EIR from adv report) a 240-bytes
>>       temporary buffer to pass to mgmt_device_found()
>>     * to memcpy() ~200 useless bytes to ev.eir in mgmt_device_found()
>> 
>> For each advertising data we gather from the LE scan (which can be
>> a lot) we would need to do that.
> 
> And the same applies to BR/EDR actually. It is just that we never really
> encounter lot of inquiry results (except UPF), but it is the same
> problem that we end up copying data around for no good reason.

BR/EDR case is slightly different. The EIR field in Extended Inquiry
Result Event doesn't have variable length, it has 240-bytes fixed
length (see page 1012). So, we don't need to "prepare" any temporary
buffer to pass to mgmt_device_found().

> If we wanna optimize this, then we better do it for both. So we have the
> same handling towards userspace.

This patch doesn't optimize any kernel-land/user-land data transfer at all.
The optimization done here is in-kernel only. It avoids some extra
operations in hci_le_adv_report_evt() in order to send mgmt_device_found
events.


If we want to optimize kernel/user data transfer by sending only the
significant part of EIR in struct mgmt_ev_device_found we might need to:
    - add a eir_length field to struct mgmt_ev_device_found (this implies
      changing the MGMT API).
    - replace the 'eir' field (240-byte buffer) by a u8 pointer in
      struct mgmt_ev_device_found (this changes the MGMT API too).
    - parser EIR in hci_extended_inquiry_result_evt() to get the length
      of its significant part.
    - do the proper handling of mgmt_device_found events in userspace.

Since this optimization will require some effort, it isn't related to
discovery support itself and we have other patches depending on this
discovery series, I'm afraid we can't work on this kernel/user data
transfer optimization right now. ASA we have mgmt interface stable and
LE main features implemented we might work on these optimizations.

So, I'll send the new version of discovery patch series soon with all
issues we've discussed.

Thanks,

Andre.
