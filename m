Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1427822644-39009-2-git-send-email-jamuraa@chromium.org>
References: <1427822644-39009-1-git-send-email-jamuraa@chromium.org>
	<1427822644-39009-2-git-send-email-jamuraa@chromium.org>
Date: Wed, 1 Apr 2015 10:40:17 +0300
Message-ID: <CABBYNZ+1wPQtiUmcGnAHmSv2cmaAoq9oZz71jB+AW8NGkRcr_g@mail.gmail.com>
Subject: Re: [BlueZ v7 01/10] shared: add bt_ad structure
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michael Janssen <jamuraa@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On Tue, Mar 31, 2015 at 8:23 PM, Michael Janssen <jamuraa@chromium.org> wrote:
> The bt_ad structure provides an abstraction for easy translation of defined
> Advertisement Data fields into the resulting raw bytes needed by the Bluetooth
> HCI LE Set Advertising Data command.
> ---
>  Makefile.am     |   1 +
>  src/shared/ad.c | 346 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  src/shared/ad.h |  60 ++++++++++
>  3 files changed, 407 insertions(+)
>  create mode 100644 src/shared/ad.c
>  create mode 100644 src/shared/ad.h
>
> diff --git a/Makefile.am b/Makefile.am
> index 676d929..e144428 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -111,6 +111,7 @@ shared_sources = src/shared/io.h src/shared/timeout.h \
>                         src/shared/uhid.h src/shared/uhid.c \
>                         src/shared/pcap.h src/shared/pcap.c \
>                         src/shared/btsnoop.h src/shared/btsnoop.c \
> +                       src/shared/ad.h src/shared/ad.c \
>                         src/shared/att-types.h \
>                         src/shared/att.h src/shared/att.c \
>                         src/shared/gatt-helpers.h src/shared/gatt-helpers.c \
> diff --git a/src/shared/ad.c b/src/shared/ad.c
> new file mode 100644
> index 0000000..8e38d26
> --- /dev/null
> +++ b/src/shared/ad.c
> @@ -0,0 +1,346 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2015  Google Inc.
> + *
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + */
> +
> +#include "src/shared/ad.h"
> +
> +#include "src/shared/queue.h"
> +#include "src/shared/util.h"
> +
> +struct bt_ad {
> +       int ref_count;
> +       struct queue *service_uuids;
> +       struct queue *manufacturer_data;
> +       struct queue *solicit_uuids;
> +       struct queue *service_data;

Did you thought about using a single queue and carrying a type in the
struct data? Perhaps it would be simpler, but in the other hand it may
consume more memory per entry but usually we don't have many entries.

> +};
> +
> +struct uuid_tagged_data {
> +       bt_uuid_t uuid;
> +       uint8_t *data;
> +       size_t len;
> +};
> +
> +struct manufacturer_tagged_data {
> +       uint16_t manufacturer_id;
> +       uint8_t *data;
> +       size_t len;
> +};

I would remove tagged term from these structs.


> +void bt_ad_clear_service_uuid(struct bt_ad *ad)
> +{

For public functions please add a NULL check first.

> +       queue_destroy(ad->service_uuids, free);
> +
> +       ad->service_uuids = queue_new();

I would prefer queue_remove_all instead of queue_destroy+queue_new to cleanup.

> +bool bt_ad_add_manufacturer_data(struct bt_ad *ad, uint16_t manufacturer_id,
> +                                                       void *data, size_t len)
> +{
> +       struct manufacturer_tagged_data *new_data;
> +
> +       if (!ad)
> +               return false;
> +
> +       new_data = new0(struct manufacturer_tagged_data, 1);
> +       if (!new_data)
> +               return false;
> +
> +       new_data->manufacturer_id = manufacturer_id;
> +
> +       new_data->data = malloc(len);
> +       if (!new_data->data) {
> +               free(new_data);
> +               return false;
> +       }
> +
> +       memcpy(new_data->data, data, len);

How about having a memdup?


-- 
Luiz Augusto von Dentz
