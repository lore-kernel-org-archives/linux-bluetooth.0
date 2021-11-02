Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D32EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Nov 2021 09:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 721D360EE5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Nov 2021 09:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhKBJUK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Nov 2021 05:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbhKBJUJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Nov 2021 05:20:09 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA20C061714
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 Nov 2021 02:17:33 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id j128-20020a1c2386000000b003301a98dd62so1247354wmj.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Nov 2021 02:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tv5wqMmti+wo3yukgN4+tpFUpJlmsSDKWuQ6B9rwAis=;
        b=Y6ndBeUjWHXgl1/b07tJJzlWuY8PxZ6qmXoSNo0QuPrSUAOaLjwy+FOvOCxw1j18RZ
         zNRwbMdb+lL00L/Tjca5NuDPFd6oaRW91Ope+hBJjPYoO0w5qO93SG0PGNKtEPMc/yoZ
         pdmOTGq+zU/bmf0mWNcY1oN5elWIqClDulwB6RYDbda5696Nd1GUHn/vaPGszUJWImXE
         GCplMDdqhsg1BOKcLGtiYPlCCM1UY7XGQWMZgph+LXU110+jyhx0Gag7ppvc6PXTJGIN
         FNBwvdWnctZ6Z46DEvYarOmfEWc/08Q3HDVuMphkAJp+iD2Hb3YPLH/oB+E0L47o+AYB
         zrSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tv5wqMmti+wo3yukgN4+tpFUpJlmsSDKWuQ6B9rwAis=;
        b=nYiIhn0F8PzmLOIEWNJ5HbMpkAhIc1nx7GjUlu8Rl69xwgaeUwDKYN3MPXczkJvd2+
         1wj5w9XF4g+6vPCIWNBQFpAIA36b5ip+NfynWyhMR97pzGW1Sbsff/JY/FjyPZ5DmLjL
         TqSotJgY6wb7B0hnNCh3r/WBcF33qGe7CY0i86rYrv7GK+dSB2cv/fqfA4+sbvVP/Biz
         c5d7nzdnS1gDoz8q5hgGZczNgcOAOxZoJVHSN+Qvw978D1JbOU4AhhR+EhUC4w6syN2h
         6UQYTWwy2HODflyyUYplx6urV85KHOe7zRPFkZfXDIAAHz3SfU7d0M7khfW/5Dn8KLVN
         ZLIQ==
X-Gm-Message-State: AOAM532pVox+ate8wIM4gImJCcFvIsJ9H+XHt7DNLJ/hqHAnuEaNf3nY
        Op2gNysTcvARtnqquqJbMBYMZYKRqiyHQ3/Mw+7XIw==
X-Google-Smtp-Source: ABdhPJzl5C8lRFJ/BEhMXKYsAFMOsHs7hm7shL20c3AVOxqfe6ZaQX6o+9bEXENQYg++7+RIS2zLWva5/JqfL6sXwuU=
X-Received: by 2002:a1c:f207:: with SMTP id s7mr5416906wmc.179.1635844652081;
 Tue, 02 Nov 2021 02:17:32 -0700 (PDT)
MIME-Version: 1.0
References: <20211101140544.Bluez.1.I515833d2764b8ec2ac2bb1f87313de80ebb497cd@changeid>
 <20211101140544.Bluez.3.Idb95ae18113225915b97a4f06983e1e41a7f7a2e@changeid> <CABBYNZJqFBgAvQY5hD6LbouiEiFA0DqYaU_50z5PEGHHxctQug@mail.gmail.com>
In-Reply-To: <CABBYNZJqFBgAvQY5hD6LbouiEiFA0DqYaU_50z5PEGHHxctQug@mail.gmail.com>
From:   Archie Pusaka <apusaka@google.com>
Date:   Tue, 2 Nov 2021 17:17:21 +0800
Message-ID: <CAJQfnxGd0-VauhimW0fS1FzjbO4PRK0McYCaxzXAMUkQrUTL_Q@mail.gmail.com>
Subject: Re: [Bluez PATCH 3/3] adapter: Remove "Master" entry from LTK storage
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Tue, 2 Nov 2021 at 14:13, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Archie,
>
> On Sun, Oct 31, 2021 at 11:06 PM Archie Pusaka <apusaka@google.com> wrote:
> >
> > From: Archie Pusaka <apusaka@chromium.org>
> >
> > The entry has been deprecated since 2014 and it's time to remove them
> > altogether.
> > ---
> > Hi maintainers,
> > While cleaning this entry, I found that this entry is involved in some
> > kind of storage file conversion, probably when upgrading BlueZ 4 to 5.
> > Should we also remove the file conversion too, since it's dated to
> > 2014 as well?
>
> Perhaps we can but I'd had such cleanup as a separate patch then.
>
Got it. Then I would prefer to wait until this series of patches is
merged before removing the file conversion.

> >
> >  src/adapter.c | 12 ------------
> >  1 file changed, 12 deletions(-)
> >
> > diff --git a/src/adapter.c b/src/adapter.c
> > index 6b12c9e793..3a3c957a6c 100644
> > --- a/src/adapter.c
> > +++ b/src/adapter.c
> > @@ -3779,8 +3779,6 @@ static struct smp_ltk_info *get_ltk(GKeyFile *key_file, const char *peer,
> >                                         uint8_t peer_type, const char *group)
> >  {
> >         struct smp_ltk_info *ltk = NULL;
> > -       GError *gerr = NULL;
> > -       bool central;
> >         char *key;
> >         char *rand = NULL;
> >
> > @@ -3836,12 +3834,6 @@ static struct smp_ltk_info *get_ltk(GKeyFile *key_file, const char *peer,
> >                                                                         NULL);
> >         ltk->ediv = g_key_file_get_integer(key_file, group, "EDiv", NULL);
> >
> > -       central = g_key_file_get_boolean(key_file, group, "Master", &gerr);
> > -       if (gerr)
> > -               g_error_free(gerr);
> > -       else
> > -               ltk->central = central;
> > -
> >         ltk->is_blocked = is_blocked_key(HCI_BLOCKED_KEY_TYPE_LTK,
> >                                                                 ltk->val);
> >
> > @@ -5904,7 +5896,6 @@ static void convert_ltk_entry(GKeyFile *key_file, void *value)
> >         g_free(str);
> >
> >         g_key_file_set_integer(key_file, "LongTermKey", "Authenticated", auth);
> > -       g_key_file_set_integer(key_file, "LongTermKey", "Master", central);
>
> Weird that it still was setting the "Master" even though this is meant
> to convert the old format into the new one.
>
Probably these "convert" methods precedes the "split LTK entries into
central and peripheral" decision, and this setting is unintentionally
left out when splitting LTKs.

> >         g_key_file_set_integer(key_file, "LongTermKey", "EncSize", enc_size);
> >         g_key_file_set_integer(key_file, "LongTermKey", "EDiv", ediv);
> >
> > @@ -8445,9 +8436,6 @@ static void store_ltk_group(struct btd_adapter *adapter, const bdaddr_t *peer,
> >                 g_error_free(gerr);
> >         }
> >
> > -       /* Old files may contain this so remove it in case it exists */
> > -       g_key_file_remove_key(key_file, "LongTermKey", "Master", NULL);
> > -
> >         for (i = 0; i < 16; i++)
> >                 sprintf(key_str + (i * 2), "%2.2X", key[i]);
> >
> > --
> > 2.33.1.1089.g2158813163f-goog
> >
>
>
> --
> Luiz Augusto von Dentz

Thanks,
Archie
