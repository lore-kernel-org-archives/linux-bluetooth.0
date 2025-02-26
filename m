Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DBAEEBB
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Feb 2025 20:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740601799; cv=none; b=M6Zkpf0u4FWnQ721XFrFlniP+qT4LELFRUBGktH5c6ZxCjVtUT0ZaBQUoYyz1y5a7y5n+c9whhuW1yEhuclzoOT0umpLlHNLd6sUtNpXrog+513TutVt5Z/K7LNwvQhHgtxasXoce0a12/jFQS4mzLpswFlYQ3lF80SLClZVJZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740601799; c=relaxed/simple;
	bh=O8lL8oJjyxURQZlza2f0Bugc9qMVsg3n3tZKWABN0Ac=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EzAnqSk6G+0VicASEoX/Fb+/R+f39otONPznLqadhz17+WOG0mXTJJQoaGJ7x++a+l8tfjSSk7ArVC9bU0PJd6UKA20baH4LkgmBYgU1B7ML2Qs1t9xOTXM3oWHrq00/5PaU0u2i6k9PnPcWP41Z81A7CL8GMyOvEfp4+PwChSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=polUrU2O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="polUrU2O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21712C4CED6;
	Wed, 26 Feb 2025 20:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740601799;
	bh=O8lL8oJjyxURQZlza2f0Bugc9qMVsg3n3tZKWABN0Ac=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=polUrU2OOhxXmE7VCz3JUa1HnZMMmQgODhAjillH83qHx/IHCjfQ03PH2OEJU9Spj
	 lRErUrFnIQuMiEOdJ4jNxtjwN8CJrMqsXcqdX92Gp03N5xdAgjmw417q6NxDVD3H1v
	 cDhTMzov47xvxq1zTdpKAm7c8rQogbZivq5zlR35Jx+93szbYTUZoxAuymXKjehieO
	 WrtirFX58jRh6g8cpcRMOAI4/m4XOIaeJ2f43/U8D7ULUWRMntHFszvWJj1BqjBD+W
	 ZiTXyUs0sprQPU7vhq6jPM5NeVyP5F27+7SMfmoWFEtCHFtlT9PK2Jkot/7eeTmEUj
	 y4Y0Fv7WmDZRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D65380CFE5;
	Wed, 26 Feb 2025 20:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bluez v3] adapter: Prepend the new added device to the
 adapter devices list
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174060183101.836490.15009751272938914519.git-patchwork-notify@kernel.org>
Date: Wed, 26 Feb 2025 20:30:31 +0000
References: <20250226-leaudio-no-media-v3-1-8f4f93d8a41c@amlogic.com>
In-Reply-To: <20250226-leaudio-no-media-v3-1-8f4f93d8a41c@amlogic.com>
To: Ye He via B4 Relay <devnull+ye.he.amlogic.com@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, ye.he@amlogic.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 26 Feb 2025 16:52:04 +0800 you wrote:
> From: Ye He <ye.he@amlogic.com>
> 
> When the DUT is paired with a mobile phone using RPA multiple times,
> multiple device contexts with the same bdaddr will be cached.
> When we query the device context through bdaddr, we always get the
> context at the head of adapter->devices, but its status is inactive.
> 
> [...]

Here is the summary with links:
  - [bluez,v3] adapter: Prepend the new added device to the adapter devices list
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f4617c531abe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


