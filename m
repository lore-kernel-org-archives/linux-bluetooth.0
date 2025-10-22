Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4096A2F363B
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Oct 2025 21:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761168567; cv=none; b=dWbpGhLsnFoCTXdwueAL9aucW94gn4i9Szi+3WDy91qcQbRE5qIUP2PPwJvyfjajGGLAQzSJeto1XhGSdRnNl7P1JjxRgJXxGKWyJ2HaHKUuVqUZuadlbaX//xa6aJKtm8ELs8R5VfPH6WPjueJa4z124G8ZM4NCd2egH4QXgBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761168567; c=relaxed/simple;
	bh=Y7PmT0Sz08nQvW4OgnQgy70TA8HgSBSsG66g0H6wacw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=laCnpDYJdjAiOjCEaS6bPUlw9P8aJUohoOINUrwvqv7/3Twt3OqPs8ZTlumdAdnLLm/+zXpWzqDDXabtUAEJV2fS6fG8L/UCDRfqN8bgDoPQQtkwYjmAHvp7+pKsltUxX/vTsr41To6KgDTo0u8mYDZCm1pmmAF4dr6FZdh39oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgOSRmn4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgOSRmn4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1297C4CEFD;
	Wed, 22 Oct 2025 21:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761168566;
	bh=Y7PmT0Sz08nQvW4OgnQgy70TA8HgSBSsG66g0H6wacw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JgOSRmn4tYqjIwsK3YW7vSSqfjc+0z7bymfu5Ww7WXIUDBtN7vAF3MyIjkE8qBCRH
	 zP+tYW2YVhM5/9t2pe5V4deoGJRPoi2hS/8FypxUBp4VPiwPoob/2NbmWk9M9X6Nai
	 BUHlUgEbaKHqru2B9kzysduHTLX+KYsWHHA62oyYyo+X+85SkFTi60akVNUb1biHZR
	 K8o322CxL264B8ji3Px0Qu9dMofR1ZoSgWrvEiYMt7AzMYK6fUoy/dIw2qQxw2Ys3R
	 dzEjI/IcWOy4BaFxtmezuJ+IqQSa96TNUR7D0aiGjv6D6OPu+t5ULsHCDlWpkh2Ic9
	 1wZ+nCdOhurHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD513809A00;
	Wed, 22 Oct 2025 21:29:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] ioctl-tester: Fix handle value
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176116854749.2074360.4645008966541568010.git-patchwork-notify@kernel.org>
Date: Wed, 22 Oct 2025 21:29:07 +0000
References: <20251022133814.1404453-1-luiz.dentz@gmail.com>
In-Reply-To: <20251022133814.1404453-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 22 Oct 2025 09:38:14 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Recent changes to emulator has changed the ACL handles to start at
> handle 0x0001 in order to use dedicated ranges for different link
> types.
> ---
>  tools/ioctl-tester.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [BlueZ,v1] ioctl-tester: Fix handle value
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0ff04a94a69c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


