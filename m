Return-Path: <SRS0=Sobe=CX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C3EC43461
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Sep 2020 17:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2742920E65
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Sep 2020 17:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpO1ZkaM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgINRdh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Sep 2020 13:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbgINRdG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Sep 2020 13:33:06 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98622C06174A
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2020 10:33:05 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id m12so698594otr.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2020 10:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gtKD+2cA9bRZX6C2303ZKrkz3oYqs84Ek3RNXj49zqo=;
        b=VpO1ZkaM4tV5n3Y8iQrNUeV4Gj4UDPYFoLFBv2sEneSSPMYupUmjJO/QCk9vzgxFAI
         vz9eEGbNc6Zx77OpsM8O0hvBR7kVS++3XVjpypkidGX4SWL3RbvR9DyaXK3Lm/ALaeh0
         eIrOEcTK/5mWE6Bdl4KB6toMvBJvzrEmgW40Y/pXfaTalWZHdUoKk3BUvKdPQ3LcaE4G
         k61DDDN7gQq8KQ/+e/l4FABGFgRem6ZLp75M1SOyMQbH7oEp5CbDYJYYfmdbKgeMU8Nh
         Hff29+5K/Vjpb8NavDv8f5w+iv7ngDaukoThtDjTznKKx22Doiv6OkfWQfOudOsUeE8e
         Vv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gtKD+2cA9bRZX6C2303ZKrkz3oYqs84Ek3RNXj49zqo=;
        b=ZIFEofcasLQnIegDaceBrwH4rM9ZXGXUeVzU6BjODclYFGjoJY3Ol6tp8NgR6gK2d1
         evmvlHwNWK6EJBNSiaJLE6QJTd22lWEn0ODAlhY9Q7bnIyRs24S9ddud6cBxpZbUThZt
         Vqa2VnRGzph6l76cS5tD8MNc+UiEdeqtU85XPq0ZmFJcLfl8jA8Sq2HKFLCao9ZDXIev
         OJLbzTqKweHKu1KGozKTfnULn5SBQuoGB6xYdk2qu6vryXXEao0Qj99HqM5/7vvJ1OTp
         BhRwtACb58Ncxjb219D7uitj02hEB8sc6EkVvMnS2XFlheAMocyUku9mkBFu2rfPRBCA
         R8BA==
X-Gm-Message-State: AOAM531klioAGzDw++nUrKTrWlxYMPNkaspPbW7E86mKaihzAV4/dlBr
        Eou6ji/as0FqsR7Q0FciyQLkJoMcSCCatKT/AEo=
X-Google-Smtp-Source: ABdhPJxQRFEG2lGqZcCHp/nUGH4+svkOL2xTVsD5NSe62d4Rij3X4jEeV4lQvrDnUZ63vdVPu4IlCwKZ4SSEZ/hPJrE=
X-Received: by 2002:a9d:4695:: with SMTP id z21mr10044227ote.91.1600104784692;
 Mon, 14 Sep 2020 10:33:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200912062357.23926-1-tedd.an@linux.intel.com> <20200912062357.23926-14-tedd.an@linux.intel.com>
In-Reply-To: <20200912062357.23926-14-tedd.an@linux.intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 14 Sep 2020 10:32:52 -0700
Message-ID: <CABBYNZLiUJi8qZnZgBAMGwu8bKM1RoeiDcjZ5AK6jfWJ7ShTpw@mail.gmail.com>
Subject: Re: [BlueZ 13/17] plugins: Add SPDX License Identifer
To:     Tedd Ho-Jeong An <tedd.an@linux.intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Tedd Ho-Jeong An <tedd.an@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Fri, Sep 11, 2020 at 11:41 PM <tedd.an@linux.intel.com> wrote:
>
> From: Tedd Ho-Jeong An <tedd.an@intel.com>
>
> This patch adds SPDX License Identifier.
>
> -------------------------------------
>        License            COUNT
> -------------------------------------
>  GPL-2.0-or-later     :      7

I guess all GPL 2.0 or later can be updated to GPL 2.1 or later.

> License: GPL-2.0-or-later
>    plugins/autopair.c
>    plugins/hostname.c
>    plugins/neard.c
>    plugins/policy.c
>    plugins/sixaxis.c
>    plugins/wiimote.c
>    plugins/external-dummy.c
> ---
>  plugins/autopair.c       | 1 +
>  plugins/external-dummy.c | 1 +
>  plugins/hostname.c       | 1 +
>  plugins/neard.c          | 1 +
>  plugins/policy.c         | 1 +
>  plugins/sixaxis.c        | 1 +
>  plugins/wiimote.c        | 1 +
>  7 files changed, 7 insertions(+)
>
> diff --git a/plugins/autopair.c b/plugins/autopair.c
> index 3089430a8..381d91c8f 100644
> --- a/plugins/autopair.c
> +++ b/plugins/autopair.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later

Why are you using C++ // comments on the .c files and /* */ comments
on .h? Also it looks like you are keeping the old license text which
should no longer be necessary.

>  /*
>   *
>   *  BlueZ - Bluetooth protocol stack for Linux
> diff --git a/plugins/external-dummy.c b/plugins/external-dummy.c
> index 536ad0663..78377b021 100644
> --- a/plugins/external-dummy.c
> +++ b/plugins/external-dummy.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   *
>   *  BlueZ - Bluetooth protocol stack for Linux
> diff --git a/plugins/hostname.c b/plugins/hostname.c
> index 4f9dfe6d8..32f15b3a5 100644
> --- a/plugins/hostname.c
> +++ b/plugins/hostname.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   *
>   *  BlueZ - Bluetooth protocol stack for Linux
> diff --git a/plugins/neard.c b/plugins/neard.c
> index 6ffcd6e10..1fefc5015 100644
> --- a/plugins/neard.c
> +++ b/plugins/neard.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   *
>   *  BlueZ - Bluetooth protocol stack for Linux
> diff --git a/plugins/policy.c b/plugins/policy.c
> index de51e58b9..86eb25ee9 100644
> --- a/plugins/policy.c
> +++ b/plugins/policy.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   *
>   *  BlueZ - Bluetooth protocol stack for Linux
> diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
> index 939fed759..8350d63f8 100644
> --- a/plugins/sixaxis.c
> +++ b/plugins/sixaxis.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   *
>   *  BlueZ - Bluetooth protocol stack for Linux
> diff --git a/plugins/wiimote.c b/plugins/wiimote.c
> index 0ced27514..9441a7681 100644
> --- a/plugins/wiimote.c
> +++ b/plugins/wiimote.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   *
>   *  BlueZ - Bluetooth protocol stack for Linux
> --
> 2.25.4
>


-- 
Luiz Augusto von Dentz
