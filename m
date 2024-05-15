Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A64158DB4;
	Wed, 15 May 2024 18:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715796913; cv=none; b=TcRHRu7kCvAbEJMWB/Y2O+UDkoNzxYLn+S7vJ63QzN4RH5YarjUvYjiU2QI2uEyzN69v+zFlKPSibOR/3d+pUMNPAgHX12wN0kzq/woLQk4WhYX/wjc2kQ/Ry1+ZOLszfYBTRuuBtWptnt9ObHKUVHUlqKxzormdg3wF826BQY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715796913; c=relaxed/simple;
	bh=rOhhqY9hje6LUTOx+VqYEfek2yHOAqEb5xlvLohkfOM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DLnx+bawrmk2Xcoh78qiiNGl5KFP9HKolLSXWVbbP5tFPsLkf9VCu0fb2cwY0wSb9b34ZlAIMpnVyMIRWvrfLM5kQLNBjgcwDEkasCs54t+DWy2uILDGXSZtsfXhM43yERni1CXfiA/dtzQ0cjOlrv7dl9T07ok2sHneYHrMQwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrnF4tHA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrnF4tHA"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E066C2BD11;
	Wed, 15 May 2024 18:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715796912;
	bh=rOhhqY9hje6LUTOx+VqYEfek2yHOAqEb5xlvLohkfOM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WrnF4tHAAdtiQV7UgMCXO7PGnll/7swVO/4gZuiWSqcJyopfRnmJmi0iFfWKSCt4L
	 0K1FRq0tqo0JIfZ3Gy2iPwrK0qoWvpbFHFFZac8n2sj430T8TLl33yto6VqXgaoqAw
	 3qmx3WaQFmv7c9Mv1cQxn7ydkkkPC6FHhBA9TvG3qQyl9e2I9SN4e/qR9/hU3czfHy
	 Iybi/fyQLdkfh98ybgroRW2iismmCjlZ8G5sKALuytMLbIJ5F3JoT2SFQkdMmxZHvi
	 80mwyJZbX/PD8qgxwu4P/1+7Mcp7usmLr3W0Zg5cTBA105y0tfuhgB/JnUuXgx4+BV
	 0W+xDt4od8WJA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9167EC25B7B;
	Wed, 15 May 2024 18:15:12 +0000 (UTC)
From: Sven Peter via B4 Relay <devnull+sven.svenpeter.dev@kernel.org>
Date: Wed, 15 May 2024 18:15:03 +0000
Subject: [PATCH v2 2/3] Bluetooth: hci_bcm4377: Increase boot timeout
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240515-btfix-msgid-v2-2-bb06b9ecb6d1@svenpeter.dev>
References: <20240515-btfix-msgid-v2-0-bb06b9ecb6d1@svenpeter.dev>
In-Reply-To: <20240515-btfix-msgid-v2-0-bb06b9ecb6d1@svenpeter.dev>
To: Hector Martin <marcan@marcan.st>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sven Peter <sven@svenpeter.dev>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715796911; l=1118;
 i=sven@svenpeter.dev; s=20240512; h=from:subject:message-id;
 bh=byENbovROROZ6LTg/OZr99a9V8DiMo0qMmjQUs9RxZg=;
 b=U9OQBMfY7bWDNjv5YOB/lQunPI+LOIMFM3a0UzhVjqnHTbEFME1936bVtxWbKi+DIDVIlYqcF
 0so1SLJpV7sBpS2pfElZdkeeOyTLScDMjekuT0kVZMv0y9Y6VFbTIEs
X-Developer-Key: i=sven@svenpeter.dev; a=ed25519;
 pk=jIiCK29HFM4fFOT2YTiA6N+4N7W+xZYQDGiO0E37bNU=
X-Endpoint-Received: by B4 Relay for sven@svenpeter.dev/20240512 with
 auth_id=159
X-Original-From: Sven Peter <sven@svenpeter.dev>
Reply-To: sven@svenpeter.dev

From: Hector Martin <marcan@marcan.st>

BCM4388 takes over 2 seconds to boot, so increase the timeout.

Signed-off-by: Hector Martin <marcan@marcan.st>
Reviewed-by: Sven Peter <sven@svenpeter.dev>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/bluetooth/hci_bcm4377.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4377.c
index caf9b64c8111..5b818a0e33d6 100644
--- a/drivers/bluetooth/hci_bcm4377.c
+++ b/drivers/bluetooth/hci_bcm4377.c
@@ -33,6 +33,7 @@ enum bcm4377_chip {
 #define BCM4387_DEVICE_ID 0x5f71
 
 #define BCM4377_TIMEOUT msecs_to_jiffies(1000)
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


