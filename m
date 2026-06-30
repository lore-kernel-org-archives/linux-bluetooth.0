Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104D347B434;
	Tue, 30 Jun 2026 20:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782851574; cv=none; b=aMLfHJ/EslFS6RJGk3wcHIPcuvVp9pUGCk22I8Ddz9ZaxmrLhaPoJJPzP9ZGydaT0lsI80kXfVvWNOrPy0UEvDKOoG5WMkoc0Et14IncaSdhga2WmRNNLFsS7bmPKuKUOn2yVS4tEcVyTLQmmaKhreUiP3waRtSrunev6caKAUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782851574; c=relaxed/simple;
	bh=l7uLryd/b3oyWZ6lgNPjHFyKDVyhRJyG6ycuof94iiE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rRdGABmjLJJgyyCWrLBgw6peZQA/iVM698VTovbzjwNQ3I3BhEKnZuqUERn7RaGcevfurh9enTA0GkPLsaBtApN0ZM3p/GnJA8+gKNsuSbxiNSdBD16l2vlSgpkoQb1IPYyMAyhezLOaxbjLacGxXHF7kbNicR8hejMIt8mXpXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3Bx6vQB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3Bx6vQB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3DD1F000E9;
	Tue, 30 Jun 2026 20:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782851572;
	bh=L9emKmY3/73fnyua6OrBcEN705iryVTxHXPjRLIxDjA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=M3Bx6vQBKJjEaT1ShD2NcilHrwCAhHT4r749/1nDhSh1Vkr3PNN6LawxpG6g4PR/I
	 OBOz9vKwpBs0fN3jv/cGbTnExxS47s8q0X16uXkXE2pYZJLTrGbJ1hpbISWKHgmd8Z
	 kxYxTrvkBnXsrXjzT3Ec4a9BHJhQ7hnNkWtqOOeYlhW8qQWZ9fszyvz4K3g2KtUbaG
	 iUSfbWdfsF45oYmrFQd4eD3R+p5gRrmLCarpNHGaDcr6PNOoJ3S8M+JN+l/IXYsJZa
	 PbFOFRK5ib29VAchx/YxdV1dNpBAuD/Yn+zNAqlEHKXJe9KS+4x6gz9DQRD+doJlGg
	 YnmghJLDsKX5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A87393A951;
	Tue, 30 Jun 2026 20:32:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btusb: Add IMC Networks QCA9377 to quirks
 table
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178285155638.267316.9485052012945402309.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jun 2026 20:32:36 +0000
References: <20260629203420.24137-1-silurust@gmail.com>
In-Reply-To: <20260629203420.24137-1-silurust@gmail.com>
To: Tibor Harcsa <silurust@gmail.com>
Cc: luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 29 Jun 2026 22:34:20 +0200 you wrote:
> Add the USB ID (13d3:3503) for the IMC Networks Qualcomm Atheros
> QCA9377 Bluetooth controller to the btusb quirks table. This device
> requires Qualcomm Rome firmware and wideband speech support to function
> properly; otherwise, BLE scanning fails with HCI unexpected event
> opcode 0x2005 errors.
> 
> The device reports the following in /sys/kernel/debug/usb/devices:
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btusb: Add IMC Networks QCA9377 to quirks table
    https://git.kernel.org/bluetooth/bluetooth-next/c/547fc6a4a51a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


