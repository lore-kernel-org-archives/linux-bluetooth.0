Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C224399EC;
	Wed, 22 Jul 2026 18:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784743851; cv=none; b=H8uY39MYqBn4AP4KWbxbWjlHt5oYpAHm3u0kuh8r9Ye8xPsJOHAJADUHdBSQsap6oeOd++FpOJT9Gzbvn3PkXowSbWt8YRufmSrT+/QTl798tjdNjGy8OQtaHb+5yJDVnta/CXrGmwlOY2XyHYNK4+cjs0JDYej+LkZX9bnBP9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784743851; c=relaxed/simple;
	bh=UxqbpF4Sw/731SzGa6mp3YbLHSt/qsWz1Ll+hinJsUQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RFCFydDDgEgdbXtPEHagAVXHZcYgPc/KLf595zH4wWYS55gp3RIMI8KFaKi3C/7bu0iHSJCvPVkJKDYXFQ+AuZNWNrh/vy5BsNdkk48unjjkUVb914zU1P+Ctzt9Znp7tjyCluSboJgW/2+F7AAcE8D6gUQQfpHAuwCNOaGxOFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ka5C5sjd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ka5C5sjd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EDFF1F00A3A;
	Wed, 22 Jul 2026 18:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784743848;
	bh=eOs5HWI9a+XXBnh4WHZwGc/BCX5Km6Rs5/Ajch2DzeE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ka5C5sjdN3dQ9gS1DtPaL2oY1yIvx1CfrKGswc8Xe6kJrEgXPd5C70rsZdrpcVEBP
	 pugB4acu8lUHiMShprRbttSVBfgZD3F2+mlmySD3HcVVKnX/Vps0YdRiuyCMM0RKjI
	 0+rmxISI7QFDrEw7pnnNW2wNYHiE1WczUEYEnmHFzQEKDGBEqygaywir23ILDwcZSp
	 Fy9hLGZTBCxSQkrft692XPWW/jnl3leHBK4wSQkODBqGwaw4drXVyWmzeRHYoSUiTL
	 ghDdIzBg5UfJ9TAoGejiuniBK6H+6bj/Ou25jhucKOKjfDus+PEBOW2btZJoKE0SPQ
	 jDBfCNrvXgPvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9395B380CECD;
	Wed, 22 Jul 2026 18:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2026-07-21
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178474381713.1967992.9082410954194468399.git-patchwork-notify@kernel.org>
Date: Wed, 22 Jul 2026 18:10:17 +0000
References: <20260721160240.884274-1-luiz.dentz@gmail.com>
In-Reply-To: <20260721160240.884274-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 21 Jul 2026 12:02:40 -0400 you wrote:
> The following changes since commit e13caf1c26587434f0b768193100440939c0fb91:
> 
>   Merge tag 'net-7.2-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-07-17 10:25:13 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-07-21
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2026-07-21
    https://git.kernel.org/netdev/net/c/9a67bbfe48ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


