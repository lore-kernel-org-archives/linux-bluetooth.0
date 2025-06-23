Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA3F2D8789
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jun 2025 19:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750705795; cv=none; b=FuJ9OSJYqZSeR/wvGEc9Cc+PXH3k8uOcf6Z1QdltJdwBEj/12sDDEwUxTcB3Od2xukAIvuxlcg7xwP4d8O+NkK2sQMl5hsd3HMLj51tl9Olic0pslacq4TxQm6HZF0yl6YuvIC5PSB9lm1JAVI/IPFwrilje4JlJUO8+i957x2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750705795; c=relaxed/simple;
	bh=YyUpHWPZPI4McUr2RlL8j/rwNoBzmEhQx93FM8/7Y+M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=arNHgznyyd9Fk6/FAwMlpOFi7S+0F4/Jtng9axpkQhdPNXiVciuHDlxRYsciyoLEKmyGJiOrvp6IjqZ5jlJ/N9C46ynvEFtR1jKZwghqSduTyJIbpjHurjp0qWzHIbnlxcmshRT6s87p4C6zj2nV5/fXTaEkMHGuugwjksPeo+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JARMGLEN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JARMGLEN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4734C4CEED;
	Mon, 23 Jun 2025 19:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750705794;
	bh=YyUpHWPZPI4McUr2RlL8j/rwNoBzmEhQx93FM8/7Y+M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JARMGLENcoMpfpTFrvRECKkAHan2IS33LPxr8Eb8Y3ZzOeCmkVyeZI8Ayi5clPC3e
	 /LzvDyVG4pXu9/dAUur+v2CTXFNbC+dGpLfX5h37IIxZj6yqOpDk6A2oElFCnpPiHV
	 btWDxmleSCiUvPgZDhUklUo32HgC+8tF3AEA9VzIqKIKYAqk5RDvoza8ddOLJjxHgS
	 XWTZFUq0Xdd94rJ6F9kDdNDVasr07LFL+4EAJvPYQ3PXgcjZomBTfgg0RZywM8r9hH
	 GASB0enZ/0HPEV51/b8QlTxtmy0LsbDc+ss//8VN62/UVpBGhf5kIxTHs2sCP0TSWY
	 uQqzp/7xek6qw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE08638111DD;
	Mon, 23 Jun 2025 19:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: btintel_pcie: Add support for device 0x4d76
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175070582049.3268784.15553534377173535592.git-patchwork-notify@kernel.org>
Date: Mon, 23 Jun 2025 19:10:20 +0000
References: <20250621064631.781861-1-kiran.k@intel.com>
In-Reply-To: <20250621064631.781861-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com,
 aluvala.sai.teja@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 21 Jun 2025 12:16:31 +0530 you wrote:
> lspci -v -k -d  8086:4d76
> 00:14.7 Bluetooth: Intel Corporation Device 4d76
>         Subsystem: Intel Corporation Device 0011
>         Flags: fast devsel, IRQ 255, IOMMU group 12
>         Memory at 13013328000 (64-bit, non-prefetchable) [disabled] [size=16K]
>         Capabilities: [c8] Power Management version 3
>         Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
>         Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
>         Capabilities: [80] MSI-X: Enable- Count=32 Masked-
>         Capabilities: [100] Latency Tolerance Reporting
>         Kernel driver in use: btintel_pcie
>         Kernel modules: btintel_pcie
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: btintel_pcie: Add support for device 0x4d76
    https://git.kernel.org/bluetooth/bluetooth-next/c/bb955a83ce91

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


