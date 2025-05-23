Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F8B2063F0
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 May 2025 15:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748013598; cv=none; b=UOLcEPZ9e3tbbyirvYTRMoTEqM3LWjtv5hmZxjxXNN43AGb4cT+yh18SMCXZ4AsubwERnkRG/lIrL4LPlIpuzDzxvs0Pcr7pqdFnHXJrJIvqDG+PGzeVyerjsRMFaRLnCvNGw0puXZDgILmT9cjcFRSAMEN7GglBvjGwIsd3ABw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748013598; c=relaxed/simple;
	bh=19l2IC5IFXqde+9EErx4XaI8tmJEoZAIg1mLsqtCaqQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YWwdeq+wFJrqZTgtChvc8ei72itdXDQplB1VZnszrP9QocLteVxhpAAnLSbUQFyROqsKxOgVEK3+oyqNBe68ElZyHpOZZKvNB2+qutnRNRHzuD4yVWSscCMdpUWfYQxi3XSIqKEBYov5O9+rusFY3uHN6Mwx0MyaY6a6ZE2MpJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhaJgg2W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhaJgg2W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0C9C4CEE9;
	Fri, 23 May 2025 15:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748013597;
	bh=19l2IC5IFXqde+9EErx4XaI8tmJEoZAIg1mLsqtCaqQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZhaJgg2WR1R4mLzaeTtg0phifZB0KiyJO7lbRanM4v8ufXGvEaMS0JBr64gn4o9c6
	 GuKgsr+gm7JzNvaTWB+UTE+y/gxEKZEBgOk5bKEp3UXRusKimJdIJOoqxE/Ti3mvV8
	 Yd00qbbzHK+dqrKwpi2kKwnPLcT/gKingFkIz9y32kTBPKAwFijmWjJZxZx3Tn911G
	 UVAfsvU1e0AbGvAMg4Wdgve6Ngop53nWD8BXpoZvLzBqpMjBc/Bes8D3+vVBgPLtVX
	 eX9VcRCre6fWgK5eSOpF+ogv6/4oLKsW+PLa0+aQ/qODd70gZKrcRD8v+/CmZB2ZGo
	 paMX1hknqX1Pg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340103810902;
	Fri, 23 May 2025 15:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v4 0/4] Propagate disconnection reason
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174801363300.3632136.18068175232903031844.git-patchwork-notify@kernel.org>
Date: Fri, 23 May 2025 15:20:33 +0000
References: <20250523072647.689324-1-frederic.danis@collabora.com>
In-Reply-To: <20250523072647.689324-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 23 May 2025 09:26:43 +0200 you wrote:
> Currently a client application is informed of the disconnection by the
> update of the Connected property to false.
> This sends a Disconnected signal with the disconnection reason before
> the property is updated.
> 
> This will help client application to know the reason for the
> disconnection and to take appropriate action.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v4,1/4] lib/mgmt: Add MGMT_DEV_DISCONN_AUTH_FAILURE define
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=593f8b06fff2
  - [BlueZ,v4,2/4] src/device: Add Disconnected signal to propagate disconnection reason
    (no matching commit)
  - [BlueZ,v4,3/4] doc/device: Add Disconnected signal
    (no matching commit)
  - [BlueZ,v4,4/4] client: Display disconnection reason
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1fe5a858bd97

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


