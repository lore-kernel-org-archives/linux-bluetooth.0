Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B923BED06
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 16:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781023252; cv=none; b=baR82ZsdsWyKEW/bVhKAvR/PrvkI/bTfyytPAiWQ6RIv0I8eULHvgOazgYMBeOHSkcHcFHRFpqs/leAJX/ormO3VyQ6RsaWz5qWCGNPRRVpksbBuMLJ6vvxS0Cli2sHGstb3OjLD9XJLh4PUm/FaVIU7jrep1ua2/Y3KQkqI7Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781023252; c=relaxed/simple;
	bh=XnzYDuO8V6Zz1811uzKUxaxJkEpt2AWHPOnQZEL1iTo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r2vmRsK5AATHniyFRNXnmtUwgSeo5qwqxN6LLcRUhpkiRaph3QbfQzMxHHOObZFJKXnzJnR+ZGT96UbqXevY+HYBph1QbQIvnoOGxvXTzpPsqJlvA02Lt0LgSMLjDg9DZQxUtAHkMexeqexhe0f/s/kAU+lisucSyNVjpf08fXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Up57PDN+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Up57PDN+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B191F00898;
	Tue,  9 Jun 2026 16:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781023251;
	bh=R7YJuEZteA4wYzlO7m9O4rEFVHgtTWA8QTajnt/Lkr8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Up57PDN+LMhX4ijo4Jen+k6W7Q2YYYkMy5dE+/0q5nMnFac+b1Q2pMOIZaNoy+ZM1
	 b1Y9TttTgNOT3dMtR2ZHVwaR3zmwD3CIPbaFTc5pULbH8JU85XEr8YDPbrSz65ZGGi
	 36Mg0TQndrC03KlCpfQA66LgV8EO+3Z89ABiTc6av0csC51AKUxuUn3Wo3W0qCiXPb
	 tu+DzYVkqu5yx14L785vEwhcop/NYUZU0mlfy7WrxWbUb8lvXtL+nvQgUh8pg5QLeE
	 G4kNcxOnVC/fHi56pAfuL0tvUDVBxy5qPC+M0s5qCl6XfqWdonX3fzJP1wKMEd82fa
	 O9AHhhfN2c5aQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A8F3930989;
	Tue,  9 Jun 2026 16:40:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Load IOSF debug regs by
 controller variant
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178102324938.2135346.6226498338854271525.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jun 2026 16:40:49 +0000
References: <20260607062117.110893-1-kiran.k@intel.com>
In-Reply-To: <20260607062117.110893-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com,
 aluvala.sai.teja@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun,  7 Jun 2026 11:51:17 +0530 you wrote:
> From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
> 
> Load the IOSF DBGC base address based on the controller hardware
> variant when reading DRAM buffers during a trace dump. Scorpius
> Peak family controllers (SCP/SCP2/SCP2F) use a different DBGC base
> address (0xf0d5d500) than Blazar family controllers (BZRI/BZRIW,
> 0xf3800300).
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: btintel_pcie: Load IOSF debug regs by controller variant
    https://git.kernel.org/bluetooth/bluetooth-next/c/e5ea095d9bd1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


