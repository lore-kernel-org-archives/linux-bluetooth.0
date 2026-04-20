Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4932C3CA48C
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 22:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776722428; cv=none; b=i0pnPyN6Ix/x59QPxRU8P3egnTTlY/Ub2aPhTu7AsqZjxipfIPfpNvKVP5gyhfJRLxiBGB9WJiT/oOkubz2082YKa1suH1/nqDwDDTxzIyL83IVoENidzotAeod43UoBJgqx/ejGee60BT9bbea3OAcEEhCoDNzABFN2yE/ZR2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776722428; c=relaxed/simple;
	bh=9LISdZqpZfpuQeRVt7X052Gihg/gZkvaQkMWWLVNEr0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uSKPrIm4Ih2X1elFsrTjJSUahG7vbNntkRotoDAA9I49+nqrjXFNUpWmwaMdMY5s51nlbA8CbKGxcOWSlvzbft/yGpfBOgZ7KyPV3bz6ffffsIXhDi7mfe1vvLJ5rwdCMleHm2U4dV1mj5p6PFsjTyqN4MmWCxQ8Nq6AXOMLhWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7PyUnYb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7PyUnYb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECCDC2BCB0;
	Mon, 20 Apr 2026 22:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776722428;
	bh=9LISdZqpZfpuQeRVt7X052Gihg/gZkvaQkMWWLVNEr0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k7PyUnYbxaKUfAOoaG40A8FSqObia+imrPyg5OcOVOyLXRYbDGHmD1Gu2trv6fNEJ
	 zZRO7F072o/aT/a4x/ir0Ep69fM5r7Po7r6r1RHShaLuyi5nhd6IDa2WZS7xALhFDJ
	 ufgT1lvSNgnoPgfdayaVvKmZCGCfmg8YBmH4KCf0GnEVa0SbtlPKW/X0UWweWhHJps
	 4QM3J7JSHXvJh7nhlqZSnvrw8B/OMF7iRgzRD7wXtRhLjocfa9DxpjLdwiWLLELEcb
	 biSGVrCBti9VYsMDzhkdhY5ptghv/jz/2o5uYeor1POIiayLDX4pMWrP9rP6ui8DTD
	 MrY/00jlHeWmw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BAB1A3930022;
	Mon, 20 Apr 2026 21:59:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btintel_pcie: treat boot stage bit 12 as
 warning
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177672239255.1802062.16259035599907976124.git-patchwork-notify@kernel.org>
Date: Mon, 20 Apr 2026 21:59:52 +0000
References: <20260420173735.950706-1-kiran.k@intel.com>
In-Reply-To: <20260420173735.950706-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, aluvala.sai.teja@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 20 Apr 2026 23:07:35 +0530 you wrote:
> From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
> 
> CSR boot stage register bit 12 is documented as a device warning,
> not a fatal error. Rename the bit definition accordingly and stop
> including it in btintel_pcie_in_error().
> 
> This keeps warning-only boot stage values from being classified as
> errors while preserving abort-handler state as the actual error
> condition.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btintel_pcie: treat boot stage bit 12 as warning
    https://git.kernel.org/bluetooth/bluetooth-next/c/dbcf6151ff1e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


