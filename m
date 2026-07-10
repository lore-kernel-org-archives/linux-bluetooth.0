Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE44379C21;
	Fri, 10 Jul 2026 20:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783714240; cv=none; b=ojmU5OFeR7tvex0eq3ea8VZxsW61tlAfnZq40ZcvQ2ao3FjBtio6Nm3BZ7nR/p5nAbIOMFDOceOgVyiJ+AxnbjPjlf5JU4Ly4gjiUlhUhZMw2e4oC79/SL9veC5eZvmHvkCove4VKKAcsvsdjxdAEYSnqtj5lV6xNsP5LcrCBXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783714240; c=relaxed/simple;
	bh=CIFC8nk68JSavveB2ZEppWuWYSWkL9Wta+hAwqp1i34=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uCC+GFcVTZYo0ugoxBNoVOLJAq+5hBmNG9bn+pDLuU3t9lGeA1s1HwHYvydIQ3V416+sdHMIEcGgl1y2imwdKYWDKkybWQMAXnSqrweY5OiqwipKNZIyGX3Fp9wB1JmhGcdGAykE6Xd8bFnxaiLCUfW4cz61c9yF86sf28ck9QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLM6Wu2y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLM6Wu2y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F2C1F00A3A;
	Fri, 10 Jul 2026 20:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783714237;
	bh=d4uaQTTp8Ar6rb7OT8M/25PrDsFvgxiBBsSWeYkrEZ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TLM6Wu2yj7RauKcSuUiqA26YPnP3bkrw842w6vre1rVPXdBSAXKgv0hes/MQnJbRt
	 LOD1tX46kUtm9JtCEV0v+Bp4omzfda7ncg4IjiaDMNGIBXkCUJY9KGRm1FU5CJAP7k
	 rvzzWVRakSRtxWtUDtiUPu8NqBJto2U9uRGGKWNRtJN3qgTcq0tAxrhAhNnOkv/c25
	 Vqqzpl6toAK6YGVljMYevOtr9aKwH+J+8SVqwtlyZ0l8/D2lAHNJH6O2QwjMzUaMqH
	 89OGqVZZY8/xpr0gE8wAu4Zo8yLCSbTrHJ5gFccu0voZk/ZqY0ygUDVpakATkMUlAk
	 NTFpiAOW2k+BA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C0339245C0;
	Fri, 10 Jul 2026 20:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: mgmt: Translate HCI reason in Device
 Disconnected
 event
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178371421438.843459.13775076078432042030.git-patchwork-notify@kernel.org>
Date: Fri, 10 Jul 2026 20:10:14 +0000
References: <20260710094731.59767-1-mikhail.v.gavrilov@gmail.com>
In-Reply-To: <20260710094731.59767-1-mikhail.v.gavrilov@gmail.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 10 Jul 2026 14:47:31 +0500 you wrote:
> MGMT_EV_DEVICE_DISCONNECTED carries a reason field which is defined to
> be one of MGMT_DEV_DISCONN_* (0x00..0x05). hci_disconn_complete_evt()
> converts the HCI error with hci_to_mgmt_reason(), but two other paths
> pass the raw HCI error straight through:
> 
>   hci_cs_disconnect()   -> cp->reason
>   mgmt_connect_failed() -> status
> 
> [...]

Here is the summary with links:
  - Bluetooth: mgmt: Translate HCI reason in Device Disconnected event
    https://git.kernel.org/bluetooth/bluetooth-next/c/eab19cb7618e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


