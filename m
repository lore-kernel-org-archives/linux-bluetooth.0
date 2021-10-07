Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA2FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Oct 2021 20:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 388876103B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Oct 2021 20:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242204AbhJGU2e (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Oct 2021 16:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242188AbhJGU2c (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Oct 2021 16:28:32 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8FEC061570
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Oct 2021 13:26:27 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id x8so4641593plv.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Oct 2021 13:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IGbnUIj88kv4IctJqhWuPp16vyq/nK0+wFYaOnm/rak=;
        b=OvP6bBw+OiyQ4quwOqVIj9hOMjJbr/zI/bx9vCtdlqCaMXCLU+zJpqqAZ7cTFZagKP
         5FdLlrGggAGPVKUxJ1G30atzPKJEKZPjcbZKXiwDWOKZN9TsTBpLJRW7o3l1MYFgGWGO
         FQfF4rYb7AsBUo77W77eHSO8maw+P7RrHpQvzLquKgq4SghgLPtjdmGHAAXUGFVbD9/m
         e0OCQgdc3G9NamJiVG3HlaXfiAeW1qQpjsU+iLARuIQxf6EoUR141DaupqR4PY1EhM/g
         Zl++FJl7dZeMkfN6Wv9OhbCNpm0koX4TCY07gJMXhUWjfkTWizs2orgdR/XoeihEdimr
         q0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IGbnUIj88kv4IctJqhWuPp16vyq/nK0+wFYaOnm/rak=;
        b=F2mo2sNZ8WZd0zNFEOWMEeBFr/30TYZrXikt8gE/u28JSCgdoteoxzNoUMDdXQ76GB
         VJVXuTh0iH+s3TLhEbnCiPpHiAtqE6uIOfLo3jPD4HpofDeQEHIoMHgvDsxfTyZRA+rv
         94xb1a93tFOokk4p8SBlMGUv3XuDMDppS3Gt4jEAxZPgLPczMOsB8LRCqWYeMGDejT/W
         Gr1ytyz1Yq1wsJoPafo7ceRP4TqJY76sZFqqmnptUQsL9svpWaK9eMHvjroRNEq5YQ1U
         pHVtr9Xjp54ogEUVhFokv6lU3p4IXmTlzTeWI0mnk88bV+n4wg/dbRr1IbjFndB+Fgv9
         zWyw==
X-Gm-Message-State: AOAM530I+ssuMLt3phSlIs1v/E/Gq40vAmwM5QDeXI7CDEZI2b1kypJ7
        mWZYtJxv1uoo6/cUYKogwxI17kXczts=
X-Google-Smtp-Source: ABdhPJwV+jZhx1j2BNxj8tGfoNZj0s3uar7uDe5PfQPM3dDCJkZxEbqUuiWR5PR37q4SIOjZL9CXgw==
X-Received: by 2002:a17:90b:1d0d:: with SMTP id on13mr7280025pjb.118.1633638386669;
        Thu, 07 Oct 2021 13:26:26 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id o2sm9184580pja.7.2021.10.07.13.26.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 13:26:26 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: L2CAP: Fix not initializing sk_peer_pid
Date:   Thu,  7 Oct 2021 13:26:25 -0700
Message-Id: <20211007202625.1462550-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In order to group sockets being connected using L2CAP_MODE_EXT_FLOWCTL
the pid is used but sk_peer_pid was not being initialized as it is
currently only done for af_unix.

Fixes: b48596d1dc25 "Bluetooth: L2CAP: Add get_peer_pid callback"
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_sock.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 160c016a5dfb..4574c5cb1b59 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -172,6 +172,21 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 	return err;
 }
 
+static void l2cap_sock_init_pid(struct sock *sk)
+{
+	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
+
+	/* Only L2CAP_MODE_EXT_FLOWCTL ever need to access the PID in order to
+	 * group the channels being requested.
+	 */
+	if (chan->mode != L2CAP_MODE_EXT_FLOWCTL)
+		return;
+
+	spin_lock(&sk->sk_peer_lock);
+	sk->sk_peer_pid = get_pid(task_tgid(current));
+	spin_unlock(&sk->sk_peer_lock);
+}
+
 static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr,
 			      int alen, int flags)
 {
@@ -243,6 +258,8 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr,
 	if (chan->psm && bdaddr_type_is_le(chan->src_type) && !chan->mode)
 		chan->mode = L2CAP_MODE_LE_FLOWCTL;
 
+	l2cap_sock_init_pid(sk);
+
 	err = l2cap_chan_connect(chan, la.l2_psm, __le16_to_cpu(la.l2_cid),
 				 &la.l2_bdaddr, la.l2_bdaddr_type);
 	if (err)
@@ -298,6 +315,8 @@ static int l2cap_sock_listen(struct socket *sock, int backlog)
 		goto done;
 	}
 
+	l2cap_sock_init_pid(sk);
+
 	sk->sk_max_ack_backlog = backlog;
 	sk->sk_ack_backlog = 0;
 
-- 
2.31.1

