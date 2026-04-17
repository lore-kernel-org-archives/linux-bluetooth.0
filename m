Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983453B2FC6
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 18:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776449438; cv=none; b=j95OMR82TZ5W9KwWiTxlGsGDo+VggS8i0kha5NHjiNWqwaEPLWoRefn2vI/03aMeRl1MFcFcMUtE1VQNyYL2/RcR3Dns7T6Js5m3m+qCUFuTyWvhGbOo308dfDOvd1rsWyxpZE/GxzS6FAAHmUa89rtH1/WFQiEMbKlRbhA+t8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776449438; c=relaxed/simple;
	bh=3LS77mS1ElSIpRCvtFyIr6v5Fg6YWQVtF3jZSBMWpwg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S0Mjd9SsrZQeDA+Ygt99d/jdJr96Du0V8UAUm3pSoRvVyWMcjWL6hz7s0QvgmDgZnlgK2JufXT1uCUw3r7CtghXtoS8jTt5ahIBbKID5iml6/xPEK+xvpuVuwASjhgTRwD2rfViA9wwPcXNmdHEMClQaJGFhV3nsixgqAHzJkoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5D620zf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5D620zf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C53C19425;
	Fri, 17 Apr 2026 18:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776449437;
	bh=3LS77mS1ElSIpRCvtFyIr6v5Fg6YWQVtF3jZSBMWpwg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L5D620zfuSJgQ28BnUdWoy9zZiuE2LQ0Wa+uTmwxYdsmx3Y3SnQnbzbqVlFuWsHNZ
	 xmjVMyOdELkLzAkhvnG/gtTdSnk2VIFhjFiOCSV2FP30nyshoHb/0z63u+F9cMuaS7
	 WGwWGp7J5givY1+8LPvKtIJToDLFZChz32uKugSlyIFZLLNwCwiJeAKvwwNC23Qfqd
	 VsP6al0DfLDeGFhEjua2SGgNgezulCP/3vEKt7ewLuJa4kg1AHXEapfXJt1zi8O9OZ
	 lXgPDaJOgIM/KirRLxE7Btv/Us9M7gtKneN2gWtRh37TiPoj5ZTLJrPBTb9EF2J/Eg
	 9XrGhGGohlfeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D1F380CEE6;
	Fri, 17 Apr 2026 18:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] unit: Add unit test for new MIN/MAX macros
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177644940464.96824.14687771952264780634.git-patchwork-notify@kernel.org>
Date: Fri, 17 Apr 2026 18:10:04 +0000
References: <20260401204527.148077-1-hadess@hadess.net>
In-Reply-To: <20260401204527.148077-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  1 Apr 2026 22:45:05 +0200 you wrote:
> ---
>  Makefile.am      |  4 ++++
>  unit/test-util.c | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
>  create mode 100644 unit/test-util.c

Here is the summary with links:
  - [BlueZ,1/2] unit: Add unit test for new MIN/MAX macros
    (no matching commit)
  - [BlueZ,2/2] all: Remove redundant MIN/MAX macro definitions
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=73c6943f0636

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


