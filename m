Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_OMiH4vcoQSG1x++_G_nnQiTseb-moF8p=9k2utE=gAEg@mail.gmail.com>
References: <1359054206-19528-1-git-send-email-johan.hedberg@gmail.com>
	<1359054206-19528-5-git-send-email-johan.hedberg@gmail.com>
	<CAJdJm_OMiH4vcoQSG1x++_G_nnQiTseb-moF8p=9k2utE=gAEg@mail.gmail.com>
Date: Thu, 24 Jan 2013 16:25:08 -0400
Message-ID: <CAJdJm_OqePCY1yMvJTwaUDnXTMbDJgucbYvEWT99=K9tbvgYQg@mail.gmail.com>
Subject: Re: [PATCH 4/6] Bluetooth: Refactor UUID-16 list generation into its
 own function
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Jan 24, 2013 at 4:21 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Johan,
>
> On Thu, Jan 24, 2013 at 3:03 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>> +static u8 *create_uuid16_list(struct hci_dev *hdev, u8 *data, ptrdiff_t len)
>> +{
>> +       u8 *ptr = data, *uuids_start = NULL;
>> +       struct bt_uuid *uuid;
>
> Maybe you should check for "len < 2" here?

Actually, "len < 4", to be able to fit at least a 16-bit UUID.

-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
