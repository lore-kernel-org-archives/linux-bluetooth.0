Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2A83BED7D
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 17:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773942616; cv=none; b=Lb16cuP0Urf6DEul5GXQGpFq2K09CICdDcI+WH+8OgnQMLryHG1whYOl31CkE9YTd556x9m8TIcn/FEDjajnzqH6TTHgXaEIpSi2dQkwFH5L7b3NpNBnXuDAsCwQU+cVthA+ZusAvoxUuKq/yvljdHxMF84+suTveLYtY6aAFI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773942616; c=relaxed/simple;
	bh=aCP0pQ1woTYRuVokCj7I1yooybrQJkyC/VJckVnn3hQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rah7yW7eZBZ2VbRqliTf5KGF4ZY147p/dZxhRV1+A4jFjrpTPuzUwdiE7aSp8GMxU98TfnuZKFcQ4zpAB3yYVWPiovM0IQoLClc4ixpa6jE02or737s7o0mSwc06aF2o0L/0uxiiasH78b3zpr13cc62j72GGwuqY8LMp1sWT5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKseOxXp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKseOxXp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B4EC19424;
	Thu, 19 Mar 2026 17:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773942616;
	bh=aCP0pQ1woTYRuVokCj7I1yooybrQJkyC/VJckVnn3hQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qKseOxXpEM8GEsSIA4ADV2IZEmu7JWm5cVczpg40PIqsfULuXGJKnt7GW2EW3bZtP
	 kOsKGq8TDMekNkUzwW66KiWFXtuENXGghAD+szW+xlfljc3yadBFFY5iUuEtcen/Xo
	 pQU1L8xtTSOsq+2cTSbDYc84Lk3jTilM6oY8GREPvHLGhDmBFdhuUpfXfrbYLoOiSo
	 OyIzAnw7vXXRqhSm97briaWnuGNbrSvhBCj5awnYdr1i/Dbjw980UntgZ2J5lSllIq
	 X31j/NokHa2X0+n7TtiX0SWAAJz33BdXNbgbeTXyBEKkQAEeuuhz+HpIwKZTZ0iCz6
	 TQ9TS3RSryYuw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE3B39302E2;
	Thu, 19 Mar 2026 17:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/1] shared/shell: Fix SIGSEGV on invalid input
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177394260678.1735656.12146727451745372530.git-patchwork-notify@kernel.org>
Date: Thu, 19 Mar 2026 17:50:06 +0000
References: <20260319141435.83060-1-wouter@xesxen.nl>
In-Reply-To: <20260319141435.83060-1-wouter@xesxen.nl>
To: Wouter <wouter@xesxen.nl>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 19 Mar 2026 15:14:34 +0100 you wrote:
> I have updated the patch according to feedback received earlier today.
> The valgrind input has been attached as a commit message, and checks are
> now applied further down the callstack rather than at the source.
> 
> --
> 
> In `bluetoothctl` when entering a space followed by a tab the CLI
> crashes with a segfault. This patch fixes the user input handling.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/1] shared/shell: Fix SIGSEGV on invalid input
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1436eab1d0e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


