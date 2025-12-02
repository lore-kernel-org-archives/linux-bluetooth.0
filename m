Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A681C221F0C
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Dec 2025 14:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764685998; cv=none; b=NbfckCZ6ipeZNWfkVLuQ5gRbE2q4J0H/gGDGtnbxogMvxFoF3P5z2kq55I5mwEO9Td3r52GqvmOZ0qL9Y2KNGGTfLveps2bdSrdzkHYPNy8yIVWC29r7dy+oG29qZOTP6RhzjC0+BQwfCdpZFobu8ncw9BBA0F815vLiylQmZHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764685998; c=relaxed/simple;
	bh=V3V3SdUQQd5LhPVEphzMY0NSB1pIN1P7ovDio+eH7BM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KqnlujufguM98hmGGXK7c/ZjIdOWkxjjqaMR9DtvwnHGAHtH928JwzS0dXPE/0RLzRiLMkyR9H8AKhVXGdybngGNoq+DrBF6KsOteFcRs3OepPObDEmjHVdNbYwAOu7TMZwWcW9o9TS+XerAa2ZF5lJPAWMomhpeyEcpfESs2NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otoxZ0AV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otoxZ0AV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4582EC4CEF1;
	Tue,  2 Dec 2025 14:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764685997;
	bh=V3V3SdUQQd5LhPVEphzMY0NSB1pIN1P7ovDio+eH7BM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=otoxZ0AVm4IgRLmSR649iwhN0aNXUkIZAduLdqVQbW7FxPDTb1qSFOU4KDiXq5XA9
	 0LVmLZWlZ/ZoROphoivGLzRTIHMF710jxSPwp34sykYbONceToSYh/nBZQaTipaOPz
	 QXqzqh6/pSQyEZK1iMDp1zlgPRIRg16RPU8zYk7Jv9zHGvFuG2fg5CoIGybyisSmbl
	 MoAzBR+hIopPNuDFHBnhPNpVsNWqOtnVBsPcelnWfBTB28GMNs7GGfDfwhSOcnHA75
	 NW0KfREbUcFO0J8jgKD7Lg5mGUq5fisn70F1kV8btuQ7RtTY/BYLrwd2j9C6WZrsU8
	 sgK9VeXvSZzDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F29D43A54A16;
	Tue,  2 Dec 2025 14:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] main: Fix wrong option name in LE options array
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176468581652.3250289.5902553279734093905.git-patchwork-notify@kernel.org>
Date: Tue, 02 Dec 2025 14:30:16 +0000
References: <20251128015818.1838246-1-Hermes.Zhang@axis.com>
In-Reply-To: <20251128015818.1838246-1-Hermes.Zhang@axis.com>
To: Hermes Zhang <Hermes.Zhang@axis.com>
Cc: linux-bluetooth@vger.kernel.org, chenhuiz@axis.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 28 Nov 2025 09:58:18 +0800 you wrote:
> From: Hermes Zhang <chenhuiz@axis.com>
> 
> Correct the name of "AdvMonitoring" to "AdvMonitor" for consistency
> with Bluetooth Low Energy (LE) terminology in the le_options array.
> 
> - ScanIntervalAdvMonitoring -> ScanIntervalAdvMonitor
> - ScanWindowAdvMonitoring -> ScanWindowAdvMonitor
> 
> [...]

Here is the summary with links:
  - main: Fix wrong option name in LE options array
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e898a615cf52

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


