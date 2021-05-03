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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B5EC433B4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 May 2021 15:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04E6B610A0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 May 2021 15:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhECPGB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 May 2021 11:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhECPGA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 May 2021 11:06:00 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5EEC06174A
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 May 2021 08:05:07 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id b10so4331432iot.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 May 2021 08:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ia6BHftyGPZ+MDEpCQe5+L+nWlqjdiwSMAkb1FakD6Q=;
        b=Ief/WPwasiJwatMS0aPJUnibz2wSUsS4yiyftdVo+3TzO8JyTj86cpogev0xnleJO8
         X//4njMPrxME4W2bRlSd3XcSoExBZrAmdIO9wjRjwCjwpBts8yBiK7MJA1lXJayFBpm2
         fd+YyutIE59cmwqMBUGaU8C2J+T4TOkOSea8mZaqnOqMWWMg4K4w+/x0mGRg9EPubuv3
         UMH7sLW7uym1waDEX5xO7SHbVFUDOSMWE4t1cr/7TYQap/Tfdmpk6yES6z+29bC8QoOa
         WTKg5lZwX+ADjdohkeZSi3F2NaIhtzyGqQLMXuXZ8Dzu2L09z5GWYrhlzICM3fN7fn8Y
         RJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ia6BHftyGPZ+MDEpCQe5+L+nWlqjdiwSMAkb1FakD6Q=;
        b=Z5rvq0YVWFIlPxkMNao7tRuFMcmCdIyqtPOhCCz4A6m2Qpa0ckeOQZT5k4hgJBZZGX
         MqrCRsih5JfUQHUQZO6+QfQ5dmo+OHu43msbfYdToXMIXHBXfcET/h1tl52DthMMMQRR
         IowSyZwKteBUhrj01dIe4Zte8C4tAzTIz+dlILROLcyJ4CLkz1FJ+vnP9+gj9N3BsMH7
         ubU6KoJ425mwhMNE91U3JP4FwyGOStBNHl7nUO9h82DFTAiNFGg4MAjDebBJgxvVsU4d
         67TZHt1QYj7iKELEOYirp1j92Zqz7ZCkWXBejEZeX0igPmj5CEOt6g3TA2G6/09vs/x4
         E/5w==
X-Gm-Message-State: AOAM530TSz0on7c9oAkhGMkBM8PdWCu2d4qakbH0BIoJ3/2MTwlbeBai
        qTVcM8DefTuk6osP++buSw0ZaRw+CrtvcCVrp+ewHf1ysWk=
X-Google-Smtp-Source: ABdhPJwk1AXE5J7k0vjB9HR7Oz7VWIvUYoHAHn82z8cKfU+CPMqQuTLu9Z3/ZnaJbIUBeVXzpHwi6io4Okb2pi2eKaU=
X-Received: by 2002:a02:2a8c:: with SMTP id w134mr1795829jaw.138.1620054306957;
 Mon, 03 May 2021 08:05:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210503180321.Bluez.1.I462ae10efbf980757258cabcce883b212259a793@changeid>
In-Reply-To: <20210503180321.Bluez.1.I462ae10efbf980757258cabcce883b212259a793@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 3 May 2021 08:04:55 -0700
Message-ID: <CABBYNZJyrR1t8cv4SVwEby79fxH22yaajKdUZxYMafsNonGpbg@mail.gmail.com>
Subject: Re: [Bluez PATCH 1/2] unit/gobex: remove timer only when it's not
 removed yet
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Yun-Hao Chung <howardchung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Mon, May 3, 2021 at 3:04 AM Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> There are instances where timer is removed because timeout has
> occurred, yet we still remove it again by the end of the test. This
> causes double removal and prints ugly messages which obscures the
> real culprit.
>
> Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> Reviewed-by: Yun-Hao Chung <howardchung@chromium.org>
> ---
>
>  unit/test-gobex.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/unit/test-gobex.c b/unit/test-gobex.c
> index 6fbfa183ec..25a3646630 100644
> --- a/unit/test-gobex.c
> +++ b/unit/test-gobex.c
> @@ -266,7 +266,8 @@ static void send_req(GObexPacket *req, GObexResponseFunc rsp_func,
>         g_main_loop_unref(mainloop);
>         mainloop = NULL;
>
> -       g_source_remove(timer_id);
> +       if (!g_error_matches(gerr, TEST_ERROR, TEST_ERROR_TIMEOUT))
> +               g_source_remove(timer_id);

That is weird way to check if the timer is active, usually the
callback shall set the id to 0 and then we check it before removing,
and we might want to consider consolidating this code into a function.

>         g_io_channel_unref(io);
>         g_obex_unref(obex);
>
> @@ -450,7 +451,8 @@ static void test_cancel_req_delay(int transport_type)
>
>         g_assert_no_error(r.err);
>
> -       g_source_remove(timer_id);
> +       if (!g_error_matches(r.err, TEST_ERROR, TEST_ERROR_TIMEOUT))
> +               g_source_remove(timer_id);
>         g_io_channel_unref(io);
>         g_source_remove(io_id);
>         g_obex_unref(r.obex);
> @@ -551,7 +553,8 @@ static void test_send_connect(int transport_type)
>         g_main_loop_unref(mainloop);
>         mainloop = NULL;
>
> -       g_source_remove(timer_id);
> +       if (!g_error_matches(r.err, TEST_ERROR, TEST_ERROR_TIMEOUT))
> +               g_source_remove(timer_id);
>         g_io_channel_unref(io);
>         if (!r.completed)
>                 g_source_remove(io_id);
> @@ -612,7 +615,8 @@ static void test_recv_unexpected(void)
>         g_main_loop_unref(mainloop);
>         mainloop = NULL;
>
> -       g_source_remove(timer_id);
> +       if (!g_error_matches(err, TEST_ERROR, TEST_ERROR_TIMEOUT))
> +               g_source_remove(timer_id);
>         g_io_channel_unref(io);
>         g_obex_unref(obex);
>
> @@ -667,7 +671,8 @@ static void test_send_on_demand(int transport_type, GObexDataProducer func)
>         g_main_loop_unref(mainloop);
>         mainloop = NULL;
>
> -       g_source_remove(timer_id);
> +       if (!g_error_matches(r.err, TEST_ERROR, TEST_ERROR_TIMEOUT))
> +               g_source_remove(timer_id);
>         g_io_channel_unref(io);
>         if (!r.completed)
>                 g_source_remove(io_id);
> @@ -748,7 +753,8 @@ static void recv_connect(int transport_type)
>
>         g_main_loop_run(mainloop);
>
> -       g_source_remove(timer_id);
> +       if (!g_error_matches(gerr, TEST_ERROR, TEST_ERROR_TIMEOUT))
> +               g_source_remove(timer_id);
>         g_obex_unref(obex);
>         g_io_channel_unref(io);
>
> @@ -800,7 +806,8 @@ static void test_disconnect(void)
>
>         g_assert_no_error(gerr);
>
> -       g_source_remove(timer_id);
> +       if (!g_error_matches(gerr, TEST_ERROR, TEST_ERROR_TIMEOUT))
> +               g_source_remove(timer_id);
>         g_io_channel_unref(io);
>         g_obex_unref(obex);
>
> --
> 2.31.1.527.g47e6f16901-goog
>


-- 
Luiz Augusto von Dentz
