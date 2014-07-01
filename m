Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <A9B54F0C-0D75-4C80-8AC1-B0EE71D6C8FF@holtmann.org>
References: <1404205896-25742-1-git-send-email-drake@endlessm.com>
	<BABA9B45-3DA7-40E4-9850-56CE967013BD@holtmann.org>
	<CAD8Lp46KFEbqi2eAotwa+J++Qo_p6cZR-KdmpWbDPcMavTPYzg@mail.gmail.com>
	<A9B54F0C-0D75-4C80-8AC1-B0EE71D6C8FF@holtmann.org>
Date: Tue, 1 Jul 2014 11:55:19 +0100
Message-ID: <CAD8Lp47NQZPb0TQTp7kcy_D_9Z6Uj5yEOCAEdNLZnQ5jSFHx0w@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Add Realtek 8723/8761 support
From: Daniel Drake <drake@endlessm.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>, Larry.Finger@lwfinger.net
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jul 1, 2014 at 11:14 AM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> the unaligned helpers will do right thing. So no need for casting ourselv=
es to death here. In addition you might want to think about the endianess h=
ere. And the unaligned helpers with the automatic endian conversion are nic=
e to keep the code readable. Let the compiler figure out the details for yo=
u.

The following code should be more correct now but I still wonder if
I'm missing something regarding the use of "unaligned helpers". Is
this what you had in mind?

    unsigned char *chip_id_base, *patch_length_base, *patch_offset_base;
    chip_id_base =3D epatch_fw->data + sizeof(struct rtk_epatch_header);
    patch_length_base =3D chip_id_base + (sizeof(u16) * epatch_info->num_pa=
tches);
    patch_offset_base =3D patch_length_base + (sizeof(u16) *
epatch_info->num_patches);
    for (i =3D 0; i < epatch_info->num_patches; i++) {
        u16 chip_id =3D get_unaligned_le16(chip_id_base + (i * sizeof(u16))=
);
        if (chip_id =3D=3D eversion + 1) {
            patch_length =3D get_unaligned_le16(patch_length_base + (i *
sizeof(u16));
            patch_offset =3D get_unaligned_le32(patch_offset_base + (i *
sizeof(u32));
            break;
        }
    }


>> +     fw_len =3D rtk_load_firmware(hdev, &fw_blob, variant, eversion);
>> +     if (fw_len < 0)
>> +             return fw_len;
>
> No. This function returns either 0 or an error. Don't confuse the Bluetoo=
th core with some random number.

I checked the return paths from rtk_load_firmware and they will always
return >0 or an error.
So the return shown above won't return random numbers, instead it will
return common errors like -ENOMEM.
Or would you prefer that I ignore the error code from
rtk_load_firmware() and just return a fixed error (EIO?) in such case?
Another alternative is to return 0 like the broadcom and intel code
does, on the offchance that the device is already running a usable
firmware version. What do you think?

Thanks
Daniel
