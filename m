Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767FB3806A2
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 11:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774004491; cv=none; b=giYoXZVrI3cHlk1yY2gWPscFzXgn8b0TiAohnLPRNSFmkWj17kRyoHPjJDIzHaD4OblHSn6m+gpmDHjdrUfYQiKPhPphx2v16TDK39jL7PcnNW6bYAV+7QPpX8mkd2X2X338d1tyYL0JbmPVL6LTChgh9/XxnOT4M5eyitwuf3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774004491; c=relaxed/simple;
	bh=7+DB3+vjlDhpyqptJ6jWB91ZjW4fJtENspxOZ3cozdI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jYJwOuIGTof2Dxss4DjRqQQV2lKuCvXRnF9LaAWLyzc/7R8h9zt3XTALivTkfGS9G6Ehjl0Eac+0EcStjKub6MPcyON74t3BfJE55B1kRktvWVlzSFcPabLNHeYWHcXDUkdQuqIJph31ytfErieg6Qf2LICUzEy70Ps3scEkm68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbNRDBbC; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbNRDBbC"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35bb9070644so336958a91.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 04:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774004490; x=1774609290; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FqQFOGzxjE5ZecTOXH8xi+uFz9L0OUi6AUwtTPl/2Ug=;
        b=PbNRDBbCk2n/ORUK122R+yUphIesP5enlYyeAUqqxblFzXu6rAoOamInB00WaZWDDe
         WKI/5TUse/+SDPV8r3fscUulJkZ0L4vEF2hb9M+NlHhLmLIinI7T4ZITDjvDqXL6Vctf
         iGSm9RPrH/HRV/vGuDPgojE7LzZi53xqu/Z+8wwJIzlpMiFjsQ0lVDdjaysgVd7YB7sH
         m7qaNNvhf3H0Uc89sOKUV6uGmvgNqS98C9qVdBSI25jPng7CL2zsYgRb6poeP10+UADw
         RiCffjwJDAZL1dBsGvb/9knWwlyBV67akS9xOmua2CtQrsqrGJO17zj0D7fPq6tb2CMC
         +lZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774004490; x=1774609290;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FqQFOGzxjE5ZecTOXH8xi+uFz9L0OUi6AUwtTPl/2Ug=;
        b=QtlbkimRmfoI2so8ltJc0iSVW2bw+uzTBSXQlr3PcxBvjeKRgpLZcmHawOD9/+Use9
         QA3YabU3FzXC4auF9WKWIOawdxnmSsRWks9QGUQdw8DsW1JUjUZ7A0h7aPgTmdiUYuu3
         FbsAzxKGo1cibieK7bsfgSTAWCzL2hRE3QCyQ/ayRHcqzqvuUSrxzkWYkkWx1Bb3tIEq
         10BE8yp37tT+BExUPnv78OvQJyqg6oGd9qC5SL1DQuHgfeWbX4A06evAguBIzHgqM9z3
         CPL/gYb4bToDM8GgfWRgnDHh0Wiw1gz6Cgw2Ow1y2l4AQRfEou+nK69YN8I6qhewijbZ
         f6Dw==
X-Gm-Message-State: AOJu0YzWw7HSCkeI1hqgcMxz//WQTZhtraqor/mNpQxbWk003a1Go04g
	9eDEylUcOymVilLdZvx+MnVZOtXrJcHOUa3jeZq94fnNVNbpderWqCfs
X-Gm-Gg: ATEYQzzAULhBy0U+c42bDR36kcMxVJiB36hh6xvLCRp9O41pi8NBfBwWdows9UA3VSM
	vHMQNI+o4/G3U0CBI3qJ/Rkk71mrUQ7gtQiDuq1NSkBiL7ffIkux0f2Vrip8A6Pr7kAmnKyzJC7
	OwDgqu1cabr2FQ6MVO7hU+c8xNbmKu3VrkQBUjK3sK5zayu2kKNxr/S/6tHkheAIxj/LOYEg/Mh
	ax5ikK8yZruDm/pBmgouQFhVfLnbBQ/4H1vnFSPnGvmfEriQyVVJIjwkWTCVXeqy7GETxtL9dxI
	a5DgTEa9+4J5S5MgyIzV0tVKys4HmmeLn86DVIQqL2Nh66J+zMcB3C1ZqAhJWhWOO34G5oMZ7zH
	PrZIitzjdzG7SuuCpSatv430nfMmbnaJR8T6Mm0QQ1Xsdla8J+6rdfi9JIrOk1HN8ouHZeDaVlk
	E11ME8or7xYtHJsYD2xMpEYh8y5Ldeu1ukXiQrRpU6yg==
X-Received: by 2002:a17:903:acb:b0:2ae:c5ae:cdfa with SMTP id d9443c01a7336-2b0827a7726mr21272915ad.28.1774004489682;
        Fri, 20 Mar 2026 04:01:29 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08354bcf0sm19970575ad.33.2026.03.20.04.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 04:01:29 -0700 (PDT)
Date: Fri, 20 Mar 2026 20:01:26 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH v2] Bluetooth: L2CAP: Fix deadlock in l2cap_conn_del()
Message-ID: <ab0pBlGrvw_SHFwB@v4bel>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

l2cap_conn_del() calls cancel_delayed_work_sync() for both info_timer
and id_addr_timer while holding conn->lock. However, the work functions
l2cap_info_timeout() and l2cap_conn_update_id_addr() both acquire
conn->lock, creating a potential AB-BA deadlock if the work is already
executing when l2cap_conn_del() takes the lock.

Move the work cancellations before acquiring conn->lock and use
disable_delayed_work_sync() to additionally prevent the works from
being rearmed after cancellation, consistent with the pattern used in
hci_conn_del().

Fixes: ab4eedb790ca ("Bluetooth: L2CAP: Fix corrupted list in hci_chan_del")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
Changes in v2:
- Replace cancel_delayed_work_sync() with disable_delayed_work_sync()
- v1: https://lore.kernel.org/all/abwTQVhyDv0_x26G@v4bel/
---
 net/bluetooth/l2cap_core.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 5deb6c4f1e41..b279620ed209 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1748,6 +1748,9 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 
 	BT_DBG("hcon %p conn %p, err %d", hcon, conn, err);
 
+	disable_delayed_work_sync(&conn->info_timer);
+	disable_delayed_work_sync(&conn->id_addr_timer);
+
 	mutex_lock(&conn->lock);
 
 	kfree_skb(conn->rx_skb);
@@ -1763,8 +1766,6 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 
 	ida_destroy(&conn->tx_ida);
 
-	cancel_delayed_work_sync(&conn->id_addr_timer);
-
 	l2cap_unregister_all_users(conn);
 
 	/* Force the connection to be immediately dropped */
@@ -1783,9 +1784,6 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 		l2cap_chan_put(chan);
 	}
 
-	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)
-		cancel_delayed_work_sync(&conn->info_timer);
-
 	hci_chan_del(conn->hchan);
 	conn->hchan = NULL;
 
-- 
2.43.0

