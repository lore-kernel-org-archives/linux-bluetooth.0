Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EA5154B1;
	Tue,  2 Jan 2024 17:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ct11qgvk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85997C433C9;
	Tue,  2 Jan 2024 17:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704217253;
	bh=p6ZDM8xETWz/WD37I2S+OM5z0ce2aPFxnW9wU1Avuzs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ct11qgvkbDRYSPlD1JBzMJYclKiypSF4iJGv+edh1xbd7HzVY89f+1T8PsZmFzfAk
	 HhVFrk7/zgdMWc1uakD+yhzdaJyvvcQhUNWOon4KkIgRy+OWPTfaY2pQBfRi6sg9iT
	 44V2iAvFSYpxFeQ1Q8FuB4GbNljHL9mF8C7uzEsvUs5HN/30qW6nm+B+tAcr3z+eMg
	 fvsclFmYBnmin7H6BrSO5XqTrw0ll6WJSLicNtHjZwIpntxylAusWDdy/9vw4wTZ0C
	 ZcBTrH1izTHlhmr+KgP7LGrQNI1c5sWK8h9faOb/VCYL+JTTUrdCu+tCPh557jM8Zq
	 uglkQ62JhnZMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 63908C395C5;
	Tue,  2 Jan 2024 17:40:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth-next 2023-12-22
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170421725340.27590.4291986758945353702.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jan 2024 17:40:53 +0000
References: <20231222184625.2813676-1-luiz.dentz@gmail.com>
In-Reply-To: <20231222184625.2813676-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Fri, 22 Dec 2023 13:46:24 -0500 you wrote:
> The following changes since commit 27c346a22f816b1d02e9303c572b4b8e31b75f98:
> 
>   octeontx2-af: Fix a double free issue (2023-12-22 13:31:54 +0000)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2023-12-22
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth-next 2023-12-22
    https://git.kernel.org/bluetooth/bluetooth-next/c/8a48a2dc24f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


