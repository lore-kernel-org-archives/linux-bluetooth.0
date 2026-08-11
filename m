Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A97359A6D;
	Tue, 11 Aug 2026 08:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786438119; cv=none; b=gZCePkYAglXfEOLvH5VOuWQKKq+vD5jZDJRtCx3QYUarmUbgG+flYQQn+ctLp+E5aGtxF4KPOaEfighxXASorxPYPxjY/VHuuehaMxo1iugs+3Aq0IOG4x7JyfjaKN+OGdbv9tTTl3NNWqX6souXCMz3Fh0Fgpil7lrxqCxf5kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786438119; c=relaxed/simple;
	bh=bY/xLBc1btBIAkD8X4lRVBzjKP9JA+p5CruUW0mpAec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ddxLioRMPvTZuKV6EDoZaJo7a2cYirj7TRQmMsHtrSFMGH4MlqmqhB8qA8sjuFNodDDDQAYg52BUFSRaKeec6VmaGXkx304v0Nw5/kXF1NJ1ABpM/gOzcDeILmzn9MiRLTBhrbRRKO3Z/ztuC/ZDKN46I/h9phmEoQF7Nxc1hPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=P+ECSxIU; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="P+ECSxIU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1786438088;
	bh=aEucSGBAb9ynMxKXekXbwUOVc8A55MONsf4tLG9t/ZQ=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=P+ECSxIUl6r91ne6y1AEHDrDcn1foDVbRqEACV3eQbIjbcIdlOUTZbXapV5bI7CiO
	 AWvscPwaVAO2j2BeChHCi38hZJ6dybghk3AZ2aqP+2XZOsJc8QAfwFoG/85irqvkmJ
	 NuXoGug0Yvms3+LRwDGGw59jHDvcJ8U0mm/6jlR4=
X-QQ-mid: zesmtpsz2t1786438083t041c9662
X-QQ-Originating-IP: SRpkCP0BO+B5w1Hb+CM7OZjuqk+634l7WUjcpjECsUo=
Received: from [10.10.7.64] ( [1.202.39.170])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 11 Aug 2026 16:47:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10427211591453291951
EX-QQ-RecipientCnt: 5
From: ZhaoJinming <zhaojinming@uniontech.com>
Date: Tue, 11 Aug 2026 16:47:37 +0800
Subject: [PATCH] Bluetooth: virtio_bt: Fix use-after-free and memory leak
 in probe error paths
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-virtio-bt-fix-probe-errors-v1-1-2f1acfde8336@uniontech.com>
X-B4-Tracking: v=1; b=H4sIAKjhemoC/x3MSQqAMBAF0atIr21InFCvIi4cfrQ3RjoSBPHuB
 pcPinooQAWB+uwhRZQg/kiweUbLPh0bWNZkKkzRmNZajqKXeJ4vdnLzqX4GQ9Vr4LUEjJvqqnY
 dpcGpSM0/H8b3/QB/qgTJbAAAAA==
X-Change-ID: 20260811-virtio-bt-fix-probe-errors-d3ee0fa545f9
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 ZhaoJinming <zhaojinming@uniontech.com>
X-Mailer: b4 0.14.2
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: M9cU/d9r+frhmrT2EFSBw7rtFxCaZrqoDg1cUdF2IqhRqbsgY89r7CQ2
	tU1KN52ehLmnxg/U+NWythOo1RcGesKAeohP6d0cKf1Bxr7QwoizRR5VYCOt6Lt11pn5rFe
	oxIDckOjcoD+KrueNA6E5FVHZeW5bDEXwCBQLWPz4Buzfi+yt0SM/uObtWQ2pGycfTFkfbD
	XZ30Iw9Zh5vt54kRnj6JLNZKrTireG044LpnVuiijE2j+ahV7Cy7ZTWu57S8Za9YQywLMOG
	Djz8/u/Yc3MYxqAFveNUSav6QMNs55uIhKKd59ME19gbiiS4/mKICETZiBZq7hjvu7KL485
	nIzdA6jOyGkok1OnC0uQkrtZgWKNYrazE5DmCmFjuOZQf5NzVPJXGgpZG19J1Y3NjotGRwd
	5qHLwnp3MNOVu4dbMnEIaDVEGDzR3bGP91nd9pTSmAESCpLBtg5mn/omsg3HbWXaXqmM+kj
	3dRK/im/GziTK7rjwR9ldCbIDICp1jyoIHUFTkM9VJRiFdPO+rImgqjVB9zOnikXHGZdBAV
	Dzs/5zWG7/78fGI5kJAPFPv6wRwepD8PQcIlxxODNACl1V9FhZox5gCJBWRwTZbOKavzMLE
	fHpA7YqjL2NohO7AGp6cBCTa1Dllf9h4OisaFhdLfSbPXNuYJ+QKDNd0D0sta1hVDnQJXZA
	fuz9cKuUocgQu6rtrePpUlPeBS2P5K3cbg+pnMI3OJMJyo7TEQ7lyBxsHOWnUmL7hWVLCt8
	gnMiFz4R9WaSAftpCuqXMXRm3sKqJVv+m52YGNT2YB63seELE0lpaX5oxw0VB9Nh+NOlW4t
	SNxV4zFB7xM+dUhGx7Lug2XEwy94gomW+7BI4EcUzPVa/Z4il40X1zmmy40lnRZP6Iyt983
	7KZJvIOQrIq74GB5ofjV4Uuc5J5nkoD24oRdVhgTNMM9U0aPikatczvDVI4m/2fiBnQHDVb
	yRiwircCprcPXiAl8fiSkXY/44bCtUeDAXW81OdKnMJ9JyTGPNRNVAtDiwEmGEErMxc+n8F
	YxpjHXYmClPHuIT1kkTRpdwdEuYU0=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

When virtbt_open_vdev() fails in virtbt_probe(), hci_free_dev(hdev) is
called without first calling hci_unregister_dev(hdev). Since
hci_register_dev() already succeeded, the HCI device remains registered
while its memory is freed, leading to a use-after-free when accessed
via sysfs or HCI sockets.

Additionally, the probe function leaks the virtio_bluetooth structure
(vbt) in several error paths:
  - When virtio_find_vqs() fails, vbt is not freed.
  - When hci_alloc_dev() or hci_register_dev() fails, vbt is not freed.
  - When virtbt_open_vdev() fails, vbt is not freed.

Furthermore, when virtbt_open_vdev() fails after virtio_device_ready()
has been called, the device is left live (DRIVER_OK set) while its
virtqueues are torn down, and any scheduled work is not flushed,
potentially allowing a use-after-free from device-initiated callbacks.

Fix all of these by restructuring the error labels to properly unwind
in reverse order of the allocation/registration sequence. The new
labels err_del_vqs and err_free_vbt ensure that del_vqs and kfree(vbt)
are called as appropriate for each failure point. For the
virtbt_open_vdev() failure path, call virtio_reset_device() and
virtbt_close_vdev() before unregistering the HCI device, matching the
cleanup pattern in virtbt_remove().

Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
---
Changes in v1:
  - Initial submission.
---
 drivers/bluetooth/virtio_bt.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 140ab55c9fc5a973d6b0034ca11d026dfed71ef2..4be6e106d6985fea5a5786ab68497b17d14f66b8 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -311,12 +311,12 @@ static int virtbt_probe(struct virtio_device *vdev)
 
 	err = virtio_find_vqs(vdev, VIRTBT_NUM_VQS, vbt->vqs, vqs_info, NULL);
 	if (err)
-		return err;
+		goto err_free_vbt;
 
 	hdev = hci_alloc_dev();
 	if (!hdev) {
 		err = -ENOMEM;
-		goto failed;
+		goto err_del_vqs;
 	}
 
 	vbt->hdev = hdev;
@@ -386,20 +386,25 @@ static int virtbt_probe(struct virtio_device *vdev)
 	if (hci_register_dev(hdev) < 0) {
 		hci_free_dev(hdev);
 		err = -EBUSY;
-		goto failed;
+		goto err_del_vqs;
 	}
 
 	virtio_device_ready(vdev);
 	err = virtbt_open_vdev(vbt);
-	if (err)
-		goto open_failed;
+	if (err) {
+		hci_unregister_dev(hdev);
+		virtio_reset_device(vdev);
+		virtbt_close_vdev(vbt);
+		hci_free_dev(hdev);
+		goto err_del_vqs;
+	}
 
 	return 0;
 
-open_failed:
-	hci_free_dev(hdev);
-failed:
+err_del_vqs:
 	vdev->config->del_vqs(vdev);
+err_free_vbt:
+	kfree(vbt);
 	return err;
 }
 

---
base-commit: d58772d8520c7ef247c4b95c9bd76d3a25da9ff5
change-id: 20260811-virtio-bt-fix-probe-errors-d3ee0fa545f9

Best regards,
-- 
ZhaoJinming <zhaojinming@uniontech.com>

