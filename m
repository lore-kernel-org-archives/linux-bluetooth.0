Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH] Bluetooth: btusb: Add Realtek 8723/8761 support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAD8Lp46KFEbqi2eAotwa+J++Qo_p6cZR-KdmpWbDPcMavTPYzg@mail.gmail.com>
Date: Tue, 1 Jul 2014 12:14:47 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Linux Bluetooth mailing list
	<linux-bluetooth@vger.kernel.org>, Larry.Finger@lwfinger.net
Message-Id: <A9B54F0C-0D75-4C80-8AC1-B0EE71D6C8FF@holtmann.org>
References: <1404205896-25742-1-git-send-email-drake@endlessm.com> <BABA9B45-3DA7-40E4-9850-56CE967013BD@holtmann.org> <CAD8Lp46KFEbqi2eAotwa+J++Qo_p6cZR-KdmpWbDPcMavTPYzg@mail.gmail.com>
To: Daniel Drake <drake@endlessm.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

>>> +     chip_id = (uint16_t *)(epatch_fw->data +
>>> +                            sizeof(struct rtk_epatch_header));
>>> +     patch_length = (uint16_t *)((unsigned char *) chip_id +
>>> +                                 (sizeof(uint16_t)
>>> +                                  * epatch_info->num_patches));
>>> +     patch_offset = (uint32_t *)((unsigned char *) patch_length +
>>> +                                 (sizeof(uint16_t)
>>> +                                  * epatch_info->num_patches));
>> 
>> Using the unaligned helpers is not an option?
> 
> Can you go into a bit more detail here?
> 
> I should indeed use get_unaligned for accessing the 32-bit
> patch_offset values as they might not be 4-byte aligned.
> The others should be fine though.
> 
> Or are you suggesting some helper that I can use to clean up the code
> in this area? If so, could you be a little more specific?

the unaligned helpers will do right thing. So no need for casting ourselves to death here. In addition you might want to think about the endianess here. And the unaligned helpers with the automatic endian conversion are nice to keep the code readable. Let the compiler figure out the details for you.

>> Do you really want to name the directory rtl_bt and not rtk or realtek or something more that makes actually sense. I have no idea where rtl comes from.
> 
> There is already /lib/firmware/rtl_nic used by r8169 driver, I was
> going for consistency with that. There is also /lib/firmware/rtlwifi.
> Does that influence your preference?

I personally do not care much either way, just make sure this is actually somewhat consistent. At least you have reason for that.

Regards

Marcel

