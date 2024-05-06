Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984626FB2;
	Mon,  6 May 2024 02:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714962089; cv=none; b=NEqNTFawcOgz2y6P86dW0+cUz+FTQp6bBGDmhuvJds6NARsYQnufC42MhFv4e6F1DCeJ7dkLEP7nrQb7cCiEBeUPxriEvueJNw4J2M25HQlJTIahYj67bCKDgW+byMtfpqHYAS43pxmvLVv/QpEWXS+T5j2pwHmVgLEnb+Wfcds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714962089; c=relaxed/simple;
	bh=7bLnFvZ1umO1ZxHq9Z11J3dP1NrG5baf3UV++oXVLyU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dkT/js6cmpXzkYOOqjfIEoMHQ/OrxYsriXMSQQNYR/Y7kbyjv/LZZs1ppXSouXIJt7wlu69bqzL7Cxy7Z4A2E1DuwJzZo8Oj66WYw5eviNrAe0dWGoQc2a0gPft/eUuFLo7IqV2IYaG4OFnhXocgMPJDxJymk/nY/arWEqqDXQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6a0ff97a9c7so30398726d6.0;
        Sun, 05 May 2024 19:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714962086; x=1715566886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k/zLrkjUXSszkJnwHyoONG4BMNMkGjqzvlLRzb2NIU8=;
        b=AskSDxsePwu70KnbSaJHdimJDRL3+qsywxXEUiQ0a8zGrlQoZ0CX2KxHmswqodp+wI
         b/JNMK5GLdV2Dd4CxksPZn0/JBlk4Ahfkoxw/lEFeSBvCGjH+8qbyEP4wh02xpPMVyeU
         luK0iFrq95CiABhmhf/+usxcMLtSz/E+BjhUC69oP6x6vmaEmW6z6bs3wOu3xcdfO7p7
         h2rWHQeJwEULZFq+oJlT0qJwmysmOeBfOGlJygdyEVHHnrIOB0GlRJOoXiv6bpL/EGHn
         43H6c3W7blXZDoeuUPHdxzqbbW2dT5dDBgjhSnJW3KJ8gqOlSTOGsV4KxEAQk/ZFz+i5
         K8xg==
X-Forwarded-Encrypted: i=1; AJvYcCUVAoHzSucteFzqIguzbZ2TKLJnW0OukFvbvKI2ZPQvNHI5MZYJEZfizoSnFnf2ld1VHHj4VOeMAstU7W0gjr4vrt1PMnZxSByniy5+9RmJLH6XWKPkiARMyZdzwCRnRsTWqyb7YwqhTqj7Iohn
X-Gm-Message-State: AOJu0YyNj07MBhRqIBQUqV+0t0WZJ95bJsTzqPRf5XsHvh5i9uz2vdZk
	Prbyk5bqNct0w8ffxCAss+DRg3BMN3fQ8lq66KUQPGx3zE5osyGe
X-Google-Smtp-Source: AGHT+IGoEjqeSYnnD8JHHUJq6a5kin5Wmy3lmygGM0FONM/ra+U1Wc7nMxUyy3HsBJ/dNtCtwN9YPQ==
X-Received: by 2002:a05:6214:5651:b0:6a0:f637:667 with SMTP id mh17-20020a056214565100b006a0f6370667mr20651975qvb.12.1714962086422;
        Sun, 05 May 2024 19:21:26 -0700 (PDT)
Received: from tofu.cs.purdue.edu ([128.210.0.165])
        by smtp.gmail.com with ESMTPSA id q18-20020a0ce9d2000000b006a07e3701a2sm3329550qvo.143.2024.05.05.19.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 19:21:26 -0700 (PDT)
From: Sungwoo Kim <iam@sung-woo.kim>
To: 
Cc: daveti@purdue.edu,
	benquike@gmail.com,
	Sungwoo Kim <iam@sung-woo.kim>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: HCI: fix divide error in __get_blocks()
Date: Sun,  5 May 2024 22:20:36 -0400
Message-Id: <20240506022035.663102-1-iam@sung-woo.kim>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hdev->block_len could be 0. Fix this by adding a check.

divide error: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 PID: 9622 Comm: kworker/u5:4 Tainted: G        W          6.9.0-rc6-00001-g38e1170f515d-dirty #32
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: hci11 hci_tx_work
RIP: 0010:__get_blocks net/bluetooth/hci_core.c:3618 [inline]
RIP: 0010:hci_sched_acl_blk net/bluetooth/hci_core.c:3766 [inline]
RIP: 0010:hci_sched_acl net/bluetooth/hci_core.c:3806 [inline]
RIP: 0010:hci_tx_work+0x73e/0x1d10 net/bluetooth/hci_core.c:3901

Fixes: b71d385a18cd ("Bluetooth: Recalculate sched HCI blk/pkt flow ctrl")
Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
---
 net/bluetooth/hci_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 0efd59760..20b1cd7f3 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3762,7 +3762,7 @@ static void hci_sched_acl_blk(struct hci_dev *hdev)
 
 	__check_timeout(hdev, cnt, type);
 
-	while (hdev->block_cnt > 0 &&
+	while (hdev->block_len > 0 && hdev->block_cnt > 0 &&
 	       (chan = hci_chan_sent(hdev, type, &quote))) {
 		u32 priority = (skb_peek(&chan->data_q))->priority;
 		while (quote > 0 && (skb = skb_peek(&chan->data_q))) {
-- 
2.34.1

