Return-Path: <SRS0=SAxJ=4M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4981AC38BE2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Feb 2020 19:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 108E420836
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Feb 2020 19:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrDnw5Ao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgBXTaH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Feb 2020 14:30:07 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45271 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgBXTaH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Feb 2020 14:30:07 -0500
Received: by mail-ot1-f67.google.com with SMTP id 59so9774763otp.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2020 11:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uxZ6OZgnKFPduV9XuCTwOr328T5ju/6mpIwxHSrioCs=;
        b=KrDnw5AoLwBxHw+9S3OCdjTobaXQp5EalnxBgamL27zKj8ny+An+XCMZJzNWw1LWgI
         HkFGAvU1orkcdb4Io/AtfWqcC/eUOb4o939xZDCDkN94mTLDkUJSATY94NWNwp9Tsr+H
         EmoeIDecSW3vcCPL/QRBqzs+w1SMrvp4kR9kA9Z5N3/kgDM3qy6LdzNvEWRUKgDNqTY1
         pPOrJjOy2El6Y8Itp5XNceXqVaHt0lsqJSckwyslK3BFHkX/TFgaXWWTy/ANoyk6kMMv
         7GngHDIwUruyuRE/XnH4yw+xHfTJeYTSGzDuvjOkCkifSrLiiDpCxD5uqXLUFXEozeDt
         KC8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uxZ6OZgnKFPduV9XuCTwOr328T5ju/6mpIwxHSrioCs=;
        b=R/IG/7d3fjxKLFhb2hhZtZIM1RCpikPSx8EFAjf6tw2v+ZPezqFM1TKamgRR7cL57L
         O/lmh1g5Fo3HfHNw5ama8sQ3rwTjefBitRGtJXJFi4XafBHyz+Xrjp4Qs96pRM5eWRjK
         as6l3dDV4rp90wU4FOiDzyg0HYGP8GEJbJVC30QF7tuLQsL/PxCc1gtZTau9rW7TRkav
         e38UMPiViWDHBlNizObiE6OURmhF4lgrllywrxVHN2ynI0LzLjDxAlW0zUOUpihIUOhn
         be2yPsiA8zIq6bYyJC+j98JYQWJTyHCDl0o1LaZGIKhVqSOnKJnKhdi3WlIMykZBpCYE
         jECg==
X-Gm-Message-State: APjAAAV8iY+ruc+qbnaAJb1JsRmmF+BG7wFaSfvCciuVv/YA88JmeMjm
        zk3W40bb+c6oedrrFeGkyPDItx9PghxT4qLfhhc=
X-Google-Smtp-Source: APXvYqxAeLLNCsActVBAu6tTM9hBhEuDzuWX1MFCCvmFW/Ttw8fr/CNWuLS3GluB7CRJwlQ9NQUVR57wZ4XHq3GbELU=
X-Received: by 2002:a9d:3f4b:: with SMTP id m69mr38556212otc.146.1582572604945;
 Mon, 24 Feb 2020 11:30:04 -0800 (PST)
MIME-Version: 1.0
References: <20200221163911.Bluez.v1.1.I3c505b4307094eb7a6f2c5949125a17c89b2e099@changeid>
In-Reply-To: <20200221163911.Bluez.v1.1.I3c505b4307094eb7a6f2c5949125a17c89b2e099@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 24 Feb 2020 11:29:53 -0800
Message-ID: <CABBYNZKc6UPfYLbesAk0fUaGWFHP6GNtMQHFAOt+p+Yy0jNkWg@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] src/profile: Ensure class UUID matches before
 connecting profile
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Fri, Feb 21, 2020 at 12:41 AM Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> According to bluetooth spec Ver 5.1, Vol 3, Part B, 4.7.2, there
> might be multiple service records returned in a SDP Service Search
> Attribute Response. Also, according to 2.5.2, the service pattern
> can match any UUID contained within the service record, it doesn't
> have to match only some specific attributes of the record.
>
> Therefore, before using the service record to connect to any
> profile, first we must check that the service class ID of the
> service record matches with whatever UUID specified in the service
> pattern we are looking for.

Im surprised we were not doing this currently, Im fairly sure we do
that for the services/plugin though since there are only probed if the
service UUID matches

> ---
>
>  src/profile.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/src/profile.c b/src/profile.c
> index 192fd0245..1b481836e 100644
> --- a/src/profile.c
> +++ b/src/profile.c
> @@ -1568,8 +1568,34 @@ static void record_cb(sdp_list_t *recs, int err, gpointer user_data)
>
>         for (r = recs; r != NULL; r = r->next) {
>                 sdp_record_t *rec = r->data;
> +               sdp_list_t *svcclass;
> +               sdp_list_t *svcclass_iter;
>                 sdp_list_t *protos;
>                 int port;
> +               bool matches_class_uuid = false;
> +
> +               if (sdp_get_service_classes(rec, &svcclass) < 0) {
> +                       error("Unable to get svc class ID list from %s record",
> +                                                               ext->name);
> +                       continue;
> +               }
> +
> +               for (svcclass_iter = svcclass; svcclass_iter != NULL;
> +                                       svcclass_iter = svcclass_iter->next) {
> +                       char *uuid = bt_uuid2string(svcclass_iter->data);
> +                       int cmp_result = bt_uuid_strcmp(uuid, ext->uuid);

I think it would be probably more efficient to convert to data to
binary format (bt_uuid_t) and then do the comparision with
bt_uuid_cmp, also there might not be needed to iterate at all see
device.c:update_bredr_service which has the logic for updating
records:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/device.c#n4602

Btw, we should probably have bt_search_service doing the matching if
the uuid is set instead of returning all records like it seems to be
doing that way we don't have to maintain duplicate logic in both
device.c and profile.c

> +                       free(uuid);
> +                       if (cmp_result == 0) {
> +                               matches_class_uuid = true;
> +                               break;
> +                       }
> +               }
> +
> +               sdp_list_free(svcclass, free);
> +
> +               if (!matches_class_uuid)
> +                       continue;
>
>                 if (sdp_get_access_protos(rec, &protos) < 0) {
>                         error("Unable to get proto list from %s record",
> --
> 2.25.0.265.gbab2e86ba0-goog
>


-- 
Luiz Augusto von Dentz
