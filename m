Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A625476DD
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 17:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789061478; cv=none; b=F/JXydRMGlP7QYbtNPynaGTPQL4ixg8n1JqZAlrTtcjllbwIKbTG//AJrlFnnC41K/Pl3+JY0aVeqgzNx+EUonshkGS9SZK7YcMXpuMLs8XqB/05MVhqgq+7+57hQqGGfPVMcDtiOojzgpeuiA42YGinQWDiR9Bj0gvWthrtqhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789061478; c=relaxed/simple;
	bh=zdl3fX8PIUKAUM/iHRaOpmLlI5ke2rxuWViLvsUSNdU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MDrSqmm94mOGOWkB5Ep4vSB2YME0l3OmTJzZEzY5pyo8Pz4ulahf3XTKEQK+04+KsnYD6jge6C6LeCrpsNyq94spHfFQJz7o+dD6xOCmCgVcynSDVM80VsMFabm5HjbHuLPanKet7k73x57hnMgBXVzsZmmMv+HrI0k05dPnPTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0SHozDL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0SHozDL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FAB61F000FF;
	Thu, 10 Sep 2026 17:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789061467;
	bh=hHVoFs4WA4UJnhi/Ss1HXYRrEGI2/74mqSR708d+Qss=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=o0SHozDLdhOcxqGF2TRAQgfJvyLtsEKMn40ALXLDgMqQDr8c896GOfNMAhmRLYYPu
	 rk6dmtswMOkZOV3VVQWUBJmh9ujlScjstom6F4MDbxlTol90/z9vtfu6bGoPjk0DYc
	 Y2+AJxFgTmFnrjLE9o1h58dEFIKJ8HVKi7+UZANuNcVNpHFAni3Wyk+RK/ELgo6ddr
	 +a6z4h0rETWAZgVw5p68FFO2/OVAfU9pFTZUaNjQz5Q+MZh5YRqtpTcBLg8uEqjQwL
	 4ANGdFlFxYzkC6W0gRauelBIAct8eYUwR9e54HVgjllJe8Q81CQOpfiZKQS1HOPCem
	 BTyuVE0Bn5lWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19B51380DBD4;
	Thu, 10 Sep 2026 17:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] build: run the test suite in parallel
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178906140489.1999514.2405079666006763952.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 17:30:04 +0000
References: <20260910164412.1495535-1-luiz.dentz@gmail.com>
In-Reply-To: <20260910164412.1495535-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 10 Sep 2026 12:44:12 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Both the unit tests and the functional tests were running serially,
> which makes "make check" unnecessarily slow.
> 
> The automake test harness spawns the individual tests from a sub-make,
> so adding -j to AM_MAKEFLAGS for the check-TESTS/recheck targets is
> enough to parallelize the unit tests.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] build: run the test suite in parallel
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ed279b3516ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


