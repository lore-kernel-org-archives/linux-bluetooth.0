Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25449C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Mar 2022 03:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353673AbiCYDcf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Mar 2022 23:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234035AbiCYDcd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Mar 2022 23:32:33 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7519F3B3
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Mar 2022 20:31:00 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id x2so6788995plm.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Mar 2022 20:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GGiTeRG4IQk7h6C89ytVphusb4+2ymibartIH2Voor0=;
        b=jSy5FHrMi1uSu+9XPjkA6dqRLZHrwSVVPGi/LShhirbbhIg051NvEtAfXFZQohs/64
         XIjdKJvuE5u2BblRvrXXkEA1gfUwsaYQvUresbFcxHuNWXxMLwDOT8Ssi7PwdukIYdB4
         28jFf7mVxW74xbdy+ZKfKxYR6FgRn35qxHdOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GGiTeRG4IQk7h6C89ytVphusb4+2ymibartIH2Voor0=;
        b=FXPjvAKzXVfZQgZ5C+6nVBavZkqQxOEoZUlJ4zAopv9b7Uh7RT33arlrOXUnBk0qhS
         u3NXKt8wJhSx57B8HODGAv6A4aZ4I//zMfGKNF76BKpcqEW2Y6au4MjETaKdG65hTsXN
         BIJQ6svrbflKlyPq7NJeK3EqiJY/1v2pAVEQJHiRdvoOYwltd7fHolj4rEsKnUOjAKa1
         jBauArhAU6pJSwuHDnoh38rA00AlpsCO+J/EjK6ub42olCjHocDwRrhhxHzDEqHorTnH
         f1uqBmwyf+anDsOQWIe4qtjiDaPIeGhl4PPkcwIjrl1LFoT4XpVOZ7c0qPyRvPVnWqR8
         aWrw==
X-Gm-Message-State: AOAM533kjzWIi0tg9jV4kumT6e3xfZK4ix2G09IW+ZeUkADkzOJUECM5
        NZsj66WvLC1nueB/YckixB1BKA==
X-Google-Smtp-Source: ABdhPJyQm2KDpZRppICe4Wr5sAd4fXOScBA5SeJDI8r3lTjC/qlbZm17yG255aUtuU6tDztFm5IfAw==
X-Received: by 2002:a17:90b:1809:b0:1c7:28fb:bdd0 with SMTP id lw9-20020a17090b180900b001c728fbbdd0mr10228571pjb.231.1648179060040;
        Thu, 24 Mar 2022 20:31:00 -0700 (PDT)
Received: from localhost (0.223.81.34.bc.googleusercontent.com. [34.81.223.0])
        by smtp.gmail.com with UTF8SMTPSA id 21-20020a630115000000b00382a0895661sm3773921pgb.11.2022.03.24.20.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 20:30:59 -0700 (PDT)
From:   Ying Hsu <yinghsu@chromium.org>
To:     marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Ying Hsu <yinghsu@chromium.org>,
        Joseph Hwang <josephsih@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH] Bluetooth: fix dangling sco_conn and use-after-free in sco_sock_timeout
Date:   Fri, 25 Mar 2022 03:30:51 +0000
Message-Id: <20220325033028.1.I67f8ad854ac2f48701902bfb34d6e2070011b779@changeid>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Connecting the same socket twice consecutively in sco_sock_connect()
could lead to a race condition where two sco_conn objects are created
but only one is associated with the socket. If the socket is closed
before the SCO connection is established, the timer associated with the
dangling sco_conn object won't be canceled. As the sock object is being
freed, the use-after-free problem happens when the timer callback
function sco_sock_timeout() accesses the socket. Here's the call trace:

dump_stack+0x107/0x163
? refcount_inc+0x1c/
print_address_description.constprop.0+0x1c/0x47e
? refcount_inc+0x1c/0x7b
kasan_report+0x13a/0x173
? refcount_inc+0x1c/0x7b
check_memory_region+0x132/0x139
refcount_inc+0x1c/0x7b
sco_sock_timeout+0xb2/0x1ba
process_one_work+0x739/0xbd1
? cancel_delayed_work+0x13f/0x13f
? __raw_spin_lock_init+0xf0/0xf0
? to_kthread+0x59/0x85
worker_thread+0x593/0x70e
kthread+0x346/0x35a
? drain_workqueue+0x31a/0x31a
? kthread_bind+0x4b/0x4b
ret_from_fork+0x1f/0x30

Signed-off-by: Ying Hsu <yinghsu@chromium.org>
Reviewed-by: Joseph Hwang <josephsih@chromium.org>
---
Tested this commit using a C reproducer on qemu-x86_64 for 8 hours.

 net/bluetooth/sco.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 8eabf41b2993..380c63194736 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -574,19 +574,24 @@ static int sco_sock_connect(struct socket *sock, struct sockaddr *addr, int alen
 	    addr->sa_family != AF_BLUETOOTH)
 		return -EINVAL;
 
-	if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND)
-		return -EBADFD;
+	lock_sock(sk);
+	if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND) {
+		err = -EBADFD;
+		goto done;
+	}
 
-	if (sk->sk_type != SOCK_SEQPACKET)
-		return -EINVAL;
+	if (sk->sk_type != SOCK_SEQPACKET) {
+		err = -EINVAL;
+		goto done;
+	}
 
 	hdev = hci_get_route(&sa->sco_bdaddr, &sco_pi(sk)->src, BDADDR_BREDR);
-	if (!hdev)
-		return -EHOSTUNREACH;
+	if (!hdev) {
+		err = -EHOSTUNREACH;
+		goto done;
+	}
 	hci_dev_lock(hdev);
 
-	lock_sock(sk);
-
 	/* Set destination address and psm */
 	bacpy(&sco_pi(sk)->dst, &sa->sco_bdaddr);
 
-- 
2.35.1.1021.g381101b075-goog

