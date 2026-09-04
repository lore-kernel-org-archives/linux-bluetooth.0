Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0881550EBE6;
	Fri,  4 Sep 2026 16:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788541034; cv=none; b=YMX/BgFToghYvPqCJhD70avS4j5xchq8CbE84DH3WfnVmT0Ei/4JBRGsydrGk15do2VexYKfEeyjEuIwwNWEZxcBZZKHlEZwhLUIJRo15f+YzXk8wHLQHAZzk8TSa8JBByfzy0WRgS6Ir4De7ZKa+ZfU+QnM5ZAyt46zCCbmUl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788541034; c=relaxed/simple;
	bh=mr4h+cItRTDEu/4O7bKIlFASxrBgiS/xruBcjlHyuec=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gBUZihQojxGl8Y4uqsydBUiudK6ancnsRUX9ljeUzrCKoXAY1NR7puo4mqdgQxeDVP/bf+ZkDOGXBPHR7lJbOf3FyT9oS4EC+twk+JYhdQH17SsRLLkhUdcIjyRdruFve5GREBFo+ZnPNY8lDQ/vsZ7IXcKmAdIn5pjt+v5Zzcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYoopY9m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYoopY9m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9702E1F00A3E;
	Fri,  4 Sep 2026 16:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788541032;
	bh=DArWlZ88qt5Zn9zhbWsI5i81ZoB9+MlseLF1a24Cnss=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eYoopY9mM7SF9GSnAKvPEpLmCoCBycX7cXSL9SHrhXncGPWOtsfIoOT2Efticx4NW
	 EVGBLnAwIbQWwW5GISCR3BalmC+cjMPYUyohwXTxuB5fHOD2WlvQX6caHbOdIZzQFr
	 3nLRymd3duzZJ4L4Ank5LpjLWVy/M7aKdjEE0f+NqFOl5TiPxcTAI+YAIaMyKSx1IA
	 jiCurltaptzecZa0Jp5O4k6dxkVS/z8tSKbdjbvtjGW4GOHJVuTAmiRD8pi29PwVeu
	 x23VNoHLFCgpb3u4qRMA/rSwvF6WtskmDbJ/CZucwYQIF5iBsWSGSMYwaOhZ235FeN
	 P8usQBsic9r8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93AEC3924A50;
	Fri,  4 Sep 2026 16:56:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btmtk: Declare MT7920 (MT7961 1a) Bluetooth
 firmware
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178854097314.344939.15082478069695241185.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 16:56:13 +0000
References: <20260904053007.667472-1-ivan.hu@canonical.com>
In-Reply-To: <20260904053007.667472-1-ivan.hu@canonical.com>
To: Ivan Hu <ivan.hu@canonical.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, peter.tsao@mediatek.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  4 Sep 2026 13:30:07 +0800 you wrote:
> btmtk_fw_get_filename() constructs the firmware name at runtime, so for
> the MT7920 variant (dev_id 0x7961 with fw_flavor set) it requests
> "mediatek/BT_RAM_CODE_MT7961_1a_2_hdr.bin" without ever declaring it via
> MODULE_FIRMWARE(). Tools that select firmware from module metadata (e.g.
> "modinfo -F firmware") therefore omit this blob, so request_firmware()
> fails and Bluetooth does not initialise on MT7920, even though the file
> is present in linux-firmware.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btmtk: Declare MT7920 (MT7961 1a) Bluetooth firmware
    https://git.kernel.org/bluetooth/bluetooth-next/c/860043e48274

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


