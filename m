Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD246C47083
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Jun 2021 23:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5A6C613DC
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Jun 2021 23:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhFBXZl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Jun 2021 19:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhFBXZk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Jun 2021 19:25:40 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368A0C06174A
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Jun 2021 16:23:57 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id v14so3601725pgi.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Jun 2021 16:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3d3ivt1fYy7wYAy9VVau3f04+YK0DuDoNcN0/4A2FUE=;
        b=UdAluVuyagP99/ZWawjZTWUKDmBjNRmnVYav+Kx0nG5UiNy4V6DHEAC8ntqCCkmuFf
         gsCi9BqiZFS8al3aVRAjVo2VFnf8pIrZjizeesZSzTCSUalNzK8iC+h1nXtkGVFqIIMP
         +cpfDA32gwWTz1vNOOmj4BfMcxj9PYb9P9TQHu9prlWauCPDSDW/C9WFIFtmOeD2ORYo
         1y9AvfwJ315hCkAxEBKJFn3TP46EoPhdkuHn7pcSZWwqSyiIc2XOl+br3a72VqJlVw0J
         nBqIXalZdi0AGK0gRObqueTU0jEPjq3elg1yuKbohYsT3o3HODMD3x4CunyXeBDoNwvd
         uChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3d3ivt1fYy7wYAy9VVau3f04+YK0DuDoNcN0/4A2FUE=;
        b=fdJ9bCOtKdcb8HEbHdxYPe15bj6PfP/Z0+jyHO4bLbRUJvyuHmeChKf5972PAIjvNa
         ajOEFvEYCO+GJLcoZM5orkef1R0UqnL7Nk6GdcawUbFJ+pPYV0+l2V8Vqv9/Ag8qE6D0
         YPqT0uWlEto0UwU3cA9zCZLBfIFdbta4+Qb4tLdEY7oiH49V2NxoE0zUw5coRp3lBjgp
         wRwkYxSi/LGXKdHwCEKE3/GBnP/XprTXeeOE9CfDF1ZvEOQ+d9SxQJYEEUMKkWYHaF6G
         FilEh4acMXya0Gtat6+LiT2pqWNpYpQcbVHKemWpOhRAOatxxX2Bzt83SyansCzGUITE
         YDfA==
X-Gm-Message-State: AOAM531HaGPkwNU7IrMT/fEPYBBnDX/VCphhvK3kUGY+7HPO7Sl4doQl
        fTjMIKuphyN3YHPuSHE3DkUxXnGLiGo=
X-Google-Smtp-Source: ABdhPJxQwhaINPqsUyF0RLn+wNVjRWiRw+J2k2qrOA01HEplZ8DekihCm5mhS3OYnaeDIYaIaCUZvQ==
X-Received: by 2002:aa7:9a97:0:b029:2e9:e1fb:2f0d with SMTP id w23-20020aa79a970000b02902e9e1fb2f0dmr14680901pfi.45.1622676236466;
        Wed, 02 Jun 2021 16:23:56 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p11sm409093pjo.19.2021.06.02.16.23.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 16:23:56 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: L2CAP: Fix general protection fault in l2cap_chan_timeout
Date:   Wed,  2 Jun 2021 16:23:48 -0700
Message-Id: <20210602232348.766496-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Even though l2cap_chan_del calls __clear_chan_timer that uses
cancel_delayed_work which doesn't prevent the work to run as it could be
already pending.

So instead this check if chan->conn has been set to NULL, which indicates
that l2cap_conn_del might have run, and proceed to release its reference
since the channel has already been cleanup.

Reported-by: syzbot+008cdbf7a9044c2c2f99@syzkaller.appspotmail.com
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9ebb85df4db4..4408e07a00d1 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -414,11 +414,21 @@ static void l2cap_chan_timeout(struct work_struct *work)
 {
 	struct l2cap_chan *chan = container_of(work, struct l2cap_chan,
 					       chan_timer.work);
-	struct l2cap_conn *conn = chan->conn;
+	struct l2cap_conn *conn;
 	int reason;
 
 	BT_DBG("chan %p state %s", chan, state_to_string(chan->state));
 
+	conn = chan->conn;
+	if (!conn) {
+		/* Channel is no longer attached to a connection so
+		 * l2cap_conn_del might have run, just release reference
+		 * acquired via __set_chan_timer.
+		 */
+		l2cap_chan_put(chan);
+		return;
+	}
+
 	mutex_lock(&conn->chan_lock);
 	/* __set_chan_timer() calls l2cap_chan_hold(chan) while scheduling
 	 * this work. No need to call l2cap_chan_hold(chan) here again.
-- 
2.31.1

