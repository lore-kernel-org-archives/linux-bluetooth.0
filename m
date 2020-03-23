Return-Path: <SRS0=apyX=5I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB93AC54FCF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Mar 2020 20:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1CC72070A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Mar 2020 20:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epGuupSZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgCWUfF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Mar 2020 16:35:05 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38075 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgCWUfE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Mar 2020 16:35:04 -0400
Received: by mail-pl1-f196.google.com with SMTP id w3so6422924plz.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Mar 2020 13:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VVQ7vhvCR/dzXjhnVWZBKnsMGVGyca6I+XsQHNIPA+E=;
        b=epGuupSZqKI2RoPNpW3BKmwAAxYPbR/BkRLGvlG8wFlzDdsAPMRKJ1lyJiakdMZ2pb
         2DqUoS/NHUeigZ7UeH3/gOpSS/Nbyi8m5oenpH7sWMg7fL0FRskfBPKd6SJjP0nrES10
         +VVNJYVPzBTGY0C3000vEyueabt0Yuq8pCcqAbLwtvmEFueCJgA7mrDpy0yDZWXyuh9q
         f+WNLqfVE4uVsBnz1jHEsjDNX6T1MKHCMe7R8VxbJoirSS0x+C2uBLYcu7vclfXmH2lE
         jRyJDYA/Nh9pEB/b6tYR8VrT8xG9kYofZsVnFs4V6Zb6yRV1AoJGQBzZeSeMYfi41Y18
         GX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VVQ7vhvCR/dzXjhnVWZBKnsMGVGyca6I+XsQHNIPA+E=;
        b=SurhtGujj+UQldX370mT32RZmE/kmLSL2Bk2cIkBc6G5xDzhV2LZom1fASLcCE/hjd
         biYwoRu7fxaUR5ODHCBrZc1BMDsY2HGtm3not17ziTP8pziBTNDYxRb5NqO+LPA3NeSm
         i4FPdSlJ8hlNRSVWK3zv7UKMVpTuXs4x5bEcnsCRSw4YMS9mTfHtr3w1E1s/AzzPbVfb
         Du36TZi2dR0BdUMb80UNcKqy9GyJyfnYq1P6Z/X33zRb3nsv3hT60n6zO5BLI72zHNBs
         6hLgdhb4palWzRIsg8Lx6jSVnQdl3YGCnKXtHPWkih4FouT8ah8M4PGKM4J/gFSTqKaC
         2WxA==
X-Gm-Message-State: ANhLgQ2RMkg4SkaTxZ+M0GvggAhStodFINdC+uGVd+MrN6B06PQpLlVC
        AOEXLUgmN0VwSKTfIUWwkldOOyb/
X-Google-Smtp-Source: ADFU+vtJ+98TrOP/hFTclDZYGAxYz0gd3p5nuJzh4K77oYXeaywyHPx1qcJC8+Tpn4f53+jfWwa7rA==
X-Received: by 2002:a17:902:ba8e:: with SMTP id k14mr9259436pls.103.1584995701433;
        Mon, 23 Mar 2020 13:35:01 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q71sm440469pjb.5.2020.03.23.13.35.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 13:35:00 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 1/3] Bluetooth: L2CAP: Add get_peer_pid callback
Date:   Mon, 23 Mar 2020 13:34:56 -0700
Message-Id: <20200323203458.24733-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200323203458.24733-1-luiz.dentz@gmail.com>
References: <20200323203458.24733-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a callback to read the socket pid.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/l2cap.h | 1 +
 net/bluetooth/l2cap_sock.c    | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 537aaead259f..2d7d28474d34 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -660,6 +660,7 @@ struct l2cap_ops {
 	void			(*suspend) (struct l2cap_chan *chan);
 	void			(*set_shutdown) (struct l2cap_chan *chan);
 	long			(*get_sndtimeo) (struct l2cap_chan *chan);
+	struct pid		*(*get_peer_pid) (struct l2cap_chan *chan);
 	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
 					       unsigned long hdr_len,
 					       unsigned long len, int nb);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 40fb10b591bd..117ba20ea194 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1504,6 +1504,13 @@ static long l2cap_sock_get_sndtimeo_cb(struct l2cap_chan *chan)
 	return sk->sk_sndtimeo;
 }
 
+static struct pid *l2cap_sock_get_peer_pid_cb(struct l2cap_chan *chan)
+{
+	struct sock *sk = chan->data;
+
+	return sk->sk_peer_pid;
+}
+
 static void l2cap_sock_suspend_cb(struct l2cap_chan *chan)
 {
 	struct sock *sk = chan->data;
@@ -1525,6 +1532,7 @@ static const struct l2cap_ops l2cap_chan_ops = {
 	.suspend		= l2cap_sock_suspend_cb,
 	.set_shutdown		= l2cap_sock_set_shutdown_cb,
 	.get_sndtimeo		= l2cap_sock_get_sndtimeo_cb,
+	.get_peer_pid		= l2cap_sock_get_peer_pid_cb,
 	.alloc_skb		= l2cap_sock_alloc_skb_cb,
 };
 
-- 
2.21.1

