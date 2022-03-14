Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0385C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Mar 2022 22:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245701AbiCNWoK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Mar 2022 18:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241218AbiCNWoJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Mar 2022 18:44:09 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21055245B3
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Mar 2022 15:42:58 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id z16so16523687pfh.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Mar 2022 15:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=matician-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uXzImYVu46L9RJxzcSb8fukGJBZ9YUapZwZ4n8MosmU=;
        b=2DiO0nmg2U3FjfSWzpXOkvsw9dbGHxHmxWYt6EfHQuXT+egJXPTy0YDrXcjMEhbr9a
         obpY/DMuHedrBGwWs1owwnSq6nSfgsfUHU/VAgT2wVj8aAneZeMDuwj8y3Q6ACruLne0
         uo/Ch2uwHeKspZ8nVMfJVv+LQlXmCuU1FFvuRW6hy/sCiTKDfFRegyKRvBKP7OAxcgEF
         hXFtxw1LcnxrhThZNpeS4cUQZK8NhxPIyzZ+m1moHoOPwNeF9zchGhJvPOBL4UVspXOd
         Xm3hLVRe7PV7CBF4OD7mSrOH6Qcu63DYk5gSuYGGVuOYDizTdJrcAqVm6k677GdM7PNp
         xWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uXzImYVu46L9RJxzcSb8fukGJBZ9YUapZwZ4n8MosmU=;
        b=k+W9UCV7/xYuQWU2enATeplshlHqO2ookCxKnBGS4aX53lpNJZp942KdaSLF1I/5Yf
         6QlS6IpOQDnzmleMKbNuLafdkDB/VwdUWN401hQJwCZhhspvbYQhLH5vwhClwSfgrOp+
         dnce7167QZiSViHln09hpwx9f2lI3vPjiC9h/mKd3Xw1ZDhW7sVHl/HyTNPFqTo9mT2F
         iGBgPjRMEmw6rzbMQdLGkpVmo6C8Xfvl+/TzOzmMs7FJk/bRUAqkGM7oCfEyGKtpZiZ7
         DFDhnTqwZMhvzkTs1LxQcd8GHu0cBf3TMAzccaSHOQ8IG1P4oMN1VOOewLA6NV+W2rfw
         9IGw==
X-Gm-Message-State: AOAM5313+oFQk/3GI7TmfEs3bJULHv56a0l3n0unP9QEAVsSdfk0lYuz
        DBKrBbp34gnBY0CUIcAqt2Jwq/Uen3xBdQ==
X-Google-Smtp-Source: ABdhPJyhmjKU/QHo6+vZuGKKI2lzztiDxe6nnPy1UBAQXJc+Ah+Ysk9JtUrYzqCxfG+orKK8O7nEVQ==
X-Received: by 2002:a05:6a00:2284:b0:4f7:86a3:6f6 with SMTP id f4-20020a056a00228400b004f786a306f6mr20581671pfe.20.1647297777461;
        Mon, 14 Mar 2022 15:42:57 -0700 (PDT)
Received: from mtgav.corp.matician.com ([38.88.246.146])
        by smtp.gmail.com with ESMTPSA id c18-20020a056a000ad200b004f0f9696578sm24236463pfl.141.2022.03.14.15.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 15:42:57 -0700 (PDT)
From:   gavin@matician.com
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, Gavin Li <gavin@matician.com>
Subject: [PATCH v2] Bluetooth: fix incorrect nonblock bitmask in bt_sock_wait_ready()
Date:   Mon, 14 Mar 2022 15:42:52 -0700
Message-Id: <20220314224252.3166367-1-gavin@matician.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Gavin Li <gavin@matician.com>

Callers pass msg->msg_flags as flags, which contains MSG_DONTWAIT
instead of O_NONBLOCK.

Signed-off-by: Gavin Li <gavin@matician.com>
---
 include/net/bluetooth/bluetooth.h | 2 +-
 net/bluetooth/af_bluetooth.c      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index a647e5fabdbd6..59f6e7675554e 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -343,7 +343,7 @@ int  bt_sock_stream_recvmsg(struct socket *sock, struct msghdr *msg,
 __poll_t bt_sock_poll(struct file *file, struct socket *sock, poll_table *wait);
 int  bt_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
 int  bt_sock_wait_state(struct sock *sk, int state, unsigned long timeo);
-int  bt_sock_wait_ready(struct sock *sk, unsigned long flags);
+int  bt_sock_wait_ready(struct sock *sk, unsigned int msg_flags);
 
 void bt_accept_enqueue(struct sock *parent, struct sock *sk, bool bh);
 void bt_accept_unlink(struct sock *sk);
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index ee319779781e6..a0cb2e3da8d4c 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -568,7 +568,7 @@ int bt_sock_wait_state(struct sock *sk, int state, unsigned long timeo)
 EXPORT_SYMBOL(bt_sock_wait_state);
 
 /* This function expects the sk lock to be held when called */
-int bt_sock_wait_ready(struct sock *sk, unsigned long flags)
+int bt_sock_wait_ready(struct sock *sk, unsigned int msg_flags)
 {
 	DECLARE_WAITQUEUE(wait, current);
 	unsigned long timeo;
@@ -576,7 +576,7 @@ int bt_sock_wait_ready(struct sock *sk, unsigned long flags)
 
 	BT_DBG("sk %p", sk);
 
-	timeo = sock_sndtimeo(sk, flags & O_NONBLOCK);
+	timeo = sock_sndtimeo(sk, !!(msg_flags & MSG_DONTWAIT));
 
 	add_wait_queue(sk_sleep(sk), &wait);
 	set_current_state(TASK_INTERRUPTIBLE);
-- 
2.34.1

