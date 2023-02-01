Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7FFC636D4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Feb 2023 22:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjBAWHK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Feb 2023 17:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjBAWHJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Feb 2023 17:07:09 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A3F721F7
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Feb 2023 14:07:08 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id g16so63009ilr.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Feb 2023 14:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7qBOJJL6bFuTm1U8vjLcOThb0TL+SIsfvVZy3FYLJ14=;
        b=i6wU/EfkdN+zyN+x6M4CBuLoZtjWpPomn/qv2h7SEKsu2FRWGQsIREXqWeml5sYPHW
         Bdc/FY/O1TLvKu+2w77fUGl0bFeKFlSQCg9xaKHYFbv4Dt+duMuUi1C572h0KAIYq98u
         HXlh8HT8g2HY7uc/JQ9GkH6L9d+78HtHBvq+8+CdxWe/Vf7HtnltlfhqVyhn4s9iFKv+
         g1Zo9s4UmMUQThEX52rCptGEApN0m1w0a4FXZ5yQe9R3m1Dqf3ClDEzRhjgIPw18OVv1
         sibLZ/MWvSOtjga7S8XR62cO4fMG3bel54GFvC2BSodaJ+xrxLAUy28vIJZCE92Rzc0f
         b+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7qBOJJL6bFuTm1U8vjLcOThb0TL+SIsfvVZy3FYLJ14=;
        b=V/syEhA6fOyI1NcEdUNVW/hd8pbAyP1neOxdnXzOxaL+hK619DMMuES2MrlAVfEr4x
         mTScP8ZoZHlalpyWx1Xzl7qoMbgyQrmUuIuLtovn9Noz7iOSKV+scNfcCH4AyFQGxGDg
         XVtNwFhdj/npBpGMFK77jCZ3StkuOcwcIq5sp1Ufw2hMawYSvN7ty90aGcV5alJVcBRN
         eSnV+8rFM0VojfsrrugEogZ7ROHPx1GsNKD7BupyzUhW1DPusXaYjpWgFwtu7DwwekQ4
         fBI8kCxgyTmGVORt4Zfh4v4ghua04x2qOZvXeoX9rOhxqhnCK1xokZg+LL1+yt5S74qr
         PqkA==
X-Gm-Message-State: AO0yUKUol2Zd0EFl/xkmU+AKglx8Aqv0ywkK00AyislQpZ3+Z4UkZM8+
        MvRXS3KdnN2ZyyhDVRWpyahvojdOwBE=
X-Google-Smtp-Source: AK7set81ldF6VxYJmrGhr0W8CKOYw76UtELVf+1MnjYcNnBq3jPzYNJ3Q+yoi4QoV92qqlM7NirqLg==
X-Received: by 2002:a92:c645:0:b0:311:ad48:ff20 with SMTP id 5-20020a92c645000000b00311ad48ff20mr256032ill.8.1675289226836;
        Wed, 01 Feb 2023 14:07:06 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id l12-20020a056638220c00b0039e68e9988csm2751772jas.56.2023.02.01.14.07.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 14:07:06 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: L2CAP: Fix potential user-after-free
Date:   Wed,  1 Feb 2023 14:07:03 -0800
Message-Id: <20230201220704.1543663-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes all instances of which requires to allocate a buffer calling
alloc_skb which may release the chan lock and reacquire later which
makes it possible that the chan is disconnected in the meantime.

Fixes: a6a5568c03c4 ("Bluetooth: Lock the L2CAP channel when sending")
Reported-by: Alexander Coffin <alex.coffin@matician.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 24 ------------------------
 net/bluetooth/l2cap_sock.c |  8 ++++++++
 2 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a3e0dc6a6e73..adfc3ea06d08 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2683,14 +2683,6 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
 		if (IS_ERR(skb))
 			return PTR_ERR(skb);
 
-		/* Channel lock is released before requesting new skb and then
-		 * reacquired thus we need to recheck channel state.
-		 */
-		if (chan->state != BT_CONNECTED) {
-			kfree_skb(skb);
-			return -ENOTCONN;
-		}
-
 		l2cap_do_send(chan, skb);
 		return len;
 	}
@@ -2735,14 +2727,6 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
 		if (IS_ERR(skb))
 			return PTR_ERR(skb);
 
-		/* Channel lock is released before requesting new skb and then
-		 * reacquired thus we need to recheck channel state.
-		 */
-		if (chan->state != BT_CONNECTED) {
-			kfree_skb(skb);
-			return -ENOTCONN;
-		}
-
 		l2cap_do_send(chan, skb);
 		err = len;
 		break;
@@ -2763,14 +2747,6 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
 		 */
 		err = l2cap_segment_sdu(chan, &seg_queue, msg, len);
 
-		/* The channel could have been closed while segmenting,
-		 * check that it is still connected.
-		 */
-		if (chan->state != BT_CONNECTED) {
-			__skb_queue_purge(&seg_queue);
-			err = -ENOTCONN;
-		}
-
 		if (err)
 			break;
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index ca8f07f3542b..eebe256104bc 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1624,6 +1624,14 @@ static struct sk_buff *l2cap_sock_alloc_skb_cb(struct l2cap_chan *chan,
 	if (!skb)
 		return ERR_PTR(err);
 
+	/* Channel lock is released before requesting new skb and then
+	 * reacquired thus we need to recheck channel state.
+	 */
+	if (chan->state != BT_CONNECTED) {
+		kfree_skb(skb);
+		return ERR_PTR(-ENOTCONN);
+	}
+
 	skb->priority = sk->sk_priority;
 
 	bt_cb(skb)->l2cap.chan = chan;
-- 
2.37.3

