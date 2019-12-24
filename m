Return-Path: <SRS0=L7UJ=2O=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D714C2D0CF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Dec 2019 07:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D68206CB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Dec 2019 07:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TYLFRtYF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfLXHyg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Dec 2019 02:54:36 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37715 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfLXHyg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Dec 2019 02:54:36 -0500
Received: by mail-pl1-f193.google.com with SMTP id c23so8183689plz.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Dec 2019 23:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w6Hpycs4MbuCZ6MDpUagkW7gAnUM2TUNcKnkJ9WLZ+o=;
        b=TYLFRtYFbM40/OGZUVUXLxrqeIUEatL0CLFvuNtUinEGe2xX5kXoTG5BCA6N1nE6UM
         V+e1qiOx5iIThim0iYA2Ka31byGaz33/plI7QmWBuGQv1c5fD2G6r4nuVuTCHAKoFAmg
         JXgWIeiTw2bXxfNvN8MXNj6tM2f6Bsxj/2lKtwl7+cX6W9Yvv8gFzT2wroXPxooKGJYK
         viV2iV+SmkBaUp/Xm7PrlUkQRyDe+Y/JlEAF50pCsCnRwyeV+IdQqT2zYyGS1axmo/pU
         coUkZZR29/qXOCXSWYMyrLrPC40bm9YuiwRbZprtHLBEG9sV82mY62yNJEEqvshvkwf0
         GTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w6Hpycs4MbuCZ6MDpUagkW7gAnUM2TUNcKnkJ9WLZ+o=;
        b=qLaUUv+LD4XGUAuJtyhkmhSBWgbo1nFfUDEhQG7m3AtkZRqPTwenUI3PIAwlJq8aEu
         Fgz9f7s+4lHE5jLDDPLCgjF3D9O4a7AvMkzbXfb9UXovu0l8aFABAsiPceA7TjsYj9DF
         1SdflzDUnLOe3HpDWbH3ONKALojGWSBT370OzhTQd066fhgcFr1hkwbWr/+DfwWwQ0hb
         ycakalz8JDuNdYhqX8KtfHuRots7yApM+SwZpSHwgzT59a3ZIQNB4C7BbjIMgupEeBMy
         hIc0Qth33v2zfT7LOtGIkVnTUdiyX22neUdXwUWyDEmnf2fwTvM3zqADBrRE+PbR9QjT
         Bt0g==
X-Gm-Message-State: APjAAAXRqK5qchgMZt+IucQ1JumpZ9XdIYESN4HdyQK2Prncur/AlpIW
        kYj+9qEBY2WTQw5Z7QuLmRWw34WdVS8NKNOPBCl5qVgpvE8=
X-Google-Smtp-Source: APXvYqwKjl+glRErqR0cdHpSlhC4167VhBP6hrSflPJns2L2lnvmVB2fUD50egsLeMEg98V6F4kWjR2a7g6PkUR6C18=
X-Received: by 2002:a17:902:9b8e:: with SMTP id y14mr10788764plp.280.1577174074761;
 Mon, 23 Dec 2019 23:54:34 -0800 (PST)
MIME-Version: 1.0
References: <20191224144804.Bluez.v1.1.Ie74d7bb468a914ba7386aae02fc63cd4f529b0ef@changeid>
In-Reply-To: <20191224144804.Bluez.v1.1.Ie74d7bb468a914ba7386aae02fc63cd4f529b0ef@changeid>
From:   Yun-hao Chung <howardchung@google.com>
Date:   Tue, 24 Dec 2019 15:54:23 +0800
Message-ID: <CAPHZWUfUOr6Z9hHxE5OLbTcpbSSpxKs32d3AUrPLtn8XAC_HTw@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] CHROMIUM: audio: fix crash during recovering process
To:     linux-bluetooth@vger.kernel.org
Cc:     ChromeOS-BT-Platform-SW-Core 
        <chromeos-bt-platform-sw-core@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

+ ChromeOS-BT-Platform-SW-Core

On Tue, Dec 24, 2019 at 2:48 PM howardchung@google.com
<howardchung@google.com> wrote:
>
> From: howardchung <howardchung@google.com>
>
> The crash with stack trace:
>
> (libc-2.27.so -raise.c:51 )                     raise
> (libc-2.27.so -abort.c:79 )                     abort
> (libc-2.27.so -libc_fatal.c:181 )               __libc_message
> (libc-2.27.so -malloc.c:5350 )                  malloc_printerr
> (libc-2.27.so -malloc.c:4157 )                  _int_free
> (libglib-2.0.so.0.5200.3 -gslist.c:878 )        g_slist_free_full
> (bluetoothd -a2dp.c:165 )                       setup_unref
> (bluetoothd -a2dp.c:2184 )                      a2dp_cancel
> (bluetoothd -sink.c:317 )                       sink_unregister
> (bluetoothd -service.c:176 )                    service_remove
> (bluetoothd -device.c:4678 )                    device_remove
> (bluetoothd -adapter.c:6573 )                   adapter_remove
> (bluetoothd -adapter.c:8832 )                   index_removed
> (bluetoothd -queue.c:220 )                      queue_foreach
> (bluetoothd -mgmt.c:304 )                       can_read_data
> (bluetoothd -io-glib.c:170 )                    watch_callback
> (libglib-2.0.so.0.5200.3 -gmain.c:3234 )        g_main_context_dispatch
> (libglib-2.0.so.0.5200.3 -gmain.c:3972 )        g_main_context_iterate
> (libglib-2.0.so.0.5200.3 -gmain.c:4168 )        g_main_loop_run
> (bluetoothd -main.c:798 )                       main
> (libc-2.27.so -libc-start.c:308 )               __libc_start_main
> (bluetoothd + 0x0000b089 )                      _start
> (bluetoothd + 0x0000b05f )                      _init
>
> triggered when 'usb disconnect' happened during AVDTP_SET_CONFIGURATION
> request is sent but haven't recevied the responce.
> In this situation, the recovering process goes into sink.c:sink_free and
> then a2dp.c:a2dp_cancel, avdtp.c:cancel_request, avdtp.c:connection_lost,
> avdtp.c:release_stream.
>
> During recovering, the reference count of setup and avdtp decrease more
> than it increase, which ends up causing the crash.
>
> The reference count of setup decreases one more time since
> a2dp.c:setconf_cfm(called by cfm->set_configuration in
> avdtp.c:cancel_request) was called in the 'error mode', which didn't
> reference the setup, but in a2dp.c:abort_cfm(called by cfm->abort in
> avdtp.c:release_stream), the reference count decreased by 1.
>
> In this case, abort_cfm shouldn't be called as we already know
> setconf_cfm didn't send any request. Setting avdtp_sep_state to
> AVDTP_STATE_ABORTING should avoid this issue.
>
> The reference count of avdtp decrease one more time since
> both sink.c:sink_free and sink.c:sink_set_state(called from
> avdtp.c:connection_lost -> avdtp.c:avdtp_set_state) unreference avdtp
> for the session. The changes in sink.c should avoid the issue.
>
> Signed-off-by: howardchung@google.com <howardchung@google.com>
> ---
> How to test:
>         The crash can be simulated by the following procedure.
>         1. injecting sleep(10) right before calling a2dp_config in
>            sink.c:select_complete.
>         2. connect with a bluetooth headset
>         3. run 'rmmod btusb' after ~5 seconds(before the connection
>            complete)
> The procedure can reproduce the crash with ~50% probability.
> Even if the bluetoothd didn't crash or it crashed with different
> signature, the reference count can end up with some invalid number.
>
> After the patch applies, there is no crash after running the test above 10
> times in a row.
>
>  profiles/audio/avdtp.c | 3 +++
>  profiles/audio/sink.c  | 4 +++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> index 91b1e4b96..f42f21bbb 100644
> --- a/profiles/audio/avdtp.c
> +++ b/profiles/audio/avdtp.c
> @@ -3550,6 +3550,7 @@ int avdtp_abort(struct avdtp *session, struct avdtp_stream *stream)
>  {
>         struct seid_req req;
>         int ret;
> +       struct avdtp_local_sep *sep = stream->lsep;
>
>         if (!stream && session->discover) {
>                 /* Don't call cb since it being aborted */
> @@ -3564,6 +3565,8 @@ int avdtp_abort(struct avdtp *session, struct avdtp_stream *stream)
>         if (stream->lsep->state == AVDTP_STATE_ABORTING)
>                 return -EINVAL;
>
> +       avdtp_sep_set_state(session, sep, AVDTP_STATE_ABORTING);
> +
>         if (session->req && stream == session->req->stream)
>                 return cancel_request(session, ECANCELED);
>
> diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
> index 966440534..7c5e77577 100644
> --- a/profiles/audio/sink.c
> +++ b/profiles/audio/sink.c
> @@ -308,8 +308,10 @@ static void sink_free(struct btd_service *service)
>                 avdtp_stream_remove_cb(sink->session, sink->stream,
>                                         sink->cb_id);
>
> -       if (sink->session)
> +       if (sink->session) {
>                 avdtp_unref(sink->session);
> +               sink->session = NULL;
> +       }
>
>         if (sink->connect_id > 0) {
>                 btd_service_connecting_complete(sink->service, -ECANCELED);
> --
> 2.24.1.735.g03f4e72817-goog
>
