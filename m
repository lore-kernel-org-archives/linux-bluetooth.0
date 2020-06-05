Return-Path: <SRS0=pjei=7S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A87C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 17:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E0DA2075B
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 17:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ky6LYplL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgFERQh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Jun 2020 13:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbgFERQg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Jun 2020 13:16:36 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D52BC08C5C2
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jun 2020 10:16:36 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id d67so8839699oig.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jun 2020 10:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C+9p8TJTm0/acgXKZbjAwrIwQz1qieLaop4V5DW76VI=;
        b=ky6LYplL8SzfYRP/eGpahfyBxbpSJQ01MrPSjUpxT/IZTfzhkw7XPQKQVOMZNa6dGB
         RPATz7ek7M0iTBhxMGp7lgj8LXDq74dRFOLPNUt4zN8OH2/HttXAmwe9315xT2CHakut
         GdCnNUyvVgXBoYejkzTdzROTuttir7K4N2LGBY12rUpVHUpHsawNyM2Ks6D68fb3I66G
         JqGy64PJ/qc9YneZ4M0KNLafJkkZP4KBmtLBEdJJhrfGp0hCYpSQsheTyZBWZMc1G1mK
         0b96XVrqpi5CurVCZGvyTuv4hpfo4BwDIBU+hVSiGQujWv8WsEAXpS8tMUZdIKk+Ogzv
         qFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C+9p8TJTm0/acgXKZbjAwrIwQz1qieLaop4V5DW76VI=;
        b=ZcGM+gmFQWgm4CMEo+Nj0/fYsu72p9KTaX0p3/YCHETutgzsgR+rhYCnj9pdEt3WOF
         ZhHCWzslhq7oeNS0ZC0Hz95zw588AE9FfU9W33JfJFtIpT/JoB8GUx4dbU3udBDiOO2U
         NMiBPKxKuHwxTF5JXlg3jiDmjVcjvdosAXOaSGOyzioU+ryEIG0+y+4QCo0N2hvqXPZJ
         Rga3xPgiwthFcUxOPObLxOfLXONQa4xb9L7AOVLkx/YbIIz64nYOVfTr/3rbmMO59QIX
         ucOjvf18+0xrQp9ztgPLuAwrSLceWEMFbE2zYfCdwkHvb6ysiWT9pb4e6mH80ofACG2a
         T6eA==
X-Gm-Message-State: AOAM530tX1G275a8Pz7tS68hbz1msOuWEIeG45fYJRX+k9MR1GStLAR0
        fEGjPiuWqvt4Tg6qqVeqijktyfDaenueyIrXq/b6blii
X-Google-Smtp-Source: ABdhPJyvTalTqj13YUdR9bUGa+NinoO/VYgpNFfqQFrpFsNNQJy6VamvDAQcQlwRx2tfK28p8+7upsTP6OcTm48arKE=
X-Received: by 2002:aca:b5d5:: with SMTP id e204mr2623183oif.108.1591377395793;
 Fri, 05 Jun 2020 10:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200605142541.28412-1-amitx.k.singh@intel.com> <20200605142541.28412-5-amitx.k.singh@intel.com>
In-Reply-To: <20200605142541.28412-5-amitx.k.singh@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 5 Jun 2020 10:16:23 -0700
Message-ID: <CABBYNZKW39ZbrPcWU_8ttj8rM7-0yzWCBCB_Ge40Mm=h8VkM4Q@mail.gmail.com>
Subject: Re: [PATCH] bluez:update handle for large database
To:     Amitsi5x <amitx.k.singh@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Amit,

On Fri, Jun 5, 2020 at 7:30 AM Amitsi5x <amitx.k.singh@intel.com> wrote:
>
> From: amit <amitx.k.singh@intel.com>
>
> Update handle for large database and
> added condition before free to avoid double free
>
> Signed-off-by: amit <amitx.k.singh@intel.com>
> ---
>  src/shared/gatt-client.c | 12 +++++++-----
>  src/shared/gatt-db.c     | 15 +++++++++------
>  2 files changed, 16 insertions(+), 11 deletions(-)
>
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index 19ff6ab65..3cb6ae443 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -1131,8 +1131,6 @@ static void discover_secondary_cb(bool success, uint8_t att_ecode,
>                                 success = false;
>                                 goto done;
>                         }
> -                       /* Database has changed adjust last handle */
> -                       op->last = end;
>                 }
>
>                 /* Update pending list */
> @@ -1392,9 +1390,13 @@ static void db_hash_read_cb(bool success, uint8_t att_ecode,
>         util_hexdump(' ', value, len, client->debug_callback,
>                                                 client->debug_data);
>
> -       /* Store ithe new hash in the db */
> -       gatt_db_attribute_write(op->hash, 0, value, len, 0, NULL,
> -                                       db_hash_write_value_cb, client);
> +       /* Store the new hash in the db */
> +       if(gatt_db_attribute_write(op->hash, 0, value, len, 0, NULL,
> +                                               db_hash_write_value_cb, client)) {
> +               util_debug(client->debug_callback, client->debug_data,"DB Hash match write: skipping discovery");
> +               queue_remove_all(op->pending_svcs, NULL, NULL, NULL);

Not following this change, if we got to write the db hash that means
the old value did not match.

> +       }
> +
>
>  discover:
>         if (!op->success) {
> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index b44f7b5e9..15af4c20a 100644
> --- a/src/shared/gatt-db.c
> +++ b/src/shared/gatt-db.c
> @@ -344,10 +344,15 @@ static bool db_hash_update(void *user_data)
>         gatt_db_foreach_service(db, NULL, service_gen_hash_m, &hash);
>         bt_crypto_gatt_hash(db->crypto, hash.iov, db->next_handle, db->hash);
>
> -       for (i = 0; i < hash.i; i++)
> -               free(hash.iov[i].iov_base);
> +       for (i = 0; i < hash.i; i++) {
> +               if(hash.iov[i].iov_base)
> +                       free(hash.iov[i].iov_base);
> +       }
> +
> +       if(hash.iov)
> +               free(hash.iov);
>
> -       free(hash.iov);
> +       hash.iov = NULL;

I believe this error was actually introduced by your changes actually,
see below.

>         return false;
>  }
> @@ -689,7 +694,7 @@ struct gatt_db_attribute *gatt_db_insert_service(struct gatt_db *db,
>         service->num_handles = num_handles;
>
>         /* Fast-forward next_handle if the new service was added to the end */
> -       db->next_handle = MAX(handle + num_handles, db->next_handle);
> +       db->next_handle += num_handles;

Note that if the service was not added to the end this starts adding
gaps in between, so I'm afraid I will have to nack this change.

>         return service->attributes[0];
>
> @@ -811,8 +816,6 @@ service_insert_characteristic(struct gatt_db_service *service,
>          * declaration. All characteristic definitions shall have a
>          * Characteristic Value declaration.
>          */
> -       if (handle == UINT16_MAX)
> -               return NULL;

This perhaps is the real reason, it seems to me that you have more
than UINT16_MAX handles so the handles loop around and start over from
0 which is invalid and will most likely cause double frees etc and
they can be multiple attributes assigned to the same handle. How big
is the database you are trying to test? If that is going past
UINT16_MAX it is probably broken and nothing can be done to fix it on
the client side which is why we stop adding attributes after it.

>         i = get_attribute_index(service, 1);
>         if (!i)
> --
> 2.17.1
>


-- 
Luiz Augusto von Dentz
