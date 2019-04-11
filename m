Return-Path: <SRS0=EB+V=SN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC95C10F13
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Apr 2019 11:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 487BB217D4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Apr 2019 11:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1kEekDX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfDKL5m (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Apr 2019 07:57:42 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42081 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfDKL5m (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Apr 2019 07:57:42 -0400
Received: by mail-oi1-f196.google.com with SMTP id w139so4617072oie.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2019 04:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=2ijxSYq9gmSFD5377IAlrqxZKDc7LYYE+a3k5eLJNQA=;
        b=h1kEekDX1wWExMLpt42b4Lm01ip2NJWh4PByMdXCQJ44kTeHkL+yUEhY7Es+aEfZ5I
         ADizqlsPT3IAHuOz0AA1zAQXZpmAflg9SlQXgYRTAqkklCPGhdnzdLZZPV8MIGtDSRvu
         WZMNnvYzae3kPS0WwjHOyen+NMbJ2E5ZsaRRbRwunFuinh40zHw/kcUq6XIjC6Y4tZ2S
         QUsdQ5LFwiyE659vcxGthGR3ppu2zkQYblhFJacQWROBsvS1s3K6dgNjxa48exKB1qli
         lY0/QY9RfvAjtwlOWsUNEbb5rjb+ztO/VV6cGM0jhQ3kwDKrEkOWOEfzUcPZjjEptN6A
         sJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=2ijxSYq9gmSFD5377IAlrqxZKDc7LYYE+a3k5eLJNQA=;
        b=IXoWSY8hH3o1zwZ5GYpuo4ghFJ372XKBCg3X/wMdKc+XgIK/CnYXGYm3mS3byIvLZh
         t8oHFNdJ65D+jsabn8+oaHNgHcao8epFjysq6mHIKK4ruelf+aPIgLRxErA1jPAHroND
         l/1FH5VB/iQEH9M8Axi5cGloopZTZ0WwTHAoA3LvfK8XKEa636Tk0pf4NJsPhxxsH4Ub
         Z1/PfNvF5wOnCKrM0SPMVhh7JcZB31QHCNwHarhC4KfPbSd1tTdmi1Xj2VqLQi5n6F7u
         AT7qMn59G33f/qOWGMKjU8U0QxUR20lGrEyWeBbMEv78O8yVwkgnrHhVfLRT+eLY8GIb
         GsUw==
X-Gm-Message-State: APjAAAXLiqZO9wdPiav3Wa4uqcpPocdlluJ4XXlk+5XKR/u9uYhNTYV7
        Hpyn5+LT+n6rufG5UVG2WFVo0++4uu0R3t3fo2/hJzHg
X-Google-Smtp-Source: APXvYqyrFsjprzm4TLvNa8p64fiftk1/PyC5iEdIDn/m4jf7kawYkxRZ+TgFMrS0ywUNP6nGtnA+LEQFlHGQtIJb8JM=
X-Received: by 2002:aca:4b03:: with SMTP id y3mr5802777oia.21.1554983860860;
 Thu, 11 Apr 2019 04:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190410102350.27781-1-luiz.dentz@gmail.com>
In-Reply-To: <20190410102350.27781-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 11 Apr 2019 14:57:27 +0300
Message-ID: <CABBYNZJzaatCpiHFVNiiWUgRdWrJQ7VKvMRgMd3bnoA-oTStGQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/gatt-db: Simplify attribute lookup
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Apr 10, 2019 at 1:23 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This consolidates attribute lookup into gatt_db_foreach_in_range and
> instead of using custom code for each operation.
> ---
>  src/shared/gatt-db.c | 251 +++++++++++++++++--------------------------
>  src/shared/gatt-db.h |   6 ++
>  2 files changed, 105 insertions(+), 152 deletions(-)
>
> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index 7b8d72325..dcfb2093e 100644
> --- a/src/shared/gatt-db.c
> +++ b/src/shared/gatt-db.c
> @@ -1126,53 +1126,24 @@ bool gatt_db_service_get_claimed(struct gatt_db_attribute *attrib)
>         return attrib->service->claimed;
>  }
>
> +static void read_by_group_type(struct gatt_db_attribute *attribute,
> +                                               void *user_data)
> +{
> +       struct queue *queue = user_data;
> +
> +       queue_push_tail(queue, attribute);
> +}
> +
>  void gatt_db_read_by_group_type(struct gatt_db *db, uint16_t start_handle,
>                                                         uint16_t end_handle,
>                                                         const bt_uuid_t type,
>                                                         struct queue *queue)
>  {
> -       const struct queue_entry *services_entry;
> -       struct gatt_db_service *service;
> -       uint16_t grp_start, grp_end, uuid_size;
> -
> -       uuid_size = 0;
> -
> -       services_entry = queue_get_entries(db->services);
> -
> -       while (services_entry) {
> -               service = services_entry->data;
> -
> -               if (!service->active)
> -                       goto next_service;
> -
> -               if (bt_uuid_cmp(&type, &service->attributes[0]->uuid))
> -                       goto next_service;
> -
> -               grp_start = service->attributes[0]->handle;
> -               grp_end = grp_start + service->num_handles - 1;
> -
> -               if (grp_end < start_handle || grp_start > end_handle)
> -                       goto next_service;
> -
> -               if (grp_start < start_handle || grp_start > end_handle)
> -                       goto next_service;
> -
> -               if (!uuid_size)
> -                       uuid_size = service->attributes[0]->value_len;
> -               else if (uuid_size != service->attributes[0]->value_len)
> -                       return;
> -
> -               queue_push_tail(queue, service->attributes[0]);
> -
> -next_service:
> -               services_entry = services_entry->next;
> -       }
> +       gatt_db_foreach_service_in_range(db, &type, read_by_group_type, queue,
> +                                               start_handle, end_handle);
>  }
>
>  struct find_by_type_value_data {
> -       bt_uuid_t uuid;
> -       uint16_t start_handle;
> -       uint16_t end_handle;
>         gatt_db_attribute_cb_t func;
>         void *user_data;
>         const void *value;
> @@ -1183,39 +1154,19 @@ struct find_by_type_value_data {
>  static void find_by_type(struct gatt_db_attribute *attribute, void *user_data)
>  {
>         struct find_by_type_value_data *search_data = user_data;
> -       struct gatt_db_service *service = attribute->service;
> -       int i;
> -
> -       if (!service->active)
> -               return;
> -
> -       for (i = 0; i < service->num_handles; i++) {
> -               attribute = service->attributes[i];
>
> -               if (!attribute)
> -                       continue;
> -
> -               if ((attribute->handle < search_data->start_handle) ||
> -                               (attribute->handle > search_data->end_handle))
> -                       continue;
> -
> -               if (bt_uuid_cmp(&search_data->uuid, &attribute->uuid))
> -                       continue;
> -
> -               /* TODO: fix for read-callback based attributes */
> -               if (search_data->value) {
> -                       if (search_data->value_len != attribute->value_len)
> -                               continue;
> -
> -                       if (memcmp(attribute->value, search_data->value,
> -                                       search_data->value_len)) {
> -                               continue;
> -                       }
> -               }
> +       /* TODO: fix for read-callback based attributes */
> +       if (search_data->value) {
> +               if (search_data->value_len != attribute->value_len)
> +                       return;
>
> -               search_data->num_of_res++;
> -               search_data->func(attribute, search_data->user_data);
> +               if (memcmp(attribute->value, search_data->value,
> +                                       search_data->value_len))
> +                       return;
>         }
> +
> +       search_data->num_of_res++;
> +       search_data->func(attribute, search_data->user_data);
>  }
>
>  unsigned int gatt_db_find_by_type(struct gatt_db *db, uint16_t start_handle,
> @@ -1228,13 +1179,10 @@ unsigned int gatt_db_find_by_type(struct gatt_db *db, uint16_t start_handle,
>
>         memset(&data, 0, sizeof(data));
>
> -       data.uuid = *type;
> -       data.start_handle = start_handle;
> -       data.end_handle = end_handle;
>         data.func = func;
>         data.user_data = user_data;
>
> -       gatt_db_foreach_service_in_range(db, NULL, find_by_type, &data,
> +       gatt_db_foreach_in_range(db, type, find_by_type, &data,
>                                                 start_handle, end_handle);
>
>         return data.num_of_res;
> @@ -1251,52 +1199,22 @@ unsigned int gatt_db_find_by_type_value(struct gatt_db *db,
>  {
>         struct find_by_type_value_data data;
>
> -       data.uuid = *type;
> -       data.start_handle = start_handle;
> -       data.end_handle = end_handle;
>         data.func = func;
>         data.user_data = user_data;
>         data.value = value;
>         data.value_len = value_len;
>
> -       gatt_db_foreach_service_in_range(db, NULL, find_by_type, &data,
> +       gatt_db_foreach_in_range(db, type, find_by_type, &data,
>                                                 start_handle, end_handle);
>
>         return data.num_of_res;
>  }
>
> -struct read_by_type_data {
> -       struct queue *queue;
> -       bt_uuid_t uuid;
> -       uint16_t start_handle;
> -       uint16_t end_handle;
> -};
> -
>  static void read_by_type(struct gatt_db_attribute *attribute, void *user_data)
>  {
> -       struct read_by_type_data *search_data = user_data;
> -       struct gatt_db_service *service = attribute->service;
> -       int i;
> -
> -       if (!service->active)
> -               return;
> -
> -       for (i = 0; i < service->num_handles; i++) {
> -               attribute = service->attributes[i];
> -               if (!attribute)
> -                       continue;
> -
> -               if (attribute->handle < search_data->start_handle)
> -                       continue;
> +       struct queue *queue = user_data;
>
> -               if (attribute->handle > search_data->end_handle)
> -                       return;
> -
> -               if (bt_uuid_cmp(&search_data->uuid, &attribute->uuid))
> -                       continue;
> -
> -               queue_push_tail(search_data->queue, attribute);
> -       }
> +       queue_push_tail(queue, attribute);
>  }
>
>  void gatt_db_read_by_type(struct gatt_db *db, uint16_t start_handle,
> @@ -1304,59 +1222,24 @@ void gatt_db_read_by_type(struct gatt_db *db, uint16_t start_handle,
>                                                 const bt_uuid_t type,
>                                                 struct queue *queue)
>  {
> -       struct read_by_type_data data;
> -       data.uuid = type;
> -       data.start_handle = start_handle;
> -       data.end_handle = end_handle;
> -       data.queue = queue;
> -
> -       gatt_db_foreach_service_in_range(db, NULL, read_by_type, &data,
> +       gatt_db_foreach_in_range(db, &type, read_by_type, queue,
>                                                 start_handle, end_handle);
>  }
>
>
> -struct find_information_data {
> -       struct queue *queue;
> -       uint16_t start_handle;
> -       uint16_t end_handle;
> -};
> -
>  static void find_information(struct gatt_db_attribute *attribute,
>                                                 void *user_data)
>  {
> -       struct find_information_data *search_data = user_data;
> -       struct gatt_db_service *service = attribute->service;
> -       int i;
> +       struct queue *queue = user_data;
>
> -       if (!service->active)
> -               return;
> -
> -       for (i = 0; i < service->num_handles; i++) {
> -               attribute = service->attributes[i];
> -               if (!attribute)
> -                       continue;
> -
> -               if (attribute->handle < search_data->start_handle)
> -                       continue;
> -
> -               if (attribute->handle > search_data->end_handle)
> -                       return;
> -
> -               queue_push_tail(search_data->queue, attribute);
> -       }
> +       queue_push_tail(queue, attribute);
>  }
>
>  void gatt_db_find_information(struct gatt_db *db, uint16_t start_handle,
>                                                         uint16_t end_handle,
>                                                         struct queue *queue)
>  {
> -       struct find_information_data data;
> -
> -       data.start_handle = start_handle;
> -       data.end_handle = end_handle;
> -       data.queue = queue;
> -
> -       gatt_db_foreach_service_in_range(db, NULL, find_information, &data,
> +       gatt_db_foreach_in_range(db, NULL, find_information, queue,
>                                                 start_handle, end_handle);
>  }
>
> @@ -1373,29 +1256,71 @@ struct foreach_data {
>         const bt_uuid_t *uuid;
>         void *user_data;
>         uint16_t start, end;
> +       bool attr;
>  };
>
>  static void foreach_service_in_range(void *data, void *user_data)
>  {
>         struct gatt_db_service *service = data;
> +       struct gatt_db_attribute *attribute = service->attributes[0];
>         struct foreach_data *foreach_data = user_data;
> -       uint16_t svc_start, svc_end;
>         bt_uuid_t uuid;
>
> +       if (foreach_data->uuid) {
> +               gatt_db_attribute_get_service_uuid(attribute, &uuid);
> +               if (bt_uuid_cmp(&uuid, foreach_data->uuid)) {
> +                       /* Compare with attribute UUID in case it is a lookup
> +                        * by group type.
> +                        */
> +                       if (bt_uuid_cmp(&attribute->uuid, foreach_data->uuid))
> +                               return;
> +               }
> +       }
> +
> +       foreach_data->func(service->attributes[0], foreach_data->user_data);
> +}
> +
> +static void foreach_in_range(void *data, void *user_data)
> +{
> +       struct gatt_db_service *service = data;
> +       struct foreach_data *foreach_data = user_data;
> +       uint16_t svc_start, svc_end;
> +       int i;
> +
> +       if (!service->active)
> +               return;
> +
>         gatt_db_service_get_handles(service, &svc_start, &svc_end);
>
>         /* Check if service is within requested range */
>         if (svc_start > foreach_data->end || svc_end < foreach_data->start)
>                 return;
>
> -       if (foreach_data->uuid) {
> -               gatt_db_attribute_get_service_uuid(service->attributes[0],
> -                                                                       &uuid);
> -               if (bt_uuid_cmp(&uuid, foreach_data->uuid))
> +       if (!foreach_data->attr) {
> +               if (svc_start < foreach_data->start ||
> +                                       svc_start > foreach_data->end)
>                         return;
> +               return foreach_service_in_range(data, user_data);
>         }
>
> -       foreach_data->func(service->attributes[0], foreach_data->user_data);
> +       for (i = 0; i < service->num_handles; i++) {
> +               struct gatt_db_attribute *attribute = service->attributes[i];
> +
> +               if (!attribute)
> +                       continue;
> +
> +               if (attribute->handle < foreach_data->start)
> +                       continue;
> +
> +               if (attribute->handle > foreach_data->end)
> +                       return;
> +
> +               if (foreach_data->uuid && bt_uuid_cmp(foreach_data->uuid,
> +                                                       &attribute->uuid))
> +                       continue;
> +
> +               foreach_data->func(attribute, foreach_data->user_data);
> +       }
>  }
>
>  void gatt_db_foreach_service_in_range(struct gatt_db *db,
> @@ -1415,8 +1340,30 @@ void gatt_db_foreach_service_in_range(struct gatt_db *db,
>         data.user_data = user_data;
>         data.start = start_handle;
>         data.end = end_handle;
> +       data.attr = false;
> +
> +       queue_foreach(db->services, foreach_in_range, &data);
> +}
> +
> +void gatt_db_foreach_in_range(struct gatt_db *db, const bt_uuid_t *uuid,
> +                                               gatt_db_attribute_cb_t func,
> +                                               void *user_data,
> +                                               uint16_t start_handle,
> +                                               uint16_t end_handle)
> +{
> +       struct foreach_data data;
> +
> +       if (!db || !func || start_handle > end_handle)
> +               return;
> +
> +       data.func = func;
> +       data.uuid = uuid;
> +       data.user_data = user_data;
> +       data.start = start_handle;
> +       data.end = end_handle;
> +       data.attr = true;
>
> -       queue_foreach(db->services, foreach_service_in_range, &data);
> +       queue_foreach(db->services, foreach_in_range, &data);
>  }
>
>  void gatt_db_service_foreach(struct gatt_db_attribute *attrib,
> diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
> index 398d69ad8..08f037428 100644
> --- a/src/shared/gatt-db.h
> +++ b/src/shared/gatt-db.h
> @@ -168,6 +168,12 @@ void gatt_db_find_information(struct gatt_db *db, uint16_t start_handle,
>  void gatt_db_foreach_service(struct gatt_db *db, const bt_uuid_t *uuid,
>                                                 gatt_db_attribute_cb_t func,
>                                                 void *user_data);
> +void gatt_db_foreach_in_range(struct gatt_db *db, const bt_uuid_t *uuid,
> +                                               gatt_db_attribute_cb_t func,
> +                                               void *user_data,
> +                                               uint16_t start_handle,
> +                                               uint16_t end_handle);
> +
>  void gatt_db_foreach_service_in_range(struct gatt_db *db,
>                                                 const bt_uuid_t *uuid,
>                                                 gatt_db_attribute_cb_t func,
> --
> 2.20.1

Applied.

-- 
Luiz Augusto von Dentz
