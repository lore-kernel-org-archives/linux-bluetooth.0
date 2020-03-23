Return-Path: <SRS0=apyX=5I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891BCC54FCE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Mar 2020 16:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A96220722
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Mar 2020 16:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xen3z2sW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgCWQjJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:39:09 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38029 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbgCWQjI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Mar 2020 12:39:08 -0400
Received: by mail-oi1-f196.google.com with SMTP id w2so4377383oic.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Mar 2020 09:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g0eg5t3GBi8KtBnXG2IsYdEe2EPR+paREKVnwwhDlPk=;
        b=Xen3z2sWGBycoS8ZpUCyi3AmQ6K9gsD7bXb+BK3jFdCQo5rXOXHf31YapcYfesJwwm
         W1x754WmQGNxugjPYJOp52SuE6ZlQA0r3Q5VnZRdy0j2zHRgi5cxITz3YnhCP2NE0a1Y
         CuAOgkL/KMiVPqkQV6UKh7GPaA/VIDhR/FnBy3TYdWuaMragkPvCjfQVdDR4wzFXb0KZ
         9kh4XM1iWo54GVus9u50ORIttxpdgCDhZtolS6OBU4o9t3XWvqPUwMimK4gdGlBU20aG
         XowuG/fooDwE6a2Ajlqew4qnrt7owwA2RbZSjcMF8i9QJUlQtqdNsJrjGGLnbLnX5Pci
         uOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g0eg5t3GBi8KtBnXG2IsYdEe2EPR+paREKVnwwhDlPk=;
        b=gSL0C9DXSJR2AoD5AWk7zuefrU+4ICB3tmCNJa/eVHyZ9CYmSwejSvKc9iBZ6qTAOU
         lwjcPZaHbfDAg/Pqbwe8OkKZQkvkFhZadQniCzaO2EZ+4+BzQAKngYjaPXCAmuUEJtfG
         SFY3SKN8xVbFtYpuCcWRnJDGI5kqHdnY4EE7Hwaw8mvXEBBRZ+IdVjsPbNZRyckt9hgq
         WQ/Msd3CwfIV3KXkGyFv/3EEccQ68OVbpxtKgQQryE6MO4j5zuQ/5k7/Dxsh2/Yz14OW
         T98Rv59Wbj+yEMzPuH2bRVaf2lQ1M0IAdAYkIt2EHLxliDorUO4yyrsvXx6Efl8rgD1L
         BD/Q==
X-Gm-Message-State: ANhLgQ1mR4au8Sbim03+l2o+YPtz3U7Gkk9byysu4ZvZsKBSd7UnIBNp
        QSApbnoWhRoBRmqyES0AWvkhHcJiYjXg6q9lgWA=
X-Google-Smtp-Source: ADFU+vuR+gfeV4OivuCS5TmnkiNTfTp18NXmVpphlMHdjiJddRoWsY30cZo2YZ/h1emUhkppHt3TuJm3EGdQH496MR8=
X-Received: by 2002:aca:b602:: with SMTP id g2mr161513oif.82.1584981547784;
 Mon, 23 Mar 2020 09:39:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200305185904.Bluez.v1.1.I6c78c0eb9826eb17c944c4903132ee75c1324136@changeid>
 <CABBYNZLPDqsoPSPKz=X9LEDJvq9Lb0r7jXDS_BCi5d57dNXi5A@mail.gmail.com> <CAPHZWUcg1p=WQ=Py6WWNSsOX6cFLT6X1uCk_Wy=v7_4hqG0+WA@mail.gmail.com>
In-Reply-To: <CAPHZWUcg1p=WQ=Py6WWNSsOX6cFLT6X1uCk_Wy=v7_4hqG0+WA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 23 Mar 2020 09:38:56 -0700
Message-ID: <CABBYNZLcZmg7tNH11F+8a4At_W-XQMZci1AJy8TjU_xTrA7yTA@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] avdtp: Fix crashes in avdtp_abort
To:     Yun-hao Chung <howardchung@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

On Mon, Mar 23, 2020 at 2:43 AM Yun-hao Chung <howardchung@google.com> wrot=
e:
>
> Hi Luiz,
>
> I can trigger the crash by running a connect disconnect loop. What I've f=
ound is that crashes always happened when sep is assigned to stream->lsep b=
ut stream is NULL. If I apply the change above, there are no such crashes a=
nymore. So I'm still believing it is caused by stream being NULL instead of=
 stream->lsep being NULL. Do I miss something?
>
> One thing to add:
> Perhaps it would be more clear if we use stream->lsep directly when calli=
ng avdtp_sep_set_state.
>
> Here is the stack trace:
>
> Crash reason:  SIGSEGV /0x00000000
> Crash address: 0x18
> Process uptime: not available
>
> Thread 0 (crashed)
>  0  bluetoothd!avdtp_abort [avdtp.c : 3487 + 0x0]
>  1  bluetoothd!a2dp_cancel [a2dp.c : 2180 + 0x5]
>  2  bluetoothd!sink_disconnect [sink.c : 404 + 0x5]
>  3  bluetoothd!btd_service_disconnect [service.c : 293 + 0x5]
>  4  libglib-2.0.so.0!g_list_foreach [glist.c : 1013 + 0x6]
>  5  bluetoothd!device_request_disconnect [device.c : 1500 + 0xe]
>  6  bluetoothd!dev_disconnect [device.c : 1652 + 0xb]
>  7  bluetoothd!generic_message [object.c : 259 + 0x8]
>  8  libdbus-1.so.3!_dbus_object_tree_dispatch_and_unlock [dbus-object-tre=
e.c : 1020 + 0x5]
>  9  libdbus-1.so.3!dbus_connection_dispatch [dbus-connection.c : 4750 + 0=
x8]
> 10  bluetoothd!message_dispatch [mainloop.c : 72 + 0x8]
> 11  libglib-2.0.so.0!g_main_context_dispatch [gmain.c : 3182 + 0x2]
> 12  libglib-2.0.so.0!g_main_context_iterate [gmain.c : 3920 + 0x8]
> 13  libglib-2.0.so.0!g_main_loop_run [gmain.c : 4116 + 0xf]
> 14  bluetoothd!main [main.c : 800 + 0x5]
> 15  libc.so.6!__libc_start_main [libc-start.c : 308 + 0x1a]
> 16  bluetoothd!_start + 0x2a

I see so the setup->stream is stil NULL in this case so trying to
access stream->lsep will fail.

>
> Thanks,
> Howard
>
> On Fri, Mar 6, 2020 at 3:17 AM Luiz Augusto von Dentz <luiz.dentz@gmail.c=
om> wrote:
>>
>> Hi Howard,
>>
>> On Thu, Mar 5, 2020 at 3:06 AM Howard Chung <howardchung@google.com> wro=
te:
>> >
>> > Initialized avdtp_local_sep later since stream could be NULL.
>> > ---
>> >
>> >  profiles/audio/avdtp.c | 3 ++-
>> >  1 file changed, 2 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
>> > index 0e075f9ff..12d984866 100644
>> > --- a/profiles/audio/avdtp.c
>> > +++ b/profiles/audio/avdtp.c
>> > @@ -3566,7 +3566,7 @@ int avdtp_abort(struct avdtp *session, struct av=
dtp_stream *stream)
>> >  {
>> >         struct seid_req req;
>> >         int ret;
>> > -       struct avdtp_local_sep *sep =3D stream->lsep;
>> > +       struct avdtp_local_sep *sep;

Lets just remove this variable for here.

>> >         if (!stream && session->discover) {
>> >                 /* Don't call cb since it being aborted */
>> > @@ -3581,6 +3581,7 @@ int avdtp_abort(struct avdtp *session, struct av=
dtp_stream *stream)
>> >         if (stream->lsep->state =3D=3D AVDTP_STATE_ABORTING)
>> >                 return -EINVAL;
>>
>> I suspect there i something else going on then just the lsep being
>> NULL since we do check it on the line above it would have crashed
>> anyway, is this perhaps the result of lsep being unregistered before
>> the avdtp_abort is called?
>>
>> > +       sep =3D stream->lsep;
>> >         avdtp_sep_set_state(session, sep, AVDTP_STATE_ABORTING);

Just use stream->lsep here since at this point we already verified
that stream !=3D NULL and even attempted to read its state.

>> >
>> >         if (session->req && stream =3D=3D session->req->stream)
>> > --
>> > 2.25.0.265.gbab2e86ba0-goog
>> >
>>
>>
>> --
>> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
