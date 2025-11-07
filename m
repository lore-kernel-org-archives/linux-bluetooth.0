Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C7C2BD035;
	Fri,  7 Nov 2025 02:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762482044; cv=none; b=F/wztbErFuzRyn9D/t/dxCJRO1qd7VNkQJFG0gYq2z9QOyeI1hVHFLqdxn2CUasxfTivZZM0uSkI5f7wxQVVELK2mExhTkaYOR5hKzCQew6N8k8CfAbT8BwF0zytgVPPPpJJNKmtGLewHOujKM0rc+bLub/QcjfAc6/YlZtn5rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762482044; c=relaxed/simple;
	bh=Ny+6vkzKc4zkwO8uwY1INd1R0sOhilS5aqCiyhq1rbU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S9smph/Il6j8XnksCTNdu0jwiRVAeJmopxMlL7FBx2iFlGLYtvyfBoSmkd8ta7b/4XC5CBaGqzmSyw9gZIN+5bqvAuYJ+u5TZeEqmmXrvm146Q+x7lYeFf4MARgEdnl1wMbfvkywn3+sqv8kCfQNgKLhbT5ILjWNUFAkg+u+/es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Itl8F5vn; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Itl8F5vn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=bf
	lethlmeHZPFEpFeRmxTMVBg9IRRWI8M8mJnAhn2rI=; b=Itl8F5vnPBJTnn3PzC
	7ZCWOnSXWqTAgezDmva8UXyvDF3vS+Vplf87mjZCTsbZnk5gdz0c2Y/rfv6bRd55
	JlgRh6m/E7fzzB1onruKWB2Nxw3yvtMocgytiimcsIIdBes+3vuYUOgWlcNtGf3K
	WUAlW8Wn0qLDkjOys8DzO5w3s=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgD3H4ttVw1pBXYgDA--.272S2;
	Fri, 07 Nov 2025 10:20:31 +0800 (CST)
From: Gongwei Li <13875017792@163.com>
To: marcel@holtmann.org
Cc: johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gongwei Li <ligongwei@kylinos.cn>
Subject: [PATCH] Bluetooth: use memset avoid memory leaks
Date: Fri,  7 Nov 2025 10:21:02 +0800
Message-Id: <20251107022102.266003-1-13875017792@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgD3H4ttVw1pBXYgDA--.272S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr4UWFy8Zw1fWF4DCr4fuFg_yoWfArb_X3
	4ruayxuF45J342ya17Xa18Wr1Yyan5Cr95WwnIqry5Xa48Jw47Kr4I9r15XFn7G34DCFy3
	A3y5J340y3yxJjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUehNVPUUUUU==
X-CM-SenderInfo: rprtmlyvqrllizs6il2tof0z/1tbiXRj9umkMAYgUBwABs8

From: Gongwei Li <ligongwei@kylinos.cn>

Similar to the handling of l2cap_le_connect in commit a5133fe87ed8
("Bluetooth: use memset avoid memory leaks"), we thought a patch
might be needed here as well.

Use memset to initialize structs to prevent memory leaks
in __l2cap_le_connect_rsp_defer.

Signed-off-by: Gongwei Li <ligongwei@kylinos.cn>
---
 net/bluetooth/l2cap_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d08320380..b987ba5de 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3786,6 +3786,7 @@ void __l2cap_le_connect_rsp_defer(struct l2cap_chan *chan)
 
 	BT_DBG("chan %p", chan);
 
+	memset(&rsp, 0, sizeof(rsp));
 	rsp.dcid    = cpu_to_le16(chan->scid);
 	rsp.mtu     = cpu_to_le16(chan->imtu);
 	rsp.mps     = cpu_to_le16(chan->mps);
-- 
2.25.1

