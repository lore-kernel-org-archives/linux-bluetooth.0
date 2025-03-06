Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F7820E71B;
	Thu,  6 Mar 2025 21:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294822; cv=none; b=TvTztHPnzy/GVhkTBiACpTVIZsZ5dH6UXqXi2lN3b8sQ7jcBZCtdvrYo83Fu6OQuZKHg4W7EM6ryj8IfVa1BYYE6gsiegigFUc0zIDNhfIfZUzkduWIaeu9duyEInquL/yL8HURNdlZAeqkx+5zvMZ9STfjT38Hrmym6NwpZ5YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294822; c=relaxed/simple;
	bh=3M7QwT9VShzTBMuAqqwkeyfxJF40EicmLSYuOMSRCX0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sOTX4PjcGb9DVeCbucxyEcDK+N8g/1/2E5ZJDY1qUxlEx9I5mqyIfj+yM6x3857yG2wZBFHo2usY3ly4tdliLDLayF7fCcH7yuMwBuOSMcO9h72O2qh1Sz3oOA3DGDCysx7n0R5v23nM+qIKNBtzTAEtAqlRy7Uy1RBLJO6BRU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2/feeyD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2/feeyD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37BEBC4CEEC;
	Thu,  6 Mar 2025 21:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741294822;
	bh=3M7QwT9VShzTBMuAqqwkeyfxJF40EicmLSYuOMSRCX0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u2/feeyDt9OdjE7cfzPf98j0671FTATt1H2gpAy3wjs/kf/LNDQ7ZkEMdI8zb5+xb
	 hv3DW7arxCbEUlskpfz/DvpYcMzubeWAAMdSVWs/c7Gq5y9N4kUdQGut3j17bn9Trs
	 iLLQv7g/0TuhakQgiqDnv64rriR9RpGq6f8eFDYzTPoWNwezbxMuoGB6gXwTKngymp
	 nZhtHjBgkYvh6WV6IW90mSD1TRS7RT/aNMTCPgmoVMrdEK6U1JkZ5Wc9on1v1hMAsW
	 A0FHu1PzLWcula+UKOv7DmITLdYi2XtYK5y/wgS4CHsSaGZU8QeAcDRh28TvWk2uit
	 x5MpHhFc1TIwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE59380CEE6;
	Thu,  6 Mar 2025 21:00:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 1/2] Bluetooth: btnxpuart: Move vendor specific
 initialization to .post_init
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174129485551.1775969.15385603820601807563.git-patchwork-notify@kernel.org>
Date: Thu, 06 Mar 2025 21:00:55 +0000
References: <20250227182620.740323-1-neeraj.sanjaykale@nxp.com>
In-Reply-To: <20250227182620.740323-1-neeraj.sanjaykale@nxp.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, loic.poulain@linaro.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 amitkumar.karwar@nxp.com, manjeet.gupta@nxp.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 27 Feb 2025 23:56:19 +0530 you wrote:
> This moves change baudrate and power save vendor commands from
> nxp_setup() to nxp_post_init().
> 
> This also moves the baudrate restore logic from nxp_serdev_remove() to
> nxp_shutdown() which ensure baudrate is restored even when HCI dev is
> down, preventing baudrate mismatch between host and controller when
> device is probed again next time.
> 
> [...]

Here is the summary with links:
  - [v1,1/2] Bluetooth: btnxpuart: Move vendor specific initialization to .post_init
    https://git.kernel.org/bluetooth/bluetooth-next/c/6391ddf8e285
  - [v1,2/2] Bluetooth: btnxpuart: Add support for HCI coredump feature
    https://git.kernel.org/bluetooth/bluetooth-next/c/b21ae0e8b437

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


