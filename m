Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785692E7394;
	Thu,  9 Jul 2026 01:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783562311; cv=none; b=u4gvoWxD2C9rT3eHx1DtdgO5HFLFoQEY7Wd0ohJ8oIrkZ1pRzltDD2xX7cJp33M0Zx2t9IqhsIOpeUO4OuxmLnlQApVehTI1J0PaLBzav+j1uOsPV8dt5E9bmvcbIl8/1Z4sbWqvO0AFyyUY6WeRwSaBmXhAXzcwjzIlT9iTCrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783562311; c=relaxed/simple;
	bh=Q6GS0tGEFL8Iq5Kwz0a1FovYfPubdFKF2hAcfqAkgJc=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=Q80oB9TmMs//Vy5qpI0xDG6KYXM4bW/ZZiZAXO/OoBAFivEBzFjnaU0Qt8W1VsV5zDi4Ixf/RPBtS6wUVw6DXZFBYmQWFXQGKGr5fHpwfnytCriGCAgS6Bx/aCzgLetyWo+jiUywvN7TzhgdgzgbTbjCcyGgHZMBTj3a2LDP1q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=cJwIOhZi; arc=none smtp.client-ip=203.205.221.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="cJwIOhZi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1783562299;
	bh=M9HosSdQ/iP6aZZ9wByFKDq/TxAPVCMaSusu1sWM1tU=;
	h=From:To:Cc:Subject:Date;
	b=cJwIOhZiHCNwAKgo7l3Pp385s72FHxscYz1A+LQQTnBKZKXEsGCoEgIYE1xEzpV+e
	 9tM/6uES3VKDXgjbPp+WuGYQ0wjPsJXUQMwL/4BNXbqfxD7kT/eTZw4rIXXnYu8yjC
	 JBb4WfavZTu6rN8xDl8f0gx2Fqy7pHnMLQh/PKfM=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id E913A4B6; Thu, 09 Jul 2026 09:58:17 +0800
X-QQ-mid: xmsmtpt1783562297tycy6v8kn
Message-ID: <tencent_EC14979976A7BBA1E2B79B3F5116F7C30C07@qq.com>
X-QQ-XMAILINFO: MZtEYADUG4AgtO9U+yZuAV1+mxAoDF4pgpJEhp7ZYfFoY4mKi2Et9vJYue4q8e
	 pdhG53ANe19CqN4JF9bRwVthtwHCetROIOcPDwMS87R3EbRnJtleSl0TtPHZHLKgFapfjTL3ldiU
	 lX3xd6WvzHuXr7CRtT2ygt/llU0ltVNmLKabMcHgVYFgYUjkAY7gRzwGyo6MubsSu6rEfippqiue
	 jZW2XpCzsxpcxMg+RYTV/3fpuSmoSRtzkPpkAVDpPsHnP5UWo1/XDGrZMA7o3SD0Ay0V3CCUTSSQ
	 9Wl/iox7t9a2Uzy2cEcUkj9z8oyKznhztXaOrjAbPaLkVgupFDSkfJ1f7BLnrJ4QHDB88iihyXrT
	 PCwPe01LQQ6ziLOob4Rb7h61d5xyJbPMnCV63jYbntxlfE8ZRgby7nlSg0jr5cc3mP3nTQrTxsh7
	 ts2Vk02Z60SP5kM3bnA3SDfR+MwzJLJXlfuQxyLxRqil5B38G0sVJMTzo9o3q5bAdG+8JvcG0mOq
	 3lbeF3qyIDa8ssWmo9I1+L7VMW+iC0G4An83l5ougpNGasjitYZZKY+CqDboBG/zpwBntuTURENI
	 ZQeuLRQwbSopypWzAonhuKAU1WxVb5YNm0OEGohq3cLzbNPCCb5iw1hjOXEwEGnPPvcYi3/gh6vW
	 mkAE2y5DgNY5CGzYfU6KnO+OvT8bbCLAaTaGFAto2SQSf60HRw1gNvw1MLzHx/ZU4/cF6TGphrd6
	 MhMDm23gjjjy1wuRKe/HDMbqq/8c8N0VA7FUyAUnvwprPdlZ6kGQ5/1j9BWozzHi1xp7Osg3+Xty
	 VAubHP78v90iq7dwoJXV8FpAzs4qCf8Hgt9PHvQQXv+9qmsWapcxVpANT+RsqNTcJDutOXhvuc8T
	 okfdjiLaWV4yMW99QGzIocUEU/UEkiJ32Spse/rGtG7yz8iUychVXYPt8c3sJHS9dYmXSTwXwazz
	 v2b/eSeKFT4BdTUjTx+wKFZWK8BB/fl87RXAloJDgWMs5oWwlKDOs90dECWqu0/Nn7Hmd665TYwi
	 k0GkVMaWni+2Vl4FaS
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Zhao Dongdong <winter91@foxmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhao Dongdong <zhaodongdong@kylinos.cn>
Subject: [PATCH] Bluetooth: virtio_bt: fix memory leak in virtbt_probe
Date: Thu,  9 Jul 2026 09:57:50 +0800
X-OQ-MSGID: <20260709015750.80288-1-winter91@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhao Dongdong <zhaodongdong@kylinos.cn>

In virtbt_probe(), the vbt structure is allocated via kzalloc_obj()
but not freed when virtio_find_vqs() fails. Additionally, the
open_failed and failed error labels do not free vbt, causing a
memory leak on any error path after vbt allocation.

Fix the leak by adding a dedicated err_find_vqs label after del_vqs
in the failed path, so that find_vqs failures skip del_vqs (since
vqs were never established) while still freeing vbt. The existing
failed and open_failed labels also gain vbt cleanup.

Fixes: afd2daa26c7a ("Bluetooth: Add support for virtio transport driver")
Signed-off-by: Zhao Dongdong <zhaodongdong@kylinos.cn>
---
 drivers/bluetooth/virtio_bt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 140ab55c9fc5..61ab3863bb0f 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -311,7 +311,7 @@ static int virtbt_probe(struct virtio_device *vdev)
 
 	err = virtio_find_vqs(vdev, VIRTBT_NUM_VQS, vbt->vqs, vqs_info, NULL);
 	if (err)
-		return err;
+		goto find_vqs_failed;
 
 	hdev = hci_alloc_dev();
 	if (!hdev) {
@@ -400,6 +400,9 @@ static int virtbt_probe(struct virtio_device *vdev)
 	hci_free_dev(hdev);
 failed:
 	vdev->config->del_vqs(vdev);
+find_vqs_failed:
+	vdev->priv = NULL;
+	kfree(vbt);
 	return err;
 }
 
-- 
2.25.1

