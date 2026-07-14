Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E1C184540;
	Tue, 14 Jul 2026 02:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783995332; cv=none; b=MDYn498LN2sWENkpaE1rK54hYUTpHE71GMPhKEgnLbOed0luOUSSxSxvagEvOdUR2YcmNRagP2iAokzI4W6NvybSUtNNTT6ay3cgkAaWA2L93D95WGILt49wd8lcdzUQgKTo4fdaD/Dokqg7uW8c8+ux/WX5CZQxc3n8s5apGUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783995332; c=relaxed/simple;
	bh=sBsYv9TuIgobYyuo1/ajZj1nC5NO7+EJ8LX73x86V4w=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=k/KgIinY6NaF0YVieejlBklc+t74UL7fWb1VTwMlnwWOl8Q5EPYsiwllOOs9i1XArN9D7LJ6kSRHCt7LKo1uGoDiMKZH0YFIXUDL8jYzjp1DqEVY8u0PDrtRuEpMeWTpb8yPx71gwaHIb+yaxVbcSqal41V/C8yCGyGYOtjvsso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=lpbyRd4y; arc=none smtp.client-ip=203.205.221.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="lpbyRd4y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1783995321;
	bh=HnWwYzjugCbUF/fK/feJAv2dej9MCyhC7pzRFbjCjFM=;
	h=From:To:Cc:Subject:Date;
	b=lpbyRd4y4zoVlnOrmYRgSjkaKRIDvo3tP84MRta+yGwuVjgpOGM6oxBzYtuUhUPun
	 2Hr4A6RrcbqAvsbD1enAz75fHo7FgsQ1VQOVUmFA4bBFd/AQEVbzmDAVTjRb6mA7GU
	 WyQ+d1fbXcADNUKw1Z2TEO94xMJsz4v19onssQvU=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 38A88873; Tue, 14 Jul 2026 10:14:10 +0800
X-QQ-mid: xmsmtpt1783995250t09gvhk3f
Message-ID: <tencent_968BDEBA1F64E4B914B4E3DC25149BDDF40A@qq.com>
X-QQ-XMAILINFO: MOnz+xTS1+9ijierBmfPtKwMYhSA96Dv5wH13vu3VOPB8w+HYq0M8/LMOWKKlQ
	 If8qht1EjwxO+Z1F9/W3vQUd+dMa3oVoacWXJo6KRqpIvOAKHtfJNROmzPsD8kI0BUppkRJ/V29E
	 hBK6S4at1C32b/HMHR/kBrWgOIyXIkUSLvWWd2SOsrYS9BrhqLBCQIPgoUbUFPvoQSBXb5Hqf2Jh
	 rDsQGmR9eMc2LmxgM/VFjwJ1GxERBD68sR8OAWzWf02rpvkLuqIi32b5kh8ARMyTgYgOYJTwbKzH
	 akM3Q7OK6kUqpVtJsq9n/JOl1v1om2+Pk0TVwkzENixF6eao18jxxAe9StD2xTUy32NrNcNYn2wj
	 qhShfCoQpoZvima2qJBCyGMyaypbaM/9b0jDH+lbbOal+l3N+ZJSFJM53faAnP/VOh++lyQboZBi
	 2uGAxdPNJmsTE3PcHOtaIbUuMsEFKOoE/3oUiM99vyNAnEzKMzlbxQr8QfCru5bLnMXn2ihFf0Yy
	 NTFxmcPDR4rKBC7Y9S72r275USwhCBD8RteDG2oCPxKQZAJP6YwetjptLeEHuKZ1jX9Zbc9BHHzk
	 +3jIoBnCjd90NcPsuZms4zpKaQw9jq9ohnsftGbkjR0rJ2iK31RrDwGGaJQgQhcfy31vsjYt3U1s
	 Gms3Dhv3TSctqwPPQfepR//Yla/IOjhib1EJLGorLbQg9fcUFs96mpbS5y04zireFz7bVKt/PKCm
	 KlCkgiWMiR2Cl8iRzW2BB7AYvmm4DRljmkImw0TvkxRQtXHKFKwr9mSKtpA00TajkJm8+NN8Sjqb
	 +skIbNVbkrDwML9SiNOlhy6e8Je6S9TJ8QcA4cm3pgg+yqGeDBYGJHB56ujGwssDuaYdk3OBa42M
	 JE219NCflCxfH+nqZdMf8Ab9eBF2V1i2gjkHlnBqtls5NvC0+9xz9xAXaW/GH+j1DcZtL+9sjAXi
	 ZUIMrNRvBeAt1AkOWcP6VrqRJ9RdYayyI+WswbSiOCrbcEmmjjmi5KEy/mKQB7ggRaqPab9C+Rc7
	 HAn4mf3gXaiBQD6MQeFnfHAoI+uRs=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Zhao Dongdong <winter91@foxmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhao Dongdong <zhaodongdong@kylinos.cn>
Subject: [PATCH] Bluetooth: virtio_bt: fix virtbt_probe error handling
Date: Tue, 14 Jul 2026 10:13:50 +0800
X-OQ-MSGID: <20260714021350.105385-1-winter91@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhao Dongdong <zhaodongdong@kylinos.cn>

The error handling in virtbt_probe() has two issues:

1. Memory leak: vbt is allocated via kzalloc_obj() but not freed on
   the virtio_find_vqs() failure path nor the generic failed path.

2. Clean-up order on open failure: virtbt_open_vdev() failing after
   hci_register_dev() leaves the device registered and queues
   dangling. Only hci_free_dev() is called, skipping unregister,
   reset and buffer cleanup.

Fix 1: add find_vqs_failed label (after del_vqs) so that VQS
failures skip queue teardown while still freeing vbt.

Fix 2: re-open the open_failed path to mirror the remove sequence
in reverse order: virtbt_close_vdev() to drop queued buffers,
virtio_reset_device() to quiesce the device, hci_unregister_dev()
to deregister from the BT core, then hci_free_dev().

Fixes: afd2daa26c7a ("Bluetooth: Add support for virtio transport driver")
Signed-off-by: Zhao Dongdong <zhaodongdong@kylinos.cn>
---
 drivers/bluetooth/virtio_bt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 140ab55c9fc5..cca7e1281740 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -311,7 +311,7 @@ static int virtbt_probe(struct virtio_device *vdev)

 	err = virtio_find_vqs(vdev, VIRTBT_NUM_VQS, vbt->vqs, vqs_info, NULL);
 	if (err)
-		return err;
+		goto find_vqs_failed;

 	hdev = hci_alloc_dev();
 	if (!hdev) {
@@ -397,9 +397,15 @@ static int virtbt_probe(struct virtio_device *vdev)
 	return 0;

 open_failed:
+	virtbt_close_vdev(vbt);
+	virtio_reset_device(vdev);
+	hci_unregister_dev(hdev);
 	hci_free_dev(hdev);
 failed:
 	vdev->config->del_vqs(vdev);
+find_vqs_failed:
+	vdev->priv = NULL;
+	kfree(vbt);
 	return err;
 }

--
2.43.0

