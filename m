Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C297DC433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 18:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9613165136
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 18:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbhCPSL1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Mar 2021 14:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239655AbhCPSIy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Mar 2021 14:08:54 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDF3C06175F
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 11:08:53 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id h3-20020a4ae8c30000b02901b68b39e2d3so4372226ooe.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 11:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oPAhGE1m4xchRfWAZrTCwo593Zsk5O5aaDHfehOatMo=;
        b=SrkEyejTAcgYKWt8/5s6wdhl1MuXC/hfpPItbuO1GIBD/8itUt+++ZKKffeCTGWorU
         5mzn/NVnxILZCVGoyIiMFFqvbIo31+zRjAJ4N7vRBvf2TsHkH6JOj+c/7/yZgEH2Vwpn
         7aO7QL/qC4u/j900HHCem2xyKIXZoV4SkszqN9R2CdHyXNEa8bl8PSTG5lFiTevtEXpX
         Q1iPF0depdMohcV79HLnE58A1mSDaLFC8VGXVN5fCwTBeJQZVtjNKTde6Iad/apdgoYD
         JIZeg/0zgXaT7zwXytvlGQWuysI1o6J+tjO79UMx52UrusMKN7LUDPohWJ/7FpRYhHMY
         ieNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oPAhGE1m4xchRfWAZrTCwo593Zsk5O5aaDHfehOatMo=;
        b=kh7DrFg87CQAgYFQ/gaoLYxfhOQj8eJxZr9Zch6PksKTIb589ieP7vScrLi18bTWv7
         N9E9W0ObR/Hj5wlfCPrQStVFIyNf4DH4GqzH1sgYBFAmW9CQEtzySslYo4EMLOkUWMXJ
         6m1h3g0UMhY8LBfl7M417JQKeHRAI+cCX8mWkN/3PhI/AB3NMaQDFl3v7ibZ05KM1yve
         Rtw/sg2zKAHGCSQ7jC+d9wJXsPc23H4c2019I1m8QucFAYq6CufzjcJWbzn8ssqvcmsZ
         1RZ8jWtipio6nPcMNBLCnjOKfahi1vRze6EHSVT7LTiZTiewYZa9Ert/8rRVnwkNyLaW
         ptZQ==
X-Gm-Message-State: AOAM531TE+uvHbrbDb8yKn2xb1mrdSTFdGv7V1usWkn2Lkqi51lbv5NT
        WaDFfDM9P8xsmwZ4+kYxqwRyz+WkR2keOyvQ4zA=
X-Google-Smtp-Source: ABdhPJwwNoimcY1UhPDoJwxksZBYVKpys99MQLZYV2i3AD4CqyOOyCy9lZUUBrMFI0w+DP+pxBls+Ri51bjDhjwPHBs=
X-Received: by 2002:a4a:c316:: with SMTP id c22mr22454ooq.65.1615918132687;
 Tue, 16 Mar 2021 11:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210316171836.28501-1-frederic.danis@collabora.com> <20210316171836.28501-2-frederic.danis@collabora.com>
In-Reply-To: <20210316171836.28501-2-frederic.danis@collabora.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 16 Mar 2021 11:08:42 -0700
Message-ID: <CABBYNZJm50Y+Wj6JuWCnXc3gMCybWOOvZ7QQSefR7cbx_OdPnw@mail.gmail.com>
Subject: Re: [PATCH Bluez v5 1/4] shared/timeout: Add timeout_add_seconds abstraction
To:     =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Fr=C3=A9d=C3=A9ric,

On Tue, Mar 16, 2021 at 10:26 AM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> g_timeout_add_seconds() call doesn't ensure the time for the first call o=
f
> the timer if the delay is less or equal to 1 second.
> In case of a 0 delay call g_idle_add() instead of g_timeout_add_seconds()=
.
> ---
>  src/shared/tester.c           | 16 +++++++++-------
>  src/shared/timeout-ell.c      |  6 ++++++
>  src/shared/timeout-glib.c     | 27 +++++++++++++++++++++++++++
>  src/shared/timeout-mainloop.c |  6 ++++++
>  src/shared/timeout.h          |  3 +++
>  5 files changed, 51 insertions(+), 7 deletions(-)
>
> diff --git a/src/shared/tester.c b/src/shared/tester.c
> index af33a79cd..c07cbc11c 100644
> --- a/src/shared/tester.c
> +++ b/src/shared/tester.c
> @@ -36,6 +36,7 @@
>  #include "src/shared/util.h"
>  #include "src/shared/tester.h"
>  #include "src/shared/log.h"
> +#include "src/shared/timeout.h"
>
>  #define COLOR_OFF      "\x1B[0m"
>  #define COLOR_BLACK    "\x1B[0;30m"
> @@ -126,7 +127,7 @@ static void test_destroy(gpointer data)
>         struct test_case *test =3D data;
>
>         if (test->timeout_id > 0)
> -               g_source_remove(test->timeout_id);
> +               timeout_remove(test->timeout_id);
>
>         if (test->teardown_id > 0)
>                 g_source_remove(test->teardown_id);
> @@ -429,7 +430,7 @@ static gboolean teardown_callback(gpointer user_data)
>         return FALSE;
>  }
>
> -static gboolean test_timeout(gpointer user_data)
> +static bool test_timeout(gpointer user_data)
>  {
>         struct test_case *test =3D user_data;
>
> @@ -470,8 +471,9 @@ static void next_test_case(void)
>         test->start_time =3D g_timer_elapsed(test_timer, NULL);
>
>         if (test->timeout > 0)
> -               test->timeout_id =3D g_timeout_add_seconds(test->timeout,
> -                                                       test_timeout, tes=
t);
> +               test->timeout_id =3D timeout_add_seconds(test->timeout,
> +                                                       test_timeout, tes=
t,
> +                                                       NULL);
>
>         test->stage =3D TEST_STAGE_PRE_SETUP;
>
> @@ -542,7 +544,7 @@ void tester_pre_setup_failed(void)
>                 return;
>
>         if (test->timeout_id > 0) {
> -               g_source_remove(test->timeout_id);
> +               timeout_remove(test->timeout_id);
>                 test->timeout_id =3D 0;
>         }
>
> @@ -583,7 +585,7 @@ void tester_setup_failed(void)
>         test->stage =3D TEST_STAGE_POST_TEARDOWN;
>
>         if (test->timeout_id > 0) {
> -               g_source_remove(test->timeout_id);
> +               timeout_remove(test->timeout_id);
>                 test->timeout_id =3D 0;
>         }
>
> @@ -606,7 +608,7 @@ static void test_result(enum test_result result)
>                 return;
>
>         if (test->timeout_id > 0) {
> -               g_source_remove(test->timeout_id);
> +               timeout_remove(test->timeout_id);
>                 test->timeout_id =3D 0;
>         }
>
> diff --git a/src/shared/timeout-ell.c b/src/shared/timeout-ell.c
> index 023364069..6416d8590 100644
> --- a/src/shared/timeout-ell.c
> +++ b/src/shared/timeout-ell.c
> @@ -101,3 +101,9 @@ void timeout_remove(unsigned int id)
>         if (to)
>                 l_timeout_remove(to);
>  }
> +
> +unsigned int timeout_add_seconds(unsigned int timeout, timeout_func_t fu=
nc,
> +                       void *user_data, timeout_destroy_func_t destroy)
> +{
> +       return timeout_add(timeout * 1000, func, user_data, destroy);
> +}
> diff --git a/src/shared/timeout-glib.c b/src/shared/timeout-glib.c
> index 8bdb7a662..3268d480c 100644
> --- a/src/shared/timeout-glib.c
> +++ b/src/shared/timeout-glib.c
> @@ -71,3 +71,30 @@ void timeout_remove(unsigned int id)
>         if (source)
>                 g_source_destroy(source);
>  }
> +
> +unsigned int timeout_add_seconds(unsigned int timeout, timeout_func_t fu=
nc,
> +                       void *user_data, timeout_destroy_func_t destroy)
> +{
> +       struct timeout_data *data;
> +       guint id;
> +
> +       data =3D g_try_new0(struct timeout_data, 1);
> +       if (!data)
> +               return 0;
> +
> +       data->func =3D func;
> +       data->destroy =3D destroy;
> +       data->user_data =3D user_data;
> +
> +       if (!timeout)
> +               id =3D g_idle_add_full(G_PRIORITY_DEFAULT_IDLE, timeout_c=
allback,
> +                                                       data, timeout_des=
troy);
> +       else
> +               id =3D g_timeout_add_seconds_full(G_PRIORITY_DEFAULT, tim=
eout,
> +                                                       timeout_callback,=
 data,
> +                                                       timeout_destroy);
> +       if (!id)
> +               g_free(data);
> +
> +       return id;
> +}
> diff --git a/src/shared/timeout-mainloop.c b/src/shared/timeout-mainloop.=
c
> index 5ffa65c2a..9be803cda 100644
> --- a/src/shared/timeout-mainloop.c
> +++ b/src/shared/timeout-mainloop.c
> @@ -71,3 +71,9 @@ void timeout_remove(unsigned int id)
>
>         mainloop_remove_timeout((int) id);
>  }
> +
> +unsigned int timeout_add_seconds(unsigned int timeout, timeout_func_t fu=
nc,
> +                       void *user_data, timeout_destroy_func_t destroy)
> +{
> +       return timeout_add(timeout * 1000, func, user_data, destroy);
> +}
> diff --git a/src/shared/timeout.h b/src/shared/timeout.h
> index 7e22345dd..0945c3318 100644
> --- a/src/shared/timeout.h
> +++ b/src/shared/timeout.h
> @@ -16,3 +16,6 @@ typedef void (*timeout_destroy_func_t)(void *user_data)=
;
>  unsigned int timeout_add(unsigned int timeout, timeout_func_t func,
>                         void *user_data, timeout_destroy_func_t destroy);
>  void timeout_remove(unsigned int id);
> +
> +unsigned int timeout_add_seconds(unsigned int timeout, timeout_func_t fu=
nc,
> +                       void *user_data, timeout_destroy_func_t destroy);
> --
> 2.18.0

Applied, note that I changed the commit message a little bit.

--=20
Luiz Augusto von Dentz
