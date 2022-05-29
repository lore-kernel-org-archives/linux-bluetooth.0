Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7206C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 29 May 2022 11:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiE2Lmu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 29 May 2022 07:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiE2Lmt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 29 May 2022 07:42:49 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB6B33368
        for <linux-bluetooth@vger.kernel.org>; Sun, 29 May 2022 04:42:44 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id 67so8337238vsh.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 29 May 2022 04:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foxdogstudios-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=qPnJWXlchheONIM69Dn09IN35UzsBae6ZWx+bklufmA=;
        b=BIYe1s4M4w0VlCW1mFz9MOZ2cFK0dbIEsZUF7BJkv0QL87hJ4eqeOs2iqzbnGy55tT
         JMTfghQiPoj/JGeAW3MUIpWdyWApNWMBy63yylqn2S8cEWosr4y3mZE4vUtzjcgRB81x
         TCtnP+lu66VUBTsXfXeIH9Yta9va3E9qkbU/8DxroPdkyxuHTLoCryp2GLATkAxGcN5i
         3qs/liyP45NHyb6YTqoiR/umkMsEs3PJgGBjI3MWLP8qj0NZi2fi+tejTvi2jFRaCwzg
         z1bKG0+xbEV2cA13PhZ43mrIGMdfzJC5TMpTYsV5jc6X3IReq6rXN/QKIZy7WeOTS75A
         tcaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=qPnJWXlchheONIM69Dn09IN35UzsBae6ZWx+bklufmA=;
        b=izfZ8mIMEgXYMpTFjWzdvYyCCBuaWFUW0OCJ02M/A6QkO9iIwulJcNVWC2tyN5PIs5
         bLuK9omeX5lmNSI1PvF8Qa2UgEu16wstKBkLf7zEprG5joqOMURuCgDVCIpMoEqJzZ/D
         PsqsDLUEKbh9WuMlLKBKrmmEXIP91wZqHSWZXRSf8k9UO31zVfEVWEWuimcmsBnpA+S5
         GrkJumwOKhnz6krS7kbpnUsllDYYpb0RHauTeQcqqdBLT6+4gSGuQ+6EIEjA3Ub9pdvA
         XF1x7F7yvdU4vw+xqsEdHuFdpKnYABKZxiFVUdsYGUOWdX3MOX6gflDt3t/UAJz9qybg
         QVvA==
X-Gm-Message-State: AOAM530YFRn6QOWD4hBFrf442OQyxmYx3BT0rpXcd4FGKl7uEbQEfCZD
        355s5kR/Lzr+M/T0XRwP+hGxo5NZilyJVFNYpe4/WABZvdJlEQ==
X-Google-Smtp-Source: ABdhPJzKBDFgDBV4fOqC9Fy/2/VPdcSB59E04Yh/dLM9XoWpH1NMo8YsTu484wFbKOOTw5ERwqCqHcUqvvOrInFmYws=
X-Received: by 2002:a67:d91e:0:b0:337:935e:517a with SMTP id
 t30-20020a67d91e000000b00337935e517amr16894341vsj.19.1653824563958; Sun, 29
 May 2022 04:42:43 -0700 (PDT)
MIME-Version: 1.0
From:   Peter Sutton <peter@foxdogstudios.com>
Date:   Sun, 29 May 2022 12:42:33 +0100
Message-ID: <CAD+dNTsbuU4w+Y_P7o+VEN7BYCAbZuwZx2+tH+OTzCdcZF82YA@mail.gmail.com>
Subject: [Bug] [Deadlock] Kernel thread deadlock in rfcomm socket release when
 connect interrupted
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Matthew Leach <matthew@mattleach.net>,
        Lloyd Henning <lloyd@foxdogstudios.com>
Content-Type: multipart/mixed; boundary="000000000000a8034b05e02509e7"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--000000000000a8034b05e02509e7
Content-Type: text/plain; charset="UTF-8"

Hi,

Compile the attached C program (gcc -lbluetooth bug.c) and execute:

$ ./a.out

Interrupt (^C/SIGINT) during the connect. The process should hang and
the Bluetooth socket will now be in deadlock.

Kernel thread stack:

[May29 12:23] INFO: task krfcommd:902 blocked for more than 122 seconds.
[  +0.000009]       Tainted: P           OE     5.18.0-arch1-1 #1
[  +0.000004] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  +0.000002] task:krfcommd        state:D stack:    0 pid:  902 ppid:
    2 flags:0x00004000
[  +0.000010] Call Trace:
[  +0.000003]  <TASK>
[  +0.000007]  __schedule+0x37c/0x11f0
[  +0.000013]  ? __schedule+0x384/0x11f0
[  +0.000012]  ? l2cap_chan_create+0x138/0x180 [bluetooth
da0a812fd33c72f9c94149bd973bd9835fc8aa63]
[  +0.000104]  schedule+0x4f/0xb0
[  +0.000008]  schedule_preempt_disabled+0x15/0x20
[  +0.000009]  __mutex_lock.constprop.0+0x2d0/0x480
[  +0.000012]  rfcomm_run+0x152/0x1900 [rfcomm
70c711e71e4c70ddabda45ec756f02d9606ec257]
[  +0.000018]  ? ttwu_do_wakeup+0x17/0x160
[  +0.000011]  ? _raw_spin_rq_lock_irqsave+0x20/0x20
[  +0.000010]  ? rfcomm_check_accept+0xa0/0xa0 [rfcomm
70c711e71e4c70ddabda45ec756f02d9606ec257]
[  +0.000015]  kthread+0xde/0x110
[  +0.000011]  ? kthread_complete_and_exit+0x20/0x20
[  +0.000010]  ret_from_fork+0x22/0x30
[  +0.000012]  </TASK>

Task stack:

[  +0.000003] INFO: task a.out:1035 blocked for more than 122 seconds.
[  +0.000004]       Tainted: P           OE     5.18.0-arch1-1 #1
[  +0.000003] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  +0.000001] task:a.out           state:D stack:    0 pid: 1035 ppid:
  817 flags:0x00004006
[  +0.000008] Call Trace:
[  +0.000002]  <TASK>
[  +0.000003]  __schedule+0x37c/0x11f0
[  +0.000009]  ? __mod_memcg_state+0x2f/0x70
[  +0.000008]  schedule+0x4f/0xb0
[  +0.000007]  __lock_sock+0x7d/0xc0
[  +0.000010]  ? cpuacct_percpu_seq_show+0x20/0x20
[  +0.000009]  lock_sock_nested+0x48/0x50
[  +0.000009]  rfcomm_sk_state_change+0x2b/0x120 [rfcomm
70c711e71e4c70ddabda45ec756f02d9606ec257]
[  +0.000018]  __rfcomm_dlc_close+0x99/0x210 [rfcomm
70c711e71e4c70ddabda45ec756f02d9606ec257]
[  +0.000015]  rfcomm_dlc_close+0x6e/0xb0 [rfcomm
70c711e71e4c70ddabda45ec756f02d9606ec257]
[  +0.000015]  __rfcomm_sock_close+0x2e/0xe0 [rfcomm
70c711e71e4c70ddabda45ec756f02d9606ec257]
[  +0.000017]  rfcomm_sock_shutdown+0x65/0xa0 [rfcomm
70c711e71e4c70ddabda45ec756f02d9606ec257]
[  +0.000016]  rfcomm_sock_release+0x32/0xb0 [rfcomm
70c711e71e4c70ddabda45ec756f02d9606ec257]
[  +0.000016]  __sock_release+0x3d/0xa0
[  +0.000010]  sock_close+0x15/0x20
[  +0.000009]  __fput+0x89/0x240
[  +0.000011]  task_work_run+0x60/0x90
[  +0.000007]  do_exit+0x337/0xac0
[  +0.000010]  ? del_timer_sync+0x73/0xb0
[  +0.000006]  do_group_exit+0x31/0xa0
[  +0.000009]  get_signal+0x986/0x990
[  +0.000007]  ? bt_sock_wait_state+0x124/0x1a0 [bluetooth
da0a812fd33c72f9c94149bd973bd9835fc8aa63]
[  +0.000060]  ? wake_up_q+0x90/0x90
[  +0.000010]  arch_do_signal_or_restart+0x48/0x760
[  +0.000012]  exit_to_user_mode_prepare+0xd3/0x140
[  +0.000008]  syscall_exit_to_user_mode+0x26/0x50
[  +0.000006]  do_syscall_64+0x6b/0x90
[  +0.000009]  ? exc_page_fault+0x74/0x170
[  +0.000009]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  +0.000007] RIP: 0033:0x7f4ab4f13557
[  +0.000006] RSP: 002b:00007fff5b37cc38 EFLAGS: 00000246 ORIG_RAX:
000000000000002a
[  +0.000007] RAX: fffffffffffffffc RBX: 00007fff5b37cd78 RCX: 00007f4ab4f13557
[  +0.000004] RDX: 000000000000000a RSI: 00007fff5b37cc4e RDI: 0000000000000003
[  +0.000004] RBP: 00007fff5b37cc60 R08: 0fffffffffffffff R09: 0000000000000000
[  +0.000003] R10: 00007f4ab4e075e0 R11: 0000000000000246 R12: 0000000000000000
[  +0.000003] R13: 00007fff5b37cd88 R14: 0000562da1cefde0 R15: 00007f4ab5214000
[  +0.000007]  </TASK>

Process stack:

[<0>] __lock_sock+0x7d/0xc0
[<0>] lock_sock_nested+0x48/0x50
[<0>] rfcomm_sk_state_change+0x2b/0x120 [rfcomm]
[<0>] __rfcomm_dlc_close+0x99/0x210 [rfcomm]
[<0>] rfcomm_dlc_close+0x6e/0xb0 [rfcomm]
[<0>] __rfcomm_sock_close+0x2e/0xe0 [rfcomm]
[<0>] rfcomm_sock_shutdown+0x65/0xa0 [rfcomm]
[<0>] rfcomm_sock_release+0x32/0xb0 [rfcomm]
[<0>] __sock_release+0x3d/0xa0
[<0>] sock_close+0x15/0x20
[<0>] __fput+0x89/0x240
[<0>] task_work_run+0x60/0x90
[<0>] do_exit+0x337/0xac0
[<0>] do_group_exit+0x31/0xa0
[<0>] get_signal+0x986/0x990
[<0>] arch_do_signal_or_restart+0x48/0x760
[<0>] exit_to_user_mode_prepare+0xd3/0x140
[<0>] syscall_exit_to_user_mode+0x26/0x50
[<0>] do_syscall_64+0x6b/0x90
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xae

Replicated by Matt (CC'ed running 5.15.39) on different hardware and
Lloyd (CC'ed) on same hardware with same stack trace. Tested on
up-to-date Arch Linux (5.18.0).

Let me know if you need anything else. Cheers
--
Pete.

--000000000000a8034b05e02509e7
Content-Type: text/x-csrc; charset="US-ASCII"; name="bug.c"
Content-Disposition: attachment; filename="bug.c"
Content-Transfer-Encoding: base64
Content-ID: <f_l3r857pq0>
X-Attachment-Id: f_l3r857pq0

I2luY2x1ZGUgPHVuaXN0ZC5oPgojaW5jbHVkZSA8c3lzL3NvY2tldC5oPgojaW5jbHVkZSA8Ymx1
ZXRvb3RoL2JsdWV0b290aC5oPgojaW5jbHVkZSA8Ymx1ZXRvb3RoL3JmY29tbS5oPgoKaW50IG1h
aW4oKSB7CiAgaW50IHNvY2sgPSBzb2NrZXQoQUZfQkxVRVRPT1RILCBTT0NLX1NUUkVBTSwgQlRQ
Uk9UT19SRkNPTU0pOwogIGlmIChzb2NrID09IC0xKSByZXR1cm4gMTsKICBzdHJ1Y3Qgc29ja2Fk
ZHJfcmMgYWRkcjsKICBhZGRyLnJjX2ZhbWlseSA9IEFGX0JMVUVUT09USDsKICBhZGRyLnJjX2No
YW5uZWwgPSAxOwogIHN0cjJiYSgiMDE6MjM6NDU6Njc6ODk6QUIiLCAmYWRkci5yY19iZGFkZHIp
OwogIGNvbm5lY3Qoc29jaywgKHN0cnVjdCBzb2NrYWRkciAqKSAmYWRkciwgc2l6ZW9mKGFkZHIp
KTsKICBjbG9zZShzb2NrKTsKfQo=
--000000000000a8034b05e02509e7--
