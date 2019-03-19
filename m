Return-Path: <SRS0=3ySR=RW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E284C43381
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Mar 2019 08:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA2620854
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Mar 2019 08:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBkSfETE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfCSIo0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Mar 2019 04:44:26 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35775 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfCSIo0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Mar 2019 04:44:26 -0400
Received: by mail-oi1-f193.google.com with SMTP id j132so12325436oib.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Mar 2019 01:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=+akalMgBBZOAqPJvgQRMrltDQRrS66hy7eLa4C0vXuE=;
        b=IBkSfETEUwBqd66kYzE7v2Ji+bNq+XXx/eARyCf8LRMYzvEN7DBD41jSi6zlbbbViO
         wgUeQSNaLp39XOePXxsBG/GjaswA9bpE6VD6asNkvpFWEMfRGd+dS4Ro6buxZ6PT2yan
         MbeXug8aAeiaUlcyB7fI55pLG9ayiuAwZmjXFkBiCBvlGGXJWkPQ0wQ6g0VZwQ6DVV39
         PlOMYkbZHmLgxA1KoNMx9tbVlcNWeeNv4E9UHkuGtkh4ru7JVv49F4oABl+AUZBwJDhq
         wDGRO6URxNJnHfuhQltJY6wa0SDPkcOlFX5u9SmMnjVNOsMRUEKiSavEw6BlAbsHgMOh
         a3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=+akalMgBBZOAqPJvgQRMrltDQRrS66hy7eLa4C0vXuE=;
        b=IFfrCBe7MAHcYBPlAIG8APucCCiS5e5b9W8zYl6sQqg7H0goXKvlhUPaFW+17n9LQ1
         nZUflnSxII93qiAp9aAztyCqRc9ItNKGwCI7zR83hvsMujfbmwxUHF0T709ZGTIPIBSg
         I/W0c+ymfB5VCZRPZ7+1S3wfOqQCuvSb4E1JcjMKDMwYoa/hDVxR1gr8TUfCQXVq+M36
         bgoC5/G75c+L+IwGlMQ9SWXe+UJZZc77qGHpRxl6i5SAbjNcP2sErgUQ88XxXAcikAbV
         A0fk/nxItNhlcU9eQuhSlNITltm7mLEs293XKyVrZl1iI25IZbnsP6w4xRm8iRY8FAn0
         ah7g==
X-Gm-Message-State: APjAAAUQIf5wl8xOJTN0a7o5An9/BPkPjeTvJfgujDNZ1RcFoBKSlFjL
        3Z/MQE2/7hp0EXNF/fQotn6PKarRxwPsxtVOHd3i8In2
X-Google-Smtp-Source: APXvYqwhX+n3NT8O3hwRTEONEF8ioP8qkB3X/JxGQT42RmbTQB2gUhMvAwatbA4ODJtCRs5h9FLaPftOQSxXmas/XsQ=
X-Received: by 2002:aca:4b03:: with SMTP id y3mr703057oia.21.1552985065215;
 Tue, 19 Mar 2019 01:44:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190318161949.21749-1-luiz.dentz@gmail.com>
In-Reply-To: <20190318161949.21749-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 19 Mar 2019 10:44:12 +0200
Message-ID: <CABBYNZKbmq1wxCB4AGihThRwsFuHHHBiGzkjNhZ1AvSU3s5YcQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] shared/gatt-client: Add debug for error with
 included services
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Mon, Mar 18, 2019 at 6:19 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This logs errors with included service so it is easier to noticed when
> they are malformed.
> ---
>  src/shared/gatt-client.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index 1119d1a34..ec1041f66 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -532,12 +532,19 @@ static void discover_incl_cb(bool success, uint8_t att_ecode,
>                                 "uuid: %s", handle, start, end, uuid_str);
>
>                 attr = gatt_db_get_attribute(client->db, start);
> -               if (!attr)
> +               if (!attr) {
> +                       util_debug(client->debug_callback, client->debug_data,
> +                               "Unable to find attribute at 0x%04x", start);
>                         goto failed;
> +               }
>
>                 attr = gatt_db_insert_included(client->db, handle, attr);
> -               if (!attr)
> +               if (!attr) {
> +                       util_debug(client->debug_callback, client->debug_data,
> +                               "Unable to add include attribute at 0x%04x",
> +                               handle);
>                         goto failed;
> +               }
>
>                 /*
>                  * GATT requires that all include definitions precede
> @@ -545,8 +552,12 @@ static void discover_incl_cb(bool success, uint8_t att_ecode,
>                  * these entries, the correct handle must be assigned to the new
>                  * attribute.
>                  */
> -               if (gatt_db_attribute_get_handle(attr) != handle)
> +               if (gatt_db_attribute_get_handle(attr) != handle) {
> +                       util_debug(client->debug_callback, client->debug_data,
> +                               "Invalid attribute 0x%04x expect it at 0x%04x",
> +                               gatt_db_attribute_get_handle(attr), handle);
>                         goto failed;
> +               }
>         }
>
>  next:
> --
> 2.20.1
>

Applied.

-- 
Luiz Augusto von Dentz
