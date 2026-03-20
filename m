Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9710438B7DD
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 11:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774006885; cv=none; b=HAU0tt5nvMIHEZDZuHS/OrOImiJZAO161EXzN1hYmMX7CIiWGz3P9+OTmygCSPoIgiVRkSxkNZQGjKo+A/nlr/yp4FaO45LU45W5Rgo/oldXC5gcvHAW4yTtk4KGP4xHk0eLxQEypim5648yOdS+iNbZz3HfeTc5HvO/19k/WcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774006885; c=relaxed/simple;
	bh=f/DikWeJE/8CN4XADRhWNewIbHTJ7ktyivdX6fz8MQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dfs1Jth4xXWZYpBtxMJH8AdNcplSW+1UW4UE8PhC9JpwoRGryBBffRpXh4HnMjMVeQSat+qzwQBQ98sqmnAq6quRLPYqgjyF6tRAjXTbYGzRHw9fQs2qVIfBKc/KaUZUrzYXEY0rKGFWcZaEoMS8GNXd6oYsWrIy14cAuCCECN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xe93b6WN; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xe93b6WN"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82735a41920so831261b3a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 04:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774006883; x=1774611683; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jxMMmq1bbA7qqGB9MU5p67lG9mJP8jUhg6my0u/i0YY=;
        b=Xe93b6WNj2hpciMbYC5272RMYaLUAZWy0p53LLwcojuFADU1SsyhZ0tiWuVgiQH+Ly
         jMY1MUeTsqjCslwg4+0sk4oKApBpRNPI7xTHxKKPfB4pdB7wovfzbA/qKzsa+q7Rh7xU
         Cx53S7VDv/gFh6UEcEdXRUVswl6Y3YniP1LwBjJX2mqqQpDm3w9KbLPausSnqKSOtRrO
         SdbtdgRvBvBmUBZgVNAWBoY+47Rd4I+I0lqvOJXPvFnjCwAD+NAoyivH1lKS1zSS2F5r
         3GIdZ5ndBR0cHNtcjOltScHV/Uaugz48RGNT79+iDzW7EZy80DuUr9uHWUYlfFzJma5T
         yXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774006883; x=1774611683;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jxMMmq1bbA7qqGB9MU5p67lG9mJP8jUhg6my0u/i0YY=;
        b=l7NBkuEEOw8InT+B9MjP+7jDtPQi2vUvCOW5oF5ER+FsEqPYefXUfvQ8LqrFq9ociK
         1sTI+1/qmj5Cvu+Rf1EuSgjuEMHfAR9AulbOVSUF0z1KE/uD+Rh6q/srmW12hzSLRQ3W
         BK91DQluB9jGxGAVR8rrs13JwPhMXTT0/yMSgE6JBSHpArLuF0YGy8uzJCU4DMQ8LHrH
         XTSKFJpfpMJyTTxFp5Q3OGQuol5DgdJo1Q1JzYb16FGrPzb7JuYquGlCxzb9gnfKHFMR
         MYKcEkPnWdSCr+qnBbMLsnEL9UQBU44su7515lfiknOJwGJBLKUKa66510c2PZWU/7Im
         AnaA==
X-Gm-Message-State: AOJu0YxPZ2ZBGRm8q2D17hTBG2X7BAt6/uMHW3EWRxhyYsnALCEvcxLP
	EVV/pC3qv727KkgAF44NFRA8srTe59/pi9eyriZM/O7efNAEOThAu64L
X-Gm-Gg: ATEYQzyro253v3U6L9UyLLRhunCKTBhVqXN+vxTPLrCPMvYCCBhNcQJ8/SAbED1dJkh
	SVn4/CzGy/gpYaxgNFteDHE8VPihxLhQXEe2g3jjVHXVdgyXmwy5S8VPiu2JG8I25BWvWjr9fOt
	oZGV66UzfRo0z+tXMfVSPHQnQhJizjjyWkehbLZebg6mjMqR73iaJJ5GI7tKCPVcb7x9PUu+DRu
	2/eFgbbLbfUmSFLGNsL5t4IWCC0UfbKc4mbswIPWd9RzfkgIu7RQHZaC+omN3plDbavawitqa90
	eHFKqCOBgeIUjYxZfQc9AkBbOSBqko+Auh3+bAyMDkJbHdW/6Kg0KZPmIAeCajqmvFGYwL1VRkn
	bcq6TtVsHMMZXxQGLuWKBOrQIfdg+2Z30V1khuqxhUw0bmeKychQL3LyMnjlf8t5P5xM3LUT0bA
	FS552+jpcseTBwZpLNmslvGlaZT9lEN7ioVfGbtHF7Z9U43RPlVH49
X-Received: by 2002:a05:6a00:ac8f:b0:82a:7471:eb90 with SMTP id d2e1a72fcca58-82a8c35cfb1mr2051065b3a.30.1774006882721;
        Fri, 20 Mar 2026 04:41:22 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03bc1e59sm1935791b3a.13.2026.03.20.04.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 04:41:22 -0700 (PDT)
Date: Fri, 20 Mar 2026 20:41:19 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH v2] Bluetooth: L2CAP: Fix use-after-free in l2cap_chan_timeout
Message-ID: <ab0yX61gGSlEaMEF@v4bel>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

l2cap_chan_timeout() reads chan->conn without holding any lock and
without taking a reference on the connection. If l2cap_conn_del()
frees the connection concurrently, mutex_lock(&conn->lock) operates
on freed memory. Additionally, the existing NULL check early return
leaks the channel reference held by the timer.

Fix the root cause by disabling channel timers when the channel is
being destroyed. Use disable_delayed_work() in l2cap_chan_del() to
prevent timers from being rearmed, and disable_delayed_work_sync()
in l2cap_conn_del() to ensure running timer work has completed
before the connection is freed.

The sync cannot be done directly inside l2cap_chan_del() because it
would deadlock in three independent ways: (1) l2cap_chan_timeout()
can call l2cap_chan_close() -> l2cap_chan_del(), so syncing chan_timer
would wait for itself; (2) callers hold conn->lock while
l2cap_chan_timeout() acquires it; (3) callers hold chan->lock while
the ERTM timer functions acquire it. Therefore, the sync is
performed in l2cap_conn_del() after releasing conn->lock.

Also fix the reference leak on the !conn early return path in
l2cap_chan_timeout().

Fixes: 3df91ea20e74 ("Bluetooth: Revert to mutexes from RCU list")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
Changes in v2:
- Moved the fix from l2cap_chan_timeout() to l2cap_chan_del()/l2cap_conn_del() to address the root cause instead of adding locking in the callback
- Used disable_delayed_work()/disable_delayed_work_sync() to prevent timer rearming and ensure completion, as suggested by Luiz
- Applied the fix to all four channel timers (chan_timer, retrans_timer, monitor_timer, ack_timer)
- Removed l2cap_conn_get()/l2cap_conn_put() and the lock reordering that caused a circular locking dependency in v1
- v1: https://lore.kernel.org/all/abwSxg_C6n8Avid3@v4bel/
---
 net/bluetooth/l2cap_core.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 5deb6c4f1e41..c08478e4512b 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -411,8 +411,10 @@ static void l2cap_chan_timeout(struct work_struct *work)
 
 	BT_DBG("chan %p state %s", chan, state_to_string(chan->state));
 
-	if (!conn)
+	if (!conn) {
+		l2cap_chan_put(chan);
 		return;
+	}
 
 	mutex_lock(&conn->lock);
 	/* __set_chan_timer() calls l2cap_chan_hold(chan) while scheduling
@@ -649,6 +651,11 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
 	struct l2cap_conn *conn = chan->conn;
 
 	__clear_chan_timer(chan);
+	/* Prevent the timer from being rearmed since the channel is about
+	 * to be destroyed. Running timer work will be synced by
+	 * l2cap_conn_del() after releasing conn->lock.
+	 */
+	disable_delayed_work(&chan->chan_timer);
 
 	BT_DBG("chan %p, conn %p, err %d, state %s", chan, conn, err,
 	       state_to_string(chan->state));
@@ -688,6 +695,10 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
 		__clear_retrans_timer(chan);
 		__clear_monitor_timer(chan);
 		__clear_ack_timer(chan);
+		/* Prevent the ERTM timers from being rearmed. */
+		disable_delayed_work(&chan->retrans_timer);
+		disable_delayed_work(&chan->monitor_timer);
+		disable_delayed_work(&chan->ack_timer);
 
 		skb_queue_purge(&chan->srej_q);
 
@@ -1742,6 +1753,7 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 {
 	struct l2cap_conn *conn = hcon->l2cap_data;
 	struct l2cap_chan *chan, *l;
+	LIST_HEAD(del_list);
 
 	if (!conn)
 		return;
@@ -1780,7 +1792,7 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 		chan->ops->close(chan);
 
 		l2cap_chan_unlock(chan);
-		l2cap_chan_put(chan);
+		list_add_tail(&chan->list, &del_list);
 	}
 
 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)
@@ -1791,6 +1803,20 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 
 	hcon->l2cap_data = NULL;
 	mutex_unlock(&conn->lock);
+
+	/* Disable and sync-wait for any running channel timer work without
+	 * holding conn->lock to avoid AB-BA deadlock with
+	 * l2cap_chan_timeout() which acquires conn->lock.
+	 */
+	list_for_each_entry_safe(chan, l, &del_list, list) {
+		disable_delayed_work_sync(&chan->chan_timer);
+		disable_delayed_work_sync(&chan->retrans_timer);
+		disable_delayed_work_sync(&chan->monitor_timer);
+		disable_delayed_work_sync(&chan->ack_timer);
+		list_del(&chan->list);
+		l2cap_chan_put(chan);
+	}
+
 	l2cap_conn_put(conn);
 }
 
-- 
2.43.0

