Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C11C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Feb 2021 04:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 702D064FA9
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Feb 2021 04:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbhBEECg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Feb 2021 23:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbhBEECg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Feb 2021 23:02:36 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09806C0613D6
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Feb 2021 20:01:56 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id l27so5687243qki.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Feb 2021 20:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iyo1w6inxPJMV9PxnjMWGoDiC8ff/rd01+lW7XOhkzU=;
        b=uKcmOg+7sgDDheoe9RzVLoSyZyU3oriw3RwuL7hrcNFWM9FkQFfRilkFJv8kCxJtc8
         q8/876PcecarJohqKunsNKim1hJpNiR1jAx18H7Zzfdz50QD+B9m+E4aT5rC/ERIIbgq
         Q5ApsE8jzFtIaSPhfDoELCeDiFD7bw8y6z6t6ZVp03P7/fVljU3LpRbPEMAj04NIskmp
         b9wSbQDl/sYBciUn7a4hJ0ELYp+5UQxSEH061HJhMW/9tSFZk2cA/TG/HjyrlCyMuRK6
         H6C/uZY5K3vIeWsPh4riZApcT56gYuZ5/TW2tYT6J5XWCXLDNPIiZdOYRv80/7zFC8R0
         I1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iyo1w6inxPJMV9PxnjMWGoDiC8ff/rd01+lW7XOhkzU=;
        b=hIMQVK3LLAqRI39cRVKkRjlZL5UBbqhX0V4FBhcgrozKaSfmUd3PvzVWOZtyDbwjcf
         tYT537YLic31jjz0PjUbd0gzsIW6U4PDvImkbpW54BwUi+gAner7oqCPyYnfZn82r5iU
         M8M5xaGO2wL7GJZUygofHVm7DDHBKA4miV18xb5M52CgeUr/Y9fFqsM+ILcoQGtnLLcf
         JarHmQNg3GRRqrTHmoO7U4Kw4Eo+Ud+PZpDqeDCv4RNj68FfLyAC4VuJ168DzKDK1nKb
         8otFimj9D0KNNzIk4kPjlPsoHnHcsNqoPp5wLVpA+7PRUxy9O5CB54CK2YDBgu91R+l/
         3BmQ==
X-Gm-Message-State: AOAM530Jz/FKEP0HCjKuDavnXZIr5+gvhIS+5yOu4VDAfDPpMpEMu5Jf
        GAQhPgGAC0XEa7BhYl8Hu5EcsF7Lmd40NUrzkAiuDLKgyQ==
X-Google-Smtp-Source: ABdhPJwfIiYGta3KeOqm+QkBaLSFcHSG+p/IXvH3H/I8rWrPsA+d8VH0lRfdQgqAHWTIkM+tzPB68CWPlcme0XcU/5c=
X-Received: by 2002:a37:788:: with SMTP id 130mr2653006qkh.390.1612497715270;
 Thu, 04 Feb 2021 20:01:55 -0800 (PST)
MIME-Version: 1.0
References: <CAC9s0NaGXXVcZ_mDf9=QFp18BT7Ke-nduUCgx9u4zMOxuW0yeA@mail.gmail.com>
 <CABBYNZJh8y8NJ2b=wOo33Zp1pqD52uA47ORw_bO2F97QOcccYA@mail.gmail.com>
In-Reply-To: <CABBYNZJh8y8NJ2b=wOo33Zp1pqD52uA47ORw_bO2F97QOcccYA@mail.gmail.com>
From:   Kenny Bian <kennybian@gmail.com>
Date:   Thu, 4 Feb 2021 20:01:42 -0800
Message-ID: <CAC9s0NbKkH+_Yh3EQbkX3AB1_VEJACL2JX2s44RmgGiiJK__uA@mail.gmail.com>
Subject: Re: How to disable cache?
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks Luiz.

We may disable the cache.

On Thu, Feb 4, 2021 at 8:52 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Kenny,
>
> On Wed, Feb 3, 2021 at 9:20 PM Kenny Bian <kennybian@gmail.com> wrote:
> >
> > Hello,
> >
> > In "/etc/bluetooth/main.conf", there seems a way to disable the cache:
> > [GATT]
> > Cache = no
> >
> > What does exactly the "disable cache" mean? It means the
> > "/var/lib/bluetooth/[MAC_ADDRESS]/cache" folder won't be created?
>
> That means it won't cache any GATT attribute found when discovering,
> the cache folder has other information as well.
>
> > We tried to disable the cache by changing the
> > "/etc/bluetooth/main.conf". It seems the
> > "/var/lib/bluetooth/[MAC_ADDRESS]/cache" folder is still created even
> > if it was deleted.
> > However, we noticed that the "[Attributes]" section in
> > "/var/lib/bluetooth/[MAC_ADDRESS]/cache/[iPHONE_MAC]" file is gone.
> > Does it mean the "disable cache" is working? Does it mean the handles
> > used between the bluetooth and the mobile app won't be cached?
>
> Yes, that is the result of not caching anything.
>
> --
> Luiz Augusto von Dentz
