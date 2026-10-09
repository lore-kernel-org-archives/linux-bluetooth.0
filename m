Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9643D7D65;
	Fri,  9 Oct 2026 08:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791534932; cv=none; b=s8aQyXDkFV1SiuO23IC7lfpXzlqF1BPV3vehza1KKDPidAnkAff3vV9PcDyHQqhL0oxP0HJdJccxuXAUbCjPgJoDZ06rn7ivDEYCrKkFEUFbDBIcoUUcAL6erPtM7iKxZC3RJ5rH9s/o7/etJK7E0ccza2vy9DOcNw2RiQMZQQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791534932; c=relaxed/simple;
	bh=BXlxO+lNnI/IhYwqOpuyxA8euR2MK8wX3hu7K+gwHRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iAanLkAcJ/8n7KubYaVZIj4Ggu1iLuKy+n+qmS/V02Ps8sqMqzGmKQEjhiHdXFFTLDw/d9CJaPjBPuKsZJ0HzZyCPTeQdkk/cV7kYXjExHp+A/uyFmvrIkTwYS6t7ZRxPiQq1/SCFhzboObiAYxKeeLVEZlNA5kGB8m/+USNFYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YuNU5hOi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YuNU5hOi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A51391F000FF;
	Fri,  9 Oct 2026 08:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791534930;
	bh=NhVNrMJ9T8caGDwFa9qT4qr4Wo3dvsNS2VTvf9SdOKw=;
	h=From:To:Cc:Subject:Date;
	b=YuNU5hOisl3DkKZTcnRGmrnKyaoTJ3WtllGmW6dOQpwsuxzknafS937gdt8JgBeoz
	 fxfZ7dZ0jl6EvQXukvUazYQIOBxoV1nvVbAzTkoxglqdQkFa7OntjDjIGlVdzHsOcB
	 VccBZTJMetnNDNJoZXxqbuYdIFrXq7hFsyE/jWYY1c42kEk4+SIkTgih0kKGthkeKI
	 HBrDLwj/9t0eOb7XpuuICDyWi9kekYutkLfN6uS9TDwixBGbAcwLjPvulv6Gr0g1++
	 bEZBsz7luialcj92HBq2Gh11D+geV11wHEu5nz1jAyq0cYERbbpOEMGzRwN6CKj+1z
	 SzLIlLwZKTZ8w==
From: Eric Dumazet <edumazet@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH] Bluetooth: btmtk: fix skb double free on ISO padding failure
Date: Fri,  9 Oct 2026 10:35:25 +0200
Message-ID: <20261009083525.733804-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btmtk_isopkt_pad() uses skb_pad(), which frees the skb on failure.

The error is propagated by alloc_mtk_intr_urb() and
btusb_send_frame_mtk() up to hci_send_frame(), which frees
the skb a second time:

	err = hdev->send(hdev, skb);
	if (err < 0) {
		bt_dev_err(hdev, "sending frame failed (%d)", err);
		kfree_skb(skb);
		return err;
	}

Use __skb_put_padto(skb, MTK_ISO_THRESHOLD, false) so that the skb
is left to the caller on error. This also replaces the open-coded
skb_pad() + __skb_put() sequence.

Fixes: ceac1cb0259d ("Bluetooth: btusb: mediatek: add ISO data transmission functions")
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 drivers/bluetooth/btmtk.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 7ea8bcd8a7ecaa0122d96cc3787307301401e00f..c9175d478a9845bd476ad998815429d2748b78f2 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -1023,12 +1023,8 @@ static int btmtk_isopkt_pad(struct hci_dev *hdev, struct sk_buff *skb)
 	if (skb->len > MTK_ISO_THRESHOLD)
 		return -EINVAL;
 
-	if (skb_pad(skb, MTK_ISO_THRESHOLD - skb->len))
-		return -ENOMEM;
-
-	__skb_put(skb, MTK_ISO_THRESHOLD - skb->len);
-
-	return 0;
+	/* On error, the skb is freed by hci_send_frame(). */
+	return __skb_put_padto(skb, MTK_ISO_THRESHOLD, false);
 }
 
 static int __set_mtk_intr_interface(struct hci_dev *hdev)
-- 
2.53.0

