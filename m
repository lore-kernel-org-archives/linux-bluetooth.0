Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053D843F8C9;
	Tue, 21 Jul 2026 08:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784621605; cv=none; b=XI7EfEyiinFI+uM1t063d0kCoQ5JBxH+sMJ2xvo0gTvRC8Ud4HyuIx8ThRb43QJWCPZyJ9SXYnCdPC6Me1EMpljlZaMqH7dLoV7SWB2rxyimcfh6GWeHFzyqe9TZoblcKTl8edOheUPZB54e+nFLQlOdNKJtRq9XrdTatAZXj44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784621605; c=relaxed/simple;
	bh=ZUrqTZz7MbMTEEhCw02voQYD7e0zh0WJBW5V/X95NGw=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=dUXAWQQlCh8KQugPDtPfyegUS+EDXckASY3tmRLmiKCiFntoKm8l9zm7JTcg7pPxIkcd1UBTBMbB7MmH3Piu2sK1z9jr2fiXfCOj8pw2PPBLcOQPGyo8kQUJJWU8/RxnBQ6SRL8SN9OLNSe+qYAThg5BxFJdwxUHE1wApqclNHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=t1mlKk1r; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="t1mlKk1r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1784621584;
	bh=HJiNJhcOjuBT8+fZJwW47LgAOV75xmZF3n5tZIv27RE=;
	h=From:To:Cc:Subject:Date;
	b=t1mlKk1rO5H4EgKskCr91cFF0wLqtvV8r6tVIwjVyM9p/9HwKMrs6QVSLljLw13m0
	 1bZZY+iq8m9pKIVdvvEadS6+go0u5rWIu0WWaoE9plflexanFJ+Lp+rqEXrv6MIMhP
	 QP5zbFkHqAy9pfHpLaAMNNMQD+B6eCM6xZfIURVI=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 3428EC10; Tue, 21 Jul 2026 16:13:02 +0800
X-QQ-mid: xmsmtpt1784621582tnocl7r5z
Message-ID: <tencent_C817DCB733CA5C38DBF7EE648B196E904509@qq.com>
X-QQ-XMAILINFO: NC4p7XQIBeahO99OUmHdDy4Lo4mw2JPdqWRuJJOMAV3WCN6QtleVtVibK//o31
	 Yu6kObDfT62+eV+NIZpKZLmzHWmmJWi48jz2/XLZTStTJ0S28Vzw7gYKbRjuDq3IWFzjohShULg8
	 hxYTd+eiBmo6G+m0Fi/7qywi08c3/vlXAg/yBMUpkEYU3T9884KUNcTUqBMGNHFXuDRc7Osjzlnt
	 nJP+Ig7oW81HhTNra9tIePyaPKnr2LXdRDH+AgsTpLHYdn0NvoSjPhnSVKMI8wbfe/wsujahKv0o
	 9dW86gytB9hxyoTp4mRW/Ac7VldnVSQ52/Pu/cKSG8n09isQ7Vi4AhDpxXErAa/f+wqo9QWJ53id
	 e6ms/OAfLjvb6z00wqYNDQ6C79daxccczAIQD/TeJWey2Sje+ukTOrqAk0AHqgiS7UDm9Cxb2jmb
	 8+riSU/fZscosRog2tqG6Gdbl9FgdyR8LsCOmvL39om2afvV7vgijXqWKMMW7nbfs9y7G8UMs2Kn
	 N/zsZyI1zbIBh98WckJAxZThRY98kxfy5//pZOXiChxFYEtjovna/T8HwX6q565VZlOmnD+x9uUT
	 aV/Mzc7kvCENBL80W4lDyS0vw6sNDxtTVPv0IIoPTyzI506Z1sDnXJxiOQC96ffygj2DVLMlJuRq
	 f2ijbhrwcRrVUC77Iwiz/8nlpV+hTMqhXI7PEjQVb220lbVNzxi0WAJdhS7IoYNAkJR0Y38tdQY+
	 UsUsWm9tKBiEfuXrcDuB3HAH7axum0MK+TEWMGrXSlG9H8WcK1PDCcNS/gDxi//RzroHKEN47oh1
	 739L8UuFLJr6domCdAFRRf9DCQCUV4pgEEnNOe/YbS24GWuM/Wvdtuf3ZSr0vPJJc1RJNhZ+kR+Z
	 efQpFjz3bZGnYdYhJ0EvEaIjItfUOmxBL7umgnrglkMLpnvIPK9Pj5X3L55+fa6v+g6oIDSl6HlO
	 Hnayxlv2n6qgSq1EaiSwTpqcrsPXwIOjyVabnErwHv5yLCFcb6NgpaTyY75SJ9LR+2UMnOV4tCRh
	 X0TB28ibsPlTWMDp7ZMM/XLB9pA7dqi5AI15Gevt8xCFUYf3g2
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Zhao Dongdong <winter91@foxmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhao Dongdong <zhaodongdong@kylinos.cn>
Subject: [PATCH] Bluetooth: sco: Remove redundant mtu assignment in sco_conn_add()
Date: Tue, 21 Jul 2026 16:12:34 +0800
X-OQ-MSGID: <20260721081234.336391-1-winter91@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhao Dongdong <zhaodongdong@kylinos.cn>

In sco_conn_add(), conn->mtu is first assigned hcon->mtu
unconditionally, then immediately overwritten by the subsequent
if/else block which either assigns hcon->mtu again (when
hcon->mtu > 0) or sets it to 60. The first assignment is dead
code and can be safely removed.

Signed-off-by: Zhao Dongdong <zhaodongdong@kylinos.cn>
---
 net/bluetooth/sco.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index c05f79b7aa31..e4f0f6fb01de 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -212,7 +212,6 @@ static struct sco_conn *sco_conn_add(struct hci_conn *hcon)
 
 	hcon->sco_data = conn;
 	conn->hcon = hcon;
-	conn->mtu = hcon->mtu;
 
 	if (hcon->mtu > 0)
 		conn->mtu = hcon->mtu;
-- 
2.25.1

