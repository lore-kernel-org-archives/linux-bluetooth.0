Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A09E583AD7;
	Tue,  8 Sep 2026 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788885096; cv=none; b=hc9xIRey9rRKw+oEGL3FV7tDGOWr+h4YoeJSewZIbr52M8vleck4ly1jrDmtOpLo13BfyF6iQDcqkDpLKwR9s9OhxEsR3/nYpSVB3L0EjHdzsfnYwEasgtrge3fBSn4/kECdMy9uapr8HGdfSG7lbdzFPsr0kF48gpBo3y/2pGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788885096; c=relaxed/simple;
	bh=srHMDoyJABlFnzqm/7x34dgLB3x1bdk1HbSXbHrmLGU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Eip4bigVL8XnQRBRFrmCaOLtMHw+XHHJDqKK0d/1XOAMDAvg6o0DtgAN8ASmloU0d1F/W10IiiGuEEu0IFUs3iLDa/ZOzB4CzasMSsv3O4wBDMQ3bU1fl8zRRrUSV0isjdu+NCNepYJ73VmENAM+tWcCaDiE2dAWnMUteScfK0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImkSdLPZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImkSdLPZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444301F00A3A;
	Tue,  8 Sep 2026 16:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788885094;
	bh=XRupftECiChZd4zoRwcAnnsyAO4ExuciPiUxwOvheWo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ImkSdLPZXTBtT0bIsaMLCiGehD2kJgo1UxZuDsGuuOywdTUNi/TLrYqHwpSIO+dcS
	 iMRc9/iy5LdWFRUlzBGA3Rmy2Mf9CcRrGO6VD0HCfcyB4vdhd526ky04LO9fagsRy6
	 0SIh9Rud2u3AEOMo0m2ZrjtSbPWELWx8sIunV/Tfei7H3kK7d2o5INisvlM0I7uFLm
	 FTKJn3jv1B5R43ZyKGikDH4pUnfe4Aknp7YQGJ9OHLO9HmXW6dEkTqNJMupTf5Yvb7
	 YdW2K34o3c+tGvRkrwCYap3skuxNNCSHgP3WdZ5o2vOAirMudyCWhlLtzkk1aD2Hnz
	 zZppRlBNp6bNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198EE39EAF6D;
	Tue,  8 Sep 2026 16:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Add device ID for MediaTek MT7925
 (13d3:3631)
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178888503263.3627954.4027043693720648569.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 16:30:32 +0000
References: 
 <7Lm0MbvHvV4KTuQVikJfyHTljM3ozGSBICPx7mcV3jvMSuZw8zx_jHkWn2wuhpZnaUhJgEpgHG22crnJMxLVX_1TRzBT4ME5WPZVtcDpBJg=@pm.me>
In-Reply-To: 
 <7Lm0MbvHvV4KTuQVikJfyHTljM3ozGSBICPx7mcV3jvMSuZw8zx_jHkWn2wuhpZnaUhJgEpgHG22crnJMxLVX_1TRzBT4ME5WPZVtcDpBJg=@pm.me>
To: Samuel Alhovuori <samuel.alhovuori@pm.me>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 03 Sep 2026 08:15:23 +0000 you wrote:
> From a4e37604a8a8e7e282739a72d1a34b9477449df0 Mon Sep 17 00:00:00 2001
> From: Samuel Alhovuori <samuel.alhovuori@pm.me>
> Date: Thu, 3 Sep 2026 11:00:27 +0300
> Subject: [PATCH] Bluetooth: btusb: Add device ID for Mediatek MT7925
>  (13d3:3631)
> 
> Add the USB ID 13d3:3631 for the MediaTek MT7925 Bluetooth module
> found on AzureWave / Mercusys MA37BE PCIe Wi-Fi 7 cards.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: Add device ID for MediaTek MT7925 (13d3:3631)
    https://git.kernel.org/bluetooth/bluetooth-next/c/9c7071e63e87

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


