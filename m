Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BCAC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 06:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69297611CA
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 06:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236878AbhJFGkk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Oct 2021 02:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235862AbhJFGkf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Oct 2021 02:40:35 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD91C061749
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Oct 2021 23:38:43 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j8so5386457wro.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Oct 2021 23:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oj924221D/6q8tU2QGWwvD7EhhJmOtHMdQq9lT1M4qY=;
        b=JkEHYvttDcAHVnfK2qGj9kjnnniyteSJz0v85WKJVepqoNxY7tEJhEcwGBQqw0/yXJ
         nfq2wk/pJzrLcYkcZHaCleVkExwOy8jtHN4QnfdmU34K0HVbuR7DXfRQyHF7cC6qU+o8
         eYclXESt01jcE1kq+bGRbC4ChN6a2ezD6gEdTAauW9S/XeC5zgYYrpg792Hm4YCs8vOk
         nZ7Yc3Qzz4JLUQrhXXWGMoBQ8h0KYI3nKBHlrSLmCwtDyAJmWPmL9bAewkq+KoRF3Xzx
         Eqrx6nFY2gekZ1RMryBCtczGhCWSuT4txJq4zTARnAPQ+AH0DBCGyvwArJv2RuW9O6Gm
         TtYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oj924221D/6q8tU2QGWwvD7EhhJmOtHMdQq9lT1M4qY=;
        b=Y0VFFdHhCQsacDjXnQJQ/HUh5CK9ksz60k+SxuL48qPWEqifXIRPwZX9eVqCOg9IDi
         HgbAH6r8r6mMeFSIHFyOGUN/jhFdHSxfTNE93sNNfsYOmaTtcn4iv1VW6nO1fSqKB1mG
         14MwG7aXav7ddOFcSe0OaOaBG4ADOU3IRdaccvZhVej3+xK8169RuVhctydzT0YKRcHX
         8neeqdqtAxQNYbAkGT/s2Y+v3ch0zRghDUNi/CFDldbG04ZvJ8ctOh1P+Oq6vG0uyWsP
         hLtpLZENE9YSLRZ7cJRQ3XAI2HQx2L69XuaWw2wX8aTdjpKPFcecBmnUnEVjI0/dlBpf
         PGSQ==
X-Gm-Message-State: AOAM530zQEWTNRSb78ahYN+8u2MKyDTbVK+dcadiEvTk4X81R6uuLjVj
        +OtUqH044gqv3LUpe5RIfW2joig0RzNtxPh1awKsD3tbZF8=
X-Google-Smtp-Source: ABdhPJwA2AyAzjM1CcWrELeoH6mFRZYR/2/FxOBakgJfK1iCxBAqCHqLqDO9CZ/SoTi9TlFsvq0Ul89r/RN/cqycGKo=
X-Received: by 2002:a05:600c:240a:: with SMTP id 10mr7882545wmp.170.1633502322139;
 Tue, 05 Oct 2021 23:38:42 -0700 (PDT)
MIME-Version: 1.0
References: <CA+6+gU=AEHhnEwVq=RyOKemRjZM_zHLmCZKkGO+aUKCaaQVOhA@mail.gmail.com>
 <CABBYNZLps0q-UzEffiQeLvHGyZ4iiiwJ-CaBe__8LMi=7P+xNQ@mail.gmail.com>
In-Reply-To: <CABBYNZLps0q-UzEffiQeLvHGyZ4iiiwJ-CaBe__8LMi=7P+xNQ@mail.gmail.com>
From:   Thomas Eriksson <thomas.eriksson@gmail.com>
Date:   Wed, 6 Oct 2021 08:38:31 +0200
Message-ID: <CA+6+gU=ViFQMud3uv+ymaP-j79Eu2gNfDaNgKnvCfM1JkqUiBw@mail.gmail.com>
Subject: Re: Null dereference in profiles/audio/avrcp.c
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, 5 Oct 2021 at 20:37, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Thomas,

Hi Luiz,

>
> On Tue, Oct 5, 2021 at 1:55 AM Thomas Eriksson
> <thomas.eriksson@gmail.com> wrote:
> >
> > Hi,
> >
> > When trying to pair my "3M Peltor WS Alert XPI" headset with Bluez i
> > get a null dereference in profiles/audio/avrcp.c.
> >
> > The following small patch avoids the problem:
> >
> > diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> > index 7c280203c..6064ab40b 100644
> > --- a/profiles/audio/avrcp.c
> > +++ b/profiles/audio/avrcp.c
> > @@ -3740,10 +3740,13 @@ static void avrcp_status_changed(struct avrcp *session,
> >                                                 struct avrcp_header *pdu)
> >  {
> >         struct avrcp_player *player = session->controller->player;
> > -       struct media_player *mp = player->user_data;
> > +       struct media_player *mp = NULL;
> >         uint8_t value;
> >         const char *curval, *strval;
> >
> > +       if (player == NULL)
> > +               return;
> > +       mp = player->user_data;
> >         value = pdu->params[1];
> >
> >         curval = media_player_get_status(mp);
> >
>
> What version are you using? This should not be reproducible with:
>
> commit cc235a8d528b36cad2cf9fe6517d54711613331a
> Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Date:   Fri Apr 1 11:07:15 2016 +0300
>
>     audio/avrcp: Fix registering to player events
>
>     If controller does not have a player skip registering to events which
>     requires a player.
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 0c6279a20..37bc29137 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -3647,8 +3647,9 @@ static gboolean
> avrcp_get_capabilities_resp(struct avctp *conn,
>                 case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
>                 case AVRCP_EVENT_UIDS_CHANGED:
>                 case AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED:
> -                       /* These events above are controller specific */
> -                       if (!session->controller)
> +                       /* These events above requires a player */
> +                       if (!session->controller ||
> +                                               !session->controller->player)
>                                 break;
>                 case AVRCP_EVENT_VOLUME_CHANGED:
>                         avrcp_register_notification(session, event);
>

The crash was present yesterday on
bb12ef4a9f71550ba84033f565a27773d893d8bf (master).


> >
> > Below is the backtrace from GDB:
> >
> > GNU gdb (Debian 10.1-2) 10.1.90.20210103-git
> > Copyright (C) 2021 Free Software Foundation, Inc.
> > License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
> > This is free software: you are free to change and redistribute it.
> > There is NO WARRANTY, to the extent permitted by law.
> > Type "show copying" and "show warranty" for details.
> > This GDB was configured as "x86_64-linux-gnu".
> > Type "show configuration" for configuration details.
> > For bug reporting instructions, please see:
> > <https://www.gnu.org/software/gdb/bugs/>.
> > Find the GDB manual and other documentation resources online at:
> >     <http://www.gnu.org/software/gdb/documentation/>.
> >
> > For help, type "help".
> > Type "apropos word" to search for commands related to "word"...
> > Reading symbols from /usr/local/libexec/bluetooth/bluetoothd...
> > (gdb) run
> > Starting program: /usr/local/libexec/bluetooth/bluetoothd
> > [Thread debugging using libthread_db enabled]
> > Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
> >
> >
> >
> > Program received signal SIGSEGV, Segmentation fault.
> > 0x0000555555594f14 in avrcp_status_changed (pdu=0x5555556d1b36,
> > pdu=0x5555556d1b36, session=0x5555556a9800) at
> > profiles/audio/avrcp.c:3743
> > 3743 struct media_player *mp = player->user_data;
> > (gdb)
> > (gdb)
> > (gdb) bt
> > #0  0x0000555555594f14 in avrcp_status_changed (pdu=0x5555556d1b36,
> > pdu=0x5555556d1b36, session=0x5555556a9800) at
> > profiles/audio/avrcp.c:3743
> > #1  avrcp_handle_event (conn=0x5555556c98e0, code=15 '\017',
> > subunit=<optimized out>, transaction=<optimized out>,
> > operands=0x5555556d1b36 "", operand_count=9, user_data=0x5555556a9800)
> >     at profiles/audio/avrcp.c:3884
> > #2  0x000055555558f3c7 in control_response (operand_count=9,
> > operands=0x5555556d1b36 "", avc=<optimized out>, avctp=<optimized
> > out>, control=<optimized out>) at profiles/audio/avctp.c:938
> > #3  session_cb (chan=<optimized out>, cond=<optimized out>,
> > data=<optimized out>) at profiles/audio/avctp.c:1107
> > #4  0x00007ffff7ebdc0f in g_main_context_dispatch () from
> > /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
> > #5  0x00007ffff7ebdfb8 in ?? () from /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
> > #6  0x00007ffff7ebe2ab in g_main_loop_run () from
> > /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
> > #7  0x0000555555617415 in mainloop_run () at src/shared/mainloop-glib.c:66
> > #8  0x00005555556177f2 in mainloop_run_with_signal
> > (func=func@entry=0x5555555af8d0 <signal_callback>,
> > user_data=user_data@entry=0x0) at src/shared/mainloop-notify.c:188
> > #9  0x0000555555577147 in main (argc=<optimized out>, argv=<optimized
> > out>) at src/main.c:1210
> >
> >
> > Best regards
> > /Thomas Eriksson
>
>
>
> --
> Luiz Augusto von Dentz
