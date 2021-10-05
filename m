Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF4DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Oct 2021 08:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BC59613B5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Oct 2021 08:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbhJEIzY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Oct 2021 04:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbhJEIzV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Oct 2021 04:55:21 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27381C061745
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Oct 2021 01:53:31 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l18-20020a05600c4f1200b002f8cf606262so2291960wmq.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Oct 2021 01:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=ONx5VFpznjWXhkLOYMC+fnBHN1V+0tvWkVcgBRK+x7U=;
        b=Cidenm04eNzFKsDJMPubAjPNS7IcC4jHMKv88NNsUdPKcMQd8WaCXOKRgg6vEYiTz5
         eQVCu1Zjy4GdA8OywexNUbW/2AIfPDm1MVR8/XpB1sf/9Fpc3RW5erx1ViAiiBMmEcwb
         vo5CUs88RE5Wn8fST8DmDUSre+0jQh2vBj1NXG1jDvx/YUZ5hX5PGPleGqxxGoTQZOos
         k08XOUB84SuYQPhPvZQQMXP4p2n+sjPHFu4U4/juZophingyLxaBgxSBTDE1j96PnqQ3
         y0FXH25WPFK12gCnTxWIzEKJvy9ajiK4rNINaOsUIWGCCR/bAnGY47hAHAHncddtsYDP
         affw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ONx5VFpznjWXhkLOYMC+fnBHN1V+0tvWkVcgBRK+x7U=;
        b=eLz+EWcRLb/bMk44cLXClfbx8pmT4xzTKdey8HuEcmAejNs54t9QVp9XLb4e4p0G8F
         uAX3jb44YswJgiamh5LXVTU7ER+vrOt8kasrF140zqhYZpQA/cLp0YtQ8EA60QiTboYA
         XHyxiho+5zP9wQAoYlOmSQ3+FWoSqnSivlsjtoGskJriYL3y+H8McLgEWMpyGhT0cCD2
         ZG04zmQKN4mOeP2wMgBvUCHXblmGlA7+AF/U1mXPqWyfEjqLLoGnen64qkrnjILrFwhD
         rdnbKGeMgrGSlf854jLWmxs//FlVpnzpjC1f+WY4zFUHlKQsyTiRNVt4PYHo0P9bvFQl
         R8sw==
X-Gm-Message-State: AOAM531DMNafylF4aQf+e3FZ7a+96Q++bR0JBQwW6aa9wb0JiWb9UqQX
        ymXadSI31qWUrT0WRA0OZ1DGn/odLfBjr//oPRJrRErvzss=
X-Google-Smtp-Source: ABdhPJy/oaiXJivVt6OVCcJczZSa8YiZm06DbmkcI2gQ7CYCelMu8KWykQgZyVWvMMI/veuieHKxii6XElwBm0tfLQk=
X-Received: by 2002:a1c:7704:: with SMTP id t4mr2085072wmi.167.1633424009763;
 Tue, 05 Oct 2021 01:53:29 -0700 (PDT)
MIME-Version: 1.0
From:   Thomas Eriksson <thomas.eriksson@gmail.com>
Date:   Tue, 5 Oct 2021 10:53:18 +0200
Message-ID: <CA+6+gU=AEHhnEwVq=RyOKemRjZM_zHLmCZKkGO+aUKCaaQVOhA@mail.gmail.com>
Subject: Null dereference in profiles/audio/avrcp.c
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

When trying to pair my "3M Peltor WS Alert XPI" headset with Bluez i
get a null dereference in profiles/audio/avrcp.c.

The following small patch avoids the problem:

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 7c280203c..6064ab40b 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3740,10 +3740,13 @@ static void avrcp_status_changed(struct avrcp *session,
                                                struct avrcp_header *pdu)
 {
        struct avrcp_player *player = session->controller->player;
-       struct media_player *mp = player->user_data;
+       struct media_player *mp = NULL;
        uint8_t value;
        const char *curval, *strval;

+       if (player == NULL)
+               return;
+       mp = player->user_data;
        value = pdu->params[1];

        curval = media_player_get_status(mp);



Below is the backtrace from GDB:

GNU gdb (Debian 10.1-2) 10.1.90.20210103-git
Copyright (C) 2021 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "x86_64-linux-gnu".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<https://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
    <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from /usr/local/libexec/bluetooth/bluetoothd...
(gdb) run
Starting program: /usr/local/libexec/bluetooth/bluetoothd
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".



Program received signal SIGSEGV, Segmentation fault.
0x0000555555594f14 in avrcp_status_changed (pdu=0x5555556d1b36,
pdu=0x5555556d1b36, session=0x5555556a9800) at
profiles/audio/avrcp.c:3743
3743 struct media_player *mp = player->user_data;
(gdb)
(gdb)
(gdb) bt
#0  0x0000555555594f14 in avrcp_status_changed (pdu=0x5555556d1b36,
pdu=0x5555556d1b36, session=0x5555556a9800) at
profiles/audio/avrcp.c:3743
#1  avrcp_handle_event (conn=0x5555556c98e0, code=15 '\017',
subunit=<optimized out>, transaction=<optimized out>,
operands=0x5555556d1b36 "", operand_count=9, user_data=0x5555556a9800)
    at profiles/audio/avrcp.c:3884
#2  0x000055555558f3c7 in control_response (operand_count=9,
operands=0x5555556d1b36 "", avc=<optimized out>, avctp=<optimized
out>, control=<optimized out>) at profiles/audio/avctp.c:938
#3  session_cb (chan=<optimized out>, cond=<optimized out>,
data=<optimized out>) at profiles/audio/avctp.c:1107
#4  0x00007ffff7ebdc0f in g_main_context_dispatch () from
/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
#5  0x00007ffff7ebdfb8 in ?? () from /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
#6  0x00007ffff7ebe2ab in g_main_loop_run () from
/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
#7  0x0000555555617415 in mainloop_run () at src/shared/mainloop-glib.c:66
#8  0x00005555556177f2 in mainloop_run_with_signal
(func=func@entry=0x5555555af8d0 <signal_callback>,
user_data=user_data@entry=0x0) at src/shared/mainloop-notify.c:188
#9  0x0000555555577147 in main (argc=<optimized out>, argv=<optimized
out>) at src/main.c:1210


Best regards
/Thomas Eriksson
