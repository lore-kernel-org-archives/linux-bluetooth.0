Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B4423373D
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Sep 2025 16:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759251015; cv=none; b=o/OoL73ugI4+4gCQPq5E5iQCJFlvQtuHY4HLb4yAF48K2kvEX7h5Ff+gurcRyoCMyZPIQ5shDA2CLcK8B0jy9Pib5FggvQB0l2aHFDqOPKi+29xVDxWpsq6iNOiRFDSOwi0GnhvWq2WjZabUBhK9eBSZF5L7QM45BuGmmXbzkv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759251015; c=relaxed/simple;
	bh=Svv4f7q20SOmouy0LYz3ABygyOjZd8x4vsBRpaHLk7Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s7VBAkoLfuVnOSgFrSQiKBaGbXo4B9ZIGo60tMsyU7IsRZ327BZo4mdVub5+nDae1ypwcc11vo71Ke99nrI3QEIczC8rjVn2NJnygzJKWTUnglJXPV/jOxuqKPltvHOsroZDtS2sU/r9kLjSm5Jujh3zBREFKaY5LuHi4JRPS78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYfc6wEb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYfc6wEb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5CE0C113D0;
	Tue, 30 Sep 2025 16:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759251014;
	bh=Svv4f7q20SOmouy0LYz3ABygyOjZd8x4vsBRpaHLk7Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uYfc6wEbHPeVufw1K/Sj8h72qvA/p5MtaDhlLEzwpMy3lF762iLuJgZLoOE/tcCd3
	 sVlmx10X5webbBBiiEqLKZuvakbibCkPhsNhUAs3c4Lg8jPl9ZelcinIz7xvOtGiar
	 1R0VaFF+V/ahXdmoXIpOaFwcnUyT6MqR19IU/UyNSsENzctU1UJqvlzmcAs7fMr1LR
	 UveamAHt32NuHQj9hTkUzXBdr4rDGGBgOn8rwUPphvbb78NUhEaDLuGMKt/gdbXtd8
	 U2+ffAhBBMy4Vf/eYPHnMWkF6x6njAxZqyctlueU7iXQp06vUaREnFHmd3i82v0GYk
	 G7UulDd5PAySA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340C839D0C1A;
	Tue, 30 Sep 2025 16:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/5] shared/hfp: Add Call answer support
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175925100799.2045788.4670004434233836692.git-patchwork-notify@kernel.org>
Date: Tue, 30 Sep 2025 16:50:07 +0000
References: <20250919082334.1443310-1-frederic.danis@collabora.com>
In-Reply-To: <20250919082334.1443310-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 19 Sep 2025 10:23:30 +0200 you wrote:
> This also manage the +CIEV:<call>,… event to create, remove or update
> calls.
> ---
>  src/shared/hfp.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++++
>  src/shared/hfp.h |  4 +++
>  2 files changed, 83 insertions(+)

Here is the summary with links:
  - [BlueZ,1/5] shared/hfp: Add Call answer support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=df19a94770ed
  - [BlueZ,2/5] unit/test-hfp: Add Answer Incoming Call tests for HF
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=aaabb8d75870
  - [BlueZ,3/5] shared/hfp: Add Call hangup support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5453bb526824
  - [BlueZ,4/5] unit/test-hfp: Add Reject Incoming Call tests for HF
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=976d87ba8e02
  - [BlueZ,5/5] unit/test-hfp: Add Terminate Call tests for HF
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c53a401998f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


