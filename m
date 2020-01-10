Return-Path: <SRS0=nFDS=27=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7768C282DD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jan 2020 23:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9790B20578
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jan 2020 23:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVEYHDgL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbgAJXy0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jan 2020 18:54:26 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40009 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbgAJXyZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jan 2020 18:54:25 -0500
Received: by mail-ot1-f67.google.com with SMTP id w21so3647883otj.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2020 15:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+/1WEz/eIINIO9NV6nKyzMWSxBJSaO1uT7HM5hfnKEI=;
        b=VVEYHDgLz7hHO2TwD9nY8D6kBXRj/hzHt2/7TNfV6AXnHT5q6ni6kFDPaTWhDezH1A
         V+FadpjMXYoaeYcg5azZEHqQQBIFKGqbnH1aRG7nmRJO9QREiyz1FQ08H7XnKyRrzd7M
         vFbForTQa90VJiGo5cOm6vU8oJGWJugdViNPGhAqSYL4nzhNZXtz7ZU1TM852htSDVkc
         reAxhqBrph6IVq0WTOxWw1hNfi3PgK8v13pHGaiyTr5IPGgzwzCgdj0HmpPIMELHVPYg
         7OkmprGNdtp0Kv2CDSvJcRG3QmurSVOL/C6D8wXrCBpfLKmD73MduYyLR2l7Zs02PFM2
         iMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+/1WEz/eIINIO9NV6nKyzMWSxBJSaO1uT7HM5hfnKEI=;
        b=eDJhGjJMrqK7ANY0hOHEJRYxaDNK9Rq9FuXtM3Ah/mlna9r96JLqp0cyB6iIrlFIxs
         Lod0zzxTiTANsIqoPAmOzyKR+6xEsQGRBGFSaMo3VnBk0o0mR/17QJiHAH9qX+LFCNEj
         NzS/Iw6u/nYVyzc1d9TDl7slFcNJ4pbEXWVE/laYT7Gs7HS+L2p/YsBrT8Irz7G+Vzz2
         QQ9YIA2JNFROUCwmLfALpaO0G6/jiri0rLFwHcUYUAVqfvGR3zD6cCQnPWfBUyZ8db+u
         LHZs6JPXui2LftGaahYOPPb/kJAmEDjyJ205PeWdztrcp8y4KoOYj9dsSVh/EM1CZlv5
         gXQw==
X-Gm-Message-State: APjAAAUwXII8WDRNZd0csjCe4YswPOyFgTrFaY6H7I6Q91MP9tx5dOLy
        fDosVjUJ3ehoWT8byC4xDeIgyCFiUuxItVGhQS3wAXY3
X-Google-Smtp-Source: APXvYqxT6H9z0adNA6fWv66/13qfrxy34L0YY4Gn9mkKdTIm4jKTvbhbDJLg2yydCf6+I1IqYvzWlyH8bvELhTCxpDI=
X-Received: by 2002:a9d:6d10:: with SMTP id o16mr4995397otp.28.1578700464840;
 Fri, 10 Jan 2020 15:54:24 -0800 (PST)
MIME-Version: 1.0
References: <20200110155716.Bluez.v3.1.Ie74d7bb468a914ba7386aae02fc63cd4f529b0ef@changeid>
 <CAPHZWUd0LQrVrWa5jCG2skA8KOORxpBMRBKtYU+n23kVtx27JA@mail.gmail.com> <CAPHZWUdpxVMvth-cobmWriLsJ9=nVrUVtqr-jtMw3kQqZ36syw@mail.gmail.com>
In-Reply-To: <CAPHZWUdpxVMvth-cobmWriLsJ9=nVrUVtqr-jtMw3kQqZ36syw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 10 Jan 2020 15:54:12 -0800
Message-ID: <CABBYNZ+d0R7Q_-a1npxFr7b8SAhwpgG-+p=cSnhG8p1fQqbBXA@mail.gmail.com>
Subject: Re: [Bluez PATCH v3] audio/a2dp - fix crash during recovering process
To:     Yun-hao Chung <howardchung@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
        chromeos-bluetooth-upstreaming@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Fri, Jan 10, 2020 at 12:13 AM Yun-hao Chung <howardchung@google.com> wro=
te:
>
> Hi Luiz,
>
> Thanks for the comment.
> I did the qualification test with and without the patch on both Chrome
> OS and Linux with bluez-5.52.
> The results are all the same.
> The tests I=E2=80=99ve run are as follows.
>
> A2DP/SRC/AS/BV-01-I
> A2DP/SRC/CC/BV-09-I
> A2DP/SRC/CC/BV-10-I
> A2DP/SRC/REL/BV-01-I
> A2DP/SRC/REL/BV-02-I
> A2DP/SRC/SET/BV-01-I
> A2DP/SRC/SET/BV-02-I
> A2DP/SRC/SET/BV-03-I
> A2DP/SRC/SET/BV-04-I
> A2DP/SRC/SET/BV-05-I
> A2DP/SRC/SET/BV-06-I
> IOPT/CL/A2DP-SRC/SFC/BV-01-I
> AVDTP/SRC/ACP/SIG/SMG/BV-06-C
> AVDTP/SRC/ACP/SIG/SMG/BV-08-C
> AVDTP/SRC/ACP/SIG/SMG/BV-10-C
> AVDTP/SRC/ACP/SIG/SMG/BV-16-C
> AVDTP/SRC/ACP/SIG/SMG/BV-18-C
> AVDTP/SRC/ACP/SIG/SMG/BV-20-C
> AVDTP/SRC/ACP/SIG/SMG/BV-24-C
> AVDTP/SRC/ACP/SIG/SMG/BI-05-C
> AVDTP/SRC/ACP/SIG/SMG/BI-08-C
> AVDTP/SRC/ACP/SIG/SMG/BI-17-C
> AVDTP/SRC/ACP/SIG/SMG/BI-20-C
> AVDTP/SRC/ACP/SIG/SMG/BI-23-C
> AVDTP/SRC/ACP/SIG/SMG/BI-28-C*
> AVDTP/SRC/ACP/TRA/BTR/BI-01-C
> AVDTP/SRC/INT/SIG/SMG/BV-05-C
> AVDTP/SRC/INT/SIG/SMG/BV-07-C
> AVDTP/SRC/INT/SIG/SMG/BV-09-C
> AVDTP/SRC/INT/SIG/SMG/BV-15-C
> AVDTP/SRC/INT/SIG/SMG/BV-17-C
> AVDTP/SRC/INT/SIG/SMG/BV-19-C
> AVDTP/SRC/INT/SIG/SMG/BV-23-C
> AVDTP/SRC/INT/SIG/SMG/BV-31-C
> AVDTP/SRC/INT/SIG/SMG/BI-30-C
> AVDTP/SRC/INT/TRA/BTR/BV-01-C
>
> Except for AVDTP/SRC/ACP/SIG/SMG/BI-28-C, the other tests had been passed=
.
> Please let me know if I need more verification.
>
> Thanks,
> Howard
>
> On Fri, Jan 10, 2020 at 4:09 PM Yun-hao Chung <howardchung@google.com> wr=
ote:
> >
> > ---------- Forwarded message ---------
> > From: howardchung@google.com <howardchung@google.com>
> > Date: Fri, Jan 10, 2020 at 3:57 PM
> > Subject: [Bluez PATCH v3] audio/a2dp - fix crash during recovering proc=
ess
> > To: <linux-bluetooth@vger.kernel.org>, <luiz.von.dentz@intel.com>
> > Cc: <chromeos-bluetooth-upstreaming@chromium.org>, howardchung
> > <howardchung@google.com>
> >
> >
> > From: howardchung <howardchung@google.com>
> >
> > The crash with stack trace:
> >
> > (libc-2.27.so -raise.c:51 )                     raise
> > (libc-2.27.so -abort.c:79 )                     abort
> > (libc-2.27.so -libc_fatal.c:181 )               __libc_message
> > (libc-2.27.so -malloc.c:5350 )                  malloc_printerr
> > (libc-2.27.so -malloc.c:4157 )                  _int_free
> > (libglib-2.0.so.0.5200.3 -gslist.c:878 )        g_slist_free_full
> > (bluetoothd -a2dp.c:165 )                       setup_unref
> > (bluetoothd -a2dp.c:2184 )                      a2dp_cancel
> > (bluetoothd -sink.c:317 )                       sink_unregister
> > (bluetoothd -service.c:176 )                    service_remove
> > (bluetoothd -device.c:4678 )                    device_remove
> > (bluetoothd -adapter.c:6573 )                   adapter_remove
> > (bluetoothd -adapter.c:8832 )                   index_removed
> > (bluetoothd -queue.c:220 )                      queue_foreach
> > (bluetoothd -mgmt.c:304 )                       can_read_data
> > (bluetoothd -io-glib.c:170 )                    watch_callback
> > (libglib-2.0.so.0.5200.3 -gmain.c:3234 )        g_main_context_dispatch
> > (libglib-2.0.so.0.5200.3 -gmain.c:3972 )        g_main_context_iterate
> > (libglib-2.0.so.0.5200.3 -gmain.c:4168 )        g_main_loop_run
> > (bluetoothd -main.c:798 )                       main
> > (libc-2.27.so -libc-start.c:308 )               __libc_start_main
> > (bluetoothd + 0x0000b089 )                      _start
> > (bluetoothd + 0x0000b05f )                      _init
> >
> > triggered when 'usb disconnect' happened during AVDTP_SET_CONFIGURATION
> > request is sent but haven't received the response.
> > In this situation, the recovering process goes into sink.c:sink_free an=
d
> > then a2dp.c:a2dp_cancel, avdtp.c:cancel_request, avdtp.c:connection_los=
t,
> > avdtp.c:release_stream.
> >
> > During recovering, the reference count of setup and avdtp decrease more
> > than it increase, which ends up causing the crash.
> >
> > The reference count of setup decreases one more time since
> > a2dp.c:setconf_cfm(called by cfm->set_configuration in
> > avdtp.c:cancel_request) was called in the 'error mode', which didn't
> > reference the setup, but in a2dp.c:abort_cfm(called by cfm->abort in
> > avdtp.c:release_stream), the reference count decreased by 1.
> >
> > In this case, abort_cfm shouldn't be called as we already know
> > setconf_cfm didn't send any request. Setting avdtp_sep_state to
> > AVDTP_STATE_ABORTING should avoid this issue.
> >
> > The reference count of avdtp decrease one more time since
> > both sink.c:sink_free and sink.c:sink_set_state(called from
> > avdtp.c:connection_lost -> avdtp.c:avdtp_set_state) unreference avdtp
> > for the session. The changes in sink.c should avoid the issue.
> >
> > ---
> > How to test:
> >         The crash can be simulated by the following procedure.
> >         1. injecting sleep(10) right before calling a2dp_config in
> >            sink.c:select_complete.
> >         2. connect with a bluetooth headset
> >         3. run 'rmmod btusb' after ~5 seconds(before the connection
> >            complete)
> > The procedure can reproduce the crash with ~50% probability.
> > Even if the bluetoothd didn't crash or it crashed with different
> > signature, the reference count can end up with some invalid number.
> >
> > After the patch applies, there is no crash after running the test above=
 10
> > times in a row.
> >
> > Changes in v3:
> > - Update the title
> > - Remove the signed-off-by section
> >
> > Changes in v2:
> > - Fixed typo in commit message
> >
> >  profiles/audio/avdtp.c | 3 +++
> >  profiles/audio/sink.c  | 4 +++-
> >  2 files changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> > index 51ead684a..620a76c90 100644
> > --- a/profiles/audio/avdtp.c
> > +++ b/profiles/audio/avdtp.c
> > @@ -3484,6 +3484,7 @@ int avdtp_abort(struct avdtp *session, struct
> > avdtp_stream *stream)
> >  {
> >         struct seid_req req;
> >         int ret;
> > +       struct avdtp_local_sep *sep =3D stream->lsep;
> >
> >         if (!stream && session->discover) {
> >                 /* Don't call cb since it being aborted */
> > @@ -3498,6 +3499,8 @@ int avdtp_abort(struct avdtp *session, struct
> > avdtp_stream *stream)
> >         if (stream->lsep->state =3D=3D AVDTP_STATE_ABORTING)
> >                 return -EINVAL;
> >
> > +       avdtp_sep_set_state(session, sep, AVDTP_STATE_ABORTING);
> > +
> >         if (session->req && stream =3D=3D session->req->stream)
> >                 return cancel_request(session, ECANCELED);
> >
> > diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
> > index 7cac21034..726e2f562 100644
> > --- a/profiles/audio/sink.c
> > +++ b/profiles/audio/sink.c
> > @@ -309,8 +309,10 @@ static void sink_free(struct btd_service *service)
> >                 avdtp_stream_remove_cb(sink->session, sink->stream,
> >                                         sink->cb_id);
> >
> > -       if (sink->session)
> > +       if (sink->session) {
> >                 avdtp_unref(sink->session);
> > +               sink->session =3D NULL;
> > +       }
> >
> >         if (sink->connect_id > 0) {
> >                 btd_service_connecting_complete(sink->service, -ECANCEL=
ED);
> > --
> > 2.25.0.rc1.283.g88dfdc4193-goog


Applied, thanks.

--=20
Luiz Augusto von Dentz
