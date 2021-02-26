Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADFAC433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Feb 2021 15:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4F7864EE2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Feb 2021 15:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbhBZPNH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Feb 2021 10:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhBZPNF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Feb 2021 10:13:05 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8B1C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Feb 2021 07:12:25 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id s8so11401864edd.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Feb 2021 07:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=1khzrm2bxZFsIRd+23BbRoAEfLQGKJN/JIXjjB8cedo=;
        b=V84B/J9IzbalHKcHD7Os8yBDQZItou9tPXaUIC0tLlQcVnHOMW6Ji1mtOnnP6bGkWN
         MtGq7vW/G36bDqDX9Rp7DhcRHlspvXPp7+OSPfekv+BJyNWQ1SNM6sK2+572wO4oirTC
         OVGzHH8c7ec5zl/zI2cA8AwOAGwXWirTSdOHQfbQ2moUl4Zp7+EEUDdlI8uMtvLoKGuA
         KPm10ubAILL9iHytaGaMXTj399B2+r/lfH7t/XkYDokWS+xiNkhJCLM+Y3Zsu6EaJ8em
         fgisnYNMquje0u7uY0gEtZbMu/egpRnkecR0iLAhgSUw7ifpWSZeyVpkYqLNvDHdBcgl
         4R4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=1khzrm2bxZFsIRd+23BbRoAEfLQGKJN/JIXjjB8cedo=;
        b=oOFdw0sF02bSwsilUzY+4nzMWW+FhwNBozoNOJ30yTIAuPSiseofER9zDs2AnDSpmu
         t8sHvLutvh1q5EFXrnWC4bL+lB+4QDl4/M28P1bPp1XZCK1Ujq576jsqwwivZOsk7ksi
         0n7yjta5jRS1WjZbrP1vR+S3Twbd8KIYHxcTq2sfrXTwVV4MjKOFa51ge6VpNFL9q8ky
         1hAOyYN4i3mCg5fb9qr4BhulEV5O5kw/y3IuWpo3d1dBDIUFrNVdupukH6bIKaFxt2/0
         MmQf0j12bdDYau+UaNA6f6xStIiyiwQpnuMcjI7FG3W866JDjXeLZfMc40wMM1WdGSar
         thxQ==
X-Gm-Message-State: AOAM532013muwiWS1u/r0TVcqTjkTjpHVhEpvK0xSalIK8+BlgQDnGEd
        dEUfBfxZnhed+K7kmP04A2Z+8z+U5Hk=
X-Google-Smtp-Source: ABdhPJwLHwI2BxZ6vK6LipN9L/lWIy1hbugpHmf3xkTsyqVIKqiqfmEwyNVKRvYsdeY31kafuVrxPg==
X-Received: by 2002:a05:6402:30a5:: with SMTP id df5mr3980112edb.24.1614352343342;
        Fri, 26 Feb 2021 07:12:23 -0800 (PST)
Received: from t2b3 ([194.140.115.160])
        by smtp.gmail.com with ESMTPSA id cr20sm5237516ejc.57.2021.02.26.07.12.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 07:12:22 -0800 (PST)
Date:   Fri, 26 Feb 2021 16:12:19 +0100
From:   "Tobias S. Predel" <tobias.predel@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: Bluez 5.56 segfaulting while A2DP
Message-ID: <YDkP07ts5xokM1um@t2b3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear all,

I experienced a SEGFAULT from bluez 5.56-1
on Arch Linux - linux 5.11.1.arch1-1:

It happened during having A2DP connection with pipewire-git 0.3.22.76.g08445d2c-1.

This is the backtrace:

# coredumpctl debug
(gdb) thread apply all bt

Thread 1 (Thread 0x7fb8325f67c0 (LWP 663)):
#0  0x00007fb832c74f19 in __strcasecmp_l_avx () from /usr/lib/libc.so.6
#1  0x000055d78e38c3b1 in play_status_to_val (status=0x0) at profiles/audio/avrcp.c:729
#2  0x000055d78e38ce3e in avrcp_player_event (player=player@entry=0x55d78f058a20, id=<optimized out>, data=data@entry=0x0) at profiles/audio/avrcp.c:807
#3  0x000055d78e38ced6 in avrcp_player_event (data=0x0, id=<optimized out>, player=0x55d78f058a20) at profiles/audio/avrcp.c:783
#4  notify_addressed_player_changed (user_data=user_data@entry=0x55d78f058a20) at profiles/audio/avrcp.c:1804
#5  0x000055d78e3906ad in avrcp_unregister_player (player=0x55d78f058a20) at profiles/audio/avrcp.c:4452
#6  0x000055d78e3830c8 in media_player_remove (data=0x55d78f050ff0) at profiles/audio/media.c:1052
#7  unregister_player (conn=<optimized out>, msg=0x55d78f0079d0, data=<optimized out>) at profiles/audio/media.c:1902
#8  0x000055d78e404fe9 in process_message (connection=0x55d78f005e00, message=0x55d78f0079d0, method=0x55d78e47b778 <media_methods+120>, iface_user_data=<optimized out>) at gdbus/object.c:246
#9  0x00007fb832df17d6 in ?? () from /usr/lib/libdbus-1.so.3
#10 0x00007fb832de13bd in dbus_connection_dispatch () from /usr/lib/libdbus-1.so.3
#11 0x000055d78e401681 in message_dispatch (data=0x55d78f005e00) at gdbus/mainloop.c:59
#12 0x00007fb832e72b84 in g_main_context_dispatch () from /usr/lib/libglib-2.0.so.0
#13 0x00007fb832ec6c21 in ?? () from /usr/lib/libglib-2.0.so.0
#14 0x00007fb832e720d3 in g_main_loop_run () from /usr/lib/libglib-2.0.so.0
#15 0x000055d78e41acc6 in mainloop_run () at src/shared/mainloop-glib.c:66
#16 0x000055d78e41b148 in mainloop_run_with_signal (func=func@entry=0x55d78e3acf70 <signal_callback>, user_data=user_data@entry=0x0) at src/shared/mainloop-notify.c:188
#17 0x000055d78e36fac0 in main (argc=<optimized out>, argv=<optimized out>) at src/main.c:1084

Regards,
Tobias Predel
-- 
La perfection est atteinte, non pas lorsqu'il n'y a plus rien à ajouter, 
mais lorsqu'il n'y a plus rien à retirer. — Antoine de Saint-Exupéry
