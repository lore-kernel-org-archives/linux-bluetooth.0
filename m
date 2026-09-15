Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF0E4A015B;
	Tue, 15 Sep 2026 23:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789516274; cv=none; b=dkowTh4w6MBIpqltCn/oNcEMnztPzZfRnk0nmSAyskBEWAyDRg+DCy453NAGvkN1/LSUuKHn8CSDnohDfxXIP55rcEmqnHXIBfqmSIXo+Qa0ScTZ4MoTWQ5RJr600+y79YGOu9X577H944T9U8FJVZ1F+LhdKeChuA8W6Ui+RZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789516274; c=relaxed/simple;
	bh=FrSL/Cs1/x25fpxszMs57ruHzmc4HdcHTE12YA5fJ2o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J02f+WJEG7epU/TKMiLAEOQDhgCQqz4DRmWpFG2BM9oP0krpsoZrN2+7JS7MskvT60B1oR8aMmMLvqdvT05lgO/+o63hjAQx2iR6aepAfSyJdiUrunYSQMA/sL18bFMhyGCOdURHer/NIkAWm5ZvGpMHCmDyKGOuoD7Hqycz8Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PN0AMPIX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PN0AMPIX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A0D1F00893;
	Tue, 15 Sep 2026 23:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789516273;
	bh=ShS17L91yNcQK/WpO6Hsr0JiXlMhUYC8wCEvUoIdUYI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PN0AMPIXboo9jmm77d9d+BfthFVrTSmMSGfFtf9LvK7J2Cf9v5QtdT6vQQAhGObSg
	 REaVv4SKbzDjLVP2riiFDXfqojniCkjHqc/CnpO6jhqwUEXJchQWjnIW9BdSQRLJ8c
	 cBnqVEv1Uu2KCTehEAgI7xq07GOPmqZBpmRYJZkUMY0y9W0bjSgF5Ap83nwyx89IPO
	 paHRjEPnE2mLJg6HeesYpFnelcwrPy4i8MNDy5/fbmGJhmKxkhirTVI8bqunEnVVfK
	 A+JkjVVN6ydMxlA4F88IhbWzrFEyxMRusq//91tiQ9K/bzSgDwKtRc6xJBrkDWu4vv
	 FQnfFBoslNlpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197DF392706C;
	Tue, 15 Sep 2026 23:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2026-09-15
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178951620762.2322156.7024746605695825913.git-patchwork-notify@kernel.org>
Date: Tue, 15 Sep 2026 23:50:07 +0000
References: <20260915192441.1130583-1-luiz.dentz@gmail.com>
In-Reply-To: <20260915192441.1130583-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Sep 2026 15:24:41 -0400 you wrote:
> The following changes since commit 83a945a529d6e002dd7339c532288a931f463dba:
> 
>   tcp: do not let tcp_rmem be set below 4096 (2026-09-15 15:21:17 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-09-15
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2026-09-15
    https://git.kernel.org/netdev/net/c/c5e367a8a3f9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


