Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BFB35C1B4
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jul 2026 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783527026; cv=none; b=gHRBRCZ8LjMKQA8I54Gz6D6DiCJFr7hKtoUUzYWavq5hE0DgqTnrx0xGsQamEv662rGgmXgmH6gk+wxJY6b6yR+mxFrSAq0GLgEwINZetC7bOKrjrPa+bms0d/W4dghRuTc4t3qNHQg1M6vnK6P4R/KDrUelgDwbW99ECNrIxDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783527026; c=relaxed/simple;
	bh=5pFRg381gD96wE5c2BxF31dsV1L4k0wcqHHNrPUbHlE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G4uYWHgI90rhpOpDtTX1OlkIyQo3Kwoqw/fhQr36IT0UjC1WMDKw7Yt8HcM6g68iWFQqRqG33bbP5lA/7hNrH1o7l3k3/Vc2uXeHtxaxJYl5GCAU90upZOuNkYy5pJsXefhUkTB+tURMcutoYctaUtgrzvsNX36EPZCXabOOBTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CV92NBSl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CV92NBSl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE101F000E9;
	Wed,  8 Jul 2026 16:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783527025;
	bh=6mVOF+JeoehEOc2F6RYftxZu86yJ4PZmZnccrNLRhMQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CV92NBSlQ9MaI8o2UKvitktRQbQFzBPBlqxlNkrXP5sTSgdTK8Cm9rPOQuuhrWLOQ
	 BnAiIU5Ov9PuJUIHZu3A/UgxuP56ZwlJFKXG8K80JkEMwlnOEdn6zS3LQ0e5HFtp0L
	 kH4zcN/tdVSqsYoH9YeyuAH6XqH/4kaMtR7K3IoaGsKwF9O1DRpAZZmec0mto1A5uf
	 dYrc092z85psvXUpqLxaBEtb4m/3onzBTX7U89vKjICRTE6ZxOtBEhqn9g1hVMOc7l
	 XMugGrNw52VMxY4QzfjmUSeQvnncAgAJQM+Y1w9rMFzKIKdzkOd57V0Tv5LtZtB844
	 b6g0oBO1REapg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09E53930FBE;
	Wed,  8 Jul 2026 16:10:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: split coredump worker into
 per-trigger works
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178352700464.3009771.15016263615696178190.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jul 2026 16:10:04 +0000
References: <20260702170359.26233-1-kiran.k@intel.com>
In-Reply-To: <20260702170359.26233-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  2 Jul 2026 22:33:59 +0530 you wrote:
> btintel_pcie_coredump_worker() handled three unrelated jobs in one
> work item: collect a DRAM trace coredump, read the hardware exception
> event, and read the firmware-trigger event. The worker walked three
> flag bits at runtime and each interrupt path mutated multiple bits
> to communicate which sub-jobs the worker should run, which made the
> ownership rules for those bits hard to reason about and entangled
> the trigger reason with the in-progress accounting.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: btintel_pcie: split coredump worker into per-trigger works
    https://git.kernel.org/bluetooth/bluetooth-next/c/ca75417ab179

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


