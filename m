Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106B082D9A
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jul 2024 14:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843632; cv=none; b=E+9QDaH18PLf54y3/as8EsPU5m4H2xBPeVMR2RebyMcpTHuJ59n5d01telRH/hiTE2vrJnLo5aJ6TpHzUuDVZYflO9/jFupGlNMt13CXLJwUpldhZAgBzbKZzQCEo1/UpXnE6ZZ3l0fumc4DK3gC4ohYrwGcw9pyR5M3ER4XufM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843632; c=relaxed/simple;
	bh=LIuirsh6HQoDrzdFKGElCFhpqA0ulDw6C8SVrDAw5R0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BKyzw6BWpBzMcsDSEYUv6PkRimZgayOyqY4gRcgCTKkivTHMJwoaWAol7ucDXMdfB06tAWsYXJrBfNYmTEGpmqEF3CSlsuTTneRHq3SFo9qoNsx9F1jF3XsVypvOu9Y2pisAt3wO1e19pLodbwjQGIcIAqgnJaj1+GoeJF9nswA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgwRAtgA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgwRAtgA"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5322C4AF0A;
	Mon,  1 Jul 2024 14:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719843631;
	bh=LIuirsh6HQoDrzdFKGElCFhpqA0ulDw6C8SVrDAw5R0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SgwRAtgAzPUrhp7tDwoJXuQWchkYjNsHhqPNySymf0U2e20WMvVY8kMh6tZa5+Vuu
	 CP3mBeJV+3y1zJ0n+gHkDF3okVE7YTUntwVKMJ2Bbox56sx1/Eq13740uhP5RjIyJw
	 780xmFwqvhn//hEdLKxixzOROD21kwn6+Aq6PnxNbTDYs3BA/QAUBc4C3pUq4BUTvp
	 Q9IEFwnQH5+8k62MZZyu1sWLK5hX8ZNTofA93BSO/S7ZAd+SAkHd1s5iOozPjKsxsC
	 GzzBh4I9kTP+sR4AvrN3f7UdH3PEG+bcckP3DvVKxErYqxa0rvL3MvK3r+VWPmauXg
	 w4q/63y7YNaqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A5833C43468;
	Mon,  1 Jul 2024 14:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] shared/shell: add a check for NULL in
 bt_shell_init()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171984363167.28078.8223500778116225252.git-patchwork-notify@kernel.org>
Date: Mon, 01 Jul 2024 14:20:31 +0000
References: <20240701134401.205121-1-r.smirnov@omp.ru>
In-Reply-To: <20240701134401.205121-1-r.smirnov@omp.ru>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 1 Jul 2024 16:44:01 +0300 you wrote:
> The opt variable is checked for NULL at the beginning of
> the function. It is necessary to add a check to prevent null
> pointer dereferencing.
> 
> Found with the SVACE static analysis tool.
> ---
>  src/shared/shell.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

Here is the summary with links:
  - [BlueZ,v1] shared/shell: add a check for NULL in bt_shell_init()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=55f561a9cd0b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


