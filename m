Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03F8275B11
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jul 2025 18:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753727394; cv=none; b=sh4iKU+EcNz111FQb/5qgoSy0pt5OlpY5ZzvYkLFFqy3K4ocSJH8F0pXOKbowg1Dpf1jOITsp48T8JSxvjwovaNe7hIHVz5u5wjEUSI0iDEsEwSk0VDdkgyjgR2fZhYPMY10z2+7TSKpPbdhJ+UOG4h+DhIwFGcMiVXy6CsutdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753727394; c=relaxed/simple;
	bh=EYN/MXX7oU/lPgmx0dkgJv1Bu9IUlMa4lDhzoJ6OgP4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Dp9C5SQ86fL/M5Djf4TPxxlalFtXYWxPz0WOr+ptxEqtmO8gZokINyDejDr53VPdfimMHU4BIHVAxHUyj6kPS626rf9g3Eg9vomHJbXtQY0xfjifmz18o7qX2Tvm4bu22Kte5VpxguVj638dTiBIS9O3Z3uI8M4AIMY+dOuGHV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQrFg1mO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQrFg1mO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27770C4CEE7;
	Mon, 28 Jul 2025 18:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753727393;
	bh=EYN/MXX7oU/lPgmx0dkgJv1Bu9IUlMa4lDhzoJ6OgP4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vQrFg1mOhzjdnz7vQt70x5VbMNOWNfBKcLT3U8VIOYzOMdmFtTNvPn2MOR4no53kR
	 rmgaDkcwoBMC8rKyoklkt543RWndUWEPNHQFvx/f0qPTqo4fHTYfSDbv7YIBphJPuB
	 tL4qtkjiQ8ZTOu+MO35rtzjTRAYdEsRc+1ningYBogAuirokyPYmqe9ruUcRlbyOfE
	 ZZK55CFYfFV1N5yfYLPoXCM/FgLDwl00jLIBg7nsRcWMg9cp0W8WusICGOxdu/pHw7
	 v+Ydmpl4b8CJ8raTjbjhMLonLhxx/Eyx5f+bzymnPDkI24vC/kyty/TmgqSiCN1iHt
	 vm1eYLc2goYcw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB4B2383BF5F;
	Mon, 28 Jul 2025 18:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/2] Bluetooth: btintel_pcie: Add Bluetooth
 core/platform
 as comments
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175372740942.805186.1883379077631029676.git-patchwork-notify@kernel.org>
Date: Mon, 28 Jul 2025 18:30:09 +0000
References: <20250728154910.1428086-1-kiran.k@intel.com>
In-Reply-To: <20250728154910.1428086-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chandrashekar.devegowda@intel.com, pmenzel@molgen.mpg.de

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 28 Jul 2025 21:19:08 +0530 you wrote:
> Add Bluetooth CNVi core and platform names to the PCI device table for
> each device ID as a comment.
> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
> changes in v3:
>     - Include product and platform name in commit message
>     - s/commnents/comments/g
> 
> [...]

Here is the summary with links:
  - [v3,1/2] Bluetooth: btintel_pcie: Add Bluetooth core/platform as comments
    (no matching commit)
  - [v3,2/2] Bluetooth: btintel_pcie: Add id of Scorpious, Panther Lake-H484
    https://git.kernel.org/bluetooth/bluetooth-next/c/ce0fc419c2cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


