Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B43145FE0
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2026 19:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775589627; cv=none; b=tCGfw37/aPnlOgbzMzQaB2sEIK004odHoZ6ixWbgqODaQuBj2nv5MEzfS/CxdJ12oRRSZdXq7OQA1RMi/71l92Fj1znFcWvkHMHwdJFDWittJt2mn4i2Vkq9RB0hkn8iqcurkxrpVJGpg8otGaCTmu7fGCYoFqr/CVXom3g5McU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775589627; c=relaxed/simple;
	bh=beByxkNVIyddHo3MwO0c17JaCkNCVN6HC2UxenrayhU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fnpqhcYe3VsjiCe4D2sS09mizXrC4JbmXZNYBpOCuWrhoX8NcUIJcul8ZwD1MLr4AC7nN/quA7HKAC9kzSUKPjbVCWjOW42DfyO/q8TsLVU8pH8p9WfLojNgZGjHW5E8p5mFxUGbTu6qDebIxHfpfXCvrIsVGE9J+d5mIwfnc/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2BeSSGD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2BeSSGD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37479C2BCB1;
	Tue,  7 Apr 2026 19:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775589627;
	bh=beByxkNVIyddHo3MwO0c17JaCkNCVN6HC2UxenrayhU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m2BeSSGDYB+0gX/zpead9AkLurAxe257wI4WdrR2Ul9s2CLR9Xkhhcspy8rkTZxPP
	 jsm5rdujNEX4p7dPGllDNua2JLwMKBUC2jiPqpHEsfxvflzSrtiacfuJyFHB4bJQ1x
	 CrDlMJH0n1mKDnkIiCD6djwB7Zdb0j2uIm2mduX0Aj4wGrZZRrV3myiHhFD8DvwLpR
	 b3IeSMcvB1FOfiq+MnTSnhfHGtbj3qoOKa6lzjHMcPoAJaDpslfKe4fo8YD7iAivTb
	 R99aJVJ7X/wtF2Cyndq6a8pOyHNRBOermJYI4iAekKwr5cD9RS6QgWSd06pCHYo8SC
	 PQbgmv9W8QGOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C023809A33;
	Tue,  7 Apr 2026 19:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND v1] Bluetooth: btintel_pcie: Align shared DMA
 memory to
 128 bytes
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177558960480.4120057.795692751925961609.git-patchwork-notify@kernel.org>
Date: Tue, 07 Apr 2026 19:20:04 +0000
References: <20260407100240.757910-1-kiran.k@intel.com>
In-Reply-To: <20260407100240.757910-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  7 Apr 2026 15:32:40 +0530 you wrote:
> Align each descriptor/index/context region to 128 bytes before
> calculating the total DMA pool size. This ensures the memory layout
> shared with firmware meets the 128-byte alignment requirement.
> 
> The DMA pool alignment is also set to 128 bytes to match the firmware
> expectation for all shared structures.
> 
> [...]

Here is the summary with links:
  - [RESEND,v1] Bluetooth: btintel_pcie: Align shared DMA memory to 128 bytes
    https://git.kernel.org/bluetooth/bluetooth-next/c/0875da1eeb29

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


