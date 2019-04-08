Return-Path: <SRS0=Ssic=SK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B9DC10F13
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Apr 2019 15:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1A9E2148E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Apr 2019 15:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bN9tIi9d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbfDHP6A (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:58:00 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46082 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfDHP6A (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Apr 2019 11:58:00 -0400
Received: by mail-ot1-f65.google.com with SMTP id s24so7399945otk.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Apr 2019 08:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=L2YcTwmronW0+/78Kp7YgcKSX1UWYC9GPPBbE6zux3s=;
        b=bN9tIi9dtP760Y54K+nFLjjTEmZBoArHL7kAh7n5PC++kxcFNjYLgPwWMMTSX2qiRi
         BrWPPdY7c4JkfFL6rzFqIzwnc8f9sfj/NGJSRAgZlXYzFJMQNbWpop3l6V3ie/JGFB3r
         KYm8RvWUftDSOVbLjet6SWlyBJV6VeKR/mmst3HGzdJ5s66i5xc/PxX9QT/O3OHDfySZ
         cN/l5Tl2oSWxiT1WJ9Hwm9lssDWpSLweDUv+hcKg685Velwb+Wty8t8x2B06m+vFYn2Z
         CAiv4QGG7JYI9kF/CxqvYOS3+f1IHV9/bAVP3NcvVps8OjIJTM7qwGvBxAvODy5HNNtL
         UAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=L2YcTwmronW0+/78Kp7YgcKSX1UWYC9GPPBbE6zux3s=;
        b=lpt8lISSmeOxXclSuPpEtQPos6ljVWVrGzlV7fochvlq8xt5LaC8P0lq/cQ/VJMT9Y
         3c2/ndMG4MA6P5ECFplKv+NIYLe0BcdIcKPSMfvpW+9VziAu9xjuno4rfkXGUAgH1F+5
         26Vc2ZgRCd147s65QN0xVtPj4C7K/0+I1F8MDUrcHLoD8W2YMGFy+lHqNsRtL+1Ifu+y
         w2xvimZy53gBGf4xEXxqsLkp0UXD08X9WNGBpStUjnaeUrTgM6EkbpYUFABGXBGOzgJ6
         rO82NMH7VbffGKvjUqyqwODNs1lNLFpyVr3ZuSzk1D7VarBinvgG5MDDaEOen8Fv1d8L
         y76Q==
X-Gm-Message-State: APjAAAXmUxDu1iiF0cJtBphK+InIYjOfbIa3HxOg8C1cWMJFbSE0fPNe
        kOCnG8N78DTf62RQIBQMbiuk+DMFQLNiPbCe3qWgK/Fn
X-Google-Smtp-Source: APXvYqxxWihN+W22zVZGCDbquThCuE6S4OOgMqc7BAwD0xUknnQAZPsAmjV7tt77/p7gHKsXmBxxEQo10Jg8TwPWQGY=
X-Received: by 2002:aca:4b03:: with SMTP id y3mr16328489oia.21.1554739078314;
 Mon, 08 Apr 2019 08:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190403173840.6236-1-luiz.dentz@gmail.com>
In-Reply-To: <20190403173840.6236-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 8 Apr 2019 18:57:44 +0300
Message-ID: <CABBYNZLEu29Ai+iuK+O2XPF0Z-pG00VvaF1D6+9+j15ryFwJXg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/gatt-db: Skip ahead if handle range is not
 within service
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Apr 3, 2019 at 8:38 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This checks if a range is within service handles skipping if it is not,
> it also convert the direct search to use
> gatt_db_foreach_service_in_range instead so all operation that do
> lookups in a range can benefit from such optimization.
> ---
>  src/shared/gatt-db.c | 40 +++++++++++++++++++---------------------
>  1 file changed, 19 insertions(+), 21 deletions(-)
>
> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index b5f7094da..7b8d72325 100644
> --- a/src/shared/gatt-db.c
> +++ b/src/shared/gatt-db.c
> @@ -1180,11 +1180,10 @@ struct find_by_type_value_data {
>         unsigned int num_of_res;
>  };
>
> -static void find_by_type(void *data, void *user_data)
> +static void find_by_type(struct gatt_db_attribute *attribute, void *user_data)
>  {
>         struct find_by_type_value_data *search_data = user_data;
> -       struct gatt_db_service *service = data;
> -       struct gatt_db_attribute *attribute;
> +       struct gatt_db_service *service = attribute->service;
>         int i;
>
>         if (!service->active)
> @@ -1235,7 +1234,8 @@ unsigned int gatt_db_find_by_type(struct gatt_db *db, uint16_t start_handle,
>         data.func = func;
>         data.user_data = user_data;
>
> -       queue_foreach(db->services, find_by_type, &data);
> +       gatt_db_foreach_service_in_range(db, NULL, find_by_type, &data,
> +                                               start_handle, end_handle);
>
>         return data.num_of_res;
>  }
> @@ -1259,7 +1259,8 @@ unsigned int gatt_db_find_by_type_value(struct gatt_db *db,
>         data.value = value;
>         data.value_len = value_len;
>
> -       queue_foreach(db->services, find_by_type, &data);
> +       gatt_db_foreach_service_in_range(db, NULL, find_by_type, &data,
> +                                               start_handle, end_handle);
>
>         return data.num_of_res;
>  }
> @@ -1271,11 +1272,10 @@ struct read_by_type_data {
>         uint16_t end_handle;
>  };
>
> -static void read_by_type(void *data, void *user_data)
> +static void read_by_type(struct gatt_db_attribute *attribute, void *user_data)
>  {
>         struct read_by_type_data *search_data = user_data;
> -       struct gatt_db_service *service = data;
> -       struct gatt_db_attribute *attribute;
> +       struct gatt_db_service *service = attribute->service;
>         int i;
>
>         if (!service->active)
> @@ -1310,7 +1310,8 @@ void gatt_db_read_by_type(struct gatt_db *db, uint16_t start_handle,
>         data.end_handle = end_handle;
>         data.queue = queue;
>
> -       queue_foreach(db->services, read_by_type, &data);
> +       gatt_db_foreach_service_in_range(db, NULL, read_by_type, &data,
> +                                               start_handle, end_handle);
>  }
>
>
> @@ -1320,21 +1321,16 @@ struct find_information_data {
>         uint16_t end_handle;
>  };
>
> -static void find_information(void *data, void *user_data)
> +static void find_information(struct gatt_db_attribute *attribute,
> +                                               void *user_data)
>  {
>         struct find_information_data *search_data = user_data;
> -       struct gatt_db_service *service = data;
> -       struct gatt_db_attribute *attribute;
> +       struct gatt_db_service *service = attribute->service;
>         int i;
>
>         if (!service->active)
>                 return;
>
> -       /* Check if service is in range */
> -       if ((service->attributes[0]->handle + service->num_handles - 1) <
> -                                               search_data->start_handle)
> -               return;
> -
>         for (i = 0; i < service->num_handles; i++) {
>                 attribute = service->attributes[i];
>                 if (!attribute)
> @@ -1360,7 +1356,8 @@ void gatt_db_find_information(struct gatt_db *db, uint16_t start_handle,
>         data.end_handle = end_handle;
>         data.queue = queue;
>
> -       queue_foreach(db->services, find_information, &data);
> +       gatt_db_foreach_service_in_range(db, NULL, find_information, &data,
> +                                               start_handle, end_handle);
>  }
>
>  void gatt_db_foreach_service(struct gatt_db *db, const bt_uuid_t *uuid,
> @@ -1382,12 +1379,13 @@ static void foreach_service_in_range(void *data, void *user_data)
>  {
>         struct gatt_db_service *service = data;
>         struct foreach_data *foreach_data = user_data;
> -       uint16_t svc_start;
> +       uint16_t svc_start, svc_end;
>         bt_uuid_t uuid;
>
> -       svc_start = get_handle_at_index(service, 0);
> +       gatt_db_service_get_handles(service, &svc_start, &svc_end);
>
> -       if (svc_start > foreach_data->end || svc_start < foreach_data->start)
> +       /* Check if service is within requested range */
> +       if (svc_start > foreach_data->end || svc_end < foreach_data->start)
>                 return;
>
>         if (foreach_data->uuid) {
> --
> 2.20.1

Applied.

-- 
Luiz Augusto von Dentz
