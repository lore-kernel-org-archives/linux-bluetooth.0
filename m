Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1B24C6D
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 19:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773777012; cv=none; b=mdKYipYJ+dJthyFMFgw4iz2dQqtgkHf24PPxc79o6Sa13j9noTNmwNPJ+j0MW/MVe4WfPUfMR1bZRSjDsHYRpqcSayIpHW5FvBo9U7ZqtyLLI6REkTrq5BsKaFNvrzGA25n82y8FvA+ya1wD+RS15cwFy85ZSeNyBru7jYAP85k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773777012; c=relaxed/simple;
	bh=F1w6PfLy9rEO+O38Fju0QloLFS7KvqJzes6kvu2EVQU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eD0ew9NBPikascUFGPksXpR6gvuZ2UwaVvRlkDGPCkuO5VlYWI3ikFSvVLq2xtb3KwxPa0x6ZZI0HBJ6QzAgBbUHfGSPEmmG2fpER5MLselRh5nbLDz3UYL/9puyV5OKQcVThycS61buhAEBh+YvDcjQdwzFj99u9qxhnAylumk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRFQVvWQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRFQVvWQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E308C4CEF7;
	Tue, 17 Mar 2026 19:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773777012;
	bh=F1w6PfLy9rEO+O38Fju0QloLFS7KvqJzes6kvu2EVQU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uRFQVvWQxcvryiV/ACphvFwrO7PaMNO+FgotozbQUEWNI51TVd36exRs3IaJ1qsvS
	 3W83RcJhhhQcuJmUAA0rOoGPxKAz2EWEdh8I+Hth0uTcI908+3+OddV8geA8kzuGA+
	 NhlpM83Yf4rlj6SE7I42cEMJ6HjTwHQhfPq1OTh64h6faFNlNIdcAGfKnb7yRgMyL0
	 LXTO6tmJiMQTljoF7WQXrw/0UGPtQG5hmF7SCYufFSb7I5aTmy9hfQud/mlr/bKujg
	 /EzomytP+OZux+GqPn2PuhQS2gHLyMSC8dcFlCqV9XyTtsYHGvQSq9KLAfR54bCi1S
	 wEX+6sMU9AXjg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDCB3808200;
	Tue, 17 Mar 2026 19:50:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] tools/btmgmt: Fix btmgmt --help hanging
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177377700429.4177599.8238187139543348466.git-patchwork-notify@kernel.org>
Date: Tue, 17 Mar 2026 19:50:04 +0000
References: <20260311111540.2170373-1-hadess@hadess.net>
In-Reply-To: <20260311111540.2170373-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 11 Mar 2026 12:14:12 +0100 you wrote:
> Another one of those. Wrote a test case again to avoid regressions :)
> 
> https://github.com/hadess/bluez/commit/81dcf1794b510a41c7b9b6ec53376cb5322b0bd2
> 
> Bastien Nocera (1):
>   tools/btmgmt: Fix btmgmt --help hanging
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] tools/btmgmt: Fix btmgmt --help hanging
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=52c2b37d90c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


