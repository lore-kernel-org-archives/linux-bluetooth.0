Received: from vtj.irix.systems (vtj.irix.systems [82.76.27.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211412EEE60;
	Sun, 11 Oct 2026 22:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.76.27.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791756698; cv=none; b=bPMe3GGlAZpVI5xUUUdvelPLQoo2S+2PCwXhzC4LJd+XSwPX2O5Nbvnm0ocH2M1rPeEfdl9rHHypHRuomNELrhfdKae3a8sqnWOLYJXIgyljWr8mGKYi7g7GYBO76BzJmuGTkhu9dfF3dyO6NUN3cC+MX4S9d9SJNdZi/ReoNjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791756698; c=relaxed/simple;
	bh=diLAlLYQiizljY+FcjMgFTcqYeqaRtS/xTckWwSR5d8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s25Vt0+QHr2ZjFIqUCKOjS65808q786B81SkKWah8MIxVCZzJwIoLhMYkNSMaQIImSsI3YxnnP8pBO804drs8pn5kxEwFMySN4X/KwjP+yi5d3Q3Q/cF/YSJcK6XlPcX4s4p67pTEJ7WX7nlaWX+C8DJhR86EoF+JBGEyatpgB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=andrei-z.com; spf=pass smtp.mailfrom=andrei-z.com; dkim=pass (2048-bit key) header.d=andrei-z.com header.i=@andrei-z.com header.b=LnuQU1Mr; arc=none smtp.client-ip=82.76.27.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=andrei-z.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrei-z.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=andrei-z.com header.i=@andrei-z.com header.b="LnuQU1Mr"
Received: from MAILGW-BIG.big.vtj.corp.irix.systems (localhost [127.0.0.1])
	by vtj.irix.systems (Proxmox) with ESMTP id 577EE8490;
	Mon, 12 Oct 2026 01:11:35 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=andrei-z.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=sig1; bh=6Q+aNr2fBV+ER+lWAEhH
	I9IqrE1eCZnSHxIZETl7MjY=; b=LnuQU1MrxvKiYBnjF+A3F1mEU5OslqynYpZ3
	WNGCsBTpqxtS8ktqfEpBibhSUqYAUsllaLfEDAPgE90Tghak6um8l9e9rHVii3d7
	wVA37ypKe/lsUaPVzQptlfRKkYJWmXx1EP0VV52Cm7/LvhLWWA2T2RW1n/sn5Il8
	tN+uP8NI9Uj3LbzUPqjRl2yzZ9TCFKHJfbKXouy2WvAPABTElsoVHUHknrbDRcG9
	G4ep/5VwTkfmHgpVBOV2D9iu2GdWbbwci9FCN+VdPRZw69f7FzzjpylE/pwf85e+
	kNuWuy+1DZMeLD7Ds8A4Aq262CD3zL+WvrWsBvVgVLEwuEi+Bw==
Received: from VTJ-MX.corp.irix.systems (unknown [IPv6:2a02:2f04:1:9c24::6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by vtj.irix.systems (Proxmox) with ESMTPS id D8E8F840F;
	Mon, 12 Oct 2026 01:11:34 +0300 (EEST)
Received: from workspace.corp.irix.systems (2a02:2f04:1:9c23::c) by
 VTJ-MX.corp.irix.systems (2a02:2f04:1:9c24::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 01:11:34 +0300
From: Andrei-Alexandru Bleortu <me@andrei-z.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Marcel Holtmann
	<marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>, George
 Moussalem <george.moussalem@outlook.com>, <linux-arm-msm@vger.kernel.org>
Subject: [PATCH 2/3] Bluetooth: btqcomipc: deassert the BTSS reset before enabling its clock
Date: Mon, 12 Oct 2026 01:09:18 +0300
Message-ID: <20261011220919.1816407-3-me@andrei-z.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261011220919.1816407-1-me@andrei-z.com>
References: <20260709-ipq5018-bluetooth-v5-4-e476c41f03b8@outlook.com>
 <20261011220919.1816407-1-me@andrei-z.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VTJ-MX.corp.irix.systems (2a02:2f04:1:9c24::6) To
 VTJ-MX.corp.irix.systems (2a02:2f04:1:9c24::6)

An unbind asserts the BTSS reset through devres, and a later probe then
enabled the LPO branch clock with the subsystem still in reset:
"gcc_btss_lpo_clk status stuck at 'off'" and the probe failed with
-EBUSY. Deassert the reset first; devres then also undoes them in the
right order (clock off, then reset).

Assisted-by: LLM
Signed-off-by: Andrei-Alexandru Bleortu <me@andrei-z.com>
---
 drivers/bluetooth/btqcomipc.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btqcomipc.c b/drivers/bluetooth/btqcomipc.c
index 21dd3e812..8513c1780 100644
--- a/drivers/bluetooth/btqcomipc.c
+++ b/drivers/bluetooth/btqcomipc.c
@@ -1147,16 +1147,20 @@ static int btqcomipc_probe(struct platform_device *pdev)
 
 	of_node_put(ipc_np);
 
-	lpo_clk = devm_clk_get_enabled(dev, "lpo");
-	if (IS_ERR(lpo_clk))
-		return dev_err_probe(dev, PTR_ERR(lpo_clk),
-				     "Failed to get lpo clock\n");
-
+	/*
+	 * The LPO branch clock cannot turn on while the subsystem is held
+	 * in reset, which is how an unbind leaves it: deassert first.
+	 */
 	btss_reset = devm_reset_control_get_exclusive_deasserted(dev, NULL);
 	if (IS_ERR_OR_NULL(btss_reset))
 		return dev_err_probe(dev, PTR_ERR(btss_reset),
 				     "unable to deassert reset\n");
 
+	lpo_clk = devm_clk_get_enabled(dev, "lpo");
+	if (IS_ERR(lpo_clk))
+		return dev_err_probe(dev, PTR_ERR(lpo_clk),
+				     "Failed to get lpo clock\n");
+
 	desc->irq = platform_get_irq(pdev, 0);
 	if (desc->irq < 0)
 		return dev_err_probe(dev, desc->irq, "Failed to acquire IRQ\n");

