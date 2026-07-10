Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E873921E4
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 20:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783714235; cv=none; b=jtsl60WSrV6YUCrV8Ru/hZ6DOVqG2SprhQbZdhmTHKCmiCI6H/fIcMkAe1MCPFnd8+BzhXiCYE6jKNKGRYhqpnZJ+vLCPydekBZWtyoxdGXqtCn4Aw5FjyiyOF9AVr332vL+zN8aKwFRfnyhAQ7mggGpPG/l55Fo8DBUMZ0YfjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783714235; c=relaxed/simple;
	bh=XMH9Pb8hmtXjOAiPLhQiFOwNNg+7u2491ttdPUKcHDI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pKjS2VrxAlxOPoN0As+8JIgGeGW7aeDglc1C53/C7TmpODUlCSTo+ewZMU5MsYFooutsHn07ZbXNhjyUYbgPTeXDjOv2JgqvaFhF85irxpzzE3Q7XA/eW5uj7cwAhUGRJMhUq/ZEr2RqXQXMVr49thKzPNQSced9KQbkY8bv2Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1Iok2dp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1Iok2dp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E6C1F000E9;
	Fri, 10 Jul 2026 20:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783714234;
	bh=iuAfU1oDrxp75TG/eOInX5tEioSKPrnReAdNXvlrbgA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=H1Iok2dpJrrg5SE8j1h8WH3REFNFJRrnM4bhH9CX22ZSXBuZ0WZrn55UclhXtqA3V
	 jAoSluWKFUCDLec07f0PEOYkb5WiOInaSbb3JNOt/SDdRN3Xyiy/Wwito6ZhdPoitl
	 ZavXq56XUjdcYc0QSjUCi1vFN4+Hgn9eLGBDP9NEWI0EYxSlkoz5ZEE7edTGqdBpRK
	 aCH1yHmC/Aeszsq6bwWTzYOLdiXqhxj946etyVMWQN8s/3b2hcgLUU9oMv95pP7vj3
	 UBy/x2gSIYrqEXQqHRBwXiHosPPSiEGzOUh/6wSLcO5i9BA6FVn+WG853WYv323U2A
	 OKJuzf/9QUsxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09573924640;
	Fri, 10 Jul 2026 20:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Add support for 1357:c123 Realtek
 8852BE
 device
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178371421139.843459.11063854284998153443.git-patchwork-notify@kernel.org>
Date: Fri, 10 Jul 2026 20:10:11 +0000
References: <20260707221549.27269-1-playximik29@gmail.com>
In-Reply-To: <20260707221549.27269-1-playximik29@gmail.com>
To: Pavel Zverev <playximik29@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  8 Jul 2026 01:15:49 +0300 you wrote:
> Wiko Hi MateBook 14 Ryzen 200 laptops (DMI system-product-name
> "MNCA-XX", board "M1060") are equipped with an RTL8852BE Wi-Fi/BT
> combo chip (rtw89_8852be), whose Bluetooth radio enumerates as
> 1357:c123 instead of one of the already-supported 1358:c123 / 0bda:c123
> identifiers, presumably due to OEM rebranding. Without a matching
> entry it only matches the generic USB Bluetooth class fallback, so the
> Realtek firmware/config (rtl8852btu_fw.bin / rtl8852btu_config.bin) is
> never loaded and the adapter cannot discover or connect to any device,
> even though hciconfig reports it as powered and scanning.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: Add support for 1357:c123 Realtek 8852BE device
    https://git.kernel.org/bluetooth/bluetooth-next/c/1386e748cfc0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


