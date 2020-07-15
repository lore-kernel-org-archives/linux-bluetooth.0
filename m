Return-Path: <SRS0=eiFZ=A2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65C8C433E1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jul 2020 22:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98D4020658
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jul 2020 22:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByQyMjc/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgGOWkF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jul 2020 18:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbgGOWkF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jul 2020 18:40:05 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB342C061755
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2020 15:40:04 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id h17so3546668oie.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2020 15:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QN6u4lUItqEbRecJZob9CnZ8D7gORmssXE47u/uPVag=;
        b=ByQyMjc/bt5tEsHpQlc/V1P6wi4kdox1kZnT7+Yic+JI61vo5UtKE1YKXmp+8pJpeY
         tF9ON/ldQ4OaMqy5SqqMOBth5w0Fg5wU6vNNxZqcGcJ9YonKgR+R3/dqyvMPbtOMgzfK
         cokdXxuB/sy68Lt1yt5/UYscb/mPcYOjMk93asThh9/YD4CfcCkontaXTcjzP80rXfwf
         WT5EackBPBxwe9om7H7moOuC3pImrSYERwwdb+p+oDfCh8rCdlinbSB4ndsHB0eXsHWk
         SlePQKN4FdyXbyDpDIuzNRWoeAewHpxiM3rsQkIk5eYzo1YlZFtZa4VvqtamnC2ePXI/
         8JSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QN6u4lUItqEbRecJZob9CnZ8D7gORmssXE47u/uPVag=;
        b=Tqx8ALx3SE9PO2Ht3T5zGgc1fc+nCiGKlWFEcYWyxSHlHohH1V8g+KZN9k07eVgPQF
         djqjFoHWCHIUhmYElE6b+kqWjw3oENdNfWyhTt9GQfDLJJsOechpWPvSw2v43KviSbvF
         jveqk0Uv5C28dPEfYyfIPCkAe+lWZ7CUD/e/JRgVk5QRm/wWfPIzi6NxUDq6dv+Q/dtH
         vYoEQOqmd/3MhabR6Mp8wi8SHhwARFcSiUVrSj88DzhuFYTxKGDXQKyKgxJv3L5k4dwX
         w1nGoshqezPLv45S8wsh19uDDEtqPqkBMlE4dsRVVrpHK3kgVgR3h9M1kDgd8nIUt5+E
         y4mw==
X-Gm-Message-State: AOAM5321bm4yMQYgrbG+kervxqPz1yaH/QC+9f41LIXNyqkBq2EpF2ab
        aVVfpXt6HTRqO+Ub7Nt3QoLjpLL5liOWDpe0KkdHyql8
X-Google-Smtp-Source: ABdhPJxxvvCw8RUH2Z0KnOwwoDmBg/2mloHEld4N4CTprNQOmhVisEOYedaYgxiHI4bjSzRRKn6fauLuXMCvmiAnQDM=
X-Received: by 2002:aca:cf81:: with SMTP id f123mr1673052oig.137.1594852804053;
 Wed, 15 Jul 2020 15:40:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200715222812.238172-1-sonnysasaka@chromium.org>
In-Reply-To: <20200715222812.238172-1-sonnysasaka@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 15 Jul 2020 15:39:52 -0700
Message-ID: <CABBYNZKDuCbwG7c94HbMXq7WqvMgL7qDaH9_JrQsHzORrr9GOw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] profile: Add exception from being claimed internally
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Wed, Jul 15, 2020 at 3:32 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> This adds a flag to give exception to profiles that are considered safe
> to be both handled internally and externally via GATT API. Currently
> this includes the battery profile.
>
> ---
>  profiles/battery/battery.c | 1 +
>  src/device.c               | 2 +-
>  src/profile.h              | 5 +++++
>  3 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
> index 4da4355a1..20aa47727 100644
> --- a/profiles/battery/battery.c
> +++ b/profiles/battery/battery.c
> @@ -354,6 +354,7 @@ static struct btd_profile batt_profile = {
>         .device_remove  = batt_remove,
>         .accept         = batt_accept,
>         .disconnect     = batt_disconnect,
> +       .claim_service_exception = true,
>  };
>
>  static int batt_init(void)
> diff --git a/src/device.c b/src/device.c
> index 0deee2707..cfa52461f 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -3818,7 +3818,7 @@ done:
>         profile = btd_service_get_profile(service);
>
>         /* Claim attributes of internal profiles */
> -       if (!profile->external) {
> +       if (!profile->external && !profile->claim_service_exception) {

The external field was added exactly to allow it to be used externally.

>                 /* Mark the service as claimed by the existing profile. */
>                 gatt_db_service_set_claimed(attr, true);
>         }
> diff --git a/src/profile.h b/src/profile.h
> index 4448a2a6d..25e83381b 100644
> --- a/src/profile.h
> +++ b/src/profile.h
> @@ -36,6 +36,11 @@ struct btd_profile {
>
>         bool auto_connect;
>         bool external;
> +       /* Some profiles are considered safe to be handled internally and also
> +        * be exposed in the GATT API. This flag give such profiles exception
> +        * from being claimed internally.
> +        */
> +       bool claim_service_exception;
>
>         int (*device_probe) (struct btd_service *service);
>         void (*device_remove) (struct btd_service *service);
> --
> 2.26.2
>


-- 
Luiz Augusto von Dentz
