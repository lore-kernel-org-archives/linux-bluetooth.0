Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A1A158DA8;
	Wed, 15 May 2024 18:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715796913; cv=none; b=h1IgBe02HoJ3C6NpWjqGvz/rekxwyPYiOHqdyeuDUYaAUzWJNZxHzoh0p+Vjr90+cHXsoFIw5hYLUOTiKWyzGPukOnI4FRp72pslKjWsj3yrflFUGZ7Tch/cUeiIQqnySEYL70TyNDgnZYOsPx5eh9Fqy2DYvgX3zzD87xg6R+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715796913; c=relaxed/simple;
	bh=06YY8ApMgy1OpGHdIukderyzK7KzMNwwBa335Fe5Jbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O5KClwUwerdleU7Kd72ZAuZtk479TPk2fzINrqG5SWuD3t/5WdcPenA2R8V/tQdPFkDaFBsOMHfq4zbLEv897r7gOMnAv5m25BdtHUFDNf+6dUCQIPkFkyQCI19/glru66S57SYjUB0KD4w2rLzukpcM+8AzEElUhDN0txBgZmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoetWJYT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoetWJYT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93A7EC32781;
	Wed, 15 May 2024 18:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715796912;
	bh=06YY8ApMgy1OpGHdIukderyzK7KzMNwwBa335Fe5Jbo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OoetWJYTHEGhiEbwzPmF15VydeMUzSo15wEoZUAf52avZs8u9Z0Capl5nyjpRk3W4
	 S+/7xbtCMD1BMV0K80Uf3kyV19yF+ERRAyBN5FB/I2NmBlBgKRfR1rxLxLCyby4Jel
	 DjF+igxvNhXh5xzcC4tZ3vqqGK+e5BL1um58rLGP1ph8QbLpoZIVrDxZw0uzT08EB6
	 qoTMoKkSVDpXgjrsNuWfoWqww6P8+/WpCqYuIWkSrH721Kjpdy1IVlZw+W9IiluqZ6
	 M8hO6mx+1M7F2AaKCXS+ykqCaY2v8ohJD8SofkvBSXoHfo07bN5loH25qTdX4AUu9q
	 ejsYMQfY1cziQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85575C25B78;
	Wed, 15 May 2024 18:15:12 +0000 (UTC)
From: Sven Peter via B4 Relay <devnull+sven.svenpeter.dev@kernel.org>
Date: Wed, 15 May 2024 18:15:02 +0000
Subject: [PATCH v2 1/3] Bluetooth: hci_bcm4377: Use correct unit for
 timeouts
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240515-btfix-msgid-v2-1-bb06b9ecb6d1@svenpeter.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715796911; l=839;
 i=sven@svenpeter.dev; s=20240512; h=from:subject:message-id;
 bh=7gQn02PYjfQWipM5wmSh7cRXbC3rcrKdfUfT0gxlvsA=;
 b=5vuT3iBepkv/NY4S5torbyPLDbQY84+ans4BusJj/uJoM6EIqY5izWUCJv/R9gWadUKYhg+sU
 pnvq3oniF36ArujjWEGXIvjbZukR6B/RB7+8A1jxROyY4DQpNkQcJra
X-Developer-Key: i=sven@svenpeter.dev; a=ed25519;
 pk=jIiCK29HFM4fFOT2YTiA6N+4N7W+xZYQDGiO0E37bNU=
X-Endpoint-Received: by B4 Relay for sven@svenpeter.dev/20240512 with
 auth_id=159
X-Original-From: Sven Peter <sven@svenpeter.dev>
Reply-To: sven@svenpeter.dev

From: Sven Peter <sven@svenpeter.dev>

BCM4377_TIMEOUT is always used to wait for completitions and their API
expects a timeout in jiffies instead of msecs.

Fixes: 8a06127602de ("Bluetooth: hci_bcm4377: Add new driver for BCM4377 PCIe boards")
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/bluetooth/hci_bcm4377.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4377.c
index 9a7243d5db71..caf9b64c8111 100644
--- a/drivers/bluetooth/hci_bcm4377.c
+++ b/drivers/bluetooth/hci_bcm4377.c
@@ -32,7 +32,7 @@ enum bcm4377_chip {
 #define BCM4378_DEVICE_ID 0x5f69
 #define BCM4387_DEVICE_ID 0x5f71
 
-#define BCM4377_TIMEOUT 1000
+#define BCM4377_TIMEOUT msecs_to_jiffies(1000)
 
 /*
  * These devices only support DMA transactions inside a 32bit window

-- 
2.34.1


