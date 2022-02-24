Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7478C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Feb 2022 10:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbiBXKHX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Feb 2022 05:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbiBXKHN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Feb 2022 05:07:13 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809182FFFB
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Feb 2022 02:06:43 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d17so1479692pfl.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Feb 2022 02:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=matician-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xBqvho+whDOFUprZBfh/FlTaGfzYbzGv44LqXg6OZyk=;
        b=ZxWBiVHYP3wHFTlORGloxO3rJ0vVgDUEVkz7sOzMBkV5egX/c+uuWF4iI7OGSgYqkY
         X9W4UmsM7VZyHgsEuKSJ/vXS9Fm+GzOHplH0QDr8udnwrNYuZrAq8xXTRPe8WReEyJLc
         /6Dw5bD/PjpX9VMChyZHNPFBae8oDUXe7Q9uw792NdQbXhWD3K0yzP/rGDlVvFAwzWJv
         3wpZ7TUoMe1NUPVsaoHVR/h/Bmb+D6P1hGbCszZ256sCAnY6NxEz8QSMJk6tz11fJtQz
         EVVgYXAQIPy5W8m8nHCtsSQ8U0JVSiH3+nQNE5+D+ZwiQc5/l9Y3ZmfKWcnAvDUbhb7U
         xkcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xBqvho+whDOFUprZBfh/FlTaGfzYbzGv44LqXg6OZyk=;
        b=oZtxvkrunC52VxHqCCovFK7N2SU+mMH1kl/TQCG8gqOlVJOvXl8Z4ihxCUWadJo67v
         FMYQavQTK5ORgJArWlENY9cscHE6g27toN8nSg2bnTH3+nqM7pO/ohQveOAx6P/tCokS
         BCBwII4XWCCzTf7CYZgFYlgsn6gHSZnr8jO/v5iRu9Bw8kATMR/1T8HzsDKWxkH5cR1i
         dG67q+BZBMu+JEfrKCCD6Uf8/vSjipqKMQdoefWhNdiOTj5G6tBo+GBkpKXQPNyZqdbP
         LnZlgjEDypeX8Ov+6bMaymXnLUahpB+H/IL2cHeIeNQTpYzkNMUuaRxf7RWkdxZxFxTV
         Ey/A==
X-Gm-Message-State: AOAM531PjP7geglxA11lmLgbgt5v7B69qFhP/7DJ7uI90iBAoiC6mQPo
        FRn0W9RJsbJsa5BqPIIGkz6Uxg==
X-Google-Smtp-Source: ABdhPJyX3iBxZh6VPM6PRSaB59VTGVVIrKYrbRZ6jUFAz5hO6sksc0J0tUeuZcXgbLvg6KyKAx0Y0w==
X-Received: by 2002:a63:9dc3:0:b0:373:5fac:6063 with SMTP id i186-20020a639dc3000000b003735fac6063mr1678845pgd.531.1645697202960;
        Thu, 24 Feb 2022 02:06:42 -0800 (PST)
Received: from mtgav.corp.matician.com ([38.88.246.146])
        by smtp.gmail.com with ESMTPSA id u18sm834613pge.91.2022.02.24.02.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 02:06:42 -0800 (PST)
From:   gavin@matician.com
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, Gavin Li <gavin@matician.com>
Subject: [PATCH] Bluetooth: fix incorrect nonblock bitmask in bt_sock_wait_ready()
Date:   Thu, 24 Feb 2022 02:06:41 -0800
Message-Id: <20220224100641.2449550-1-gavin@matician.com>
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
index a647e5fabdbd6..87f0bba39b0f7 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -343,7 +343,7 @@ int  bt_sock_stream_recvmsg(struct socket *sock, struct msghdr *msg,
 __poll_t bt_sock_poll(struct file *file, struct socket *sock, poll_table *wait);
 int  bt_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
 int  bt_sock_wait_state(struct sock *sk, int state, unsigned long timeo);
-int  bt_sock_wait_ready(struct sock *sk, unsigned long flags);
+int  bt_sock_wait_ready(struct sock *sk, unsigned int flags);
 
 void bt_accept_enqueue(struct sock *parent, struct sock *sk, bool bh);
 void bt_accept_unlink(struct sock *sk);
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index ee319779781e6..69374321130e4 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -568,7 +568,7 @@ int bt_sock_wait_state(struct sock *sk, int state, unsigned long timeo)
 EXPORT_SYMBOL(bt_sock_wait_state);
 
 /* This function expects the sk lock to be held when called */
-int bt_sock_wait_ready(struct sock *sk, unsigned long flags)
+int bt_sock_wait_ready(struct sock *sk, unsigned int flags)
 {
 	DECLARE_WAITQUEUE(wait, current);
 	unsigned long timeo;
@@ -576,7 +576,7 @@ int bt_sock_wait_ready(struct sock *sk, unsigned long flags)
 
 	BT_DBG("sk %p", sk);
 
-	timeo = sock_sndtimeo(sk, flags & O_NONBLOCK);
+	timeo = sock_sndtimeo(sk, flags & MSG_DONTWAIT);
 
 	add_wait_queue(sk_sleep(sk), &wait);
 	set_current_state(TASK_INTERRUPTIBLE);
-- 
2.34.1

