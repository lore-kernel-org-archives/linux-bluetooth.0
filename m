Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493541C07C9
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jan 2025 20:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736801413; cv=none; b=LmYffwwud2Z6lzvhi+bUsyWEz3EN3f9dJu4TvVcecg57DhVR92SIc9KLZRIk+4hzEF4gZFbIwW01WdNirIVAZ+G5QKmbT6KYYedNPU167I09PbTJBBspk0VPmJhYfp61DIVmKSOeyd0OVZmppbFkI7ej4gMXOY4vkW5GT6sPNGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736801413; c=relaxed/simple;
	bh=hvbx7mwmItlrejnXFcOCw0lfOmAC0scrXq8ahs6+g58=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EtJqygp6uUoYxW0Oz0D2/mt8DPYFNXPyln3t+aeZrg71Bs3+7StrN0gM2Mfe0ljX4ulpWc4jBBlaM3Ve2R6Zj93AO8ZU3/qpTWrS16e7ZaKlJ+94/EuFwiMyCRI9sqO+ZsLjBQFlzkEYKvxy7toAB/5RB4XKJNvYOtfTfVaCTtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuaJjB/x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuaJjB/x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B251FC4CED6;
	Mon, 13 Jan 2025 20:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736801412;
	bh=hvbx7mwmItlrejnXFcOCw0lfOmAC0scrXq8ahs6+g58=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NuaJjB/x5YpW95bU/6LgxGJ4ISUrqwG2TN8ek4U5NrbfitskhqSzofngHkpnsq9pe
	 MEGTk56Jmvs5RZ6exK9rx/RSCxbOqfbn1moI+9eykDe8QxsHQQNJpRCLrDz63+qiqe
	 T/YJyP8L/3U3udQGgdWp+osV3zqubvEkOBERoHBCvDKkd8UdthaOteVeg7/oMULTCl
	 +19ySLFrLf6MEFEPbIq1HpIBGEHfk8U7Uyu5Ob5b2Uzcq5H96Os+fti5LfrJQLE9Iy
	 zJXe/aEirX0pW6tycR1BcmISGs7YjjU0vJ0bQ2MeFTYBxQ6SPJpowXSeJn954G5YxW
	 cupUPt9n8TFug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 73943380AA5F;
	Mon, 13 Jan 2025 20:50:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] BNEP: Fix the BNEP Unknown Control Message in PTS testing:
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173680143529.3628468.10668052417891978869.git-patchwork-notify@kernel.org>
Date: Mon, 13 Jan 2025 20:50:35 +0000
References: <20250110065444.3192525-1-quic_shuaz@quicinc.com>
In-Reply-To: <20250110065444.3192525-1-quic_shuaz@quicinc.com>
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_chejiang@quicinc.com,
 quic_jiaymao@quicinc.com, quic_zijuhu@quicinc.com, quic_mohamull@quicinc.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 10 Jan 2025 14:54:44 +0800 you wrote:
> This change is required for passing below PTS testcase:
> 1. BNEP/CTRL/BV-01-C
> 
> Fix the flag judgment issue, it should check type
> instead of ctrl.
> 
> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> 
> [...]

Here is the summary with links:
  - [v1] BNEP: Fix the BNEP Unknown Control Message in PTS testing:
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a30763866b7a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


