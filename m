Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11339C433DB
	for <linux-bluetooth@archiver.kernel.org>; Sat, 27 Feb 2021 08:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C59BD64EC0
	for <linux-bluetooth@archiver.kernel.org>; Sat, 27 Feb 2021 08:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhB0IyG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 27 Feb 2021 03:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhB0IyG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 27 Feb 2021 03:54:06 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9DEC06174A
        for <linux-bluetooth@vger.kernel.org>; Sat, 27 Feb 2021 00:53:25 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id do6so18703293ejc.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 27 Feb 2021 00:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nWccv7VoVApd0xwkIcfY5vt/aWqE+TVMbP3N4HxRCns=;
        b=MBK1R5MTkrKBQuWzKABOy8evELDOS3TIy1XxcQK1aFa7u3IOm3vJNwCkzU9HhHMqG5
         pag4HN0KkPJIy8isI6HrnEpgd3Y5MqmAaKKGhcMgaXZpHMn9ZRwJrhATY4jWMKSqBkPX
         XZMtVKRjKWpy9W/T7YJ4VvxcOO0MnutEgZeL0nTR8I+q2wyFOaoQvpIpab7d9XC3TMLZ
         gnGtR5XSwMv68pp5kVowygI6JUHL8w4eXQdpMKLjz2RehgVlzJtVLZwpS6KCiGUOGIRX
         7tEj+zDYLBXEn+fJGPQegCjlk8w0wPFLjX8XAbBF84qoHwtqTNBoCUPikqOmEUzPv41U
         DHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nWccv7VoVApd0xwkIcfY5vt/aWqE+TVMbP3N4HxRCns=;
        b=nGNKmWYgoxD2GUQ7D9Sw+345LqV89mLOM2lNOTuvBKzbhID2CwPicsNf7W+obFZLZo
         XJ1ncXWQl57HG1OanmY0NFTAVjwNTYi4En9zcv+uhSeC+A1Bv+nJD3yj3PdOtkQo2Dn6
         ewXslgPLcgIsd9ztl2uoUxicn+ipjqKVX4DgW7x+51oO8CnIbhTQTvW6mRYHtJqnCCyN
         yAcSLrQjCAbLji87B2VofT6RWaf2LqgblzYi6ChniWSD6hWtJK4hC3q7Co/yHDC1iOUV
         Adxv5w4oBXRY7y0mqbAi4OHmIeUzgq9v689YAFlB79dk6gjT83unuG+OzmtL1kazoXt9
         FbVQ==
X-Gm-Message-State: AOAM5307EX5MQ5b33jNTe6DScXBLJCUUxR2XQhuFJ+l3pM3/n7vGAc9C
        wPOHOzLpEscnPilVY2+dJvkeg8kPLG5rkw==
X-Google-Smtp-Source: ABdhPJzOwRnLW2SKDI4vZQpU8fYxki9r425pRzeJ9oLh6r6u+DD2XtcVEJ8g8kgmLykcro8pKjLmcQ==
X-Received: by 2002:a17:906:3883:: with SMTP id q3mr7123612ejd.160.1614416004031;
        Sat, 27 Feb 2021 00:53:24 -0800 (PST)
Received: from t2b3 ([194.140.115.59])
        by smtp.gmail.com with ESMTPSA id c13sm2117007eje.37.2021.02.27.00.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Feb 2021 00:53:23 -0800 (PST)
Date:   Sat, 27 Feb 2021 09:53:20 +0100
From:   "Tobias S. Predel" <tobias.predel@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Bluez 5.56 segfaulting while A2DP
Message-ID: <YDoIgF+WGDhA30UY@t2b3>
References: <YDkP07ts5xokM1um@t2b3>
 <CABBYNZLYwS0vgxZHs+=bXZP+KOe05kKwYOQ2jcT1x3MtmQ58wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZLYwS0vgxZHs+=bXZP+KOe05kKwYOQ2jcT1x3MtmQ58wg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Thanks for your reply!

This is beyond my knowledge. By guessing I looked into the D-Bus system-
in the system bus, so if you mean under org.bluez
/org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/org.bluez.MediaControl1/Player,
that property is not set, so I think there is no registration.

I would come back to you and this issue if I experienced another time.
I changed something, deactivated the MPRIS proxy systemd service.

Regards,
Tobias

Luiz Augusto von Dentz <luiz.dentz@gmail.com> schrieb / wrote / a écrit / ha escrito / je pisao / је писао: 

> Hi Tobias,
> 
> On Fri, Feb 26, 2021 at 7:17 AM Tobias S. Predel
> <tobias.predel@gmail.com> wrote:
> >
> > Dear all,
> >
> > I experienced a SEGFAULT from bluez 5.56-1
> > on Arch Linux - linux 5.11.1.arch1-1:
> >
> > It happened during having A2DP connection with pipewire-git 0.3.22.76.g08445d2c-1.
> >
> > This is the backtrace:
> >
> > # coredumpctl debug
> > (gdb) thread apply all bt
> >
> > Thread 1 (Thread 0x7fb8325f67c0 (LWP 663)):
> > #0  0x00007fb832c74f19 in __strcasecmp_l_avx () from /usr/lib/libc.so.6
> > #1  0x000055d78e38c3b1 in play_status_to_val (status=0x0) at profiles/audio/avrcp.c:729
> > #2  0x000055d78e38ce3e in avrcp_player_event (player=player@entry=0x55d78f058a20, id=<optimized out>, data=data@entry=0x0) at profiles/audio/avrcp.c:807
> > #3  0x000055d78e38ced6 in avrcp_player_event (data=0x0, id=<optimized out>, player=0x55d78f058a20) at profiles/audio/avrcp.c:783
> > #4  notify_addressed_player_changed (user_data=user_data@entry=0x55d78f058a20) at profiles/audio/avrcp.c:1804
> > #5  0x000055d78e3906ad in avrcp_unregister_player (player=0x55d78f058a20) at profiles/audio/avrcp.c:4452
> 
> This looks like it is related to AVRCP not A2DP, does pipewire
> register a player?
> 
> > #6  0x000055d78e3830c8 in media_player_remove (data=0x55d78f050ff0) at profiles/audio/media.c:1052
> > #7  unregister_player (conn=<optimized out>, msg=0x55d78f0079d0, data=<optimized out>) at profiles/audio/media.c:1902
> > #8  0x000055d78e404fe9 in process_message (connection=0x55d78f005e00, message=0x55d78f0079d0, method=0x55d78e47b778 <media_methods+120>, iface_user_data=<optimized out>) at gdbus/object.c:246
> > #9  0x00007fb832df17d6 in ?? () from /usr/lib/libdbus-1.so.3
> > #10 0x00007fb832de13bd in dbus_connection_dispatch () from /usr/lib/libdbus-1.so.3
> > #11 0x000055d78e401681 in message_dispatch (data=0x55d78f005e00) at gdbus/mainloop.c:59
> > #12 0x00007fb832e72b84 in g_main_context_dispatch () from /usr/lib/libglib-2.0.so.0
> > #13 0x00007fb832ec6c21 in ?? () from /usr/lib/libglib-2.0.so.0
> > #14 0x00007fb832e720d3 in g_main_loop_run () from /usr/lib/libglib-2.0.so.0
> > #15 0x000055d78e41acc6 in mainloop_run () at src/shared/mainloop-glib.c:66
> > #16 0x000055d78e41b148 in mainloop_run_with_signal (func=func@entry=0x55d78e3acf70 <signal_callback>, user_data=user_data@entry=0x0) at src/shared/mainloop-notify.c:188
> > #17 0x000055d78e36fac0 in main (argc=<optimized out>, argv=<optimized out>) at src/main.c:1084
> >
> > Regards,
> > Tobias Predel
> > --
> > La perfection est atteinte, non pas lorsqu'il n'y a plus rien à ajouter,
> > mais lorsqu'il n'y a plus rien à retirer. — Antoine de Saint-Exupéry
> 
> 
> 
> -- 
> Luiz Augusto von Dentz
