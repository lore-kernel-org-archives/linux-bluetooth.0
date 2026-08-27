Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA61530B53F
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 16:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787849460; cv=none; b=k13HrSSpsROYxhkYkcHm81AfL9NqpwO62vEYGdrly2PxXa8cGqDJr99jeIVVyZCjTKuDlmmjtyv2GLPQum1I9XhZlydZPr6OewQTbBGONq/t4F+lKf7Zle5TFQryFaAXABdG0KgZJ7+jRv8Bvsk+FUEN7X3T6ckWlpiTEcUkQ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787849460; c=relaxed/simple;
	bh=H6Blt2hSgIMlyLsfQQkI6X9nQfjE3iQa3+GCshhqrf8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Pqyhv/Xt2WML7xAO7nnvGKCtia5r6ggvz9Q+raUSvZ3vHhwX6Vg4sdZLnhgnksAMv5WeFfIElb8DGQTDLLEL2cpx3UnpebZsd3cZ/JZ0jdmI8x3dWwwCRD/1eUJzvXk14zi84gsKui0zM8HyhPkaVrIltdsBA4yS3/nVWwi9KOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvSE01cg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvSE01cg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F011F000E9;
	Thu, 27 Aug 2026 16:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787849459;
	bh=jEkV/WqtPK4g6YboEWHUzZzKsBrPSmnoQaHR7X3Gxzw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BvSE01cgqjieZoD/iM44KElLi6m+PrO8uRZ85X5cV3z4MuIyWUtrrKmIXpLvlCqZG
	 Mn/IqL2E1OU/fzUgr4vLAZhgBDE2+jZ4sJLx1/F/GkFqku95fKQAdEp1q1llxN7Cfn
	 RyKLYUNcfzy5HiN+/H/OlToIwVvscqgFjCp/5iaD36R6PPIx0niGJ/HBm+1jeNsRRa
	 I5nAiUbpfNucyAOWSOKyHcVQbzrbN/Aq3YGMrXYPs3cG+hlN3q59TnVQIaKcqiIBpe
	 nDRJ4I0tbscW9uGE/2XRtLngMH0R3saDvPbM7ocFdaoFo8hu/j8RGZvSlTkpon4FMJ
	 C0YnYV5amuF8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5693F3809A88;
	Thu, 27 Aug 2026 16:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btintel_pcie: Clear automask on spurious
 interrupts
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178784940516.1742962.8755153331785550697.git-patchwork-notify@kernel.org>
Date: Thu, 27 Aug 2026 16:50:05 +0000
References: <20260825172300.150440-1-kiran.k@intel.com>
In-Reply-To: <20260825172300.150440-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 25 Aug 2026 22:53:00 +0530 you wrote:
> On spurious interrupt where the TX and RX causes are not set, driver was
> not clearing the auto mask which can block all the interrupts. Driver
> needs to clear the automask even if no causes are set.
> 
> Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
> Signed-off-by: Kiran K <kiran.k@intel.com>
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btintel_pcie: Clear automask on spurious interrupts
    https://git.kernel.org/bluetooth/bluetooth-next/c/bcb621272aa0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


