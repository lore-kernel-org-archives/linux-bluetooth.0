Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D297E327C0D
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 15:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018421; cv=none; b=NyiLNhOpdw6sULqFo/9+5UxXQhn0/dJzazMfhNnFI1T7JI1Lp+hvn9lJizCf6lThhBckyCjlOxmwCwmVXUiLBT/X2DsCDQS4Owaa/SFPp0S8+C3jc38wK+N6ZI106+Zh/TUeG4OeNktgtrd1WgJY5t6dhpGUaJW9w402yf3/9xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018421; c=relaxed/simple;
	bh=baSWkwMlzxOlK+mAOEZ5uuOXS9yDRYJCZHB5/9q4Wb8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q9kf8w69gOS8Pq3h2yG7mdqrir81Szcf4p5O7aJKg1mtCRZcFrGKpAXdVAB0d6fPUaBlCDcxqC6Lut1LKKjUAnobqZK8H28XHUi9YtgP+p9ZK2FIAsUvOexudmPb0NdVhlHpOoNQC6PxbsAV2/OQj9wioFiZpD2Yh76OUqoNUj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTg9B/18; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTg9B/18"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8FE1F00893;
	Tue,  9 Jun 2026 15:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781018420;
	bh=toR//4Z1S/ehEPnRVGhGER+gkCVAePcOExisb+/oYnc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kTg9B/188zIRrgKd3Q50ggLyFVeTS5Ium86uMjCPDAigDXifjUiNwVZwyKQFnXNWs
	 28qzsIdiIBqIrAB87Nh6TafT5TS1dJqrBD5JlyHDpbng3/lX4rk1duCjintLwpKb+A
	 RDfywtF1ouIDbbJnH8EGYpDbgj+a6BvJF33HIbAv72p9jd+3FZU/RCf19CeiVtf8a+
	 xr9s6wT+bWiQCZrUS3G6OiPokQlS2HOuh9b+8lutiHcZ1E1IsYM+CKSc6f3uIolF/J
	 48ja+P6jJfbL2J49sPW+h/lAFA5E29bHYQ0dm/2fhZD6LaV8Miun9vnIfN+GKEdwSv
	 5E69dLvgd9fnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A633930901;
	Tue,  9 Jun 2026 15:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ PATCH v3 0/2] shared/bap: add ASE Control Point error
 responses
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178101841863.2087958.17757230484857347841.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jun 2026 15:20:18 +0000
References: <20260609102548.6887-1-raghavendra.rao@collabora.com>
In-Reply-To: <20260609102548.6887-1-raghavendra.rao@collabora.com>
To: raghu447 <raghavendra.rao@collabora.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  9 Jun 2026 15:55:46 +0530 you wrote:
> Added bap unit tests in a seperate patch.
> These changes are required to Pass BAP/USR/SPE/BI-01[5]-C tests.
> 
> raghu447 (2):
>   shared/bap: add ASE Control Point error responses
>   unit/bap: add SPE tests
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,1/2] shared/bap: add ASE Control Point error responses
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8bc6dd81c9c2
  - [BlueZ,v3,2/2] unit/bap: add SPE tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=912d67d1d3a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


