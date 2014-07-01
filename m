Return-Path: <cyrus@holtmann.org>
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <53B2C954.3070900@lwfinger.net>
Date: Tue, 01 Jul 2014 09:44:36 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>,
 Daniel Drake <drake@endlessm.com>
CC: "Gustavo F. Padovan" <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: btusb: Add Realtek 8723/8761 support
References: <1404205896-25742-1-git-send-email-drake@endlessm.com> <BABA9B45-3DA7-40E4-9850-56CE967013BD@holtmann.org> <CAD8Lp46KFEbqi2eAotwa+J++Qo_p6cZR-KdmpWbDPcMavTPYzg@mail.gmail.com> <A9B54F0C-0D75-4C80-8AC1-B0EE71D6C8FF@holtmann.org>
In-Reply-To: <A9B54F0C-0D75-4C80-8AC1-B0EE71D6C8FF@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 07/01/2014 05:14 AM, Marcel Holtmann wrote:
> Hi Daniel,
>
>>>> +     chip_id = (uint16_t *)(epatch_fw->data +
>>>> +                            sizeof(struct rtk_epatch_header));
>>>> +     patch_length = (uint16_t *)((unsigned char *) chip_id +
>>>> +                                 (sizeof(uint16_t)
>>>> +                                  * epatch_info->num_patches));
>>>> +     patch_offset = (uint32_t *)((unsigned char *) patch_length +
>>>> +                                 (sizeof(uint16_t)
>>>> +                                  * epatch_info->num_patches));
>>>
>>> Using the unaligned helpers is not an option?
>>
>> Can you go into a bit more detail here?
>>
>> I should indeed use get_unaligned for accessing the 32-bit
>> patch_offset values as they might not be 4-byte aligned.
>> The others should be fine though.
>>
>> Or are you suggesting some helper that I can use to clean up the code
>> in this area? If so, could you be a little more specific?
>
> the unaligned helpers will do right thing. So no need for casting ourselves to death here. In addition you might want to think about the endianess here. And the unaligned helpers with the automatic endian conversion are nice to keep the code readable. Let the compiler figure out the details for you.
>
>>> Do you really want to name the directory rtl_bt and not rtk or realtek or something more that makes actually sense. I have no idea where rtl comes from.
>>
>> There is already /lib/firmware/rtl_nic used by r8169 driver, I was
>> going for consistency with that. There is also /lib/firmware/rtlwifi.
>> Does that influence your preference?
>
> I personally do not care much either way, just make sure this is actually somewhat consistent. At least you have reason for that.

I would prefer that you add the firmware to /lib/firmware/rtlwifi. That way all 
the Realtek firmware will be in the same place. In addition as discussed on 
GitHub, I would prefer the extension .bin on all firmware files.

Larry
