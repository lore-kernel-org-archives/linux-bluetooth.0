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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00A5C433C1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Mar 2021 06:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5A076192E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Mar 2021 06:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhCVGB2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Mar 2021 02:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhCVGBJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Mar 2021 02:01:09 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753CEC061762
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Mar 2021 23:01:09 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a63so59233138yba.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Mar 2021 23:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5I10KmTF85pJvFc7zWF/I23hQrUb++spC+kPfoWl0gs=;
        b=c9XgGsl1zbqM2sva4joEfnSV7hDID7Lv3Hg9YmulQCxI46Pp32uMd+U93tz6FJcf9V
         +dwPmAPherZPRSAPkRCBzDzYIYIu97H2V97Ttm5U4NWXfsUKtdsqFJgWVIBzAKCUcZTo
         xBMxTdBDP8/4T09zUqXjktns3k7pmDbDTMghuXfiRMsHXCnRMIc5kq+Bnxn7Ul/uGbnv
         hqMrlrHpY9fr05VsFp4rrpRL8GLQTfhnP46jRWB41y34YhEDaK+TR11g+1WarhhgRnyD
         qk5I0dc+ciajtCCqUhXOrWwj58BMGhjxEO/UP5ll3cEIE0XQczrU2+2Cqbk5kI2RBzx1
         k2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5I10KmTF85pJvFc7zWF/I23hQrUb++spC+kPfoWl0gs=;
        b=cAwF3dLNDR+UdVC+9REBXzrtjD7cmt9EaOd0+pZAeCS8Smmxunxh5KiEqTkR3l3Dlk
         YqKnZA74RW3yME01mZDVyLJGeUo7oX88ZYN0oRZjVh7fuvEMEk2Gsa+F6xLK4N0Lh6cv
         j0h6mkUZX1sHJaf8woFFOg3RAathroqXhF6BZZ/v8H923FzDiQ5I9lzLjdzg8yun2UP4
         hW777o+k9xIhVwYbnwsQ9nUl9+bmgyTMQivBt85zKKkV/+RSAcxkYrqjik2fsvcKVecH
         MSbuislSX+JzNJ7MgUN6OLyxRItxuGkXultnNg6AvPkVvoXH6AzkVGo7AA9a8BCuPT58
         Z9aQ==
X-Gm-Message-State: AOAM5334fyoJDOU8+srw3+SEUDNuh/oqqK9eoTp76f1lSajucZ5u53bQ
        pkk8nBcsTWj5p4+4r/dvKeSItKZnPgAM+ReKsjBsYWhMghg8qLLCzhNs03X7xSkghnBrWrYjWk+
        7QzSJ1a46aceQh/g7BomkxEy7cRKaS24DJt526DCzpfRVWlUWwbr4uGmCNTbUIcI2m8G6GaPJMP
        XK
X-Google-Smtp-Source: ABdhPJyOUjg2iuItG5KmaZ6zQLnZF+LuuNxppSFBsY6NFp8yarG7SYRJ+2b6G2g8e7XiyXxlGLdY8F2+ucC9
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:fdf3:9f7d:e4e3:ccad])
 (user=apusaka job=sendgmr) by 2002:a25:390:: with SMTP id 138mr21736645ybd.130.1616392868490;
 Sun, 21 Mar 2021 23:01:08 -0700 (PDT)
Date:   Mon, 22 Mar 2021 14:01:01 +0800
Message-Id: <20210322140046.1.I6c4306f6e8ba3ccc9106067d4eb70092f8cb2a49@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH] Bluetooth: check for zapped sk before connecting
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        syzbot+abfc0f5e668d4099af73@syzkaller.appspotmail.com,
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

There is a possibility of receiving a zapped sock on
l2cap_sock_connect(). This could lead to interesting crashes, one
such case is tearing down an already tore l2cap_sock as is happened
with this call trace:

__dump_stack lib/dump_stack.c:15 [inline]
dump_stack+0xc4/0x118 lib/dump_stack.c:56
register_lock_class kernel/locking/lockdep.c:792 [inline]
register_lock_class+0x239/0x6f6 kernel/locking/lockdep.c:742
__lock_acquire+0x209/0x1e27 kernel/locking/lockdep.c:3105
lock_acquire+0x29c/0x2fb kernel/locking/lockdep.c:3599
__raw_spin_lock_bh include/linux/spinlock_api_smp.h:137 [inline]
_raw_spin_lock_bh+0x38/0x47 kernel/locking/spinlock.c:175
spin_lock_bh include/linux/spinlock.h:307 [inline]
lock_sock_nested+0x44/0xfa net/core/sock.c:2518
l2cap_sock_teardown_cb+0x88/0x2fb net/bluetooth/l2cap_sock.c:1345
l2cap_chan_del+0xa3/0x383 net/bluetooth/l2cap_core.c:598
l2cap_chan_close+0x537/0x5dd net/bluetooth/l2cap_core.c:756
l2cap_chan_timeout+0x104/0x17e net/bluetooth/l2cap_core.c:429
process_one_work+0x7e3/0xcb0 kernel/workqueue.c:2064
worker_thread+0x5a5/0x773 kernel/workqueue.c:2196
kthread+0x291/0x2a6 kernel/kthread.c:211
ret_from_fork+0x4e/0x80 arch/x86/entry/entry_64.S:604

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reported-by: syzbot+abfc0f5e668d4099af73@syzkaller.appspotmail.com
Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
---

 net/bluetooth/l2cap_sock.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index f1b1edd0b697..b86fd8cc4dc1 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -182,6 +182,13 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr,
 
 	BT_DBG("sk %p", sk);
 
+	lock_sock(sk);
+	if (sock_flag(sk, SOCK_ZAPPED)) {
+		release_sock(sk);
+		return -EINVAL;
+	}
+	release_sock(sk);
+
 	if (!addr || alen < offsetofend(struct sockaddr, sa_family) ||
 	    addr->sa_family != AF_BLUETOOTH)
 		return -EINVAL;
-- 
2.31.0.rc2.261.g7f71774620-goog

