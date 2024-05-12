Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5261CD13;
	Sun, 12 May 2024 12:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715515938; cv=none; b=jlRA5Web5+CPu1+tWLpqlcvkUvk6OPQlpzLjIA3Ef/vJlDJQZ7ciHET1o6LbTNVPbmFXwMCzNm1E5pBiwilH8R3GIeMVA3zLLiuz6nCh5vz9KlCmnWopS4KWdVus2t8xAfjV/KBNi0IIpz1Kd5ssg1i387yhQ84ylmrlQculGG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715515938; c=relaxed/simple;
	bh=uQn2LpSYH3VSkLT8zOSF6zifQuGNp9REuyof47a4VwA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j+soa6LsFLTjW0aS2FK+x1jd+PBfuQA3TdJck98J91GeyA0fnwtoDib/8z/A+9WMqYVtUGSt8Bn+MjMtYqsHNcEtN2GFlV63pmmoJNBVXPFGWF9BcOZtkl+riv+EQlxg+ZMTPdNzCulyimFQmnDA0zABroXyQNHPO2038X96F9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqNnZpM3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqNnZpM3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF572C32783;
	Sun, 12 May 2024 12:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715515937;
	bh=uQn2LpSYH3VSkLT8zOSF6zifQuGNp9REuyof47a4VwA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AqNnZpM3MZ5HNyZPwo2bV4eQ1+sLLGVHhFFC4vZYXptzUoi4p2vuPTCkBk23SLaPQ
	 E+aiLzKIBT9goBdCFK/VjCEy06HdZXfinaiASvNGbk4WgptoBjCMFMfMMpukJR7BNP
	 etcIHwtrNTMmButKi9Yh18kLziysGCaMa8h1h3woL/CIL0z+ItfpMo2yFyh33lvzJn
	 8Cyn65p0NHcS9L2KiZhjx69mKu8H7whT4havYJWa25KIcaQoHfqb9gt3Uo6zghQR5m
	 7+yr3Qa/kT9+8ygJ83M9KEjP4Mn+JpWI0XuVpLs1krkw4L8bsK1aKmeoDO2Bgh0dUm
	 pQ6ysO5elyClw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E7AC10F1A;
	Sun, 12 May 2024 12:12:17 +0000 (UTC)
From: Sven Peter via B4 Relay <devnull+sven.svenpeter.dev@kernel.org>
Date: Sun, 12 May 2024 12:12:07 +0000
Subject: [PATCH 1/2] Bluetooth: hci_bcm4377: Increase boot timeout
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240512-btfix-msgid-v1-1-ab1bd938a7f4@svenpeter.dev>
References: <20240512-btfix-msgid-v1-0-ab1bd938a7f4@svenpeter.dev>
In-Reply-To: <20240512-btfix-msgid-v1-0-ab1bd938a7f4@svenpeter.dev>
To: Hector Martin <marcan@marcan.st>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sven Peter <sven@svenpeter.dev>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715515936; l=1230;
 i=sven@svenpeter.dev; s=20240512; h=from:subject:message-id;
 bh=l5zSo1PIT3qiMZokOHqlZSiHEp61gw9G4TR1ydgJdn8=;
 b=n9bTv01yWWAEQyW+jcLjnXCkBT8m4v+1sdLTdkCYA3JsdBqYIW4HWVo/du2TPgpdY0+vEtEB4
 T1TnR3JSZ2OAgeOOqyVSTnayjE6KuEhWnqjURCkz09+JQZmZBnRmMWq
X-Developer-Key: i=sven@svenpeter.dev; a=ed25519;
 pk=jIiCK29HFM4fFOT2YTiA6N+4N7W+xZYQDGiO0E37bNU=
X-Endpoint-Received: by B4 Relay for sven@svenpeter.dev/20240512 with
 auth_id=159
X-Original-From: Sven Peter <sven@svenpeter.dev>
Reply-To: sven@svenpeter.dev

From: Hector Martin <marcan@marcan.st>

BCM4388 takes over 2 seconds to boot, so increase the timeout (and also
fix the units while we're here).

Signed-off-by: Hector Martin <marcan@marcan.st>
Reviewed-by: Sven Peter <sven@svenpeter.dev>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/bluetooth/hci_bcm4377.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4377.c
index 9a7243d5db71..5b818a0e33d6 100644
--- a/drivers/bluetooth/hci_bcm4377.c
+++ b/drivers/bluetooth/hci_bcm4377.c
@@ -32,7 +32,8 @@ enum bcm4377_chip {
 #define BCM4378_DEVICE_ID 0x5f69
 #define BCM4387_DEVICE_ID 0x5f71
 
-#define BCM4377_TIMEOUT 1000
+#define BCM4377_TIMEOUT msecs_to_jiffies(1000)
+#define BCM4377_BOOT_TIMEOUT msecs_to_jiffies(5000)
 
 /*
  * These devices only support DMA transactions inside a 32bit window
@@ -1857,7 +1858,7 @@ static int bcm4377_boot(struct bcm4377_data *bcm4377)
 	dev_dbg(&bcm4377->pdev->dev, "waiting for firmware to boot\n");
 
 	ret = wait_for_completion_interruptible_timeout(&bcm4377->event,
-							BCM4377_TIMEOUT);
+							BCM4377_BOOT_TIMEOUT);
 	if (ret == 0) {
 		ret = -ETIMEDOUT;
 		goto out_dma_free;

-- 
2.34.1


