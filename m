Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B7E52CCC5
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 17:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790876424; cv=none; b=thavqBuZJ5ew9ru65opy4QITGCV6qaK6G9kZC1X9fdr1GGHy2wH3DG7GQLW9DNB/TSfuuSeHfBqDPGoWtc4Q90RHDqehwvNXmSRMwF0vjDjpUIJsqIJP3HwO48EsdnQ8PF9d1z8JyG545ODZt0s/rW4NNz0cJe/+h8dikZc7zzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790876424; c=relaxed/simple;
	bh=aTKBcCfGL0c7qAg3ITfd/9IOFk3EhbG6At11udg+Chc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BrhSV42mvUtCVVQWfJgTCZapRjJoL6066tXFTUy6blNWcCc5q0yqVfYEItu+G6P5pz0viLzlS2FtJts3gFP0m0ZiCowEqECRQq7mM004u5yPWBEGoZcxnYD5WGT8U7mPybIXYAq1D5ulbaeazovmj1YeNV6yLOXljGlfVQd7X9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwvg18Ce; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwvg18Ce"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC3701F00898;
	Thu,  1 Oct 2026 17:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790876415;
	bh=wPEJGZeohq9OQ9Y2mD3dAhDiXoJqFBqmiOmBKf90Pqw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gwvg18Ces87ujGmX5qO+MocOKopaXUBTYt3e5Txg7cioD/rs7reii1GeXS/A0N+Ri
	 aaKzZYRgLhT03mpCjuxB6JWyfjjJCnDB+Jlp44EfxcxA9my6plXuOtvXFTgKTuOYMd
	 w3KnMIheix3n/Xj/AfmjkJayFzpmxJ5B/6dDV3bMQT3p6vqMw2BGmIATRqnbIPZUAp
	 1u3aUF1sx4V0T9dUG69fz564BSwcjtQ7A4IEbi5fFu4JxZ/UMTGagZzbjbz+0Zv+uQ
	 dpI0/Vs2bpbgTz+Cpqy2cYHL4w3GW3UK3ihtdjY7TRm43k4BiPuIkFovYa0Zkyr4lK
	 kSWSGdu0cIk5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44CA3811961;
	Thu,  1 Oct 2026 17:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/3] doc: Add commit message guidelines for AI
 coding
 assistants
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179087641439.3027576.842784778085859511.git-patchwork-notify@kernel.org>
Date: Thu, 01 Oct 2026 17:40:14 +0000
References: <20261001151054.2422165-1-luiz.dentz@gmail.com>
In-Reply-To: <20261001151054.2422165-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  1 Oct 2026 11:10:52 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Require commit messages to record only the changes and their rationale,
> to follow Rule 2 of the maintainer guidelines, and to have their factual
> claims checked against the diff.
> 
> Inspired by WirePlumber's AGENTS.md:
> https://gitlab.freedesktop.org/pipewire/wireplumber/-/blob/master/AGENTS.md
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/3] doc: Add commit message guidelines for AI coding assistants
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=798da8d7ace2
  - [BlueZ,v1,2/3] doc: Add bug fixing procedure for AI coding assistants
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=17ea5080c481
  - [BlueZ,v1,3/3] Add AGENTS.md symlink to doc/coding-assistants.rst
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2f1ae1462507

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


