Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH] Bluetooth: btusb: Add Realtek 8723/8761 support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAD8Lp47NQZPb0TQTp7kcy_D_9Z6Uj5yEOCAEdNLZnQ5jSFHx0w@mail.gmail.com>
Date: Tue, 1 Jul 2014 13:05:33 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Linux Bluetooth mailing list
	<linux-bluetooth@vger.kernel.org>, Larry.Finger@lwfinger.net
Message-Id: <A3C73917-5596-460E-8F27-D2876EE1067C@holtmann.org>
References: <1404205896-25742-1-git-send-email-drake@endlessm.com> <BABA9B45-3DA7-40E4-9850-56CE967013BD@holtmann.org> <CAD8Lp46KFEbqi2eAotwa+J++Qo_p6cZR-KdmpWbDPcMavTPYzg@mail.gmail.com> <A9B54F0C-0D75-4C80-8AC1-B0EE71D6C8FF@holtmann.org> <CAD8Lp47NQZPb0TQTp7kcy_D_9Z6Uj5yEOCAEdNLZnQ5jSFHx0w@mail.gmail.com>
To: Daniel Drake <drake@endlessm.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

>> the unaligned helpers will do right thing. So no need for casting ourselves to death here. In addition you might want to think about the endianess here. And the unaligned helpers with the automatic endian conversion are nice to keep the code readable. Let the compiler figure out the details for you.
> 
> The following code should be more correct now but I still wonder if
> I'm missing something regarding the use of "unaligned helpers". Is
> this what you had in mind?
> 
>    unsigned char *chip_id_base, *patch_length_base, *patch_offset_base;
>    chip_id_base = epatch_fw->data + sizeof(struct rtk_epatch_header);
>    patch_length_base = chip_id_base + (sizeof(u16) * epatch_info->num_patches);
>    patch_offset_base = patch_length_base + (sizeof(u16) *
> epatch_info->num_patches);
>    for (i = 0; i < epatch_info->num_patches; i++) {
>        u16 chip_id = get_unaligned_le16(chip_id_base + (i * sizeof(u16)));
>        if (chip_id == eversion + 1) {
>            patch_length = get_unaligned_le16(patch_length_base + (i *
> sizeof(u16));
>            patch_offset = get_unaligned_le32(patch_offset_base + (i *
> sizeof(u32));
>            break;
>        }
>    }

Yes. this looks a lot better.

>>> +     fw_len = rtk_load_firmware(hdev, &fw_blob, variant, eversion);
>>> +     if (fw_len < 0)
>>> +             return fw_len;
>> 
>> No. This function returns either 0 or an error. Don't confuse the Bluetooth core with some random number.
> 
> I checked the return paths from rtk_load_firmware and they will always
> return >0 or an error.
> So the return shown above won't return random numbers, instead it will
> return common errors like -ENOMEM.
> Or would you prefer that I ignore the error code from
> rtk_load_firmware() and just return a fixed error (EIO?) in such case?
> Another alternative is to return 0 like the broadcom and intel code
> does, on the offchance that the device is already running a usable
> firmware version. What do you think?

Scratch my comment then. This is fine.

Regards

Marcel

