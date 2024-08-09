Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1FE1E49B
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Aug 2024 14:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723213235; cv=none; b=THX2E+9dnZIdj3ccH+Zpkbc61jXwP4N3XKRXoltWU2jyc7qEJv79FMTSYxYBnAc0bfEUeEh2JrqxOvwugqNXLMmNAdrA9sgNxDHosqiQ6HqxFmB/75+bsDUavcasru+3p3PWqht3TyVSY/Q7B2+i/UqUpRc0rShhS/FjFxMUdCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723213235; c=relaxed/simple;
	bh=ci7ruRGw68CJw0HfN92LVJBPUeDzIL9qx9XmM1sWnRs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P7O3ELpGH0ar4ZpRQ/lBOXgNURgN0ULbXEAyT0/3rPBnTOG6ViUh3txKUZPeNs+VL1FR1dc7ba+XpDmNyBniNnTnd55ieTg7sRyWrsN30Imgu0SWz/GJwzxnsRwnJTM5N0ZwQQGriGCK5vhWmoncktYeqCw089+qUQcURYNYYh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQykwzPs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQykwzPs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505DCC32782;
	Fri,  9 Aug 2024 14:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723213235;
	bh=ci7ruRGw68CJw0HfN92LVJBPUeDzIL9qx9XmM1sWnRs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KQykwzPsLrCZHFStKpboSqbHt13MEn8W3bwgOIcRY0sGVsHSV8gYuF3//oD89IIKa
	 5DxG10TgL2ok8TvuF+UPpKCqXYD4DZXZxJ6lx4MzF3vAxpGM+ZZmccbJrykkGXrH3u
	 ciOCcyWXMqrEjg7HKVY2l5P8qSScl8QgethDw53vS6nPsyYi7uGzCaDeWcklbz8H4W
	 +JgYsQg9AxE7rwtrPF75RqFXA6vzhW3d+MUo5Gf2D5eWUyt8A3lsJTZIig8HMC2mdZ
	 jFHHdERpD956hs23YfqwyE/6tEwt0R/pEsdaxnCFEsoIAMsTwox0DplL/ulrzebm3Q
	 sMXjzmb0rrTQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7141D382333D;
	Fri,  9 Aug 2024 14:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] shared/shell: Add support for comments on
 scripts
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172321323427.3802990.16799049318046458493.git-patchwork-notify@kernel.org>
Date: Fri, 09 Aug 2024 14:20:34 +0000
References: <20240807212818.193908-1-luiz.dentz@gmail.com>
In-Reply-To: <20240807212818.193908-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  7 Aug 2024 17:28:17 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds support for entering comments onscripts by starting the line
> '#'.
> ---
>  src/shared/shell.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,v1,1/2] shared/shell: Add support for comments on scripts
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=66044ecd8dd9
  - [BlueZ,v1,2/2] shared/shell: Add support for running script command as part of script
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


