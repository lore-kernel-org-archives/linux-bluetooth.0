Return-Path: <SRS0=qc6f=CZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6489C43461
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 23:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5911E221EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 23:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lL6McyBz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgIPXFj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Sep 2020 19:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgIPXFi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Sep 2020 19:05:38 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA06C06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 16:05:38 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id u126so187256oif.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 16:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dZzF8IF7OE/onHztdIfetKyvDD+3RLdrnkG6RLH0aeI=;
        b=lL6McyBzkj8lZOCug8DaVsj9tG4rjzviriNTARZSKRfMDefDwxk1jViOYR6vLgBDEi
         pWEKpSGMYffwiA5Xo9m5IhAVU9QaLq7jLOEyOwrE3l99RSLn4NfXPz2ZI4aacuWRUcQm
         Y9YpsIbXUWSqlM78aT30sk3VEylIeI3uy0uscbXZHQvcSRtL3BfuoNlQULC3rs7brRHR
         FKG42akPRYk/seopppWgncCdEp7MXrvpNSbsmpsfuftmdynm5gsZLvjvcvrxuoAxJPCA
         pW6X52v6USiNYxAKUgdJ6+l1khOe+WSY1eTkTHsUL1Ypk3mTXSur5sRiNcfB9pt8161J
         zKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dZzF8IF7OE/onHztdIfetKyvDD+3RLdrnkG6RLH0aeI=;
        b=EVw8S5OaGM6juIPQq0XWT7TkrNh0AIkSFrwvxG+MXkZSYSBwosJUTfFQu4kk9Mbnt8
         Yl31qUjy7U9IWCdyBVgsZbYha9/ZnBIkz76n3Pf4Dv+fCLTeEthTHFGOtQJ5kcKildDk
         j4gK+XOJbY+EUyAWpVO/F+nDFPZeINnFVM3FWRmChGJXIeNQCP+/ucT+4tSPfxBGV1gD
         33i0TUZ5/6+014XBmqr9l9Lkw7URnOh2EKYG3uDrr7nKs1rK9oIef9yDD14GreHYcQoI
         D8Mr01OxSwsNOpBD1Il/q64hOO7vi2mL5sW6YFaNDcqlZ/QbAojYKJfTB0JKoVji6dc1
         QRQg==
X-Gm-Message-State: AOAM532XrNc+VDqUSoemYuFeRd8QLxcl/H22zt7zF1h1PhdnXSRCajpq
        GZWFzExHHtbP0sCu0BN7nWjGv0AKn6N7vEx11/8wfAgx
X-Google-Smtp-Source: ABdhPJx6+FfNZAnGsEEsMI5WPomeDp2X+jxTv2dO92UqmSpxmMeadicr0YTQwo9AhgmmzkK/TPh00d6sEH4RAhShYxY=
X-Received: by 2002:aca:3e08:: with SMTP id l8mr4280336oia.152.1600297537287;
 Wed, 16 Sep 2020 16:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200813002819.359374-1-sonnysasaka@chromium.org> <CAO271mneguPsiJRNjW44oGEHZSuYof0og9+cHxByqoOntjevYw@mail.gmail.com>
In-Reply-To: <CAO271mneguPsiJRNjW44oGEHZSuYof0og9+cHxByqoOntjevYw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 16 Sep 2020 16:05:13 -0700
Message-ID: <CABBYNZL1jaVfvxAZ0GVEa2A0i_8bw_=ynYPL7z20H0ZkDVF3xA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] checkpatch: Ignore SPDX license tag
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Wed, Sep 16, 2020 at 3:43 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> Dear BlueZ maintainers,
>
> I saw recent patches that BlueZ started adding SPDX license tags to
> file headers. Is this where the convention is going? If so, please
> ignore this patch.

Yes, it is better that way so we don't have to keep up with the
license on every file and will probably attempt do some automation to
check if SDPX Identifier is proper.

> On Wed, Aug 12, 2020 at 5:28 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> >
> > BlueZ does not use SPDX license tag on file headers.
> >
> > ---
> >  .checkpatch.conf | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/.checkpatch.conf b/.checkpatch.conf
> > index 419733832..72c3529c3 100644
> > --- a/.checkpatch.conf
> > +++ b/.checkpatch.conf
> > @@ -12,3 +12,4 @@
> >  --ignore PREFER_PACKED
> >  --ignore COMMIT_MESSAGE
> >  --ignore SSCANF_TO_KSTRTO
> > +--ignore SPDX_LICENSE_TAG
> > --
> > 2.26.2
> >



-- 
Luiz Augusto von Dentz
