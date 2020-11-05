Return-Path: <SRS0=JOhI=EL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D80C388F7
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 23:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9FD420704
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 23:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKsdKs0k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732035AbgKEXWM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Nov 2020 18:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgKEXWL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Nov 2020 18:22:11 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AE2C0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2020 15:22:11 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id j14so3079689ots.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2020 15:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q+8LU+2g7AblWCSw8h1uq/mUyulXDb1oNKntdrqzG60=;
        b=eKsdKs0kRXEXqsLGhHENjw8Dxqd1hAEtAglRlOluaO4g4+I7VfCisgCnHvPUuVyelJ
         tJ+hooGB4oZ2/Tu0lbFZWsXzBWeCU6sbTokcyBS/USPJQlDB64ddbMsXaTpq1a8z0sR0
         LDt8Gp7FV1Qf2NUmFLGw2UPL9WrBmYYhOrsKAt1XCgyzuULihgfgfV/2nPfLR6R0Jsy6
         WljwS8BRmB77k46GS4WkhTerN9MhYGmDHd06gPZdIZKVwqiJTmZ5SfQc38WKcLrh+F6S
         T67lb/OKx+6l9GYnUkddG3UUUenH9KLz/phEg4S8o030hb2SffvBDzZyFgqXAd0YtcOZ
         jN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q+8LU+2g7AblWCSw8h1uq/mUyulXDb1oNKntdrqzG60=;
        b=fiXRIYsXQpKYMqfmHKAe+am2aFhM8nmF1jpTqfkixR9NvmeJaIJkBcg70xZ2YahWaz
         yp9swW4XZZVy6GQ2ieMavBKXQxHvHUzCeXxVWEL54xG/UL1J05weG93SquwTXBoib5JB
         k2JxkRmvEZ8lSkUO94TggCFO0P9VSpk/n+lKOUgojlj3ujnxp2rr3Gy+RjAKm12nz5Fj
         EnFz8pPobpQhq4SD8zx9n/v9DrkHICXAqBZkANovEyLH4pv7JOmddKGSuYJQrdv9Gqjh
         6yLUPWjmzjiwCNw4/paH48S35kPT+LY1jo3QZmzqiVBJPVaritIuvkhGEV9uDfvBUo+4
         URag==
X-Gm-Message-State: AOAM5308Uhr7Amhj8M24slRfT9oaMwFq9BVmdAlRXrd6QcEoZ6/fI40I
        rfxlZrMaUCAjKslkCvRBI5FO4I6e3HwABFuJaHxiNroUF54=
X-Google-Smtp-Source: ABdhPJwi0vlYhiUX4vx6Hej6ujFsStopd1p2pJqY8SCO9uh8NW4a7uCeDv8/Q2jTkOsYxSQ8g+WgO19cVt0j1M3IXWw=
X-Received: by 2002:a9d:6a0a:: with SMTP id g10mr3380117otn.44.1604618530984;
 Thu, 05 Nov 2020 15:22:10 -0800 (PST)
MIME-Version: 1.0
References: <20201105224923.377-1-sonnysasaka@chromium.org>
In-Reply-To: <20201105224923.377-1-sonnysasaka@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 5 Nov 2020 15:22:00 -0800
Message-ID: <CABBYNZ+WHENGaL9NGD0F8bf6zaw9Omgb8iczRqWRcVWUAYY7Xw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] Cancel GATT client operations when cleaning up GATT cache
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Thu, Nov 5, 2020 at 2:53 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> A crash is found when discovery_complete_op is invoked but
> gatt_db_attribute objects have been freed. A solution is to always
> cancel GATT client operations every time we clean GATT cache.
>
> The crash is reproducible by connecting to an LE mouse and then calling
> RemoveDevice immediately, triggering disconnection while GATT service
> discovery is in progress.
>
> Sample crash stack trace:
> 0  gatt_db_service_get_handles (service=0x1751130, service=0x1751130, end_handle=0x7ffcd600806e, start_handle=0x7ffcd600806c) at src/shared/gatt-db.c:569
> 1  gatt_db_attribute_get_service_data (attrib=<optimized out>, start_handle=0x7ffcd600806c, end_handle=0x7ffcd600806e, primary=0x0, uuid=0x0) at src/shared/gatt-db.c:1657
> 2  0x00000000004983a8 in discovery_op_complete (op=op@entry=0x173b320, success=<optimized out>, err=err@entry=10 '\n') at src/shared/gatt-client.c:406
> 3  0x000000000049a548 in discover_descs_cb (success=<optimized out>, att_ecode=<optimized out>, result=<optimized out>, user_data=0x173b320) at src/shared/gatt-client.c:915
> 4  0x00000000004a1d87 in discovery_op_complete (op=0x1748450, success=<optimized out>, ecode=<optimized out>) at src/shared/gatt-helpers.c:615
> 5  0x00000000004a2379 in discover_descs_cb (opcode=<optimized out>, pdu=0x174d551, length=<optimized out>, user_data=0x1748450) at src/shared/gatt-helpers.c:1465
> 6  0x00000000004966db in handle_rsp (pdu_len=4, pdu=<optimized out>, opcode=<optimized out>, chan=0x17483c0) at src/shared/att.c:814
> 7  can_read_data (io=<optimized out>, user_data=0x17483c0) at src/shared/att.c:1011
> 8  0x00000000004a0853 in watch_callback (channel=<optimized out>, cond=<optimized out>, user_data=<optimized out>) at src/shared/io-glib.c:157
> 9  0x00007fb3f2d7fe87 in g_main_context_dispatch () from /usr/lib64/libglib-2.0.so.0
> 10 0x00007fb3f2d80230 in ?? () from /usr/lib64/libglib-2.0.so.0
> 11 0x00007fb3f2d80542 in g_main_loop_run () from /usr/lib64/libglib-2.0.so.0
> 12 0x00000000004a0e25 in mainloop_run () at src/shared/mainloop-glib.c:66
> 13 0x00000000004a11f2 in mainloop_run_with_signal (func=func@entry=0x43f200 <signal_callback>, user_data=user_data@entry=0x0) at src/shared/mainloop-notify.c:188
> 14 0x000000000040c72e in main (argc=<optimized out>, argv=<optimized out>) at src/main.c:959
>
> Change-Id: I17b8ccc5322b0a83fc63d711e83c9f4a58a0374c
> ---
>  src/device.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/src/device.c b/src/device.c
> index a5ef46730..d5e884ff4 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -569,6 +569,7 @@ static void gatt_cache_cleanup(struct btd_device *device)
>         if (gatt_cache_is_enabled(device))
>                 return;
>
> +       bt_gatt_client_cancel_all(device->client);
>         gatt_db_clear(device->db);
>  }
>
> --
> 2.26.2

Applied, thanks.

-- 
Luiz Augusto von Dentz
