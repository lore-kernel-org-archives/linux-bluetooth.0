Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562E228A1F7
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 19:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745437189; cv=none; b=MA3/4U3JlOOpzgSlySbQKOvIbxC12x2hpyXMc8lwwFZk4/VHYbuC91Gr3/0PZ006b/fPG1pgQ/g+DqzKnYOp4/zyCxGWzaMKuWXxkjREqPSCSQLRFD4e372Ou5ZwVxlfRkK+8hNeBUVsz7/Pu2R/meicMzrYJ1kioa8Sc1c29Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745437189; c=relaxed/simple;
	bh=WiwYCU+3uOkuGA3SW8hNtoKiyTjnIy2vyXGLXU5Ekyo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o9WYjpiEb1hFfSjZ7V0AuoPQ489P3+xGgSA5q//hg5p7Yln/QX6fSW/64w1zo2WA3xvueWVYIfIGGIUOth1v2o1e1J5a46Q24Pi+iVaLsee71kHWkmEm8r4TfGPl35A/x6XIxePfc/DdrgJSsZAYCe98Ym+6yj1UiE+A9iFDdkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCEL95jF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCEL95jF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4FA3C4CEE2;
	Wed, 23 Apr 2025 19:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745437188;
	bh=WiwYCU+3uOkuGA3SW8hNtoKiyTjnIy2vyXGLXU5Ekyo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eCEL95jF/IyV1A54WUpSBsZVknsuiovTuWak714PLBiDQHq90OLbPmLhUVcirMkKU
	 LZl7pfNvqywub0mrhZiPu60HL2YI6lBcL6GMUSKr+U6YXyOskiVbimj9IDsuaKxu49
	 EIjLYPr//3lMLh0EwTVQMM6a/PcbMJDKjMmSi70HpNn8tUh1C/Ff15Yz8iQcj2bzRm
	 NYC0GZTnqyttRXLzSg07uy3JaR564KEIz6X7WHB4EQtsfLFE6xX5zA2Qz8bKW15VWB
	 t0AVVr7q8va67w6ARmsOkr4T+77Zp+ZzIvF7YqBS3OmdnJIK8cJ6M7u4tqbECP+5lT
	 b07WMbv2Cj6VQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E25380CED9;
	Wed, 23 Apr 2025 19:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] workflow/sync: Fix workflow task
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174543722725.2747647.13376124051820317879.git-patchwork-notify@kernel.org>
Date: Wed, 23 Apr 2025 19:40:27 +0000
References: <20250423192912.1182925-1-luiz.dentz@gmail.com>
In-Reply-To: <20250423192912.1182925-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 23 Apr 2025 15:29:12 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Sync repo from bzcafe does assume that syncing with master has not
> happened yet, thus it aborts before syncing the workflow branch which is
> required for patchwork task to create PRs.
> ---
>  .github/workflows/sync.yml | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [BlueZ,v1] workflow/sync: Fix workflow task
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e06ed62241c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


