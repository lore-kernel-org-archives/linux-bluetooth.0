Return-Path: <SRS0=nFDS=27=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BD9C33CA2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jan 2020 08:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971B52072E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jan 2020 08:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c0S53NZX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgAJIMe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jan 2020 03:12:34 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32830 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbgAJIMe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jan 2020 03:12:34 -0500
Received: by mail-pg1-f194.google.com with SMTP id 6so650579pgk.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2020 00:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Stq24dS1Z6xfdk4pDOGb8M2Nd25zUod97TaQOtiZjSk=;
        b=c0S53NZXfogkt4DUiHhOSzxrf/j3ANtyAQCbETtIQbqnvJ5Rjwl0yiFMHJHhiY16DS
         K9/+pIG+L5F5M+4HlK0qn0Pzc+GtbvPeg85zAov1yKuiwXJG79AmvEG+Az03edzZIxbq
         euXl+u17uhkbcMhKScTtn9R9R+G/GiOlCa0xZHHOQfGGIBbC4bBI7amwSV/ANiypEWTS
         wSHjHhpqsqdguskjUxnOKJ/duIQfPHpsuWB/tFUc8+ho660cbpnn69GEY+STlVFbTcJq
         dv/poRWX5jzwbJZbgaDmuDB45R4EyVcrbQPgiMgshaeDq1rAYF2mLQxgFnFye5KjdsdZ
         5g3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Stq24dS1Z6xfdk4pDOGb8M2Nd25zUod97TaQOtiZjSk=;
        b=h/bMGQ/sa04LS/HK7TMuvcpHjR7HTB2PBkvKl3VeeBzy9YKfucL41zLx5twL6rkhZN
         YL3gmLk3MRPXgRUwbokOdgzpByztJj4i4UgDSYQ6oSxDAplPqJ2ZLuDvp64nXPjJFvGP
         kct7gUdo1AmmW8VbjZvrnr0RTuBdG+FQbmarP+b0ewgHEryjpXgFTrzClbtiWKr9u/SF
         KC7QKS8kYXvTUQC02J/O/jo3MZKas8h0PHhJG3jnNkfVYu6xZA6WU/1e7b53nZWJe2Q7
         gV7juj+e5IV9mo68eZKqV3AZ5olV9YjMahom19oblO9zwIuFY61+s1skePtTwAdoPV6u
         lEVQ==
X-Gm-Message-State: APjAAAUc7/DHm16JT02S2y+CKi3j4UGWtfOwKbUJpzB0Zxa2qQpcoDxq
        xAM7XHf3gRRvMxZqt6L8wre3qk149CROjStscevbqZRdj5I=
X-Google-Smtp-Source: APXvYqxWAU0nACWBKzpn0bbNzR0/Rj95YzI4Pcr8zuJ//sZFENxnUEBwkBqowlH9cycG4LvOi6pZOUIlT0YtWdDOKsQ=
X-Received: by 2002:aa7:9629:: with SMTP id r9mr2667857pfg.51.1578643952452;
 Fri, 10 Jan 2020 00:12:32 -0800 (PST)
MIME-Version: 1.0
References: <20200110155716.Bluez.v3.1.Ie74d7bb468a914ba7386aae02fc63cd4f529b0ef@changeid>
 <CAPHZWUd0LQrVrWa5jCG2skA8KOORxpBMRBKtYU+n23kVtx27JA@mail.gmail.com>
In-Reply-To: <CAPHZWUd0LQrVrWa5jCG2skA8KOORxpBMRBKtYU+n23kVtx27JA@mail.gmail.com>
From:   Yun-hao Chung <howardchung@google.com>
Date:   Fri, 10 Jan 2020 16:12:21 +0800
Message-ID: <CAPHZWUdpxVMvth-cobmWriLsJ9=nVrUVtqr-jtMw3kQqZ36syw@mail.gmail.com>
Subject: Re: [Bluez PATCH v3] audio/a2dp - fix crash during recovering process
To:     linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Thanks for the comment.
I did the qualification test with and without the patch on both Chrome
OS and Linux with bluez-5.52.
The results are all the same.
The tests I=E2=80=99ve run are as follows.

A2DP/SRC/AS/BV-01-I
A2DP/SRC/CC/BV-09-I
A2DP/SRC/CC/BV-10-I
A2DP/SRC/REL/BV-01-I
A2DP/SRC/REL/BV-02-I
A2DP/SRC/SET/BV-01-I
A2DP/SRC/SET/BV-02-I
A2DP/SRC/SET/BV-03-I
A2DP/SRC/SET/BV-04-I
A2DP/SRC/SET/BV-05-I
A2DP/SRC/SET/BV-06-I
IOPT/CL/A2DP-SRC/SFC/BV-01-I
AVDTP/SRC/ACP/SIG/SMG/BV-06-C
AVDTP/SRC/ACP/SIG/SMG/BV-08-C
AVDTP/SRC/ACP/SIG/SMG/BV-10-C
AVDTP/SRC/ACP/SIG/SMG/BV-16-C
AVDTP/SRC/ACP/SIG/SMG/BV-18-C
AVDTP/SRC/ACP/SIG/SMG/BV-20-C
AVDTP/SRC/ACP/SIG/SMG/BV-24-C
AVDTP/SRC/ACP/SIG/SMG/BI-05-C
AVDTP/SRC/ACP/SIG/SMG/BI-08-C
AVDTP/SRC/ACP/SIG/SMG/BI-17-C
AVDTP/SRC/ACP/SIG/SMG/BI-20-C
AVDTP/SRC/ACP/SIG/SMG/BI-23-C
AVDTP/SRC/ACP/SIG/SMG/BI-28-C*
AVDTP/SRC/ACP/TRA/BTR/BI-01-C
AVDTP/SRC/INT/SIG/SMG/BV-05-C
AVDTP/SRC/INT/SIG/SMG/BV-07-C
AVDTP/SRC/INT/SIG/SMG/BV-09-C
AVDTP/SRC/INT/SIG/SMG/BV-15-C
AVDTP/SRC/INT/SIG/SMG/BV-17-C
AVDTP/SRC/INT/SIG/SMG/BV-19-C
AVDTP/SRC/INT/SIG/SMG/BV-23-C
AVDTP/SRC/INT/SIG/SMG/BV-31-C
AVDTP/SRC/INT/SIG/SMG/BI-30-C
AVDTP/SRC/INT/TRA/BTR/BV-01-C

Except for AVDTP/SRC/ACP/SIG/SMG/BI-28-C, the other tests had been passed.
Please let me know if I need more verification.

Thanks,
Howard

On Fri, Jan 10, 2020 at 4:09 PM Yun-hao Chung <howardchung@google.com> wrot=
e:
>
> ---------- Forwarded message ---------
> From: howardchung@google.com <howardchung@google.com>
> Date: Fri, Jan 10, 2020 at 3:57 PM
> Subject: [Bluez PATCH v3] audio/a2dp - fix crash during recovering proces=
s
> To: <linux-bluetooth@vger.kernel.org>, <luiz.von.dentz@intel.com>
> Cc: <chromeos-bluetooth-upstreaming@chromium.org>, howardchung
> <howardchung@google.com>
>
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
> After the patch applies, there is no crash after running the test above 1=
0
> times in a row.
>
> Changes in v3:
> - Update the title
> - Remove the signed-off-by section
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
> @@ -3484,6 +3484,7 @@ int avdtp_abort(struct avdtp *session, struct
> avdtp_stream *stream)
>  {
>         struct seid_req req;
>         int ret;
> +       struct avdtp_local_sep *sep =3D stream->lsep;
>
>         if (!stream && session->discover) {
>                 /* Don't call cb since it being aborted */
> @@ -3498,6 +3499,8 @@ int avdtp_abort(struct avdtp *session, struct
> avdtp_stream *stream)
>         if (stream->lsep->state =3D=3D AVDTP_STATE_ABORTING)
>                 return -EINVAL;
>
> +       avdtp_sep_set_state(session, sep, AVDTP_STATE_ABORTING);
> +
>         if (session->req && stream =3D=3D session->req->stream)
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
> +               sink->session =3D NULL;
> +       }
>
>         if (sink->connect_id > 0) {
>                 btd_service_connecting_complete(sink->service, -ECANCELED=
);
> --
> 2.25.0.rc1.283.g88dfdc4193-goog
