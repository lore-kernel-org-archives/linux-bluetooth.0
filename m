Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEA1C61DB3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Jan 2023 03:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbjAKDSn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Jan 2023 22:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234596AbjAKDS1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Jan 2023 22:18:27 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDBA140D2
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jan 2023 19:18:23 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id q64so14483470pjq.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jan 2023 19:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DAbF+23J3WNopzFWmwTkdmCspCTcLNnSoUJcTK0GAFs=;
        b=DE/cmeK3OBSndt4c0IKA6JG+HDRlOVKjYBXKoUihcvFcJ03NuoZwBVHI7wxYUvMJxT
         wuZiHEjFprkHQl3NkLLHZtmv2YdO9qBE6cpxlLWIVEJUPeD6QLsqgY8SGHFIzDnv76mE
         vZoICCP+B8Zt7b9OorU2AuvtzSSo/rp3U9qjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DAbF+23J3WNopzFWmwTkdmCspCTcLNnSoUJcTK0GAFs=;
        b=X05DTXRTE3xyLu+OZ/bw1587zuwzyh6Ltk6wruqwQMPYEeX7mabiXIZAeHTeqBSkvD
         9+r9CsY2s1KuoNJZj4FfNcqYJOTtdHAMOUzPmJm/fBkKv9qnkXge2lYin9lZ6Uh52CBK
         hSgs3m2BOgQNkUpOQ825elnI1qwODo/fsXoeF8ovoq73B7ylwpEFgXaIRDeQY3uZeH1F
         BCAFmpb1JYCZ62HIWbJ+HV6+jDS3Peiqihg0FdFN/Io3tAon2wE4xgxjQ3EnOrPUCU0e
         /wCZJNXUbBuJ8MthKFlAImwplVfXJ6HET644r0LZiqWX3WCf8Dd7rHykZJNeTkSOfYzK
         HsZw==
X-Gm-Message-State: AFqh2kqAiubSDX22OnKRwq4qJhWWYEV2qu25LxGw1pSvnzqWV+BPmMdF
        L/cUvdMIhWv1Wk3AOh7o6VPrJT2w25WpqSVj
X-Google-Smtp-Source: AMrXdXtdXPd92VZ4OuZs+hLhLJ0sBhmQ9zsy8iKrN3gjRA28v67aK3QwpoKwrHM7ZfKUz/fBm/dk8g==
X-Received: by 2002:a05:6a20:3c8a:b0:af:8128:757 with SMTP id b10-20020a056a203c8a00b000af81280757mr110302543pzj.61.1673407102474;
        Tue, 10 Jan 2023 19:18:22 -0800 (PST)
Received: from localhost (21.160.199.104.bc.googleusercontent.com. [104.199.160.21])
        by smtp.gmail.com with UTF8SMTPSA id gk19-20020a17090b119300b00218f9bd50c7sm7896488pjb.50.2023.01.10.19.18.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 19:18:21 -0800 (PST)
From:   Ying Hsu <yinghsu@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        leon@kernel.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Ying Hsu <yinghsu@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Tedd Ho-Jeong An <tedd.an@intel.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v3] Bluetooth: Fix possible deadlock in rfcomm_sk_state_change
Date:   Wed, 11 Jan 2023 03:16:14 +0000
Message-Id: <20230111031540.v3.1.I1f29bb547a03e9adfe2e6754212f9d14a2e39c4b@changeid>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot reports a possible deadlock in rfcomm_sk_state_change [1].
While rfcomm_sock_connect acquires the sk lock and waits for
the rfcomm lock, rfcomm_sock_release could have the rfcomm
lock and hit a deadlock for acquiring the sk lock.
Here's a simplified flow:

rfcomm_sock_connect:
  lock_sock(sk)
  rfcomm_dlc_open:
    rfcomm_lock()

rfcomm_sock_release:
  rfcomm_sock_shutdown:
    rfcomm_lock()
    __rfcomm_dlc_close:
        rfcomm_k_state_change:
	  lock_sock(sk)

This patch drops the sk lock before calling rfcomm_dlc_open to
avoid the possible deadlock and holds sk's reference count to
prevent use-after-free after rfcomm_dlc_open completes.

Reported-by: syzbot+d7ce59...@syzkaller.appspotmail.com
Fixes: 1804fdf6e494 ("Bluetooth: btintel: Combine setting up MSFT extension")
Link: https://syzkaller.appspot.com/bug?extid=d7ce59b06b3eb14fd218 [1]

Signed-off-by: Ying Hsu <yinghsu@chromium.org>
---
This commit has been tested with a C reproducer on qemu-x86_64
and a ChromeOS device.

Changes in v3:
- Revise the commit message.

Changes in v2:
- Fix potential use-after-free in rfc_comm_sock_connect.

 net/bluetooth/rfcomm/sock.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 21e24da4847f..4397e14ff560 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -391,6 +391,7 @@ static int rfcomm_sock_connect(struct socket *sock, struct sockaddr *addr, int a
 	    addr->sa_family != AF_BLUETOOTH)
 		return -EINVAL;
 
+	sock_hold(sk);
 	lock_sock(sk);
 
 	if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND) {
@@ -410,14 +411,18 @@ static int rfcomm_sock_connect(struct socket *sock, struct sockaddr *addr, int a
 	d->sec_level = rfcomm_pi(sk)->sec_level;
 	d->role_switch = rfcomm_pi(sk)->role_switch;
 
+	/* Drop sock lock to avoid potential deadlock with the RFCOMM lock */
+	release_sock(sk);
 	err = rfcomm_dlc_open(d, &rfcomm_pi(sk)->src, &sa->rc_bdaddr,
 			      sa->rc_channel);
-	if (!err)
+	lock_sock(sk);
+	if (!err && !sock_flag(sk, SOCK_ZAPPED))
 		err = bt_sock_wait_state(sk, BT_CONNECTED,
 				sock_sndtimeo(sk, flags & O_NONBLOCK));
 
 done:
 	release_sock(sk);
+	sock_put(sk);
 	return err;
 }
 
-- 
2.39.0.314.g84b9a713c41-goog

