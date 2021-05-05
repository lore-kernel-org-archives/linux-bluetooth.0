Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548ECC433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 May 2021 16:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32FED613F1
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 May 2021 16:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbhEEQdT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 May 2021 12:33:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:52820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234235AbhEEQc4 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 May 2021 12:32:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7FEF66140F;
        Wed,  5 May 2021 16:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620232319;
        bh=ozxYQK2I4m6WXRH/vrM28MgAhUkooC2xtMvHqQPFQho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OI7/M76apy0hG2Q4Jxx1onZbb9bEK5CrexJEBt/+UaSOeYnxLvsY6ZjRRcuATMT9F
         qkLDnfjhL10KpIzcQ9XRoMOJerupex+BoeZZe1+8CA0ZmJsGrNVW1dDVBrM5OJ+58g
         vFKAWJqXsc4/IZmNpWgaTmX0XJovrKzAtB662b2HCYN4FeF6V7HhGmZVGykonlvGlx
         MRcYy4GpaJqbZVYzuF4AGCZ7YAQgO1cVyFQYakVOxLVQ4w1/faucXnTJy3QNa8cMR2
         Pz9G1o8gVlav+/gvOhD1ZMlR1SiQyD73J+vC60Rrn4hN5EnnlXp2idnE677lnt+szT
         uQGaqcXdKi9zg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzbot <syzbot+fadfba6a911f6bf71842@syzkaller.appspotmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.12 025/116] Bluetooth: initialize skb_queue_head at l2cap_chan_create()
Date:   Wed,  5 May 2021 12:29:53 -0400
Message-Id: <20210505163125.3460440-25-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210505163125.3460440-1-sashal@kernel.org>
References: <20210505163125.3460440-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[ Upstream commit be8597239379f0f53c9710dd6ab551bbf535bec6 ]

syzbot is hitting "INFO: trying to register non-static key." message [1],
for "struct l2cap_chan"->tx_q.lock spinlock is not yet initialized when
l2cap_chan_del() is called due to e.g. timeout.

Since "struct l2cap_chan"->lock mutex is initialized at l2cap_chan_create()
immediately after "struct l2cap_chan" is allocated using kzalloc(), let's
as well initialize "struct l2cap_chan"->{tx_q,srej_q}.lock spinlocks there.

[1] https://syzkaller.appspot.com/bug?extid=fadfba6a911f6bf71842

Reported-and-tested-by: syzbot <syzbot+fadfba6a911f6bf71842@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/l2cap_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index db6a4b2d0d77..53ddbee459b9 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -451,6 +451,8 @@ struct l2cap_chan *l2cap_chan_create(void)
 	if (!chan)
 		return NULL;
 
+	skb_queue_head_init(&chan->tx_q);
+	skb_queue_head_init(&chan->srej_q);
 	mutex_init(&chan->lock);
 
 	/* Set default lock nesting level */
-- 
2.30.2

