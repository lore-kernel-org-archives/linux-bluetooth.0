Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E5341A4FB;
	Mon, 14 Sep 2026 09:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789378686; cv=none; b=d0n1P7k/CkJaYs+IIJBAqCyLhS/roY2xam5kyj20CTgrdssG8Pxij9CZK578Okt86dC8S8dxqKduKIpb2gY198JMuE25mHLxGk5nAhoaC45cnis+RUhBEOtWIHllkAATKD5nt+J/By3+bQkfxwS6k/hJQuzZpzt26+kA3r9tqSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789378686; c=relaxed/simple;
	bh=TfcFfDZDrk0DqAZBBL4h6OR44UPkg7B0FARbEJfC+KQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ennok9DrRI3XYMNAaRyPbrR+NpbOIQhiNbXMZdHFcagqutkbtOoTC8WjVKSuYOXhZ6ZwZ97zvZXbqLSOD3525I4BdcZvwqM+SmPnxrKpOEmLqEFN/JIs8vMtQbf5M5AKS60irh/98DaQgWxtRcQoalGpulEwhR97YPu00DW6cFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wd93u+cc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wd93u+cc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AEB1CC2BCB8;
	Mon, 14 Sep 2026 09:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789378685;
	bh=TfcFfDZDrk0DqAZBBL4h6OR44UPkg7B0FARbEJfC+KQ=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Wd93u+cc0ud7+gFdVc7bTxr4LSYSOqfn/lnwBKlCuwcPSCogsYKR3bFhJ8m4UQDIK
	 Ncl57vCAvykacDFcp0DaClkX/1LtSsC24OMNZ5cGuHAC+c/cypRmp7X888w806xaS2
	 yki+/YQ2AfmGgSIsOBCQknjSwFuZWqOpaZzrLWMcv4qyaZsLXqV1O7tpeAnhEKq+fS
	 FG+XZ6fJCMRS7ZyqmDtjjnmmLZg0kWJURoX3NB6p0pEVrrk/BnnDmqGYi98/5oT8h2
	 uDOyYrSXzsWIDjtVNYFYSRB2GxSAFCNarUtsXzsV26w8CJLM7Hv4p/F104DgcbhG9b
	 uYdYbVuYR5Afg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF95C88E50;
	Mon, 14 Sep 2026 09:38:05 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Mon, 14 Sep 2026 04:37:24 -0500
Subject: [PATCH RESEND] Bluetooth: btbcm: Add entry for BCM4356A3 UART
 bluetooth
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-bcm4356a3-bt-v1-1-ce44d0abb5db@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789378684; l=1010;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=bQ6WFjUIqP2rPELTYAWoRuAn5MAUJ18Jq8ZRipAGP0w=;
 b=8OUptnnuLKHDleCzLZRrCt5VceNmOhOqslfjCD1QV3P3xw5xezfea/Gb5tV7OY71WWvIh9qgj
 hKCW0VMIp/EDwAVDMyp2Vp52VDxGpukgEr36a0uCFu0T/e4MEjn/xi5
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

This patch adds the device ID for the bluetooth chip used in the
Nvidia specific Broadcom BCM4356 PCI-E WiFi / UART BT chip.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/bluetooth/btbcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 463d59890befe..14acea7325478 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -506,6 +506,7 @@ static const struct bcm_subver_table bcm_uart_subver_table[] = {
 	{ 0x6606, "BCM4345C5"	},	/* 003.006.006 */
 	{ 0x230f, "BCM4356A2"	},	/* 001.003.015 */
 	{ 0x2310, "BCM4343A2"	},	/* 001.003.016 */
+	{ 0x2409, "BCM4356A3"	},	/* 001.004.009 */
 	{ 0x220e, "BCM20702A1"  },	/* 001.002.014 */
 	{ 0x420d, "BCM4349B1"	},	/* 002.002.013 */
 	{ 0x420e, "BCM4349B1"	},	/* 002.002.014 */

---
base-commit: 49362394dad7df66c274c867a271394c10ca2bb8
change-id: 20260717-bcm4356a3-bt-cd78cc0f42e8

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>


