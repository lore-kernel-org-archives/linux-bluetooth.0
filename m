Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D9E38A715;
	Thu, 19 Mar 2026 18:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773943814; cv=none; b=nYScahn/jKMCa2lzkeDlU0WyLm1Ro/roMiFAFFozdKuXpNUxt8PObTi4+OlUxouVpDBp/1Wnd5R/omewQBU4eji3fLZEvPXFjkDUBumhTopxudzDasY1aM8vJu6Jp/KORbG0aka4caOVZ09u/nPbSn1m/apY3UbCxwKjl5yzdew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773943814; c=relaxed/simple;
	bh=JQuym0gmuzZJNCmQWYt6ON78GZMHIH8FvGWVv/Otee4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BkMqxtZQZRLLNAcSLpXEbBnnzPoITkm3nxi5Iw41XtRSlgOaprhxTEtcjNY9V7k3Kfgs7Dv+eld9r/stdan8/ft0tQ3ra1BNus4b17QJdBNXBjAW5D+p4Zm3wXS4lsCFL+rGxqkcfgkmUkJENrWs3X2kVlRyFmuaC38jgvXQXbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tiB5qKST; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tiB5qKST"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DEB3C19425;
	Thu, 19 Mar 2026 18:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773943814;
	bh=JQuym0gmuzZJNCmQWYt6ON78GZMHIH8FvGWVv/Otee4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tiB5qKSTDBxnzFzd292IDvdbijIi8j8EWVUxZDw8BpwIjLuipDVlkKa4au32Y13fl
	 jh6E4BwGcLk6X5ZVqC8nh4oRLa2nX5/IuZmBuxj8sKGF7yxNLpqwfA/8jeWwZ3SNkq
	 KXVQ/RcLKV6qThzxhW4hqsomEFxapq5DsS6gBch6sLewaAEZ3qhATDxoMynSpQftX8
	 pm1MKJ+1pKFKJ2ulMAPheMG9tMO9jXLnteGz1X39l7MtmcWFa6UjgJwvEYaDk83OUh
	 tSon0oAWGwsMnfv/eImh6J6XmDT7pwHcjIHQT8tHhjcADb0gFNqlY9G/sru+vZAt0w
	 o9T9br/hgkidg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD8E39302E2;
	Thu, 19 Mar 2026 18:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bluetooth: btusb: Fix whitespace in btusb.c
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177394380529.1743613.13070223390701457895.git-patchwork-notify@kernel.org>
Date: Thu, 19 Mar 2026 18:10:05 +0000
References: <20260313163914.20533-1-rebootrequired42@gmail.com>
In-Reply-To: <20260313163914.20533-1-rebootrequired42@gmail.com>
To: Lukas Kraft <rebootrequired42@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 13 Mar 2026 17:39:12 +0100 you wrote:
> Replace single space with tab and insert blank line after declaration, according to checkpatch
> 
> Signed-off-by: Lukas Kraft <rebootrequired42@gmail.com>
> ---
>  drivers/bluetooth/btusb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - bluetooth: btusb: Fix whitespace in btusb.c
    https://git.kernel.org/bluetooth/bluetooth-next/c/1d58bcf4a6c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


