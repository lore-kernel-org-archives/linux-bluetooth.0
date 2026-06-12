Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73AD38A717
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 14:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781274609; cv=none; b=EB2jwZzKWmr7cuf4rM0nJ/a/9Zo+Lky/AmAXkf3Mn95cc93+gG4QcFhxaoOEMq5T9tRpgymplyk+63l30Pxy+JlkEUGUljsUqt90SNRJkjW/xY5gJvGhTbuetSUqio1HSpFgWKVtPIi218l0n/vYg8GxzQ31P4D52RB5bwjc1Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781274609; c=relaxed/simple;
	bh=42vq0s1CW6pS5npu7NBYbdRSd18x/BIg0hFEwy9H4rw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=mZdHUo31f9wxBwLJu47B19corfTJB/aFzYkJRYKKgxhQUX7zwPby4O2yllmoCW5iBjaFsGPxRTQjmvzDuOKNAisb3cWqwQ9NjVkbYW9CnZ+Vq1dRiCSnNA7oZ6NdfhewOCIbq1NKaprZNzOoWU+JgavYIV62l78Y4Pmyes4eSlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4RCOGLS; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4RCOGLS"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-59d4aa96ef2so680841e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 07:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781274607; x=1781879407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fC0FS23L2Hrrdg7BKtz+clG1pu/KUe07eS2fGcZDIu8=;
        b=c4RCOGLSQbejv+Qws7MPivV16k1ulNkIcfnn5ww9Bc3gAto3Id0764qz018nNqOdWs
         Hdh7W3+q2q2fgTsDK/esLD0I+Gt8jzBLCRzJ1kY23SqhjmL1yXi0SbAnEZ1VCzfSQTFq
         lfKiB0diQWs1Jttj/fWXdgo3B83bK65lo9coz42yKornu7Y89hSIbqQM47v6Tp546x8o
         ZChH7snQ8Db+E7hMZ6UiGSkYINFQZ/ZjvyUl+yGeBHrMn79Rqp+bhsSCJYo++/BNLNsl
         gGwhazeyWRKvniqjarcduuV3HnOQYMQtTW97ik/Yyz5lSdUUlZiuPpZBGAonse5Ra7Bu
         jgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781274607; x=1781879407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fC0FS23L2Hrrdg7BKtz+clG1pu/KUe07eS2fGcZDIu8=;
        b=ltdVYmtBFnzAqijkV0W8lZoSbCMmaPiu7A+x9V16MqjbZPxHHwcCeVjMoV5TJGkulI
         KSOfJmx8EedsQgN/ycdOyqd/Mr5qArr99KLulYc+6kqj4cSA6FHb7O9jvt6OrdZ8LphK
         UsHKQibFALlHl7fjRVbiS6gOe6zP00hBSVVVq6Rl+wAmAR/FTl//nbxS2QIlrD7T1e7t
         2lai6DkS6OQLPkbkWNum0oXnSXBU6wgSJ4Fb4x8iPvlT2y2lGon6jqrZfZRpySsvh9Ar
         4K1JDeoxpshtbTrzY0SHL83xW/pBspaasK6mHJ8AjIBVm4GenC48wyfVdeX+cvWvRR0K
         RXZw==
X-Gm-Message-State: AOJu0Yy17oCSfN82L48kr1Z4hSh5Yo1foXCG3+pp78ddaapzoSBLiboF
	Ullrj5qZ/hjtrXyv0apJ65jN7hdKckXNK1NiN/Sd04hw+Du90hkPW37zqPabPYYN
X-Gm-Gg: Acq92OH9OgfzKkWIaaVJ6XugQ1SYKR/tCqSVSEt4nUUHWk941aMPAku+q/NwrDw1NJj
	tFjsCY56Y3+BK1kpn3WYZvjTb0gKL/oVvpiOnxDFJ1XKqHgUhwptyy3Zzp3pmnOiJkvU87aI4IG
	Yc+6tVyfxHzqjucLt6/ibZ78eA7LAT2f5a/Q4+isoZueEfnWWwUEhCOphfEcGtpt5+MRas9Uxsm
	V9yNQRcZMK4H9As7LLPejBOrIYJZS0qxA0hqmppq46d9unzVW7okOd2GAzZ7ma112QiuKJHM/xo
	qJ/ljhvzuBVptX+1/lmVdIDX38ZTH6kt5bvaR5vyQ7YcsyF1dz6/L40PVK55FmDya8d9mdg9OBi
	dxdUweUt+7Ou7ZUCNV8sGvGL1XT3NmK0jeRZtr0aKha16z1R2+Jvjk9pTJ0Gi7wp76grRmAQO4D
	nlo+cidjxrVwg9LnZGxMC6xxe/M+fsZILs5UgozCEFc6hXB/TrbxKrLcEP+f8hbGvr8UeVR/bvA
	8GY6zBM3GFQzW3FpQ==
X-Received: by 2002:a05:6102:1611:b0:633:7d88:c77d with SMTP id ada2fe7eead31-71e88fda267mr1729559137.29.1781274606784;
        Fri, 12 Jun 2026 07:30:06 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-71e85ab7f41sm1566953137.0.2026.06.12.07.30.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 07:30:06 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: 6lowpan: Fix using chan->conn as indication to no remote netdev
Date: Fri, 12 Jun 2026 10:29:57 -0400
Message-ID: <20260612142957.524526-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

b66774b48dd9 ("Bluetooth: L2CAP: Fix UAF in channel timeout by holding
conn ref") don't reset the chan->conn to NULL anymore making the bt#
netdev not be remove once the last l2cap_chan_del is removed.

Instead of restoring the original behavior this remove the logic of
keeping the interface after the last channel is removed because it
never worked as intended and the l2cap_chan_del always detach its
l2cap_conn which results in always removing the channel anyway.

Fixes: b66774b48dd9 ("Bluetooth: L2CAP: Fix UAF in channel timeout by holding conn ref")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/6lowpan.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index cb1e329d66fd..dba0c9128cf6 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -801,16 +801,6 @@ static void chan_close_cb(struct l2cap_chan *chan)
 
 	BT_DBG("chan %p conn %p", chan, chan->conn);
 
-	if (chan->conn && chan->conn->hcon) {
-		if (!is_bt_6lowpan(chan->conn->hcon))
-			return;
-
-		/* If conn is set, then the netdev is also there and we should
-		 * not remove it.
-		 */
-		remove = false;
-	}
-
 	spin_lock(&devices_lock);
 
 	list_for_each_entry_rcu(entry, &bt_6lowpan_devices, list) {
-- 
2.54.0

