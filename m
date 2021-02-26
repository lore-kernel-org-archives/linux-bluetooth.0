Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FDBC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Feb 2021 21:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55A6C64F1F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Feb 2021 21:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhBZVWz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Feb 2021 16:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbhBZVWz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Feb 2021 16:22:55 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA08AC061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Feb 2021 13:22:14 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id x20so11160992oie.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Feb 2021 13:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zhHIycLRtDNycFxBGkxbacwMa3/oZxn6aW9OFnO7O6I=;
        b=RgS191np9XsTEb/Ar6DfrbOTZHC7SHdnySyi3RBmuCwAGFAlrDDgmggshv4iJzt5SZ
         +HuEekrS6SBGnKqzlF7De6I/U2uTigWUqDPlpNiSIG3eDdvN8PNZGIQHNUqAoE9oZryY
         UR7eW7N3tyuh37EMr0grxbfop352ebkaBW0cFdJJgUssUzm8tgH8MNUPEcSPGhS8aoDW
         UK4/DGDwKEJuSUE2bLKdtD941l/Yccn3+8Rrn6HPwQxuvmg7oMl/L80KJH+Zr7Oe4fph
         pGGnmwwWZM4cpx1FbPmUK8xxSdO1Tk29vg65mgpdgPQ+5xas8oj9yNlmWzD/OpJIOz7d
         q5Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zhHIycLRtDNycFxBGkxbacwMa3/oZxn6aW9OFnO7O6I=;
        b=odpvxSMLGU66/awgYAIiMdgvwIG3A7HvgoZTr12YSVkRBWU0JnsSKY/rIkZQUclVev
         waQGbVkhvpDTzFZ9fO984wPZXx4oOJQ9vHz3o+oIOD4uFVTzBvhuXn0Kqsg3fUQDs0/t
         HRLzVVtC4DycMipmvPl6PRy5o1AVA0onQGLUUXS4EL8uprVB/kbPvi8dohVKAR4ZUs1+
         /auOscvzICY5FuH6+0YYr3diW+gZNPKv6azL2YO15VuSKJT4hg+TlIABTNZfeWIY9mFK
         3ZhPOHQAhTJRyPunfOhsopP/qnXdfO75bU7IjwNuRtSr6xT8fpded5gXUGKcj5ZLFl87
         Rpkg==
X-Gm-Message-State: AOAM5328rtz9QFn+kcYEMCH3p+BQ01TR5HCeylAGh+YBppohRc3vzhR8
        cthxbC62fU7g/58nuuRf1kyY7BYIIxA7Bw9KCk0=
X-Google-Smtp-Source: ABdhPJxsKooA5giIoQbMGzusf2dXLApu2z+wTHqePI39mo6JaEwNQBcxsZkZ3h3Pu2XfDQJsAQnZfV/Ml2jKMjKhoOw=
X-Received: by 2002:aca:c109:: with SMTP id r9mr3467952oif.64.1614374534299;
 Fri, 26 Feb 2021 13:22:14 -0800 (PST)
MIME-Version: 1.0
References: <YDkP07ts5xokM1um@t2b3>
In-Reply-To: <YDkP07ts5xokM1um@t2b3>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 26 Feb 2021 13:22:03 -0800
Message-ID: <CABBYNZLYwS0vgxZHs+=bXZP+KOe05kKwYOQ2jcT1x3MtmQ58wg@mail.gmail.com>
Subject: Re: Bluez 5.56 segfaulting while A2DP
To:     "Tobias S. Predel" <tobias.predel@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tobias,

On Fri, Feb 26, 2021 at 7:17 AM Tobias S. Predel
<tobias.predel@gmail.com> wrote:
>
> Dear all,
>
> I experienced a SEGFAULT from bluez 5.56-1
> on Arch Linux - linux 5.11.1.arch1-1:
>
> It happened during having A2DP connection with pipewire-git 0.3.22.76.g08=
445d2c-1.
>
> This is the backtrace:
>
> # coredumpctl debug
> (gdb) thread apply all bt
>
> Thread 1 (Thread 0x7fb8325f67c0 (LWP 663)):
> #0  0x00007fb832c74f19 in __strcasecmp_l_avx () from /usr/lib/libc.so.6
> #1  0x000055d78e38c3b1 in play_status_to_val (status=3D0x0) at profiles/a=
udio/avrcp.c:729
> #2  0x000055d78e38ce3e in avrcp_player_event (player=3Dplayer@entry=3D0x5=
5d78f058a20, id=3D<optimized out>, data=3Ddata@entry=3D0x0) at profiles/aud=
io/avrcp.c:807
> #3  0x000055d78e38ced6 in avrcp_player_event (data=3D0x0, id=3D<optimized=
 out>, player=3D0x55d78f058a20) at profiles/audio/avrcp.c:783
> #4  notify_addressed_player_changed (user_data=3Duser_data@entry=3D0x55d7=
8f058a20) at profiles/audio/avrcp.c:1804
> #5  0x000055d78e3906ad in avrcp_unregister_player (player=3D0x55d78f058a2=
0) at profiles/audio/avrcp.c:4452

This looks like it is related to AVRCP not A2DP, does pipewire
register a player?

> #6  0x000055d78e3830c8 in media_player_remove (data=3D0x55d78f050ff0) at =
profiles/audio/media.c:1052
> #7  unregister_player (conn=3D<optimized out>, msg=3D0x55d78f0079d0, data=
=3D<optimized out>) at profiles/audio/media.c:1902
> #8  0x000055d78e404fe9 in process_message (connection=3D0x55d78f005e00, m=
essage=3D0x55d78f0079d0, method=3D0x55d78e47b778 <media_methods+120>, iface=
_user_data=3D<optimized out>) at gdbus/object.c:246
> #9  0x00007fb832df17d6 in ?? () from /usr/lib/libdbus-1.so.3
> #10 0x00007fb832de13bd in dbus_connection_dispatch () from /usr/lib/libdb=
us-1.so.3
> #11 0x000055d78e401681 in message_dispatch (data=3D0x55d78f005e00) at gdb=
us/mainloop.c:59
> #12 0x00007fb832e72b84 in g_main_context_dispatch () from /usr/lib/libgli=
b-2.0.so.0
> #13 0x00007fb832ec6c21 in ?? () from /usr/lib/libglib-2.0.so.0
> #14 0x00007fb832e720d3 in g_main_loop_run () from /usr/lib/libglib-2.0.so=
.0
> #15 0x000055d78e41acc6 in mainloop_run () at src/shared/mainloop-glib.c:6=
6
> #16 0x000055d78e41b148 in mainloop_run_with_signal (func=3Dfunc@entry=3D0=
x55d78e3acf70 <signal_callback>, user_data=3Duser_data@entry=3D0x0) at src/=
shared/mainloop-notify.c:188
> #17 0x000055d78e36fac0 in main (argc=3D<optimized out>, argv=3D<optimized=
 out>) at src/main.c:1084
>
> Regards,
> Tobias Predel
> --
> La perfection est atteinte, non pas lorsqu'il n'y a plus rien =C3=A0 ajou=
ter,
> mais lorsqu'il n'y a plus rien =C3=A0 retirer. =E2=80=94 Antoine de Saint=
-Exup=C3=A9ry



--=20
Luiz Augusto von Dentz
