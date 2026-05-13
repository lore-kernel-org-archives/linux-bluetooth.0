Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92902DEA86
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 14:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778680860; cv=none; b=ueuJ7tW88KRDyLHDlbGDMWdWoLfybtNpkN1yNzGQPCuDqYVyeTq1OrTgC0PoGfsFLVV/K2FpWEjx/bI+gN0rN2E6bE5ic2kfa8ijQnD0Qaqjf6ocVLpgz7vlNeUy43PWnjGlkS7any5E9FXRK/nqRzlSeiZ3sGroKuQ59YcB870=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778680860; c=relaxed/simple;
	bh=5Y8lj5qlkBrRPj+awxSI2HbA/6kADOo7l1u4RRcuPRs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z9k9b43OvSXRyN6fE+MsvRd1LMAn4lxQQIis6xg9k2iGcPYNi+zC44kNHZ8H4MWqL4CZK00Uf9l32Y6a9BugXEKnJNCgr3l/zpFfRypZNuHiuEYzgGpF+46X005ZtuBUhm1qWDnUDcrvuI+061GlncySCVpQ3VsDNgtdeja54Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFO8CW7B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFO8CW7B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ABBBC2BCF7;
	Wed, 13 May 2026 14:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778680859;
	bh=5Y8lj5qlkBrRPj+awxSI2HbA/6kADOo7l1u4RRcuPRs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dFO8CW7BGAhH77G5hNIvRZO4m3kkH0wghVqf3Ar4JxCDR83yUtyhord/BQfjFQ3jc
	 Pl4Dbn2FHEffF5fP3Gu4RBjWXCv4p67QOZcIPyb0PEHCJAgXE5wpc1swWdLEEufUem
	 bFxUhdy0ENABNDZtpyCSWoCXDBEqbrPYnk+LF7fDoZ6tkMLv7gnKwVEHGAG9+I1yGo
	 r3G1L160ZHhoJ4f8zAJ8PG7WNIZUGr38cpRJjkwOOwVKF1w++iyIEp0zX7nA5YQP+C
	 iiV2jb1yW5I9dOUBAboUtGI+Z/m321Hne/LmaT0zoRlTl0ISTKPD0SFl+kd//NCpmW
	 DJZQC7/L7QvEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC9F39301A9;
	Wed, 13 May 2026 14:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] monitor: Add decoding for Microsoft defined event
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177868080504.3661151.15162342456690924989.git-patchwork-notify@kernel.org>
Date: Wed, 13 May 2026 14:00:05 +0000
References: <20260415073940.739683-1-apusaka@google.com>
In-Reply-To: <20260415073940.739683-1-apusaka@google.com>
To: Archie Pusaka <apusaka@google.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 chromeos-bluetooth-upstreaming@chromium.org, apusaka@chromium.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 15 Apr 2026 15:36:45 +0800 you wrote:
> From: Archie Pusaka <apusaka@chromium.org>
> 
> This adds decoders to MSFT LE monitor device event
> ---
> 
>  monitor/msft.c   | 78 +++++++++++++++++++++++++++++++++++++++++++++++-
>  monitor/msft.h   |  1 +
>  monitor/packet.c | 44 ++++++++++++++++++++++-----
>  3 files changed, 115 insertions(+), 8 deletions(-)

Here is the summary with links:
  - [BlueZ] monitor: Add decoding for Microsoft defined event
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c4789506455f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


