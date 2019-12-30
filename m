Return-Path: <SRS0=qfK6=2U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B859FC2D0C2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Dec 2019 17:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 844212071E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Dec 2019 17:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWj3YVSo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfL3R3L (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Dec 2019 12:29:11 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33937 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbfL3R3L (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Dec 2019 12:29:11 -0500
Received: by mail-ot1-f67.google.com with SMTP id a15so47039413otf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Dec 2019 09:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WsRtzWiehIimxKm8/el5dg68h3OdVW0vZyZNLiruqqw=;
        b=eWj3YVSohBO43wBRDfnxBuu5Lt8sRaO9qxNxnasJ8SWMTT5lsWDuw8lq/pnG6x2ISq
         iP4eLwUtJH88ybuVTr3qqNkXFssWrC37PT6RLVo7oT3ifHFqjIb0rPVM5xTCY0e00i4g
         tesl6IGAVmLDpebtMxmG5loe77CWZyvWeQ92xIzkXpmsc5Zd15BUwYV5myBob8ckRBEK
         PmWaGJOFpfCaFIOFKNgxxP53RE1cOf8152piAd0+IRxTb5emeZQuBf2FLdtycpCHWYBu
         W1120bXYHf2QA54Z/mEgMtf5XBtphEEo/g9sAiEwik+tYZDhXkWeebNHFIVpwxGvpU5T
         erQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WsRtzWiehIimxKm8/el5dg68h3OdVW0vZyZNLiruqqw=;
        b=PyZ0Gy2r8Av9c4uHUvCWqyiwKMS9RIPukq1Gz3ApCPa7kYKzndcKfvaqfP+Jr2yc7N
         uguOn6TEEg62/ReV6P8lgCRj2TULz3vBtqhYlR76IyOTf+6GGUjeS4y+WbQCU14+8+7v
         o1FNMBy4rtNbcL+cbLFf4PYpyAAJOtXa73nFBZ8fW49e0HCiIm0eCt64S4CBiCM+SUJn
         gS2olKqOaPbnIJAjUJ7xORurI+kkrmGaELogQ3dAxZrOZp31O8XnpXw4NAfdGXalFu9a
         cpyLqDR0/kydLjMK0o92izMd/l0gjLy5LX7ZjP5Z7r/pQ+HaoJyZ2qp7iM+rj1tqV5wJ
         CrDQ==
X-Gm-Message-State: APjAAAW6nhN0WpszZ/27OpFOjyghtizLXtJqaN4yVTQMu2DeUF5ONtd1
        3vo4dCPQNT5EeEhF5iaM9XSXZNfAe0mxkI1YDWk=
X-Google-Smtp-Source: APXvYqwJgkLbodeATtQfrMxWBu9BSmTwBTqoH78kUlCndih6CFLrUgDOpo0SeIPhspQKI0Ai8ryFMKEhzSa9uXLJTWg=
X-Received: by 2002:a9d:6d10:: with SMTP id o16mr77168900otp.28.1577726950339;
 Mon, 30 Dec 2019 09:29:10 -0800 (PST)
MIME-Version: 1.0
References: <20191230180355.Bluez.v2.1.Ie74d7bb468a914ba7386aae02fc63cd4f529b0ef@changeid>
In-Reply-To: <20191230180355.Bluez.v2.1.Ie74d7bb468a914ba7386aae02fc63cd4f529b0ef@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 30 Dec 2019 09:28:58 -0800
Message-ID: <CABBYNZ+8zp4vw6tuGkJ=eAF9O4h3PvEX1quvALpOYXDFuLzqhA@mail.gmail.com>
Subject: Re: [Bluez PATCH v2] CHROMIUM: audio: fix crash during recovering process
To:     "howardchung@google.com" <howardchung@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
        chromeos-bluetooth-upstreaming@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Mon, Dec 30, 2019 at 2:10 AM howardchung@google.com
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
> request is sent but haven't received the response.
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

We don't use signed-off-by on userspace.

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
> Changes in v2:
> - Fixed typo in commit message
>
>  profiles/audio/avdtp.c | 3 +++
>  profiles/audio/sink.c  | 4 +++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> index 51ead684a..620a76c90 100644
> --- a/profiles/audio/avdtp.c
> +++ b/profiles/audio/avdtp.c
> @@ -3484,6 +3484,7 @@ int avdtp_abort(struct avdtp *session, struct avdtp_stream *stream)
>  {
>         struct seid_req req;
>         int ret;
> +       struct avdtp_local_sep *sep = stream->lsep;
>
>         if (!stream && session->discover) {
>                 /* Don't call cb since it being aborted */
> @@ -3498,6 +3499,8 @@ int avdtp_abort(struct avdtp *session, struct avdtp_stream *stream)
>         if (stream->lsep->state == AVDTP_STATE_ABORTING)
>                 return -EINVAL;
>
> +       avdtp_sep_set_state(session, sep, AVDTP_STATE_ABORTING);

We still have the same code on avdtp_abort_resp which I guess is no
longer necessary, anyway for this type of change it might be worth
checking if we didn't break anything with regards of qualification.

>         if (session->req && stream == session->req->stream)
>                 return cancel_request(session, ECANCELED);
>
> diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
> index 7cac21034..726e2f562 100644
> --- a/profiles/audio/sink.c
> +++ b/profiles/audio/sink.c
> @@ -309,8 +309,10 @@ static void sink_free(struct btd_service *service)
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


-- 
Luiz Augusto von Dentz
