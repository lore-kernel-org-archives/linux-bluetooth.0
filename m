Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1359054206-19528-5-git-send-email-johan.hedberg@gmail.com>
References: <1359054206-19528-1-git-send-email-johan.hedberg@gmail.com>
	<1359054206-19528-5-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 24 Jan 2013 16:21:06 -0400
Message-ID: <CAJdJm_OMiH4vcoQSG1x++_G_nnQiTseb-moF8p=9k2utE=gAEg@mail.gmail.com>
Subject: Re: [PATCH 4/6] Bluetooth: Refactor UUID-16 list generation into its
 own function
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Thu, Jan 24, 2013 at 3:03 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> +static u8 *create_uuid16_list(struct hci_dev *hdev, u8 *data, ptrdiff_t len)
> +{
> +       u8 *ptr = data, *uuids_start = NULL;
> +       struct bt_uuid *uuid;

Maybe you should check for "len < 2" here?

> +
> +       list_for_each_entry(uuid, &hdev->uuid16, list) {
> +               u16 uuid16;
> +
> +               uuid16 = get_unaligned_le16(&uuid->uuid[12]);
> +               if (uuid16 < 0x1100)
> +                       continue;
> +
> +               if (uuid16 == PNP_INFO_SVCLASS_ID)
> +                       continue;
> +
> +               if (!uuids_start) {
> +                       uuids_start = ptr;
> +                       uuids_start[0] = 1;
> +                       uuids_start[1] = EIR_UUID16_ALL;
> +                       ptr += 2;
> +               }
> +
> +               /* Stop if not enough space to put next UUID */
> +               if ((ptr - data) + sizeof(u16) > len) {
> +                       uuids_start[1] = EIR_UUID16_SOME;
> +                       break;
> +               }
> +
> +               *ptr++ = (uuid16 & 0x00ff);
> +               *ptr++ = (uuid16 & 0xff00) >> 8;
> +               uuids_start[0] += sizeof(uuid16);
> +       }
> +
> +       return ptr;
> +}

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
