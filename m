Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6386C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Oct 2023 00:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbjJaA0V (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Oct 2023 20:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236714AbjJaA0U (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Oct 2023 20:26:20 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBD1A9
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Oct 2023 17:26:16 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a87ac9d245so49050617b3.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Oct 2023 17:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698711975; x=1699316775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:to:content-language
         :references:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YWoTABCuUHb/iWDFcRYhNCp0l8SKo3vWRMfSIb5s2Cs=;
        b=hNX0mDgSnqiI1AFU5n9O6ZXOd79NH3Z1UfTCzAN98laVHqf7FSiGxoAGLp9OSQ74/A
         p3VIyaKyHYOowruyrdcbt+XUnN9KKK88Lpkc35XMQfOGWDRNqjrMrGYWadUlzlhYKeeU
         9NVpyiIfBLLv81hHdZmM+xybHCvwh/w8JrzFGVgoX6rGwntmE9QOQPmyPVd+479+UUtz
         FpJP23nvyoEmGhYPrGTYSNGCA557P4te53z7Yz3YgOJ4E8Wrvytx7TBZ6YrSSfFTdSxq
         1HN41iDAX8AMdLkgwY+OqyDcBHfb+ramhRsfWcaPDga4oHN0dfQ7rL6r15lStKNfdRoB
         tT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698711975; x=1699316775;
        h=content-transfer-encoding:in-reply-to:to:content-language
         :references:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YWoTABCuUHb/iWDFcRYhNCp0l8SKo3vWRMfSIb5s2Cs=;
        b=ZPi7azFjXl4lIfL4Q+xPE6ssfJHJ4rs5Q7SNAU2EmvgyvQ/QyzETfgit85bhJuHz5b
         VaM1/LN9bSOLtZAQeqpgyFUCEk+Tr+bhzdBq16wUvHbaw07/o5R96IJQ7zVKf2CDpY5+
         RwXl9FKpPvtDFgaX4QBFD+p2yLEpCKipIn30sQwDvZVGx92NbxrrKXWb06blK082gS1X
         aG+zIhFZt1E1sK/yuYf8OGnICTw+M6dV6MbZiePPunFZnL/18FP1mMD/UcPz7j/GH5Eg
         U6O0jLu+kKExLijL+mXDSKfnxGvEsE9SVQCeeSz+3cszhwdD2nZove1Ck7Vj1F81/aic
         6GhA==
X-Gm-Message-State: AOJu0YyX2uWqAFZGkpfgUFSjpst1DXLK2HUPld5RPYcB3Z0Oj3kyemg7
        fb8lT2hVulLBwCxD1y04UjZEJ9elh+DdPA==
X-Google-Smtp-Source: AGHT+IH5H3h4VidQEIuZqAyeWw/rxWjtbXjjp+Nj7elKAzHk1Al5TIMlFMYGWIriemJUW6jAA+3rQA==
X-Received: by 2002:a0d:ec0d:0:b0:59f:b0d9:5df2 with SMTP id q13-20020a0dec0d000000b0059fb0d95df2mr9971191ywn.0.1698711974767;
        Mon, 30 Oct 2023 17:26:14 -0700 (PDT)
Received: from ?IPV6:2804:1b3:a700:338d:9eb6:d0ff:fec7:eb57? ([2804:1b3:a700:338d:9eb6:d0ff:fec7:eb57])
        by smtp.gmail.com with ESMTPSA id x67-20020a814a46000000b005a92da33e4fsm117944ywa.77.2023.10.30.17.26.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 17:26:14 -0700 (PDT)
Message-ID: <a4cdc60b-19b0-483a-85ef-d12168c5eda5@gmail.com>
Date:   Mon, 30 Oct 2023 21:26:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   =?UTF-8?Q?=C3=89rico_Nogueira?= <erico.erc@gmail.com>
Subject: Segfault on bluetoothctl exit
References: <CWM5JM4FFK7M.3SUWTL9IW2SRI@disroot.org>
Content-Language: en-US
To:     linux-bluetooth@vger.kernel.org
In-Reply-To: <CWM5JM4FFK7M.3SUWTL9IW2SRI@disroot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi there!

I have observed a segfault in bluetoothctl when closing it with Ctrl-D
or with the exit command, be it with or without running any other
commands.

My bluez build is version 5.70, I'm on Void Linux with musl libc, and
this is the segfault backtrace:

#0  0x0000558a92ee2043 in queue_remove_all (queue=<optimized out>, 
function=function@entry=0x0, user_data=user_data@entry=0x0,
     destroy=0x558a92ee7430 <io_destroy>) at src/shared/queue.c:338
         tmp = 0xfffffffefffffffe
         entry = 0xfffffffefffffffe
         count = 0x0
#1  0x0000558a92ee69af in bt_shell_detach () at src/shared/shell.c:1518
No locals.
#2  bt_shell_detach () at src/shared/shell.c:1513
No locals.
#3  0x0000558a92eadc3d in disconnect_handler (connection=<optimized 
out>, user_data=<optimized out>) at client/main.c:111
No locals.
#4  0x0000558a92ee108b in g_dbus_client_unref (client=0x558a948cafe0) at 
gdbus/client.c:1450
         i = <optimized out>
         i = <optimized out>
#5  g_dbus_client_unref (client=0x558a948cafe0) at gdbus/client.c:1413
         i = <optimized out>
#6  0x0000558a92ead21c in main (argc=<optimized out>, argv=<optimized 
out>) at client/main.c:3214
         client = 0x558a948cafe0
         status = 0x0

Running it under valgrind shows that there are UAF issues even before
exiting:

==1178== Memcheck, a memory error detector
==1178== Copyright (C) 2002-2022, and GNU GPL'd, by Julian Seward et al.
==1178== Using Valgrind-3.21.0 and LibVEX; rerun with -h for copyright info
==1178== Command: bluetoothctl
==1178== Parent PID: 31848
==1178== ==1178== Invalid read of size 4
==1178==    at 0x1560F5: queue_isempty (queue.c:372)
==1178==    by 0x1596D1: bt_shell_printf (shell.c:544)
==1178==    by 0x138AF8: print_media (player.c:549)
==1178==    by 0x138AF8: media_removed (player.c:3380)
==1178==    by 0x138AF8: proxy_removed (player.c:3430)
==1178==    by 0x1541A8: proxy_free (client.c:568)
==1178==    by 0x4D24A07: g_list_foreach (in 
/usr/lib/libglib-2.0.so.0.7800.0)
==1178==    by 0x4D24A2A: g_list_free_full (in 
/usr/lib/libglib-2.0.so.0.7800.0)
==1178==    by 0x155070: g_dbus_client_unref (client.c:1443)
==1178==    by 0x155070: g_dbus_client_unref (client.c:1413)
==1178==    by 0x1392EF: player_remove_submenu (player.c:4280)
==1178==    by 0x12120E: main (main.c:3211)
==1178==  Address 0x492df48 is 24 bytes inside a block of size 32 free'd
==1178==    at 0x48C109B: free (in 
/usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
==1178==    by 0x15AA33: bt_shell_cleanup (shell.c:1364)
==1178==    by 0x15AAB5: bt_shell_run (shell.c:1287)
==1178==    by 0x121202: main (main.c:3208)
==1178==  Block was alloc'd at
==1178==    at 0x48BE7D4: malloc (in 
/usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
==1178==    by 0x15611D: util_malloc (util.c:46)
==1178==    by 0x155B5D: queue_new (queue.c:47)
==1178==    by 0x15AFCB: bt_shell_init (shell.c:1256)
==1178==    by 0x1210C1: main (main.c:3171)
==1178== ==1178== Invalid read of size 4
==1178==    at 0x1560F5: queue_isempty (queue.c:372)
==1178==    by 0x1596D1: bt_shell_printf (shell.c:544)
==1178==    by 0x126F65: print_iter (print.c:125)
==1178==    by 0x126FC8: print_iter (print.c:162)
==1178==    by 0x127379: print_property_with_label (print.c:191)
==1178==    by 0x127379: print_property (print.c:196)
==1178==    by 0x138B07: print_media (player.c:550)
==1178==    by 0x138B07: media_removed (player.c:3380)
==1178==    by 0x138B07: proxy_removed (player.c:3430)
==1178==    by 0x1541A8: proxy_free (client.c:568)
==1178==    by 0x4D24A07: g_list_foreach (in 
/usr/lib/libglib-2.0.so.0.7800.0)
==1178==    by 0x4D24A2A: g_list_free_full (in 
/usr/lib/libglib-2.0.so.0.7800.0)
==1178==    by 0x155070: g_dbus_client_unref (client.c:1443)
==1178==    by 0x155070: g_dbus_client_unref (client.c:1413)
==1178==    by 0x1392EF: player_remove_submenu (player.c:4280)
==1178==    by 0x12120E: main (main.c:3211)
==1178==  Address 0x492df48 is 24 bytes inside a block of size 32 free'd
==1178==    at 0x48C109B: free (in 
/usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
==1178==    by 0x15AA33: bt_shell_cleanup (shell.c:1364)
==1178==    by 0x15AAB5: bt_shell_run (shell.c:1287)
==1178==    by 0x121202: main (main.c:3208)
==1178==  Block was alloc'd at
==1178==    at 0x48BE7D4: malloc (in 
/usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
==1178==    by 0x15611D: util_malloc (util.c:46)
==1178==    by 0x155B5D: queue_new (queue.c:47)
==1178==    by 0x15AFCB: bt_shell_init (shell.c:1256)
==1178==    by 0x1210C1: main (main.c:3171)
==1178== ==1178== Invalid read of size 4
==1178==    at 0x1560F5: queue_isempty (queue.c:372)
==1178==    by 0x1596D1: bt_shell_printf (shell.c:544)
==1178==    by 0x138BFE: print_endpoint (player.c:1009)
==1178==    by 0x138BFE: endpoint_removed (player.c:3413)
==1178==    by 0x138BFE: proxy_removed (player.c:3438)
==1178==    by 0x1541A8: proxy_free (client.c:568)
==1178==    by 0x4D24A07: g_list_foreach (in 
/usr/lib/libglib-2.0.so.0.7800.0)
==1178==    by 0x4D24A2A: g_list_free_full (in 
/usr/lib/libglib-2.0.so.0.7800.0)
==1178==    by 0x155070: g_dbus_client_unref (client.c:1443)
==1178==    by 0x155070: g_dbus_client_unref (client.c:1413)
==1178==    by 0x1392EF: player_remove_submenu (player.c:4280)
==1178==    by 0x12120E: main (main.c:3211)
==1178==  Address 0x492df48 is 24 bytes inside a block of size 32 free'd
==1178==    at 0x48C109B: free (in 
/usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
==1178==    by 0x15AA33: bt_shell_cleanup (shell.c:1364)
==1178==    by 0x15AAB5: bt_shell_run (shell.c:1287)
==1178==    by 0x121202: main (main.c:3208)
==1178==  Block was alloc'd at
==1178==    at 0x48BE7D4: malloc (in 
/usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
==1178==    by 0x15611D: util_malloc (util.c:46)
==1178==    by 0x155B5D: queue_new (queue.c:47)
==1178==    by 0x15AFCB: bt_shell_init (shell.c:1256)
==1178==    by 0x1210C1: main (main.c:3171)
==1178== ==1178== Invalid read of size 4
==1178==    at 0x1560F5: queue_isempty (queue.c:372)
==1178==    by 0x1596D1: bt_shell_printf (shell.c:544)
==1178==    by 0x138B8E: print_transport (player.c:3346)
==1178==    by 0x138B8E: transport_removed (player.c:3420)
==1178==    by 0x138B8E: proxy_removed (player.c:3440)
==1178==    by 0x1541A8: proxy_free (client.c:568)
==1178==    by 0x4D24A07: g_list_foreach (in 
/usr/lib/libglib-2.0.so.0.7800.0)
==1178==    by 0x4D24A2A: g_list_free_full (in 
/usr/lib/libglib-2.0.so.0.7800.0)
==1178==    by 0x155070: g_dbus_client_unref (client.c:1443)
==1178==    by 0x155070: g_dbus_client_unref (client.c:1413)
==1178==    by 0x1392EF: player_remove_submenu (player.c:4280)
==1178==    by 0x12120E: main (main.c:3211)
==1178==  Address 0x492df48 is 24 bytes inside a block of size 32 free'd
==1178==    at 0x48C109B: free (in 
/usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
==1178==    by 0x15AA33: bt_shell_cleanup (shell.c:1364)
==1178==    by 0x15AAB5: bt_shell_run (shell.c:1287)
==1178==    by 0x121202: main (main.c:3208)
==1178==  Block was alloc'd at
==1178==    at 0x48BE7D4: malloc (in 
/usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
==1178==    by 0x15611D: util_malloc (util.c:46)
==1178==    by 0x155B5D: queue_new (queue.c:47)
==1178==    by 0x15AFCB: bt_shell_init (shell.c:1256)
==1178==    by 0x1210C1: main (main.c:3171)
==1178== ==1178== Invalid read of size 4
==1178==    at 0x1560F5: queue_isempty (queue.c:372)
==1178==    by 0x1596D1: bt_shell_printf (shell.c:544)
==1178==    by 0x1284B2: agent_unregister (agent.c:460)
==1178==    by 0x1541A8: proxy_free (client.c:568)
==1178==    by 0x4D24A07: g_list_foreach (in 
/usr/lib/libglib-2.0.so.0.7800.0)
==1178==    by 0x4D24A2A: g_list_free_full (in 
/usr/lib/libglib-2.0.so.0.7800.0)
==1178==    by 0x155070: g_dbus_client_unref (client.c:1443)
==1178==    by 0x155070: g_dbus_client_unref (client.c:1413)
==1178==    by 0x12121B: main (main.c:3214)
==1178==  Address 0x492df48 is 24 bytes inside a block of size 32 free'd
==1178==    at 0x48C109B: free (in 
/usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
==1178==    by 0x15AA33: bt_shell_cleanup (shell.c:1364)
==1178==    by 0x15AAB5: bt_shell_run (shell.c:1287)
==1178==    by 0x121202: main (main.c:3208)
==1178==  Block was alloc'd at
==1178==    at 0x48BE7D4: malloc (in 
/usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
==1178==    by 0x15611D: util_malloc (util.c:46)
==1178==    by 0x155B5D: queue_new (queue.c:47)
==1178==    by 0x15AFCB: bt_shell_init (shell.c:1256)
==1178==    by 0x1210C1: main (main.c:3171)
==1178== ==1178== Invalid read of size 4
==1178==    at 0x1560F5: queue_isempty (queue.c:372)
==1178==    by 0x1596D1: bt_shell_printf (shell.c:544)
==1178==    by 0x121A13: print_adapter (main.c:138)
==1178==    by 0x1267F0: adapter_removed (main.c:554)
==1178==    by 0x1267F0: proxy_removed (main.c:594)
==1178==    by 0x1541A8: proxy_free (client.c:568)
==1178==    by 0x4D24A07: g_list_foreach (in 
/usr/lib/libglib-2.0.so.0.7800.0)
==1178==    by 0x4D24A2A: g_list_free_full (in 
/usr/lib/libglib-2.0.so.0.7800.0)
==1178==    by 0x155070: g_dbus_client_unref (client.c:1443)
==1178==    by 0x155070: g_dbus_client_unref (client.c:1413)
==1178==    by 0x12121B: main (main.c:3214)
==1178==  Address 0x492df48 is 24 bytes inside a block of size 32 free'd
==1178==    at 0x48C109B: free (in 
/usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
==1178==    by 0x15AA33: bt_shell_cleanup (shell.c:1364)
==1178==    by 0x15AAB5: bt_shell_run (shell.c:1287)
==1178==    by 0x121202: main (main.c:3208)
==1178==  Block was alloc'd at
==1178==    at 0x48BE7D4: malloc (in 
/usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
==1178==    by 0x15611D: util_malloc (util.c:46)
==1178==    by 0x155B5D: queue_new (queue.c:47)
==1178==    by 0x15AFCB: bt_shell_init (shell.c:1256)
==1178==    by 0x1210C1: main (main.c:3171)
==1178== ==1178== Invalid read of size 4
==1178==    at 0x1560F5: queue_isempty (queue.c:372)
==1178==    by 0x15A98F: bt_shell_detach (shell.c:1515)
==1178==    by 0x121C3C: disconnect_handler (main.c:111)
==1178==    by 0x15508A: g_dbus_client_unref (client.c:1450)
==1178==    by 0x15508A: g_dbus_client_unref (client.c:1413)
==1178==    by 0x12121B: main (main.c:3214)
==1178==  Address 0x492df48 is 24 bytes inside a block of size 32 free'd
==1178==    at 0x48C109B: free (in 
/usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
==1178==    by 0x15AA33: bt_shell_cleanup (shell.c:1364)
==1178==    by 0x15AAB5: bt_shell_run (shell.c:1287)
==1178==    by 0x121202: main (main.c:3208)
==1178==  Block was alloc'd at
==1178==    at 0x48BE7D4: malloc (in 
/usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
==1178==    by 0x15611D: util_malloc (util.c:46)
==1178==    by 0x155B5D: queue_new (queue.c:47)
==1178==    by 0x15AFCB: bt_shell_init (shell.c:1256)
==1178==    by 0x1210C1: main (main.c:3171)
==1178== ==1178== ==1178== HEAP SUMMARY:
==1178==     in use at exit: 293,527 bytes in 1,357 blocks
==1178==   total heap usage: 4,732 allocs, 3,375 frees, 501,006 bytes 
allocated
==1178== ==1178== LEAK SUMMARY:
==1178==    definitely lost: 0 bytes in 0 blocks
==1178==    indirectly lost: 0 bytes in 0 blocks
==1178==      possibly lost: 0 bytes in 0 blocks
==1178==    still reachable: 292,935 bytes in 1,348 blocks
==1178==         suppressed: 592 bytes in 9 blocks
==1178== Rerun with --leak-check=full to see details of leaked memory
==1178== ==1178== For lists of detected and suppressed errors, rerun 
with: -s
==1178== ERROR SUMMARY: 9 errors from 7 contexts (suppressed: 0 from 0)

 From a quick look at the code, it seems to be related the fact that the
bt_shell_run() function called by the client utility also calls
bt_shell_cleanup(), but I can't say for sure.

Cheers, Érico
