Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10298CCA47B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jun 2022 19:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349911AbiFJTUC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jun 2022 15:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349805AbiFJTTz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jun 2022 15:19:55 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17ECC2C651
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 12:19:55 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id 144-20020a621496000000b0051ba2e95df2so98886pfu.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 12:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+dbqcGyic4c3zYFWxW8WIDheVsDHS+XGvESBEzG7d5k=;
        b=VJWfSHAO2Je3tlWHbkl6eBf3JQors99nQSoFMQw5AngSQ7uNthpdVTVVO6if8U823B
         Wu1S8b2rx3Ak6ZkOk6+AwA9gGBNOOThMx8xQHTEW6s7PY/nUBi2uIclkac9x4cTHvxmo
         y/AJXy2aaupC/ITuM+2EZT3d4ceiyjYVlx4GC0SwtlZuKBtjFcy8EeMDNXQjTjgKmwiO
         YMx+HsIRaSR+hgiXac40qw+UTiQ5bhIIl843JQc3xND8j8ThTL2i79J9eJ9I2kPOTUhP
         l8UN1bhL572rWtU7JWt1Y+XqSDy0cbu4e8aGAxD0ZcWNoS6OGV3QWf79o7u/NVh09cqV
         5qng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+dbqcGyic4c3zYFWxW8WIDheVsDHS+XGvESBEzG7d5k=;
        b=awTQEJ1kZlYjClLR9FQZY19ksGf0mMY3nqg/rfSexayOyb3PSOzuKgCvFGLkfNBHhr
         hyFKN6g6nSnt0btqE1KEjtAGYPD+WgUPaKWXEDO5Hnt/ern9Oemg5HZzZ0ziN8Hr1xpM
         U3CazIvRtCbhAoLbgEEGTVrl7ZIO6nPq/chAJ5HAdUWfocmYHLxATZ5Z9pa9BEiANof7
         Lnazq1fEcylZbqmCkSdKoFtgIfVMGll5qKLu3omP2DDrI42iR2YgwXNtQLDGK2+sBs+b
         Rbkv6VPPP97Z8rRvt9AZPodroozzi0ZrXu/MnjiFDn0bawgkuy0X+EZxgEtWmi+QviNJ
         g27w==
X-Gm-Message-State: AOAM533qyV8MCfv4mQvpmOdbQEDS5wkQE8sfWSRHl4tH9n+MVwN2FVA+
        nlaB10UpG/hd/t0dzJRpQiwaxLZpyOl5sHsX7q0hur+cjagU9ACaIlbzqHpVJAULo1pqzY2G6JR
        zW53+ZKMChWQsFMdVUbJ0d/1tLu0Khv2sKQCrMebGeNWHpd1g7g5RsuCwc2j68Oee5pzbkbwUFk
        3H
X-Google-Smtp-Source: ABdhPJyMdoK0Z7VltgUeKks6E5rfObRdmAL0gzme9n9MCpzTKMf4h5EvoDtvJMEi3EHvOfGfzYtIGm3btkTn
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a17:902:6bc6:b0:166:3c39:50a1 with SMTP id
 m6-20020a1709026bc600b001663c3950a1mr46022372plt.36.1654888794338; Fri, 10
 Jun 2022 12:19:54 -0700 (PDT)
Date:   Fri, 10 Jun 2022 12:19:34 -0700
In-Reply-To: <20220610191934.2723772-1-jiangzp@google.com>
Message-Id: <20220610121915.kernel.v1.1.Ia621daca5b03278ee09314c59659b64c901408cf@changeid>
Mime-Version: 1.0
References: <20220610191934.2723772-1-jiangzp@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [kernel PATCH v1 1/1] Bluetooth: mgmt: Fix refresh cached connection info
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Zhengping Jiang <jiangzp@google.com>,
        Brian Gix <brian.gix@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Set the connection data before calling get_conn_info_sync, so it can be
verified the connection is still connected, before refreshing cached
values.

Fixes: 47db6b42991e6 ("Bluetooth: hci_sync: Convert MGMT_OP_GET_CONN_INFO")
Signed-off-by: Zhengping Jiang <jiangzp@google.com>
---

Changes in v1:
- Set connection data before calling hci_cmd_sync_queue

 net/bluetooth/mgmt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 74937a8346488..cfbea6fa04335 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6828,11 +6828,14 @@ static int get_conn_info(struct sock *sk, struct hci_dev *hdev, void *data,
 
 		cmd = mgmt_pending_new(sk, MGMT_OP_GET_CONN_INFO, hdev, data,
 				       len);
-		if (!cmd)
+		if (!cmd) {
 			err = -ENOMEM;
-		else
+		} else {
+			hci_conn_hold(conn);
+			cmd->user_data = hci_conn_get(conn);
 			err = hci_cmd_sync_queue(hdev, get_conn_info_sync,
 						 cmd, get_conn_info_complete);
+		}
 
 		if (err < 0) {
 			mgmt_cmd_complete(sk, hdev->id, MGMT_OP_GET_CONN_INFO,
@@ -6844,9 +6847,6 @@ static int get_conn_info(struct sock *sk, struct hci_dev *hdev, void *data,
 			goto unlock;
 		}
 
-		hci_conn_hold(conn);
-		cmd->user_data = hci_conn_get(conn);
-
 		conn->conn_info_timestamp = jiffies;
 	} else {
 		/* Cache is valid, just reply with values cached in hci_conn */
-- 
2.36.1.476.g0c4daa206d-goog

