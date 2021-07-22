Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5683FC63797
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 17:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D2F76135A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 17:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhGVRIw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 13:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbhGVRIw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 13:08:52 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9D5C061575
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 10:49:26 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id r135so6550190ybc.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 10:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nXLvzn7aCCwPZJW9fA6ngYZfOHqXXfkTvMrPQxZeqfE=;
        b=g2xQLWJbkdqpODh3foFjNBmk2+J8v/Bhc0jdClTU3BJsl/mt5kkKiUf/oXgAhdIz+9
         Xt3NqJVd8HLasbSJ4L3JXcUKyIFuVgE6oa8wCkHoqC19ywz2RH0xkcugLtDjLfyqOhti
         kgNEK9ExRKfMa3yaCdDsw+hAufvjosJR6tC/queYlmW4f1Sj35eI7Ph+HoIpUcT21JJ4
         9+/egU+X0/3jOejAWsbYq9NP2Dbr4ks5pxa7Jj8fDM8776o+7ApLnDU4Z9L/eZbW4+i4
         2C+Na2Al8fV0ayHv1hfMa3N7rr7UO9JSAKuo0f2AnI8qeOQEJ5Y69JLQXOuiK/6AofK9
         A0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nXLvzn7aCCwPZJW9fA6ngYZfOHqXXfkTvMrPQxZeqfE=;
        b=qLd86qMjI5Ap62ZOO1rZS9cWSmASmFaQxAOhrc/RbjqdHlkiBVkCYsnQIaD0ss7Lyj
         NLQnHLw8ZznB9zf7JujwWar7TmU2o5WNv5Fv77Bl2n72GivxM9t6p18a6xX+3iTEUp8/
         fsW/VuSBrq9lr1qH5pYJe/Qft0BiUxRIRsqka9GTOUqiUKq8EZP1jauiBIj2E+3aAali
         YIfpJDYWHm5d5xN0t4xScVmN5qS2IX5PFIs4+Fk9lYncPY+IcjnG106duC67CP4/m/YF
         LXJ85eefPjNxKXHcuvGFBXP/KZNPsZUxQxBjjYHZoqBJ2fqwCCY106ibFJRiIZ8jBLvO
         +RwQ==
X-Gm-Message-State: AOAM533x7OTQpFag/XUaUFpfG+I9W5fRS6bBJQh2SXd1sd/8YgyOQ4uT
        +nBh8nWeF4iSCm2824XRmM/x0A5lTToqRMk8vM0=
X-Google-Smtp-Source: ABdhPJyKpMs9Jjurm9NVH4s6vSLcdCLUocz8iEtsgBAjA2ZnKUP3sq/4zw+009Z+u4k0IuZLZLNIgC5GZF65ho77n0g=
X-Received: by 2002:a25:fc1c:: with SMTP id v28mr975796ybd.408.1626976165127;
 Thu, 22 Jul 2021 10:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210722072321.1225119-1-howardchung@google.com> <20210722152159.Bluez.v2.4.Id0842634d98a21fbdfa5cc72c76a462a98bf6f40@changeid>
In-Reply-To: <20210722152159.Bluez.v2.4.Id0842634d98a21fbdfa5cc72c76a462a98bf6f40@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 22 Jul 2021 10:49:14 -0700
Message-ID: <CABBYNZJzSSQizXAHQ-uWBAy9Hvw8gTp+Wcu=yU6giwx2fGAbSQ@mail.gmail.com>
Subject: Re: [Bluez PATCH v2 04/11] plugins: new plugin
To:     Howard Chung <howardchung@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Yun-Hao Chung <howardchung@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

On Thu, Jul 22, 2021 at 12:23 AM Howard Chung <howardchung@google.com> wrote:
>
> From: Yun-Hao Chung <howardchung@chromium.org>
>
> This adds an initial code for a new plugin admin_policy.
>
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> ---
>
> (no changes since v1)
>
>  Makefile.plugins       |  5 +++++
>  bootstrap-configure    |  1 +
>  configure.ac           |  4 ++++
>  plugins/admin_policy.c | 30 ++++++++++++++++++++++++++++++
>  4 files changed, 40 insertions(+)
>  create mode 100644 plugins/admin_policy.c
>
> diff --git a/Makefile.plugins b/Makefile.plugins
> index 4e6a72b0bdf6..b6be0e0d559d 100644
> --- a/Makefile.plugins
> +++ b/Makefile.plugins
> @@ -11,6 +11,11 @@ builtin_sources += plugins/autopair.c
>  builtin_modules += policy
>  builtin_sources += plugins/policy.c
>
> +if ADMIN_POLICY
> +builtin_modules += admin_policy
> +builtin_sources += plugins/admin_policy.c
> +endif
> +
>  if NFC
>  builtin_modules += neard
>  builtin_sources += plugins/neard.c
> diff --git a/bootstrap-configure b/bootstrap-configure
> index 0efd83abc2c4..89c0747b0256 100755
> --- a/bootstrap-configure
> +++ b/bootstrap-configure
> @@ -30,4 +30,5 @@ fi
>                 --enable-pie \
>                 --enable-cups \
>                 --enable-library \
> +               --enable-admin_policy \

Let have this as --enable-admin-plugin

>                 --disable-datafiles $*
> diff --git a/configure.ac b/configure.ac
> index be32782a641d..53ed8911f95c 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -364,6 +364,10 @@ AC_ARG_ENABLE(logger, AC_HELP_STRING([--enable-logger],
>                 [enable HCI logger service]), [enable_logger=${enableval}])
>  AM_CONDITIONAL(LOGGER, test "${enable_logger}" = "yes")
>
> +AC_ARG_ENABLE(admin_policy, AC_HELP_STRING([--enable-admin_policy],
> +               [enable admin policy plugin]), [enable_admin_policy=${enableval}])
> +AM_CONDITIONAL(ADMIN_POLICY, test "${enable_admin_policy}" = "yes")
> +
>  if (test "${prefix}" = "NONE"); then
>         dnl no prefix and no localstatedir, so default to /var
>         if (test "$localstatedir" = '${prefix}/var'); then
> diff --git a/plugins/admin_policy.c b/plugins/admin_policy.c
> new file mode 100644
> index 000000000000..dd8d8973636f
> --- /dev/null
> +++ b/plugins/admin_policy.c
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2021 Google LLC
> + *
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include "src/log.h"
> +#include "src/plugin.h"
> +
> +static int admin_policy_init(void)
> +{
> +       DBG("");
> +}
> +
> +static void admin_policy_exit(void)
> +{
> +       DBG("");
> +}
> +
> +BLUETOOTH_PLUGIN_DEFINE(admin_policy, VERSION,
> +                       BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
> +                       admin_policy_init, admin_policy_exit)

Let's have it as just admin, since you can have multiple drivers
registered by the same plugin you just have to name the driver as
admin-policy that way it is simpler to extend if we found other uses
for the plugin.

> --
> 2.32.0.402.g57bb445576-goog
>


-- 
Luiz Augusto von Dentz
