Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDD03C0621
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 03:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786418886; cv=none; b=hD4Iu9+o++xphzOU8lFkd5UKaFwt4NF3QUb6iCuP8seWeFoVUxF1YYeYJeMn4O1YDX0OmBmS5HQj6ay5Xv9dnc4iIi8ZhhFEKBO8wV2m7v2Sh2wHoxseS/+TBqDP42rSWUf0ERK9mOVVqm7E9moVFWEo6jmbazLViGHTFOxUZV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786418886; c=relaxed/simple;
	bh=WS2dw+ZWEothzANVTXzaxmh15W8sg85qzLaOkuEnpVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LzpP30BgXIGMlHZrRplnDrd6P2mM9UAjc367Rvp6/i3YagvkZgNpDPjA/4APemUMstDPViB7fITF0zxKy56MY6qAYgvkc2Q5DqGzvcFkrdg1jt2DM0LBT2sZLpSqHOnA7Dc5sXKsL8N0dMLR0kp7+uyVnuWv7CEcfZmbsEdxpFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sgXO6yfW; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sgXO6yfW"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786418883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=poryoDFQ2WWBKKBg7BQ/rEalIYvo5T7K8jWvYKaI9Mw=;
	b=sgXO6yfWjATjRb32kxcLJsmVboKb/tche86YxeKcq6HYRitzSlOI4wcyiKyWj+IpEtRkvl
	PMANkZurP206QUGdOH6gR++TeVYIZroZ8tK5hiMX7SAt2XXCXznKkpjz7GymJThseN5v/R
	NLzG/DnOLEIXEY5gsdaahl1ahICFJTM=
From: Yi Cong <cong.yi@linux.dev>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	stable@vger.kernel.org,
	Yi Cong <yicong@kylinos.cn>
Subject: [PATCH 2/2] Bluetooth: virtio_bt: unregister hdev before freeing on open failure
Date: Tue, 11 Aug 2026 11:27:02 +0800
Message-Id: <20260811032702.67908-3-cong.yi@linux.dev>
In-Reply-To: <20260811032702.67908-1-cong.yi@linux.dev>
References: <20260811032702.67908-1-cong.yi@linux.dev>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Yi Cong <yicong@kylinos.cn>

When virtbt_open_vdev() fails after hci_register_dev() has succeeded,
the 'open_failed' path frees the hdev without unregistering it first,
leaving a dangling entry in the global HCI device list.

Fixes: afd2daa26c7a ("Bluetooth: Add support for virtio transport driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yi Cong <yicong@kylinos.cn>
---
 drivers/bluetooth/virtio_bt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index b674fe0c2779e..7c9c3f0085dc0 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -401,6 +401,7 @@ static int virtbt_probe(struct virtio_device *vdev)
 	return 0;
 
 open_failed:
+	hci_unregister_dev(hdev);
 	hci_free_dev(hdev);
 failed:
 	vdev->config->del_vqs(vdev);
-- 
2.25.1

