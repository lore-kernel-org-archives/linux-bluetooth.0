Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE62335AC01
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 18:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781116815; cv=none; b=KjviYe4Aooo2ENdqclQ7O8StP8I+kyPArVmrjdPjKTqHwEuggVG5c9uNB44flg8wS9yzQl8GWCzYS9mOQTGz/gxNIgOADwCep33kBS+yNNm61JMw2/1TRoM3TTjS4W9DVjNJtW4W3jdKkoI0lVQ616SapiXu3YDo0jETUw8bA3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781116815; c=relaxed/simple;
	bh=mX0qS//Rf0yFXaMdwRrDycTMGl5KWLk2oD01mSkQOQ0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Rg7tvxXc8McW5xkvOst1TcFpYe386cCxVTufVwZ2SqFnOlIZygyaOS9pJ5WxvnztthAbOjlBH64R/fyZyhTdSbcfAB2QEnAb+mi0x1vM/LmUw0S0Ibl/rhPuquEDGx3IZPOPG+uGc5k+0iAV6El9N4Af0kqBs22p/6GAECAaB2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5BqkfVs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5BqkfVs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9E61F00893;
	Wed, 10 Jun 2026 18:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781116814;
	bh=1ncVuWCz14PCBAO2idz9S7cYEZAZ0nGkOyHuRxI+NgM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=i5BqkfVsZw+eVsnjqvGuxR0O44t+dYWzxohzeX7ntSCqMnE0baIu2VJYAyWeZWKCZ
	 LP7SR9C19+BL+XASKqyyhNEIoftzV19WwQBYXlFjq/D5fDfz11IwJCh3V4Tbirx0Rj
	 4px/ychO+Erh3tJ//2AYm9XxEQYGh0pMHS/DSLLGoaWg3PfsC9+tMfViUcqi0k3rlu
	 AWGJ2+qJrMPetSFJ0Vz734QUvl77tRnsuuBsqGeLg1ylstS+c8CYk/TIj9/Bhomm98
	 oedRCcLYwuNNZmCcf4XEZ0kzFg60T1G31zuGRPoHn5obmrms59Ak9jQ7d4nUxHqxxB
	 waO3izztWpV+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9387E3930DEB;
	Wed, 10 Jun 2026 18:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] transport: Complete Acquire for Sink ASE entering
 Enabling
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178111681213.3588149.4306776156862401187.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 18:40:12 +0000
References: <20260609211130.3887817-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20260609211130.3887817-1-simon.mikuda@streamunlimited.com>
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  9 Jun 2026 23:11:29 +0200 you wrote:
> On the QoS to Enabling transition the IO is not yet available because
> the CIS is not established, so the handler returns early and a pending
> Acquire is left unanswered once the IO later arrives.
> 
> Notify the connecting callbacks once the fd is attached so the
> transport can re-run the Enabling handling and complete the Acquire.
> 
> [...]

Here is the summary with links:
  - [BlueZ] transport: Complete Acquire for Sink ASE entering Enabling
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3047c2a4c5ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


