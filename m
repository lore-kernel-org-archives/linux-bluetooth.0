Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8836C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 08:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7D756115A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 08:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237689AbhJFIzA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Oct 2021 04:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237593AbhJFIy7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Oct 2021 04:54:59 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8877EC061749
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Oct 2021 01:53:07 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t8so6590583wri.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Oct 2021 01:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bEeWzZefLLHSp+gGHKPbji9DDe5EAyLRbjYqIMeUUAw=;
        b=BAqWa/hEUGrC+a71eTJTvgbn2znt1KPNnXI4mg1wXf9XIzSCBRG4AZ4hzgiy6F4h4d
         UGwvK0uXM6RnjZf+BSz9ROH5ivFRaf5EoADUiA9npWvMa214tSEJTZeCly15A5IIzsRW
         xF8fxsmfTCuKa5dlHJF1fsekuRgMLUA7AmpCYBQJxOAKaMupH0Ek8/kASpOsGxr1esn+
         PtKBAJV2YpLUVak/TJfcNHxhQBSQcjlHmBlx/2iX8JnfcPfrN90Ja6JntZ5LfQMdZxW/
         hQvH41cBTpDm8vcbqV3OY4Yc/GHsX5QaMP+wO/o4hcQzNGZJgWXOnvPzrX9U0flVpmoa
         1OrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bEeWzZefLLHSp+gGHKPbji9DDe5EAyLRbjYqIMeUUAw=;
        b=Tl/E0mh6jJZDXLU64SK2b4fBpSXqTvg1Y+uouu5qK3Mqur8Dq9kSw2UnlUWUGA+skV
         lOraH73StIQ9ZkzBN1q0uwWMnl9DwYU7mtdIdxRwn19MEuSzyXJ6z9oHtFzb/USTJQRa
         WNCICv8AMTdpf1+tMRAXXjYlv6XYywqUnhMoWToP5WInJJM9fLdCsqSez8VH8J9weSta
         9ClVyKZ3m5eDbBajerb9bdGa6NN2fN9rEKy8XX/jOPNneIp1JIi2o+hQ8fG+bD2UZbrg
         BM4wl8GzEvJd09DjGF0so1PZj7OP/qBfmcME84Sg1Fo1UVn9blJbi4esOIkLkvDCDvvw
         gT2w==
X-Gm-Message-State: AOAM531XtvzNuOeb22/YUs2W285DWu6W/RHU2AP19gvxkWK9i8tq70PQ
        RTKAtmgLBfV0AOQ4qKP77RRTFqGrhhnST+xVMrc=
X-Google-Smtp-Source: ABdhPJxdKKe7/eSikMdcPXLMc1aORSoLoHk5Nx53k9V/yiXiRBMSmmp783w4EJqC3f+pIX3H569b3ggXCf6Gsm3dxic=
X-Received: by 2002:a7b:ce83:: with SMTP id q3mr8392445wmj.103.1633510386079;
 Wed, 06 Oct 2021 01:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <CA+6+gU=AEHhnEwVq=RyOKemRjZM_zHLmCZKkGO+aUKCaaQVOhA@mail.gmail.com>
 <CABBYNZLps0q-UzEffiQeLvHGyZ4iiiwJ-CaBe__8LMi=7P+xNQ@mail.gmail.com>
 <CA+6+gU=ViFQMud3uv+ymaP-j79Eu2gNfDaNgKnvCfM1JkqUiBw@mail.gmail.com> <CABBYNZLanVFd3=QutQvzNnN58z4kYiGw29gUG_TMuFaG_A339w@mail.gmail.com>
In-Reply-To: <CABBYNZLanVFd3=QutQvzNnN58z4kYiGw29gUG_TMuFaG_A339w@mail.gmail.com>
From:   Thomas Eriksson <thomas.eriksson@gmail.com>
Date:   Wed, 6 Oct 2021 10:52:54 +0200
Message-ID: <CA+6+gUkHdyWZwK5LaxPAtn5u=BW7WAuCKx04HSJn=CKV0Rwrbw@mail.gmail.com>
Subject: Re: Null dereference in profiles/audio/avrcp.c
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000004cb42c05cdab46f4"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--0000000000004cb42c05cdab46f4
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Oct 2021 at 08:53, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Thomas,
>
Hi Luiz,

> On Tue, Oct 5, 2021 at 11:38 PM Thomas Eriksson
> <thomas.eriksson@gmail.com> wrote:
> >
> > On Tue, 5 Oct 2021 at 20:37, Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Thomas,
> >
> > Hi Luiz,
> >
> > >
> > > On Tue, Oct 5, 2021 at 1:55 AM Thomas Eriksson
> > > <thomas.eriksson@gmail.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > When trying to pair my "3M Peltor WS Alert XPI" headset with Bluez i
> > > > get a null dereference in profiles/audio/avrcp.c.
> > > >
> > > > The following small patch avoids the problem:
> > > >
> > > > diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> > > > index 7c280203c..6064ab40b 100644
> > > > --- a/profiles/audio/avrcp.c
> > > > +++ b/profiles/audio/avrcp.c
> > > > @@ -3740,10 +3740,13 @@ static void avrcp_status_changed(struct avrcp *session,
> > > >                                                 struct avrcp_header *pdu)
> > > >  {
> > > >         struct avrcp_player *player = session->controller->player;
> > > > -       struct media_player *mp = player->user_data;
> > > > +       struct media_player *mp = NULL;
> > > >         uint8_t value;
> > > >         const char *curval, *strval;
> > > >
> > > > +       if (player == NULL)
> > > > +               return;
> > > > +       mp = player->user_data;
> > > >         value = pdu->params[1];
> > > >
> > > >         curval = media_player_get_status(mp);
> > > >
> > >
> > > What version are you using? This should not be reproducible with:
> > >
> > > commit cc235a8d528b36cad2cf9fe6517d54711613331a
> > > Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > Date:   Fri Apr 1 11:07:15 2016 +0300
> > >
> > >     audio/avrcp: Fix registering to player events
> > >
> > >     If controller does not have a player skip registering to events which
> > >     requires a player.
> > >
> > > diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> > > index 0c6279a20..37bc29137 100644
> > > --- a/profiles/audio/avrcp.c
> > > +++ b/profiles/audio/avrcp.c
> > > @@ -3647,8 +3647,9 @@ static gboolean
> > > avrcp_get_capabilities_resp(struct avctp *conn,
> > >                 case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
> > >                 case AVRCP_EVENT_UIDS_CHANGED:
> > >                 case AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED:
> > > -                       /* These events above are controller specific */
> > > -                       if (!session->controller)
> > > +                       /* These events above requires a player */
> > > +                       if (!session->controller ||
> > > +                                               !session->controller->player)
> > >                                 break;
> > >                 case AVRCP_EVENT_VOLUME_CHANGED:
> > >                         avrcp_register_notification(session, event);
> > >
> >
> > The crash was present yesterday on
> > bb12ef4a9f71550ba84033f565a27773d893d8bf (master).
>
> Can you attach the HCI trace, I wonder if the headset is sending a
> notification without a registration then.

I've attached a HCI trace of the pairing process.

Best regards
/Thomas



>
> >
> > > >
> > > > Below is the backtrace from GDB:
> > > >
> > > > GNU gdb (Debian 10.1-2) 10.1.90.20210103-git
> > > > Copyright (C) 2021 Free Software Foundation, Inc.
> > > > License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
> > > > This is free software: you are free to change and redistribute it.
> > > > There is NO WARRANTY, to the extent permitted by law.
> > > > Type "show copying" and "show warranty" for details.
> > > > This GDB was configured as "x86_64-linux-gnu".
> > > > Type "show configuration" for configuration details.
> > > > For bug reporting instructions, please see:
> > > > <https://www.gnu.org/software/gdb/bugs/>.
> > > > Find the GDB manual and other documentation resources online at:
> > > >     <http://www.gnu.org/software/gdb/documentation/>.
> > > >
> > > > For help, type "help".
> > > > Type "apropos word" to search for commands related to "word"...
> > > > Reading symbols from /usr/local/libexec/bluetooth/bluetoothd...
> > > > (gdb) run
> > > > Starting program: /usr/local/libexec/bluetooth/bluetoothd
> > > > [Thread debugging using libthread_db enabled]
> > > > Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
> > > >
> > > >
> > > >
> > > > Program received signal SIGSEGV, Segmentation fault.
> > > > 0x0000555555594f14 in avrcp_status_changed (pdu=0x5555556d1b36,
> > > > pdu=0x5555556d1b36, session=0x5555556a9800) at
> > > > profiles/audio/avrcp.c:3743
> > > > 3743 struct media_player *mp = player->user_data;
> > > > (gdb)
> > > > (gdb)
> > > > (gdb) bt
> > > > #0  0x0000555555594f14 in avrcp_status_changed (pdu=0x5555556d1b36,
> > > > pdu=0x5555556d1b36, session=0x5555556a9800) at
> > > > profiles/audio/avrcp.c:3743
> > > > #1  avrcp_handle_event (conn=0x5555556c98e0, code=15 '\017',
> > > > subunit=<optimized out>, transaction=<optimized out>,
> > > > operands=0x5555556d1b36 "", operand_count=9, user_data=0x5555556a9800)
> > > >     at profiles/audio/avrcp.c:3884
> > > > #2  0x000055555558f3c7 in control_response (operand_count=9,
> > > > operands=0x5555556d1b36 "", avc=<optimized out>, avctp=<optimized
> > > > out>, control=<optimized out>) at profiles/audio/avctp.c:938
> > > > #3  session_cb (chan=<optimized out>, cond=<optimized out>,
> > > > data=<optimized out>) at profiles/audio/avctp.c:1107
> > > > #4  0x00007ffff7ebdc0f in g_main_context_dispatch () from
> > > > /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
> > > > #5  0x00007ffff7ebdfb8 in ?? () from /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
> > > > #6  0x00007ffff7ebe2ab in g_main_loop_run () from
> > > > /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
> > > > #7  0x0000555555617415 in mainloop_run () at src/shared/mainloop-glib.c:66
> > > > #8  0x00005555556177f2 in mainloop_run_with_signal
> > > > (func=func@entry=0x5555555af8d0 <signal_callback>,
> > > > user_data=user_data@entry=0x0) at src/shared/mainloop-notify.c:188
> > > > #9  0x0000555555577147 in main (argc=<optimized out>, argv=<optimized
> > > > out>) at src/main.c:1210
> > > >
> > > >
> > > > Best regards
> > > > /Thomas Eriksson
> > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz

--0000000000004cb42c05cdab46f4
Content-Type: application/octet-stream; name="hcitrace3.snoop.xz"
Content-Disposition: attachment; filename="hcitrace3.snoop.xz"
Content-Transfer-Encoding: base64
Content-ID: <f_kuf8wiru0>
X-Attachment-Id: f_kuf8wiru0

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
sQABtFGE/gUANuhr57HEZ/sCAAAAAARZWg==
--0000000000004cb42c05cdab46f4--
