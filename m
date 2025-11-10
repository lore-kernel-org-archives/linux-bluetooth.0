Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6A528000B
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 21:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762809035; cv=none; b=Je1WnUtY6WOzrbCMv0fa4438xSlzFm99xDhtdmat9ckPovWgCq9NevTDG7Rpffn+hD1sBeqK+G9Epqlj2mrJUDIRA5DJE0XnicvdSnpt+d7q+OZ+FPfamRhmemNaEgWaDFQm7kFyXnK+3EM2dQS0MUxzBAIY3l/rnfiZnbxf8vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762809035; c=relaxed/simple;
	bh=LyVsvVNyb4wGoJJoC1GHbSbus6TtBeCyXkA11NvHLjc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NLbRS/Qb0POAQSlpJ0nc00+GT9FdbFGFsYS06OD3xhpzej9g+dHWOuahralH1t7NYR1MvK3OkczQhgzXTpmuJ1UkzyY0jVP/P8YyQFDjK+w8yH/Z3cZtqx7EZqbgiaWxWpaZ2DX60u0Pmlj4XrZN6U3nszlspSMS2YGJu8fEY3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUZ7d2G4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUZ7d2G4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B645C113D0;
	Mon, 10 Nov 2025 21:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762809035;
	bh=LyVsvVNyb4wGoJJoC1GHbSbus6TtBeCyXkA11NvHLjc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oUZ7d2G4pxQ+cnqLljJi1JqBSM6RlnbNNyEBGCHNwsHB2iQm07cxPegZEeVDzcnlj
	 c+9JDLBZU+JYWQO/mYKBld0sIYdSOmiqSgqNQ3r51wnqIM9TKTBBRr7iXHRtDXjVgw
	 AGAwlAnNtEpqcTrBau+kK5LfoGWAsuvR3tQtSJhsUkI9Avzbp/2/KjoZlrwYk4sWoX
	 gItVr4KeJF362eYu1DJVC7jE60vjgjDNE/8N8GfqC+Vj87X3tEXFpovrcbh6pplgx3
	 Ax+CDeBeowgGQR/BtmCvJk91R9Nv6zPvthXucU9L1Raet5xMKLK57xqk/zNLpsJUyC
	 Stjt4+KctLTeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBC47380CFD5;
	Mon, 10 Nov 2025 21:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] The GATT.Client option is in the wrong section.
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176280900578.2775094.16100231208863886192.git-patchwork-notify@kernel.org>
Date: Mon, 10 Nov 2025 21:10:05 +0000
References: <20251107122734.228-1-pvbozhko@salutedevices.com>
In-Reply-To: <20251107122734.228-1-pvbozhko@salutedevices.com>
To: Pavel Bozhko <pvbozhko@salutedevices.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 7 Nov 2025 15:27:34 +0300 you wrote:
> GATT.Client is currently in the CSIS section, but should
> be in the GATT section. The bug is that
> setting the Client option to false has no effect.
> ---
>  src/main.conf | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [BlueZ] The GATT.Client option is in the wrong section.
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5e41d1e1d361

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


