Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D84723245A;
	Tue, 14 Jan 2025 17:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736875215; cv=none; b=nfg52LQQ50t+M0BQl3psNfOXZjk3V+HA8ID87W+CR3al4HTozwXluv55hUWrfy9DXxLukwwx/l/00HUZRLiI15e+d6aPOwQnzw8KjlKLsB+dA64g9Pqit2qNvJg/ORLhmwesXZ72TK06i2Vb0UO8ZF6YA0NvLcZWE40hj3SXXpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736875215; c=relaxed/simple;
	bh=Us42PgdTR1gECs3bZF/yH5bD1vAp+86dFeWSXqN2NQw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fdYEI1R1n+k7RlLRpXZhs1wo1buW6gRJf4dwBhfsmBDMPSlDF7BC+CfBh2jq454LpXJbOnTcCt88BCvsr9dRXNhUL33JVBLSoFvlsC6PBGy+LM0EEf09JrLGwDtXd7hMYVW2kYpSUlyypyCo6LYE6DmtJPvkfZO24LyMPqieR40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7TDimQ4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7TDimQ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBAA6C4CEDD;
	Tue, 14 Jan 2025 17:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736875213;
	bh=Us42PgdTR1gECs3bZF/yH5bD1vAp+86dFeWSXqN2NQw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C7TDimQ4dEMEYEMrDdaUjdbrs/c5LFJhvJiKR6p8nMm/m9Q18AYxvPR5l55jur1VZ
	 cRE7qvFzlbQn0osxe3SOXhpSg7EHgRN9OghWkYOTSMLSPJjY3JtTBP5qLs+N6iP89n
	 iAU2hZDt1W0uQvxy2GJ7gzTbggSk6wQayOYYTca09QsUjIEQuuDyX+LhNJazlqeQh7
	 jxnkFfb/5707I09MxntCjefPNv/gAiDA6vCq8IV7NSTNOJZGx801HsK218Nv2qKQTL
	 SO64wlkdiX8hJOwPnUfuuGZE1pO7rvO5z4FYFrjD2KslERXQZSJN/jy8FP9LsHSE55
	 R9u2Pz1FXxnpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE2B8380AA5F;
	Tue, 14 Jan 2025 17:20:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: qca: Fix poor RF performance for WCN6855
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173687523651.62266.7168479061326166895.git-patchwork-notify@kernel.org>
Date: Tue, 14 Jan 2025 17:20:36 +0000
References: <20250113-wcn6855_fix-v3-1-eeb8b0e19ef4@quicinc.com>
In-Reply-To: <20250113-wcn6855_fix-v3-1-eeb8b0e19ef4@quicinc.com>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, steev@kali.org,
 bjorande@quicinc.com, quic_aiquny@quicinc.com, quic_chejiang@quicinc.com,
 johan@kernel.org, jens.glathe@oldschoolsolutions.biz, pmenzel@molgen.mpg.de,
 luiz.von.dentz@intel.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, quic_zijuhu@quicinc.com, stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 13 Jan 2025 22:43:23 +0800 you wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> For WCN6855, board ID specific NVM needs to be downloaded once board ID
> is available, but the default NVM is always downloaded currently.
> 
> The wrong NVM causes poor RF performance, and effects user experience
> for several types of laptop with WCN6855 on the market.
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: qca: Fix poor RF performance for WCN6855
    https://git.kernel.org/bluetooth/bluetooth-next/c/67f8711aae4b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


