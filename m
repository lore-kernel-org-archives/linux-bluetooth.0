Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265C9C001E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Jul 2023 01:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjGXBmN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 23 Jul 2023 21:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjGXBlk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 23 Jul 2023 21:41:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930CA4EE0;
        Sun, 23 Jul 2023 18:36:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 085F860F14;
        Mon, 24 Jul 2023 01:33:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4765FC433CB;
        Mon, 24 Jul 2023 01:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162384;
        bh=UyHxfqUl9MQg/GfcFVN8UXFu7u8PfUUqHYukYbKHR6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sxOwL+CKPl5X8G4AW0/9V54vK2SljDsxckKu5qACOogdasoPGVEUUDzOJHB8Ao0Qh
         TAmhkwVtRTGAsvhMkBflgJ/fm0q9CbvkB5ZG4RfE+sNWcOXhfkMaMvKnE8YasQBCLM
         c+mmrkqeNG9nRc1f+YGYJbR7SCWc8Ef0xxqfwkpCvrM1Oo+t0CkEUBuoyTbHjoe60s
         t0ZXlkrI/4ZBDWGEZIW4N9pZCLc2/SlM4kFKQvXL+SBvvjbgiNVPTtHGeeo3rJVAnu
         SgNLnyEGzfs2LXxWSPXeXKGhIslvczlpwQgBC7bGMUzquPkeZs7ejmDtKfaldLFlmn
         xz6Rk5BvQxxiw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhengping Jiang <jiangzp@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>, marcel@holtmann.org,
        gustavo@padovan.org, johan.hedberg@gmail.com, davem@davemloft.net,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 19/34] Bluetooth: L2CAP: Fix use-after-free
Date:   Sun, 23 Jul 2023 21:32:22 -0400
Message-Id: <20230724013238.2329166-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013238.2329166-1-sashal@kernel.org>
References: <20230724013238.2329166-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.40
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Zhengping Jiang <jiangzp@google.com>

[ Upstream commit f752a0b334bb95fe9b42ecb511e0864e2768046f ]

Fix potential use-after-free in l2cap_le_command_rej.

Signed-off-by: Zhengping Jiang <jiangzp@google.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/l2cap_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 02fc9961464cf..a7899857aee5d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6375,9 +6375,14 @@ static inline int l2cap_le_command_rej(struct l2cap_conn *conn,
 	if (!chan)
 		goto done;
 
+	chan = l2cap_chan_hold_unless_zero(chan);
+	if (!chan)
+		goto done;
+
 	l2cap_chan_lock(chan);
 	l2cap_chan_del(chan, ECONNREFUSED);
 	l2cap_chan_unlock(chan);
+	l2cap_chan_put(chan);
 
 done:
 	mutex_unlock(&conn->chan_lock);
-- 
2.39.2

