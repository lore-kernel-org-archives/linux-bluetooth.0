Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C49A43DA3A
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 08:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785313605; cv=none; b=r/1JCiiNpab3ShF8bxd8lPcS4oua4lgOcCHRdtO51TPOuXmFdxJZel0yDePktupe1cXi8UFc+C0YkYfucq+uAkeC5xgODuTOXoRP9JhZKnZxVXAkYBuaE/SvJFJzid/htjO9r99xOzG0kryI7pmpPmFJDcPpdKFgWFF2vVgzoqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785313605; c=relaxed/simple;
	bh=NRr/PPKE2tayn33AWBxWRxD9ZfM4ROw+JKEoMSSaRd0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=USXcVw81vMqnSS4F8IYvEUL9MkX7VlNbaVmaI+n4iQ348CiupXKUqlLd/dm8YeSMU94xx6//zaxGQgs7e6NvJfn0bQU7NYmtDmiMeQZaSGZobin26htTWiKogf0f7/R9Cq4flzN4AnTr9tGHgh5zvYiDkYsJspkHdAgsj5pnYfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pfS0RhGt; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pfS0RhGt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=40
	rBicJUszC8qh3xVLhwtMRSZ+FMA7+omUBnS/S45hA=; b=pfS0RhGtZ7iGy+R1UA
	2TlqoFnffPofK0+EyEmJRzA5h7pIPNTg1DsvLNCSJ11tQGxSU1dP2pn7nlhprf7N
	+JKhRqbPfE+MXwoLjU6eTxV/lLSGTtl3TaAKX18eUOfK6JkwvIbeBRw5L9P2G6Qh
	gBs7CbH0Knhrkzt+l/M5p8w4M=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3X_4puWlqssxQLw--.22578S2;
	Wed, 29 Jul 2026 16:26:19 +0800 (CST)
From: zhangchen200426@163.com
To: luiz.von.dentz@intel.com,
	michael.bommarito@gmail.com,
	kees@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	Chen Zhang <zhangchen01@kylinos.cn>
Subject: [PATCH] Bluetooth: virtio_bt: Fix memory leak in virtbt_probe
Date: Wed, 29 Jul 2026 16:26:15 +0800
Message-Id: <20260729082615.308918-1-zhangchen200426@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X_4puWlqssxQLw--.22578S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrurW3urW5Jryktw1Uuw1Utrb_yoWftFg_C3
	WfZ347Zr1DGF18u3W8Cry5ZrWay3WrWF4kWwnaqas3W34DCr17Xa42qr1DAF17WrWUKr1U
	Aws8XrsxCw4fCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8Hq2tUUUUU==
X-CM-SenderInfo: x2kd0whfkh0jaqqujli6rwjhhfrp/xtbCwAttCmppuSu6awAA3s

From: Chen Zhang <zhangchen01@kylinos.cn>

In virtbt_probe, if virtio_find_vqs fails, it will return
directly, causing a memory leak in vbt.

Signed-off-by: Chen Zhang <zhangchen01@kylinos.cn>
---
 drivers/bluetooth/virtio_bt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 140ab55c9fc5..5ca163f8ea70 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -311,7 +311,7 @@ static int virtbt_probe(struct virtio_device *vdev)
 
 	err = virtio_find_vqs(vdev, VIRTBT_NUM_VQS, vbt->vqs, vqs_info, NULL);
 	if (err)
-		return err;
+		goto alloc_vqs_failed;
 
 	hdev = hci_alloc_dev();
 	if (!hdev) {
@@ -400,6 +400,8 @@ static int virtbt_probe(struct virtio_device *vdev)
 	hci_free_dev(hdev);
 failed:
 	vdev->config->del_vqs(vdev);
+alloc_vqs_failed:
+	kfree(vbt);
 	return err;
 }
 
-- 
2.25.1

