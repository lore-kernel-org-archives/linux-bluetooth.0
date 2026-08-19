Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168953C3F41
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 17:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787159463; cv=none; b=HJXG/8Au0TzwaRe3Csl7QVRgPj47PZkn37edXhPlruBxb5FpbPLnztAhwu8Ya2x4V1Ef+fX75hQuHwlpxQh2jeEZwnmhFsfY19sSJbHNKG+F1IvVUrLtj6tzZMlJAgPSiPK5Dw8rt7RmQZrdwi7k8i+U8flmiX8WQfXtT2/xQOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787159463; c=relaxed/simple;
	bh=oy+VkBULRXyxSjoclra4GHX4b6DGvrv+ip4xRkEb5y0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mG+1UHqKjXxVCwiFtN2nT8D/B2Zr4DehoPBk2Agf8z2p/KRhW4ZSqsab0kbsYcFEt9U4JewIO10FBvQuGysmzL76ohz0fMbrTBcORpLy/yvjSyLbRt+50ZDlqJUnohPhXt2tIaLElaZeKtQPLIGN6Dpj7iC8EffFsAsWd0Zh5Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwGdNNTi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwGdNNTi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26C11F00A3A;
	Wed, 19 Aug 2026 17:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787159461;
	bh=REB4YJwv0Ns34u/RGRWJ3d2hGrGVjE9Di0BRFvhN0Ec=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TwGdNNTiXuem1Vt5McOJ8eoaW5uenJTKl+acRH7YVXQ6EAiBqSp2TrVK46YsNkXHZ
	 WfFrrWZNVbtioL2WvlrEr5+wtL1hwBOpgv0nhUhkr2/rycwRDLQ2qY3Zkh30Kd0d3P
	 L/2kV0oyhPANyham5b8TuSwk2pBBwwrB+mNt44Kb46rhAwfoLci21RXzYHXvCPvQ8M
	 TRZQFL57xVRhtgQijl6GReDcESO5X0haZPMgnY7+4LOXQAYob2L2IQx90CzI/FNRZf
	 n6E+sqSI1k84svF5P1IelkinvxS68PXqQ3ONdepSGAjqtaVyAJI1LXl2pQkNveuh+C
	 ie46GuiFgsFOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D092738119E6;
	Wed, 19 Aug 2026 17:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 1/3] Bluetooth: btintel_pcie: parse FW memory region
 addresses via mailbox TLV
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178715941238.3583745.6450247910448931285.git-patchwork-notify@kernel.org>
Date: Wed, 19 Aug 2026 17:10:12 +0000
References: <20260811154553.629211-1-kiran.k@intel.com>
In-Reply-To: <20260811154553.629211-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 11 Aug 2026 21:15:51 +0530 you wrote:
> From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
> 
> Implement GP1 mailbox interrupt handling to receive memory region
> addresses from firmware via a TLV-based protocol. When firmware sends
> a BUILD_SPECIFIC_RESOURCES_MAPPING mailbox message, the driver reads
> a TLV table from device memory containing addresses and sizes of
> debug memory regions (exception dump, DCCM, SDS, ECL, SMEM).
> 
> [...]

Here is the summary with links:
  - [v1,1/3] Bluetooth: btintel_pcie: parse FW memory region addresses via mailbox TLV
    (no matching commit)
  - [v1,2/3] Bluetooth: btintel_pcie: sync mbox tlv parsing with GP0 alive interrupt
    https://git.kernel.org/bluetooth/bluetooth-next/c/185b9b3869fa
  - [v1,3/3] Bluetooth: btintel_pcie: Route debug traces to WiFi DBGC by default
    https://git.kernel.org/bluetooth/bluetooth-next/c/52eff0428bf2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


