Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA9C330B07
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 17:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769449810; cv=none; b=HQ1wHcah6pAlsT/+JygfKuZ3YquZByq2F1G2ApJ/cF50FSSNMwc02SNLHRlc8kAS6nDNUzdgPV/qUUU7Dj8kTX1Z59cmP8yledhpR9lBbE6e87cZjP1IHNce4/Dwv5M/NnGGtzXBaI752PfbrmzTgdhd5CarJvlIxrOM0AOfMu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769449810; c=relaxed/simple;
	bh=BXjHQEYwWVoAfZB0ogXOvIrAlYesKEgiRcd2DQm1N1A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AvsIsWt1QMCqLK25TzuoL0nZnu1W06WwdokVLSmukj4HpLWUtwOV8dfTwgsbxzUAxVSMG5EJiRqEqCcdledpMclCyf5sLmbe+Dyn3TMeBT590mfMt7sPgQL6YeTj1GpyIG5UYVSHABdV/53oSORVe+iNWuqfRHYxzej/97wmAfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcENP9Ye; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcENP9Ye"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB47C116C6;
	Mon, 26 Jan 2026 17:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769449809;
	bh=BXjHQEYwWVoAfZB0ogXOvIrAlYesKEgiRcd2DQm1N1A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AcENP9Yetv1FKQGCMOi2QI+JCW82P1++eIMTCC3/nzhw+QL0g2Nfh10bRjYpLZ5nH
	 2tI8gL33xRstpTlw/93GbIvMslTka0ENqRep2jsFwyQtCh1t880ByjPzu9aYND35pW
	 PyRINSPR+yOu8s/swciPW0UCyaOxoQcSg4/Qo5yh7QjPDu4K8NIa+6bkUr9KgldJTR
	 b7Dlj17c0s7gf3+vsZAGOwHVhODmEjh/4pHcgWPojF22VHuKIqIz/vsJoghHUiLGHk
	 vDJlD/O/Dhb1+ajxwgNPjEnZGngTKBTh8Lci8JJa5UC/PCZlC74qwzTyjSLPHExayN
	 XBLXj9cx27XrQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BADE380A94A;
	Mon, 26 Jan 2026 17:50:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] shared/shell: Fix not dequeueing command
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176944980435.117979.9951645687707573384.git-patchwork-notify@kernel.org>
Date: Mon, 26 Jan 2026 17:50:04 +0000
References: <20260126144705.3516388-1-luiz.dentz@gmail.com>
In-Reply-To: <20260126144705.3516388-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 26 Jan 2026 09:47:05 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If script execution started with command that call
> bt_shell_noninteractive_quit directly it wouldn't execute the next
> command since data.line wouldn't be set.
> ---
>  src/shared/shell.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)

Here is the summary with links:
  - [BlueZ,v1] shared/shell: Fix not dequeueing command
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=825015d82e2e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


