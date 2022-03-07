Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A142C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Mar 2022 21:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245311AbiCGVZn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Mar 2022 16:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbiCGVZm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Mar 2022 16:25:42 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B82C60DB1
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Mar 2022 13:24:47 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id w16so33678131ybi.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Mar 2022 13:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KmB8fp7Em83941w0yGbKCxsAUDlc6685RYn/O4lBIl4=;
        b=jSyCvV57zmxczNPC40QHfPWINMD/nuYifLzVrc/vjUwKS3pbGvfVGeI0vetgvmL35P
         8Pgcg5wiYMubvlmJ8ccpmErRj2oj0W0TeEgwTx+O6gEKH7SGOoPddTq0eynI+jxxHFcr
         4e0qZQEul4HNmY/9n4yFM1WuVCZOWvnoq9wk8RDRYlFhEnKV+mDeniYOpyhqCXFJkwAA
         0TGlBELaqQHr/mUBCgowcqwz438GStd0CvgwtGbje5P/7uzW3/lppWxaO/siNSGFPzFj
         LDUcI1hk+rmLouIWWcnLCHHbxWsNDkxbcVNbjYTFFsXvK9Pb5S/pN1dejvhjh1TNhAca
         TwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KmB8fp7Em83941w0yGbKCxsAUDlc6685RYn/O4lBIl4=;
        b=zuxIVhDeawVFlzjKd/eUjM7Ejpzv1d7yI45AJzMyC0NoEf2PiHA4oqs2fUwIzMpbfe
         LRIWux85Ujaj0Syi9HwlL6EKV6o8xOvKyd8g5NO1Hlqn2psL7rt7Ynb8eGykL9TMGB6P
         21FPpztGhLCsuf98ry+SJl26AfL/O+HV9yqdYmAexu5f19bFcAMZKH1ZNnvk2dTgxC31
         Ps443sLp8TnUjSZFEp/4r6M1gxfs/BKgDkOwJTpByD0Cc33/beE8hqp5Gn4TT9+Vhxjl
         ncbBkoFUOMQIgA304KGth1CAanHru7xiFKBWc6EW2qB0QnnfVQQdcQUh0qdsdh2k2jsw
         /90w==
X-Gm-Message-State: AOAM533ZkfTC3wdegSCeWYUEQ9yRo9J6Wx85OTgL//IwUTbaWYCGk2hz
        CjXx1zRS3m/xtjA+dIOrBAyeEiCjsZQNw4GuUw8=
X-Google-Smtp-Source: ABdhPJxng1DWnpyk5PDAqQelp5on+A4FpUWnAuULTfVmY1eFPsyi/VShygvxJSKxlDKHu6oL0pUjXeOTzxmSisRW8ls=
X-Received: by 2002:a25:d083:0:b0:629:254e:bd42 with SMTP id
 h125-20020a25d083000000b00629254ebd42mr7861648ybg.459.1646688286434; Mon, 07
 Mar 2022 13:24:46 -0800 (PST)
MIME-Version: 1.0
References: <20220307140437.Bluez.v1.1.Ieb7448d3d951876e1f412452fcfd27cdc7bd015b@changeid>
In-Reply-To: <20220307140437.Bluez.v1.1.Ieb7448d3d951876e1f412452fcfd27cdc7bd015b@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 7 Mar 2022 13:24:35 -0800
Message-ID: <CABBYNZJnUtn4LwcFc+Nccpx4PRuBzgpu1-3-D2if_P6NaLZmkQ@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] audio: fix crash in a2dp_discover
To:     Howard Chung <howardchung@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Yun-Hao Chung <howardchung@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

On Sun, Mar 6, 2022 at 10:06 PM Howard Chung <howardchung@google.com> wrote:
>
> From: Yun-Hao Chung <howardchung@chromium.org>
>
> Sample stack trace:
> 0x0000567c394e4c6b (bluetoothd - a2dp.c: 270) setup_cb_free
> 0x0000567c394e4a94 (bluetoothd - a2dp.c: 2884) a2dp_discover
> 0x0000567c394e3c03 (bluetoothd - sink.c: 275) sink_setup_stream
> 0x0000567c394e3d4f (bluetoothd - sink.c: 299) sink_connect
> 0x0000567c39535183 (bluetoothd - service.c: 294) btd_service_connect
> 0x0000567c39539f68 (bluetoothd - device.c: 2006) connect_next
> 0x0000567c3954086d (bluetoothd - device.c: 2060) service_state_changed
> 0x0000567c39534efb (bluetoothd - service.c: 111) change_state
> 0x0000567c3953559c (bluetoothd - service.c: 0)
> btd_service_connecting_complete
> 0x0000567c39534a5c (bluetoothd - profile.c: 1641) record_cb
> 0x0000567c395197cd (bluetoothd - sdp-client.c: 298) connect_watch
> 0x00007b14bc8034f6 (libglib-2.0.so.0 - gmain.c: 3337)
> g_main_context_dispatch
> 0x00007b14bc803801 (libglib-2.0.so.0 - gmain.c: 4131)
> g_main_context_iterate
> 0x00007b14bc803a7d (libglib-2.0.so.0 - gmain.c: 4329) g_main_loop_run
> 0x0000567c39566af1 (bluetoothd - mainloop-glib.c: 79) mainloop_run
> 0x0000567c39566ddb (bluetoothd - mainloop-notify.c: 201)
> mainloop_run_with_signal
> 0x0000567c3954bf4c (bluetoothd - main.c: 1222) main
> 0x00007b14bc579797 (libc.so.6 - libc-start.c: 332) __libc_start_main
> 0x0000567c394df449 (bluetoothd) _start
> 0x00007ffd70145737
>
> This could be triggered from a2dp_discover -> avdtp_discover ->
> send_request -> send_req -> l2cap_connect (return error) ->
> avdtp_set_state (to disconnect state)-> channel_remove -> channel_free
> -> finalize_setup_errno (discover cb is freed) -> error handling all
> the way back to a2dp_discover -> a2dp_discover (discover cb is freed
> again, crashed!).
>
> The fix is to add setup_ref/setup_unref around a2dp_discover to ensure
> setup alive, and check if setup->chan to see if channel_free has been
> called or not.
>
> Reviewed-by: Archie Pusaka <apusaka@chromium.org>
> ---
> Hi maintainers,
>
> The fix is tested by forcing session->io to NULL in send_req in the code
> and verifing the crash doesn't happen.
>
>  profiles/audio/a2dp.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> index 9fbcd35f7..39e1e9624 100644
> --- a/profiles/audio/a2dp.c
> +++ b/profiles/audio/a2dp.c
> @@ -2878,14 +2878,22 @@ unsigned int a2dp_discover(struct avdtp *session, a2dp_discover_cb_t cb,
>         if (!setup)
>                 return 0;
>
> +       setup_ref(setup);
>         cb_data = setup_cb_new(setup);
>         cb_data->discover_cb = cb;
>         cb_data->user_data = user_data;
>
> -       if (avdtp_discover(session, discover_cb, setup) == 0)
> +       if (avdtp_discover(session, discover_cb, setup) == 0) {
> +               setup_unref(setup);
>                 return cb_data->id;
> +       }
>
> -       setup_cb_free(cb_data);
> +       /* Check if the channel is still there before freeing setup_cb, since it
> +        * could be freed by channel_free().
> +        */
> +       if (setup->chan)
> +               setup_cb_free(cb_data);
> +       setup_unref(setup);
>         return 0;

This sounds a little too complicated and I'm afraid we may run into
other problems if we start taking extra references, so how about we
don't attach the cb_data to begin with:

https://gist.github.com/Vudentz/7f1a3eeea7decdb17b67d288b1dff77e

>  }
>
> --
> 2.35.1.616.g0bdcbb4464-goog
>


-- 
Luiz Augusto von Dentz
