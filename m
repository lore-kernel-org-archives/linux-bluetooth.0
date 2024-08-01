Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C76184541
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Aug 2024 09:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722504638; cv=none; b=YbQmDvjm80ZvydO3pYIPaAvymoDlbinAFffoItSx9YVqFJDGS5kHSgxBVGJ3icZKTNjxz1p2H8gImQguAd30kNGTo5zyQFC23zNvTLJwVEWDDiUdc6R0/fDTyvrxp0RWi9P4q9I41l0PZw6bzS/eraW9FYFQws+eNLGldxtfWyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722504638; c=relaxed/simple;
	bh=NRLlrxDr6CBFHU2ru5NJWklmd7eUx7AiV7iEXb9fe98=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EfaNZXujFJbHN4ug1Je/reY3Xb5Uml9HgmOu4/i5ZDwmyflOg8Hy+BtvadaIN9ux/bHhPZ0Dh+r3npEqV7jy37LiZ3ZCxQViCmrP4/WI+q7C1eYKuYQKv9ugiZcrcemAiw3kONDhCn/MD9BWSJyxCoiBTCdX3TAUKpalTRr4pyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+moksiw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+moksiw"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE071C4AF15;
	Thu,  1 Aug 2024 09:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722504638;
	bh=NRLlrxDr6CBFHU2ru5NJWklmd7eUx7AiV7iEXb9fe98=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J+moksiwNLG1NUNDokGQyv5vb4JHXrDjzF/npLS+oMoNECGPpMr+RSMZln0ha/ae5
	 LLuUgB8zDZAAOtWqKQT1qtYzdmk+x++TY58801J8E0Lh54LynixMPZ6hcsWqpV3Sju
	 wCj9y3/saEWj2S49Sx4WaatvCNa8jVoXOmNL6y6JByPTwx1pg1kU4Uy6qRge9gGgVS
	 oRpTvyQWa44NWXtGOGZtK+X8iRGq4f58AZ+X4wC43GZNkUdMZRiiuzH5tyBXIj/I7M
	 M1cN3C0Tjq8XZdfYHsCCGm0QsUB6JdGit7kfqBs7bEr5W3RXbvzWkUg5Vn3i1GXY3m
	 F2U1ej4AAllJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E2E44C4332F;
	Thu,  1 Aug 2024 09:30:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/4] client/player: Fix not setting config
 target_latency with edpoint.config
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172250463791.8059.18335318768534763145.git-patchwork-notify@kernel.org>
Date: Thu, 01 Aug 2024 09:30:37 +0000
References: <20240731135718.429604-1-luiz.dentz@gmail.com>
In-Reply-To: <20240731135718.429604-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 31 Jul 2024 14:57:15 +0100 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes not setting target_latency with endpoint.config command.
> ---
>  client/player.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [BlueZ,v1,1/4] client/player: Fix not setting config target_latency with edpoint.config
    (no matching commit)
  - [BlueZ,v1,2/4] monitor: Fix crash parsing notification
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8a708aa5f046
  - [BlueZ,v1,3/4] shared/bap: Fix not setting metadata
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fe703a0058d8
  - [BlueZ,v1,4/4] bap: Fix not setting metatada
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=998104507ba1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


