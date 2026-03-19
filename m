Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3FB3D3481
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 15:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773933261; cv=none; b=fKI3PiTTZ8fnHdqHiG9wsTOkJLCxEvdsrGuGh5cJG1R+gio4t2i+Z4jk/cCuVnSV37VyXLLyGhjOnqHgS3aF4qDKsptyI2mcwN5DsL0WtlantpBLjR7SrtcZFu054R7TXYrZi+d9QcWqDWWgRvbjnGmbOs0ncyv0qpRwDUfrmao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773933261; c=relaxed/simple;
	bh=Yh1KWG36tQefR8k0X3ZkMlmQTGTOabvf8mYG/l5cCCw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WDLhjUHl/kbbwwoThbzMcmIzex6Z21E6KMS9fTQYi/xoZ0iRomn1Yy8/FsAVhghhl/AeSsvTTvv196+4tLMLOKef3VQDB1yodocsrd2NXtULFxmlE1CK0qdL5ZrWi0WtLEC2Ji9bkq+m0i7ZkEWatEgyC0p7GJpEO+j63pVlhnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWhWU61K; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWhWU61K"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c742bc88d87so390613a12.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 08:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773933258; x=1774538058; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nCSEapq1J1ufHM2bvEKMNM9th4Sk3rQLQZ3x+hOj/gY=;
        b=BWhWU61KZdpbxfwT1WHnAmoZUcEMKhx/lTDZO0rh6Br5KA+oFNjMRTptqBDtQQPqPh
         XQu76WRzNc1RStmTbjH6IWYe/9PpjLbGUn6sYn/R660Q329vV36rM1t0DEuwNyr0rpoP
         YAROa4UBKI0VNIYXdquYxLWEVA4L6y5YY7e8AnNF8r4C6Ha986O+xR1jmMvFTUVEPbn9
         D5e/6sS7V0GfZmqbFGmrtFySRlbrdri/UTk9M8dN8XlHoIHBIDZ9NcX+iFcao4tjll2v
         uGOBmDsorueiPzUtshVBlhW3SkgjSPxeS7HiligkhOivGDz6rVzmvM1DyLsGML33WZI/
         oaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773933258; x=1774538058;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nCSEapq1J1ufHM2bvEKMNM9th4Sk3rQLQZ3x+hOj/gY=;
        b=WSQjzQPZhlJqsDIDukmzlhXDqshPmjxv0eGVp5roJFteWQb8K1bVo4rt/holkUwkF8
         GhPSTKXZPl+qce84zStOgYRa2J85jrKHC3RMo2u3PjDG29R2nFwn+M/fVAgM7hKwQJuA
         ZoTy40mcR/VF64mAV4ol6dFDrqM+xMZvZaWcefTRjCD9NlA0jfrAA0PLPPgjF/3o04e5
         fm7OAki72jsODqCihv86fhF7PPvl9pp4qVGmTHZqd3AQPXJsAPrvqId0OY+aw4KmZd/8
         U+X7mkytB3YMUHjWlHBC3XmoV9IiO+nvgGS8S6XiLIfQFAmy84oA0/rTbVMpVhINa6e0
         iARw==
X-Gm-Message-State: AOJu0Yy3A4AdXh/Riibf+eTeLSDD/WNOT+xrNfRpMRUtoee2fSm1UgcO
	XwZ5HLqzK7F3U7IMCUW9Psakhjqu1ZcCizMopD4uYQs5Hj35nEJnGkxv
X-Gm-Gg: ATEYQzyn+UZny8qVy0khLCH93w+e1Yew9Ysq/Oe6bQSPjwmCGCZ6zG+6Wk7JNqZ/uyI
	1XH6ILbkql4Grz+LNTJLb5eIXgjlQoB0BTEK9BPfApdqOO7/Yuy1h5cBjNjT3oDFDNSMas0Bb3k
	o62TumzpWzdsgqxc0yGnRuAgfv8vkMfz/CMQMBqTccYUWs1zFHst2LBwdX6+K6aLBTQiCbRgXnf
	tI9Y+Y5qidftSSmY2kvCPP3T0q3iJhyOG1Izzo5pxRBR6iC/dLns2hpmmkDU4A7ToGM33CsGvKf
	1JsvVNJ/TcsQ1n+0BvJOC8QcjKQlAb6N77OMN0WO5DX2FZ31oYfCy7hXGKVJTgRjzDYuEJn04D/
	cOmt90j+nW3ZlKE6NP4Td6ySd07m8+39fdx5myy2Q7HPI811fPTZFWpXbyv+mIC2/d9E1zu03ub
	3Sz0reX0STTe2OFLi11u9k+Wrh1jcwlJd3ONRPWT4YuA==
X-Received: by 2002:a05:6a21:392:b0:398:c0ba:9ceb with SMTP id adf61e73a8af0-39b99de916fmr6603654637.12.1773933258072;
        Thu, 19 Mar 2026 08:14:18 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6b531f35sm6361034b3a.11.2026.03.19.08.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 08:14:17 -0700 (PDT)
Date: Fri, 20 Mar 2026 00:14:14 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH] Bluetooth: L2CAP: Fix use-after-free in l2cap_chan_timeout()
Message-ID: <abwSxg_C6n8Avid3@v4bel>
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
on freed memory. The existing NULL check is insufficient as it cannot
prevent the connection from being freed after the check passes, and
the early return also leaks the channel reference held by the timer.

Fix by reading chan->conn under l2cap_chan_lock() and holding the
connection with l2cap_conn_get(). After acquiring locks in the correct
order (conn->lock then chan->lock), re-verify chan->conn in case
l2cap_conn_del() already cleaned up the channel.

Fixes: 3df91ea20e74 ("Bluetooth: Revert to mutexes from RCU list")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/bluetooth/l2cap_core.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index abd091155d04..a432e94281dc 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -406,13 +406,20 @@ static void l2cap_chan_timeout(struct work_struct *work)
 {
 	struct l2cap_chan *chan = container_of(work, struct l2cap_chan,
 					       chan_timer.work);
-	struct l2cap_conn *conn = chan->conn;
+	struct l2cap_conn *conn;
 	int reason;
 
 	BT_DBG("chan %p state %s", chan, state_to_string(chan->state));
 
-	if (!conn)
+	l2cap_chan_lock(chan);
+	conn = chan->conn;
+	if (!conn) {
+		l2cap_chan_unlock(chan);
+		l2cap_chan_put(chan);
 		return;
+	}
+	l2cap_conn_get(conn);
+	l2cap_chan_unlock(chan);
 
 	mutex_lock(&conn->lock);
 	/* __set_chan_timer() calls l2cap_chan_hold(chan) while scheduling
@@ -420,6 +427,17 @@ static void l2cap_chan_timeout(struct work_struct *work)
 	 */
 	l2cap_chan_lock(chan);
 
+	/* Recheck since l2cap_conn_del() may have cleaned up the channel
+	 * while we were waiting for conn->lock.
+	 */
+	if (!chan->conn) {
+		l2cap_chan_unlock(chan);
+		l2cap_chan_put(chan);
+		mutex_unlock(&conn->lock);
+		l2cap_conn_put(conn);
+		return;
+	}
+
 	if (chan->state == BT_CONNECTED || chan->state == BT_CONFIG)
 		reason = ECONNREFUSED;
 	else if (chan->state == BT_CONNECT &&
@@ -436,6 +454,7 @@ static void l2cap_chan_timeout(struct work_struct *work)
 	l2cap_chan_put(chan);
 
 	mutex_unlock(&conn->lock);
+	l2cap_conn_put(conn);
 }
 
 struct l2cap_chan *l2cap_chan_create(void)
-- 
2.43.0

