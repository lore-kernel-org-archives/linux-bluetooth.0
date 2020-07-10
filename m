Return-Path: <SRS0=rPFF=AV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40561C433E3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jul 2020 20:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12F552068F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jul 2020 20:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+mY1V5S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgGJU7I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jul 2020 16:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgGJU7H (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jul 2020 16:59:07 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51C0C08C5DC
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2020 13:59:07 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id x2so1249098oog.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2020 13:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u1/JtT6kLeY1DxICnY5yfjydt1+DeA48Qpq7XZ7cwH8=;
        b=e+mY1V5SRk9jMxgAuxR1ALEBIWQCS2dKQYBgbzIqvUh3h2zTic3F2cIbvxKr4mzosI
         5UPqZl2xD8ssNZhFK6PdZlYDulUHtPJVKjAZ6mykphqnz6iipFPPwrNrc/pytPBF0N9h
         zQuwp0tO+8aKUu4ZZedN1a8nmsa+/rIGkpGOmLwk/md6a7NKc/5I0fC3mxwTLWHF3IHT
         9PALA49UcuC8WfMPwlZPXx1SUQd2yFyVSh1hUo8M4RO3CeTidjyKlILx3TrtOXUtYsQu
         as/8zvUYe9JUegOk9xxc7nbWObKl5PxYecpezS/D/15m2SvU0SqOy3teDEjYIIF5r2fX
         PhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u1/JtT6kLeY1DxICnY5yfjydt1+DeA48Qpq7XZ7cwH8=;
        b=l5e1ev5Kd8xi1gok/ZWboGTG/YRrKkdONErY3EGxyomXLb++XkcuBH+TyMWTcSLUBd
         yKIu74pPNELSIH2oDMzWv24o4pl+JFxyWow5t1d+ooqAx6StxguT/gA7EsZXclIGAvZH
         lJvhOpAXERhRRYssYBVFnp/nQ3HlnFyy4Svn9Xp0KYYuoutmCAlZK/g7nC31xaN0vJ76
         rR8xea0SQCb9KMRh49vZfIltckp7On+3ceyr10H9hJCvNmnbQVrc0daXJje3BpCOVr4w
         Dp17drQS3hdwKZQxvUGOS9QvZ+WSqKfHO0Uali+MTD/aXx/C/FO0zvwtIBuVnSXeH9lb
         P8+g==
X-Gm-Message-State: AOAM531R8AxDcMnnOB02cEpNXmMLeIejDpZj+qWZUYiXiB3ZI0DdIqwc
        hr+hdrbMwe1tpb8OhGGh13mgLtwXbKsiEFFXnns=
X-Google-Smtp-Source: ABdhPJw5xkkP/M93zd75u8JYU7THT31FsfwbacltCQEv7Af3+UtOGD7Y0medVnsKw8RySJV0tmdQ8nfRsUVIsaPm02w=
X-Received: by 2002:a4a:a21d:: with SMTP id m29mr10096110ool.17.1594414747083;
 Fri, 10 Jul 2020 13:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200709090631.Bluez.v1.1.I6aa22c6e425e5b19c321c0768f50ca3fc2c090da@changeid>
 <CABBYNZ+43QgENg6ZrF9ZVxnPSkJaE3OUeZH5aeN_zrP9N5OwNQ@mail.gmail.com> <CAHC-ybywfMDxm84GVTxUC3fbC0R2VW=k5sjmN_vo9bXZYNu7hQ@mail.gmail.com>
In-Reply-To: <CAHC-ybywfMDxm84GVTxUC3fbC0R2VW=k5sjmN_vo9bXZYNu7hQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 10 Jul 2020 13:58:55 -0700
Message-ID: <CABBYNZKL289y5ibK32a6+Y_7ZEKA_fEpUM0oBQfJzougB+xGbw@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] audio/media - Fix volume sync between media and transport
To:     Yu Liu <yudiliu@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Hsin-Yu Chao <hychao@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Jul 10, 2020 at 1:48 PM Yu Liu <yudiliu@google.com> wrote:
>
> Sorry, which patch?

From Archie, subject: [Bluez PATCH v1 2/2] audio/transport: store
volume for initialization

> On Fri, Jul 10, 2020 at 1:35 PM Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>>
>> Hi,
>>
>> On Thu, Jul 9, 2020 at 9:10 AM Yu Liu <yudiliu@google.com> wrote:
>> >
>> > From: Hsin-Yu Chao <hychao@chromium.org>
>> >
>> > A volume value is cached on the global media player object. And a
>> > check was used to NOT update volume to each transport if this
>> > value doesn't change. That is causing problem at disconnect then
>> > reconnect when the new constructed transport never receive update
>> > about the last used volume value.
>>
>> I think this might be related to the other bug we have where the
>> transport is created after the fetch of the volume so the volume we
>> have stored in mp->volume is never updated in the transport, see my
>> comments on the other patch.
>>
>> > Reviewed-by: sonnysasaka@chromium.org
>> > Reviewed-by: hychao@chromium.org
>> >
>> > ---
>> >
>> > Changes in v1:
>> > - Initial change
>> >
>> >  profiles/audio/media.c | 3 ---
>> >  1 file changed, 3 deletions(-)
>> >
>> > diff --git a/profiles/audio/media.c b/profiles/audio/media.c
>> > index 993ecb3b3..92e363de9 100644
>> > --- a/profiles/audio/media.c
>> > +++ b/profiles/audio/media.c
>> > @@ -1204,9 +1204,6 @@ static void set_volume(uint8_t volume, struct btd_device *dev, void *user_data)
>> >         struct media_player *mp = user_data;
>> >         GSList *l;
>> >
>> > -       if (mp->volume == volume)
>> > -               return;
>> > -
>> >         mp->volume = volume;
>> >
>> >         for (l = mp->adapter->endpoints; l; l = l->next) {
>> > --
>> > 2.27.0.383.g050319c2ae-goog
>> >
>>
>>
>> --
>> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
