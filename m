Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EE1C433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Mar 2021 06:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 919C861927
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Mar 2021 06:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhCVGCc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Mar 2021 02:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbhCVGCV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Mar 2021 02:02:21 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8E3C061762
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Mar 2021 23:02:21 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 6so59361876ybq.7
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Mar 2021 23:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=w4n6Y6TRgjyD9SHfdO058vXR1r4LRwmUmHS4TxN0IUQ=;
        b=VvvFYSfyRxpvJOTLwaDhC7q5by4hb3byrVlKjP5CT/9X60WGM6qnHuYV8DfJmC/Z+7
         o8pZFJ7UEM1RhFbr9o5LQo/t5qgl3Or+rnmqF4MY5tCf0kNH81N+1rEYvkXcV02DDao4
         U8BVCCGXj2lPmZB3SB0JUBCdiIidnIFo6XUJUj1G+DDRyeAmOG8oCoDJxxTvQ8wBV1uq
         Wf/CCelq59jPEaaVT2Mynjon5YFSWCuOXnSsWG/yLXXNoPhlm36NB68yD6Zmd6k+BOBj
         XP8j0F2L9cUeX7Ws4iip+JqRFY+8cU44AL6a9BX1/vOpXomx/y5KxmCKtsGzFqL8i73M
         p0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=w4n6Y6TRgjyD9SHfdO058vXR1r4LRwmUmHS4TxN0IUQ=;
        b=oT5tlAkg8Vz6t+chFgzihbg6/TIJ1By/q9kYjgvNnEhu42aFE3wRhS1A3WsWaRXkZo
         miFK3+W5F5nBXiQ13Kw01AoGOBkwfpOderEKsfWJKdvD6qBtErQ8PjN/RRr39TF0lJAC
         CApUU/Mzk3DL9fhU0iB0tLFSztA+QwiHQQCLcwMEXNfP1d59CzP1FzYYvXffm29Dn5yg
         +3YIj4AfzY5HQyyvnoqsespwJg+GFE8BIiKDegixOYoQ6tBg3kQVZw6vTz4VBceO0LRu
         DI2lWmKaYxj07AXAR50KPPi1vx56O5vjT5S80QqNfuU2YuajkjTmONz/AHOnWFq6M1Yy
         ue8g==
X-Gm-Message-State: AOAM531JKLAIxmGvk+NKWFXT48vhS3q23z2MgswzUA3hQCGAjhIE9zqk
        IuLADfuCcoSPChZh8gp34ft0t589HaMft773eqcIM5vA0ARl6Ncl/UJey26ONq8qeJYjluznEAq
        rgjSf/ALyEIYB66Ka26nEtvH1YqdYXbs1X+f7OQs/WtQIQZ+8zOVnlH1nVxpRQmj76YQwvpAUKj
        xL
X-Google-Smtp-Source: ABdhPJz18QXc98nJNotAJXH1w16tomxxC41Sm171H6xFFCDRDaArBTvl2SSZayQp3Fzd2/rQeafanaLF0jHr
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:fdf3:9f7d:e4e3:ccad])
 (user=apusaka job=sendgmr) by 2002:a25:b0f:: with SMTP id 15mr22845240ybl.467.1616392940803;
 Sun, 21 Mar 2021 23:02:20 -0700 (PDT)
Date:   Mon, 22 Mar 2021 14:02:15 +0800
Message-Id: <20210322140154.1.I2ce9acd6cc6766e6789fc5742951b21b7ab27067@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH] Bluetooth: Set CONF_NOT_COMPLETE as l2cap_chan default
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        syzbot+338f014a98367a08a114@syzkaller.appspotmail.com,
        Alain Michaud <alainm@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Currently l2cap_chan_set_defaults() reset chan->conf_state to zero.
However, there is a flag CONF_NOT_COMPLETE which is set when
creating the l2cap_chan. It is suggested that the flag should be
cleared when l2cap_chan is ready, but when l2cap_chan_set_defaults()
is called, l2cap_chan is not yet ready. Therefore, we must set this
flag as the default.

Example crash call trace:
__dump_stack lib/dump_stack.c:15 [inline]
dump_stack+0xc4/0x118 lib/dump_stack.c:56
panic+0x1c6/0x38b kernel/panic.c:117
__warn+0x170/0x1b9 kernel/panic.c:471
warn_slowpath_fmt+0xc7/0xf8 kernel/panic.c:494
debug_print_object+0x175/0x193 lib/debugobjects.c:260
debug_object_assert_init+0x171/0x1bf lib/debugobjects.c:614
debug_timer_assert_init kernel/time/timer.c:629 [inline]
debug_assert_init kernel/time/timer.c:677 [inline]
del_timer+0x7c/0x179 kernel/time/timer.c:1034
try_to_grab_pending+0x81/0x2e5 kernel/workqueue.c:1230
cancel_delayed_work+0x7c/0x1c4 kernel/workqueue.c:2929
l2cap_clear_timer+0x1e/0x41 include/net/bluetooth/l2cap.h:834
l2cap_chan_del+0x2d8/0x37e net/bluetooth/l2cap_core.c:640
l2cap_chan_close+0x532/0x5d8 net/bluetooth/l2cap_core.c:756
l2cap_sock_shutdown+0x806/0x969 net/bluetooth/l2cap_sock.c:1174
l2cap_sock_release+0x64/0x14d net/bluetooth/l2cap_sock.c:1217
__sock_release+0xda/0x217 net/socket.c:580
sock_close+0x1b/0x1f net/socket.c:1039
__fput+0x322/0x55c fs/file_table.c:208
____fput+0x17/0x19 fs/file_table.c:244
task_work_run+0x19b/0x1d3 kernel/task_work.c:115
exit_task_work include/linux/task_work.h:21 [inline]
do_exit+0xe4c/0x204a kernel/exit.c:766
do_group_exit+0x291/0x291 kernel/exit.c:891
get_signal+0x749/0x1093 kernel/signal.c:2396
do_signal+0xa5/0xcdb arch/x86/kernel/signal.c:737
exit_to_usermode_loop arch/x86/entry/common.c:243 [inline]
prepare_exit_to_usermode+0xed/0x235 arch/x86/entry/common.c:277
syscall_return_slowpath+0x3a7/0x3b3 arch/x86/entry/common.c:348
int_ret_from_sys_call+0x25/0xa3

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reported-by: syzbot+338f014a98367a08a114@syzkaller.appspotmail.com
Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
---

 net/bluetooth/l2cap_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 374cc32d7138..59ab9689b37d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -516,7 +516,9 @@ void l2cap_chan_set_defaults(struct l2cap_chan *chan)
 	chan->flush_to = L2CAP_DEFAULT_FLUSH_TO;
 	chan->retrans_timeout = L2CAP_DEFAULT_RETRANS_TO;
 	chan->monitor_timeout = L2CAP_DEFAULT_MONITOR_TO;
+
 	chan->conf_state = 0;
+	set_bit(CONF_NOT_COMPLETE, &chan->conf_state);
 
 	set_bit(FLAG_FORCE_ACTIVE, &chan->flags);
 }
-- 
2.31.0.rc2.261.g7f71774620-goog

