Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460C64519A6;
	Mon, 17 Aug 2026 19:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786996008; cv=none; b=QRG7wPPkZLEwwqiKKLtJceQQxKfTYa06zWXlQ8oQ3nYzlnKgcxdLOCcQQgzoY32hAfLCjxWH192a1GqQV+Rb4rW+JDRdxnnVyyjB83IbPTXmvBmQ/kJ9fod5UORRhOh9QeiI5wiL9F+UdkShnp/Py6SdWTwNYJRoXdpRiRgILiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786996008; c=relaxed/simple;
	bh=d0Rm7C+tWgJeW3lyYaRjz3I0gD24Fb4SO4YFqJIgM6o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rJdVR14AiKQ0GKgokusIXKXgBeWvnTrUjl0CVt/WnFpr5wEeJ2Cd2DoaRySg5nkKbUipKnVvxX7Cfe3baDvsUpTcgbRFu2+3DAd4wubfxgRTg18pltJNFenVRPkH7XCNdDrYAc3oExZ3AAAzw0Mzi31DTisbSeMhuL5Rypp0/HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDTcvuCb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDTcvuCb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5931F00A3A;
	Mon, 17 Aug 2026 19:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786996007;
	bh=ncZ2rFBFQmB7lHnYBO+T99kDbunK49tTTpiKFcew394=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LDTcvuCb9Tp63mh0hn8H+nZue9UzxQp1jnA8NBNVNVt/3nlcCKlHXPxHisnOYNsgX
	 ndeoHULCYOmnjHrHLvH+mb6CkkFJdTbn7vkPZC2pDm7siU9lmEO7tlLAuDpKbkA73n
	 Z5UHZBTLd8cSOlDyWeYnyEuMNp2H0UFDasQy5qrjM+r0fgZ9Ljkz4sOor7YFWUZqAD
	 FhMx6IH8ga0FRZ7SPM1YMofLg4Dac6vKDl3FqqjTRPvFjKNaYR8oW5JZHSzIMAuZSf
	 Ybxu/pFSfdcojw+0Voo7EF1ww8RetKinu60bXeEZ0UCQHB7pUj5fWn1g+VutQDuuBb
	 kpoRbXvRPvGEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56AF23926262;
	Mon, 17 Aug 2026 19:46:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btnxpuart: Check remote M.2 connector
 availability before pwrseq
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178699595888.1691257.12228192402111698983.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 19:45:58 +0000
References: <20260817-btnxpuart_m2-v1-1-a23e51020794@nxp.com>
In-Reply-To: <20260817-btnxpuart_m2-v1-1-a23e51020794@nxp.com>
To: Sherry Sun (OSS) <sherry.sun@oss.nxp.com>
Cc: amitkumar.karwar@nxp.com, neeraj.sanjaykale@nxp.com, marcel@holtmann.org,
 luiz.dentz@gmail.com, mani@kernel.org, bartosz.golaszewski@oss.qualcomm.com,
 Frank.Li@nxp.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, sherry.sun@nxp.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 17 Aug 2026 10:27:39 +0800 you wrote:
> From: Sherry Sun <sherry.sun@nxp.com>
> 
> The current code uses of_graph_is_present() to decide whether to enter
> the pwrseq path. However, of_graph_is_present() only checks for the
> structural presence of a port/ports sub-node and does not check the
> status property. This causes problems when a DT overlay disables the
> remote M.2 connector node (e.g., switching from PCIe WiFi to SDIO WiFi):
> the port node still exists, so of_graph_is_present() returns true, but
> the pwrseq provider never registers because the connector is disabled,
> leading to an infinite -EPROBE_DEFER loop.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btnxpuart: Check remote M.2 connector availability before pwrseq
    https://git.kernel.org/bluetooth/bluetooth-next/c/f716a05f4967

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


