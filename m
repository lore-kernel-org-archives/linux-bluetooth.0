Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42E73911B2;
	Fri, 17 Jul 2026 09:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784281239; cv=none; b=V6awl2n8DMJ0X3KuHjs91G3kzXyLzS+brmpCbMCl27ZWPoo0Uo4rHunH5d0Yutz3KsOwxN0/4+qeUjGOjP08uZExvTm2tJ+m/jY6Kuccvz48uFc5ctMfLD/rnprI98NVtlXCYoKoTI9QBfsoSSi6OuoOkJfpL2zG+4ViDxfnBow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784281239; c=relaxed/simple;
	bh=L9JuH6dAzzGogHkUJSBKFoZKh4sEmR2ZvjQU97yOucU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z3pwDPcULToxrSzuyAJHtVX8LK00mME8Quo4v67+1oaeenXGfzuydYl5/7RhZtUSHUEaM4JF17SjRU0v7s9HDyV74zJn42LVIkALctYTEm365OIPexkO71EbwbZ9Z+blNIrWWbIuz08WjoeJ/gHRQbENbrR2B1q83S1yhN3nBLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgLOQkRV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgLOQkRV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A43B1F000E9;
	Fri, 17 Jul 2026 09:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784281238;
	bh=RT4JxwOY1ePKkIqCIrIetEl8O64RDaigbYU8vXdNCMU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IgLOQkRVFlSfvMeiRsTMqOZ0EfhnsAB9KwHqWiXH/84FjgS3Fz6+0SSS7ydAObXmB
	 wmeiChdBrehWlp8M4RsoEUl1W2M9SjO2K9Pfo6k7jOa7FSF4uPplvRV0yq7me2NLbS
	 OoumLNC5kldgkWgdBsRivhv4sPi0+AvclyHsLlTJWlgtvQiYR/i2sTlq9hRlc5hunB
	 rG0PlzeNN+CbGx/fgIsvg3HWIWwG5DAHdRkG43V2tsgwRw8xs7WtRJcwE4oviFE62u
	 sfxPAAOKFdZOl4Dd5ct8FBFYA0mU0cXOyjT+WgQrOB3+2m5hbiIDQVaL6jS60rikDF
	 SkV+Vim5VygiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A5C380CECD;
	Fri, 17 Jul 2026 09:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2026-07-13
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178428121090.1634389.7712460611024460306.git-patchwork-notify@kernel.org>
Date: Fri, 17 Jul 2026 09:40:10 +0000
References: <20260713141940.954317-1-luiz.dentz@gmail.com>
In-Reply-To: <20260713141940.954317-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 13 Jul 2026 10:19:40 -0400 you wrote:
> The following changes since commit 3f1f755366687d051174739fb99f7d560202f60b:
> 
>   net: openvswitch: reject oversized nested action attrs (2026-07-11 13:09:11 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-07-13
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2026-07-13
    https://git.kernel.org/netdev/net/c/78d24e77ffd3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


