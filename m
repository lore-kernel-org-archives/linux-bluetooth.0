Return-Path: <SRS0=zBKN=5Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6F1C43331
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 18:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301432073B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 18:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsYVuDzb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgCaSAJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Mar 2020 14:00:09 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35405 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgCaSAJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Mar 2020 14:00:09 -0400
Received: by mail-ot1-f68.google.com with SMTP id v2so18431704oto.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2020 11:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NGGoffaEEoevhuPIQxSMZGVrLYBDcDvDGYpX4Ko/TTk=;
        b=ZsYVuDzbevImFOxGazF/WJReHFlxzQCz9Ps51UmeuzS/N6IaoMy3qqAR19KRU/4eYP
         EALEasHHHcdricOHjpDcL9XjGo6xtW8ELwQ0SjN1Zeg0Z/2kIu8U74JYMo/gzvCg0EL1
         zgS2NHVCH9N8sL4ReD2NlZ2ztq4gCf4Dd0M2Uoh5KL22pxD4HeidfliRuCozL/Llge42
         PBNy3kbLIr1AHy2g8cep5pZ9AAXElLv7hARtu+98GlCsJHnYB6qx+pPhGjuO1Was8ZOe
         VwLPXTV9SmLHZXsDuu2pUBRQ/KxYfoXZIcl6JiZ24JYT9gWgnQ+cBIbjTOTmaUZlscmr
         lkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NGGoffaEEoevhuPIQxSMZGVrLYBDcDvDGYpX4Ko/TTk=;
        b=uK5OhspAvtc/UBWwjhSGv2yXlYeBe5wsRePRzSXZ6Mza955f5pUMq+t/rnCUkbJs1v
         O2GieVYh30BM4xNhEBzSt4N8juprXcotJzyJ2z+iGP4MNxMF9Dpdg5iBF4JjkIFJt/CZ
         gH+fhu0+xx5YcC9C6NS1Qa/NorRb3DvPdakSuQ1tW4R5omDmza3sU2gNwRlSnb2Ys1sA
         4tNBUtmTkNWO4J/P0YyZau23oE2ijcSIyuv/NNqx41ZRm4Pf94m1qMcvlnib4wYZvyeY
         u9fmly+aqnnGAakzJabaoIywvh6aCcNXYyORQ2le/i0BMshqDSwbCNbwRP027//2PqTv
         d92g==
X-Gm-Message-State: ANhLgQ0yF9NfTAK+V5Q8D6EvwUJwmJRcIhKPKDXv+H1J/QrsHQfEMsle
        DxYZhV5wRcwXlMOVsERkLzyeVK98+cWrA1MhU3E=
X-Google-Smtp-Source: ADFU+vvvjX/yAV4/HTNWKXK4KGFtJXDupHKl2tm6LO+oLkqAYftojAf1UR5y5JgdLiewWBqyAvx1NvZxkxQqK6vNQSE=
X-Received: by 2002:a9d:644:: with SMTP id 62mr8521452otn.177.1585677608576;
 Tue, 31 Mar 2020 11:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200331104532.365961-1-szymon.janc@codecoup.pl>
In-Reply-To: <20200331104532.365961-1-szymon.janc@codecoup.pl>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 31 Mar 2020 10:59:57 -0700
Message-ID: <CABBYNZ+r8XEJL=a15eCL5FJ8+mBZb+2VzKR=95ArD_jXpjWr_A@mail.gmail.com>
Subject: Re: [PATCH] shared/gatt: Fix NULL pointer dereference
To:     Szymon Janc <szymon.janc@codecoup.pl>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Szymon,

On Tue, Mar 31, 2020 at 3:48 AM Szymon Janc <szymon.janc@codecoup.pl> wrote:
>
> bluetoothd[363094]: src/device.c:device_connect_le() Connection attempt to: 00:AA:01:00:00:23
>
> Program received signal SIGSEGV, Segmentation fault.
> write_complete_cb (attr=0x55555580aa30, err=-110, user_data=0x55555585f7c0) at src/shared/gatt-server.c:793
> 793             util_debug(server->debug_callback, server->debug_data,
> (gdb) bt
>  #0  write_complete_cb (attr=0x55555580aa30, err=-110, user_data=0x55555585f7c0) at src/shared/gatt-server.c:793
>  #1  0x00005555556a5852 in pending_write_result (p=0x555555866030, err=<optimized out>) at src/shared/gatt-db.c:162
>  #2  0x00005555556a5ac7 in write_timeout (user_data=0x555555866030) at src/shared/gatt-db.c:1879
>  #3  0x00005555556a9b15 in timeout_callback (user_data=user_data@entry=0x555555864b20) at src/shared/timeout-glib.c:34
>  #4  0x00007ffff7e1f081 in g_timeout_dispatch (source=source@entry=0x555555864f00, callback=0x5555556a9b00 <timeout_callback>, user_data=0x555555864b20) at ../glib/gmain.c:4705
>  #5  0x00007ffff7e1e570 in g_main_dispatch (context=0x5555557d9630) at ../glib/gmain.c:3216
>  #6  g_main_context_dispatch (context=context@entry=0x5555557d9630) at ../glib/gmain.c:3881
>  #7  0x00007ffff7e1e900 in g_main_context_iterate (context=0x5555557d9630, block=block@entry=1, dispatch=dispatch@entry=1, self=<optimized out>) at ../glib/gmain.c:3954
>  #8  0x00007ffff7e1ebf3 in g_main_loop_run (loop=0x5555557d75d0) at ../glib/gmain.c:4148
>  #9  0x00005555556a9dbd in mainloop_run () at src/shared/mainloop-glib.c:79
>  #10 0x00005555556aa36a in mainloop_run_with_signal (func=<optimized out>, user_data=0x0) at src/shared/mainloop-notify.c:201
>  #11 0x00005555555bb9e3 in main (argc=<optimized out>, argv=<optimized out>) at src/main.c:770
> ---
>  src/shared/gatt-server.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
> index 7e5d652e4..4e07398d2 100644
> --- a/src/shared/gatt-server.c
> +++ b/src/shared/gatt-server.c
> @@ -790,14 +790,14 @@ static void write_complete_cb(struct gatt_db_attribute *attr, int err,
>         struct bt_gatt_server *server = op->server;
>         uint16_t handle;
>
> -       util_debug(server->debug_callback, server->debug_data,
> -                               "Write Complete: err %d", err);
> -
>         if (!server || op->opcode == BT_ATT_OP_WRITE_CMD) {
>                 async_write_op_destroy(op);
>                 return;
>         }
>
> +       util_debug(server->debug_callback, server->debug_data,
> +                                               "Write Complete: err %d", err);
> +
>         handle = gatt_db_attribute_get_handle(attr);
>
>         if (err)
> @@ -914,14 +914,14 @@ static void read_complete_cb(struct gatt_db_attribute *attr, int err,
>         uint16_t mtu;
>         uint16_t handle;
>
> -       util_debug(server->debug_callback, server->debug_data,
> -                               "Read Complete: err %d", err);
> -
>         if (!server) {
>                 async_read_op_destroy(op);
>                 return;
>         }
>
> +       util_debug(server->debug_callback, server->debug_data,
> +                               "Read Complete: err %d", err);
> +
>         mtu = bt_att_get_mtu(server->att);
>         handle = gatt_db_attribute_get_handle(attr);
>
> --
> 2.25.1
>
Applied, thanks.

-- 
Luiz Augusto von Dentz
