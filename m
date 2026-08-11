Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6C738DC66
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 03:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786418883; cv=none; b=NCbTcmBCoprxzD//UkTdLnzuJecSBbSz1ksiDbLyzXjSYwgw5Gh9bm2O4YsleC/Vq1xV81GWwNCBVrNNSgYkIBfM+kGB3I6/bvaNw5BOXKQ7Itggm10cEfcGE/5m0+G/AxKD8Kww8pUO7tF/3lNXb5V/gVlWWkSH4kuXhBU5b6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786418883; c=relaxed/simple;
	bh=Z1UMnQkQ7RHnbzSQtXUxBC+spluPC7yPs/hg1k9MK/k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FuyK3HwLGTXYcsQc9nH7kE626jTRt+VMbEywJKRGLNHkRVwSplR84Un/7nZTxNrAiSKmU4//kqcnTGTyHqaDI4Xeb3ko6LI5EG+YXLcX654CRL9WQZ+IoPFu6wS3I9Ha3D+zOGjwb75VP+a7JMX225umIycBTA7/w0ehB/2tx3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RdWMXj2Y; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RdWMXj2Y"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786418879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IZ63MsPGPL9yGX0NSI+upDbrCQu3p5KU0q6reB3Ro8w=;
	b=RdWMXj2Yxakg8Mxj+b3v3CIvjVUZ76PWmjIC5fMG4crMK/ePeoRVMTcd3NDFpvUn5sxd3q
	oQ9qYP1UIbRjxlI16WKz0eJnD3SxYC/oOgDVF5fPTeHGouufGbbsVtajBGQyTNy+lwPl6m
	b9m4WscOJdQKr3YwcAOWYvmHMoByEys=
From: Yi Cong <cong.yi@linux.dev>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	stable@vger.kernel.org,
	Yi Cong <yicong@kylinos.cn>
Subject: [PATCH 0/2] Bluetooth: virtio_bt: harden probe error paths
Date: Tue, 11 Aug 2026 11:27:00 +0800
Message-Id: <20260811032702.67908-1-cong.yi@linux.dev>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Yi Cong <yicong@kylinos.cn>

This small series hardens the two error paths in virtbt_probe() that
currently leak or leave dangling state behind:

  1/2 - if virtio_find_vqs() fails, the allocated 'vbt' and the
        'vdev->priv' pointer that already references it are leaked.
  2/2 - if virtbt_open_vdev() fails after hci_register_dev() has
        succeeded, the hdev is freed without unregistering, leaving a
        dangling entry in the global HCI device list (UAF).

  Fixes: afd2daa26c7a ("Bluetooth: Add support for virtio transport driver")

Yi Cong (2):
  Bluetooth: virtio_bt: fix leak of vbt on virtio_find_vqs failure
  Bluetooth: virtio_bt: unregister hdev before freeing on open failure

 drivers/bluetooth/virtio_bt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.25.1

