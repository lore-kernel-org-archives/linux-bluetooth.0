Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98271C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Dec 2021 21:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237030AbhLHVOa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Dec 2021 16:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236037AbhLHVOa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Dec 2021 16:14:30 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E939EC061746
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Dec 2021 13:10:57 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id ay21so7038345uab.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Dec 2021 13:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kltfpp/isGbgdVHChNfcr0yQ+v0QnIuq75sSENxfFbs=;
        b=bPyDNJ7ggynYkgThwj59A7bC8UBhiiHwNLbmZrX8bZQGvTO0+F+57/5svcKAuiWqNl
         RenEgngEKfRIoMjNBh9d+nmVPR6/2VeWZfvtJSvI+JBurTk0Ir2WykHO1sfgZqHB6GoZ
         vj2QaHflW7UKjIQj4XkBRXw/mgpt72Zo1XEZN++EjZAppSZ5BrPpHaG8TjhcBvXY/pAW
         M9QjfQPFJHjP9mHiesmURM/BZKUS6pq9zNcHNh/OPGtfJvoxNgPR6tfbQDFbX46FWmXG
         /cFXjOqcBIahbWECJwmNBoYMat3/Y+5RExpybcbSL7kyqtaSXf/pUy+4w0Ag3YwF2eAm
         DKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kltfpp/isGbgdVHChNfcr0yQ+v0QnIuq75sSENxfFbs=;
        b=PD9i3X8xcftWsU31Mko8tCffkOSvyv+PUoqcZ/uRtP+qW9z0RXNXUPmjYCGz/MszW8
         2A787AhyIIEnJz1k1XS9ppJH26dEZ1xLhBRU/tHL66MoOmLs3/c0/SszNrEbXxX8Q/xp
         sn5HSWz11oODASyHkoIi6Yaf09bj0iakC+r8Q+7hWw6qe409fUScCDqYrxfPui0eu3ap
         lHDWfffLJkg63ey5waG8AA8yndON3jltD86NGRqwqrWYJ7/NT8H6faAm0Qe3cD4Wjbig
         95VFWnzwG9oeoKMVc2GfgYJktCSbQMp5V/ULh6U0JUVjEPf7u/iPfRy+5KVnwchABuXM
         GFYQ==
X-Gm-Message-State: AOAM533YwMDUToh3Ou6C9O8+FWMEPKUcx3t6KMe4EDA97Tu4QdYoirVS
        KLXF9rE53fISVs/CNRxdooHNXvBeZm/8GWXx21t2k443
X-Google-Smtp-Source: ABdhPJzfKHVqXaVR+gO73KA6lTz1L3/Of9/cYNXerg+WkPoUYFhaj5AbwWJKR8Nx1PsCLsb+lL24H+VyL6vUyoxSj2A=
X-Received: by 2002:a67:3093:: with SMTP id w141mr1507296vsw.24.1638997857032;
 Wed, 08 Dec 2021 13:10:57 -0800 (PST)
MIME-Version: 1.0
References: <202112062257.1B6MvJMT374832@d7010.compata.com> <202112080601.1B861HZC669128@d7010.compata.com>
In-Reply-To: <202112080601.1B861HZC669128@d7010.compata.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 8 Dec 2021 13:10:46 -0800
Message-ID: <CABBYNZJBnFAxt+97w804gWpYca+f-Tn8Pq6gr5bUnx5kcwJDpw@mail.gmail.com>
Subject: Re: hcidump replacement
To:     Dave Close <dave@compata.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Dave,

On Wed, Dec 8, 2021 at 1:32 AM Dave Close <dave@compata.com> wrote:
>
> I wrote:
>
> >I've been recording data from a sensor using a script like this --
> >
> >  while read a; do
> >    grep <pattern> $a
> >    # do my stuff
> >  done < <( hcidump -R )
> >
> >Reading tons of web pages and mailing list entries, I still haven't
> >found anything equivalent that doesn't use the deprecated hcidump.
> >Suggestions appreciated.
>
> Is this the wrong list for my question?

Check out btmon.

-- 
Luiz Augusto von Dentz
