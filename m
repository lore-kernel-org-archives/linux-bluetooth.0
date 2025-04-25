Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C709221882B
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 19:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745607676; cv=none; b=mAoo9Ay4J2aHu1co5ZKrINR2KTcEZ5GoEAZw+wUNDIsw1W0CjRyWfj9TyoRH46Z3tL+PRifYNEtz4HKFti+oi+NWIQDxMFYS0H7KGI+zCkCVsT0H/geGnpkep3cpq+mBJuNl6//MInE2FlCQe/cn+Gj4zhMVj/UMF9ORnUfnk34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745607676; c=relaxed/simple;
	bh=koOhT3tj1GEiuUlB0kP63mtGFdIsa26rvIo26lueDKM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SmG1IXhqSKBDnUxcOwaD1/vuLpGw1nl9g7UZEZNrNxxCeHdayXvVReNqRDjmfjSRJKQKf9IecZDpth99cQafiaXX/iT7TKeS9SIW8wWbg3uhHjd7aJ5vsLNEerbRFyRg8x9eCqfn3onmNYJFNnWpuJDIuKCDB1nZaa7TcvVyuQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=szmT1nIA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="szmT1nIA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4498CC4CEE4;
	Fri, 25 Apr 2025 19:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745607676;
	bh=koOhT3tj1GEiuUlB0kP63mtGFdIsa26rvIo26lueDKM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=szmT1nIAELLSA2/M/xxTiNuKYTQLPTt/CWoo6NPVbjsapT7K/s61RSmkFdveMeTTF
	 RambwgbwXynT0MKvYt/CjHN2jtkUsjcubitwbsWUqUKyEgYkxdcPal0vFYe8CDZEOT
	 gBWKizUveSrcnHkAcF5amJioBEQldMX5fXFVi7oprYal00zWT9OcgTbpoLCxhAxux0
	 alZmqA4//blxOe9mbMNPtk2/CTZfEf7XvLqxKjHV3mt6Ht6QM0oWRWdybaKi3LxJr0
	 6f7c0d1PJzyo2X4KydbmbGSLaIjPJciwMiRPBK3XcBnRPTzZqrZMZe6Y3JEHRdAk7Z
	 JWCsP9gJl3gAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D52380CFD7;
	Fri, 25 Apr 2025 19:01:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] shared/asha: Only update device set after start
 succeeds
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174560771498.3803904.211039046424414038.git-patchwork-notify@kernel.org>
Date: Fri, 25 Apr 2025 19:01:54 +0000
References: <20250425140447.615075-1-arun@asymptotic.io>
In-Reply-To: <20250425140447.615075-1-arun@asymptotic.io>
To: Arun Raghavan <arun@asymptotic.io>
Cc: linux-bluetooth@vger.kernel.org, sanchayan@asymptotic.io

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 25 Apr 2025 10:04:47 -0400 you wrote:
> This ensures that one side's connected status is only exposed to the
> other after the connection is actually complete.
> ---
>  src/shared/asha.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Here is the summary with links:
  - [BlueZ] shared/asha: Only update device set after start succeeds
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c29bb3f92825

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


