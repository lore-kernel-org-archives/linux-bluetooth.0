Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BABA9B45-3DA7-40E4-9850-56CE967013BD@holtmann.org>
References: <1404205896-25742-1-git-send-email-drake@endlessm.com>
	<BABA9B45-3DA7-40E4-9850-56CE967013BD@holtmann.org>
Date: Tue, 1 Jul 2014 10:58:29 +0100
Message-ID: <CAD8Lp46KFEbqi2eAotwa+J++Qo_p6cZR-KdmpWbDPcMavTPYzg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Add Realtek 8723/8761 support
From: Daniel Drake <drake@endlessm.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org, Larry.Finger@lwfinger.net
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Thanks for the fast review!

On Tue, Jul 1, 2014 at 10:26 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
>> +     chip_id = (uint16_t *)(epatch_fw->data +
>> +                            sizeof(struct rtk_epatch_header));
>> +     patch_length = (uint16_t *)((unsigned char *) chip_id +
>> +                                 (sizeof(uint16_t)
>> +                                  * epatch_info->num_patches));
>> +     patch_offset = (uint32_t *)((unsigned char *) patch_length +
>> +                                 (sizeof(uint16_t)
>> +                                  * epatch_info->num_patches));
>
> Using the unaligned helpers is not an option?

Can you go into a bit more detail here?

I should indeed use get_unaligned for accessing the 32-bit
patch_offset values as they might not be 4-byte aligned.
The others should be fine though.

Or are you suggesting some helper that I can use to clean up the code
in this area? If so, could you be a little more specific?

> Do you really want to name the directory rtl_bt and not rtk or realtek or something more that makes actually sense. I have no idea where rtl comes from.

There is already /lib/firmware/rtl_nic used by r8169 driver, I was
going for consistency with that. There is also /lib/firmware/rtlwifi.
Does that influence your preference?

I'll address all other comments in the next patch.

Thanks
Daniel
