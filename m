Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12D4C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 19:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344457AbiCWUAG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbiCWUAG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Mar 2022 16:00:06 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169EC27B00
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 12:58:36 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id u103so4680140ybi.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 12:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HUuHIEv0o+LFeMtSUaKrqm1eMAqC9FZGgtOg0F+ne9o=;
        b=QvsfGU4NHzKlWE/sejfWuPbPaGNjG16Ws5gZvECOUOSlnOV4aQ2waia0zz+KWiS6Fn
         LtFMQIlJULky38/4um3VjkWmYN/mTe9QXQhotWjEocsFQaXUBRI0Q+5T/RtEYmGTdtSo
         r8OdKVQsEgk/G9vJFZ1URScMpCRMLbRk396IpIXnE94V2Kbeo6U9c5frEsWaGPA+QtmZ
         6omckn15tD2WLbEXdBdt8YUXftyoHU4SSFLpdVNPO0WHxvKzSVAMj+KOxxG4qFUx6CO/
         tiFOVOjZdBmyFgHTvduH1k8MgWaYDo06AXZZndCJ2btaR1qx5/wIz2k4SbaqJwsO56Gh
         G6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HUuHIEv0o+LFeMtSUaKrqm1eMAqC9FZGgtOg0F+ne9o=;
        b=drhe+xkSKZHIIMLNh0/+gAlsWcle+ArapLX6uQwxLtAio/KzZ9sLctRk0UUc4Xb4Da
         6W47ZxSWOdnMjonOU+NhuhSOvvmpK7/fb2+LO6OLR+kdqRN9QzNpftMdTQjg1Bbcl9uu
         +YV4W107PhsfJRIMfdQLSxOlPoixjD0QWeH458G99m7/3ftJ0SA0JrcoiqW5e2wP/M97
         3Nc29DBF02bvGXUiPwNVar81P6wozZO2szj4yoYMgxxQKwW8vfvsb8yyLbKCByYzareX
         mDVJiXIDHkPepKUwXswZPLuDoiJV1hRYpadKHQcX27/zbrxJHirJyvj2s7tc6FY/rrN9
         YH6g==
X-Gm-Message-State: AOAM533ZufCI7riNPLzkwjqOwl4ETjQ/m+W2bvPD+APs7kCrTrxa9KLC
        g3nVk3lhhcV8+cPGudkkAavJe/k+h8GYrTIGftFTUT1Igfw=
X-Google-Smtp-Source: ABdhPJzzY0JTWd1TdSOJi//Cgz8b5IQXcr1GQAlQTZrYsHtHYB4urW9SdvJhT7Z+AdpPdW43acWQTVjZtED7nhGydyY=
X-Received: by 2002:a25:9742:0:b0:61d:9526:ebc3 with SMTP id
 h2-20020a259742000000b0061d9526ebc3mr1619721ybo.578.1648065515290; Wed, 23
 Mar 2022 12:58:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220323000654.3157833-1-luiz.dentz@gmail.com>
 <20220323000654.3157833-4-luiz.dentz@gmail.com> <DE87AE95-85DD-4732-8D49-F6E212F836B6@holtmann.org>
In-Reply-To: <DE87AE95-85DD-4732-8D49-F6E212F836B6@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 23 Mar 2022 12:58:24 -0700
Message-ID: <CABBYNZK+Sh_r5SW7ot=QR2gweKf6MtGDsKjGdRGWOmKEP-ny5g@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 4/9] adapter: Don't use DBG in mgmt_debug
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Wed, Mar 23, 2022 at 3:37 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> > mgmt_debug callback is used to print debug strings from mgmt instances
> > which includes the file and function names so using DBG would add yet
> > another set of file and function prefixes which makes the logs
> > confusing.
> > ---
> > src/adapter.c | 8 +++-----
> > 1 file changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/src/adapter.c b/src/adapter.c
> > index 97ce26f8e..6680c5410 100644
> > --- a/src/adapter.c
> > +++ b/src/adapter.c
> > @@ -10327,9 +10327,8 @@ static void read_version_complete(uint8_t status, uint16_t length,
> >
> > static void mgmt_debug(const char *str, void *user_data)
> > {
> > -     const char *prefix = user_data;
> > -
> > -     info("%s%s", prefix, str);
> > +     if (DBG_IS_ENABLED())
> > +             btd_debug(0xffff, "%s", str);
> > }
> >
> > int adapter_init(void)
> > @@ -10342,8 +10341,7 @@ int adapter_init(void)
> >               return -EIO;
> >       }
> >
> > -     if (getenv("MGMT_DEBUG"))
> > -             mgmt_set_debug(mgmt_primary, mgmt_debug, "mgmt: ", NULL);
> > +     mgmt_set_debug(mgmt_primary, mgmt_debug, NULL, NULL);
>
> oh no. This is crazy. Please re-think this and what computational overhead you are introducing.

I considered moving DBG_IS_ENABLED() in place of getenv("MGMT_DEBUG")
so that would be use just once per adapter, the problem is that
wouldn't work with:

case SIGUSR2:
__btd_toggle_debug();

Or perhaps I just need yet another match that adds the file and
function name so we can strip them out of DBG_IDX.

> Regards
>
> Marcel
>


-- 
Luiz Augusto von Dentz
