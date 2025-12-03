Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CCE22579E
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Dec 2025 20:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764793989; cv=none; b=Rak5Awca2qHam9Naz7rsCKmb+ISpbRHOwLmw7qPwGoryBEmso2tLe8iAhT3g2iQPMUHl/Oc9FSkOROx55As5Ei5KZU7jjgpK0FQMIeAbGefwfnU/WH/grIaxVdjaOG37RsCZGLeZZ3HMmYOjvMJHNI/iJIU48Lp67pHQ3oPmGb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764793989; c=relaxed/simple;
	bh=YFEfM+R8bXHudv4IpifrnO0hkx8ND+Lv1RcUOe8KaHs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=au1S63NEQcXlVI/v0G5rk3wFGwKteeFtOmOOE9UX1Nkfqiwg00GFNlFg7I8MaTcQeFQ6Sf6GEwdi32i1iopfWvz2p9H+XoxfNZoVVg4JPimsl2x2EMMCiyVjY3KI9Qc8DHHCyVwskTHAZY56LdlWAulsCwPXBOg7MuABlBiie2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lk//GDec; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lk//GDec"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B430EC4CEF5;
	Wed,  3 Dec 2025 20:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764793989;
	bh=YFEfM+R8bXHudv4IpifrnO0hkx8ND+Lv1RcUOe8KaHs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lk//GDeczMH2W13PJpH4NHWHr7LDAK+RW74Cc43+oK2PZJkJhjkqERR9JGAbGbl6W
	 LA5yp+jBbsNJW1YbuOgiIISgajR+cIT7nnD87SObTm8PoqTe3hsSNFdY8PvLnXfpcC
	 iV+ADGLk4QYWOjb5VGMAU3Yi+pyIhRG900IkSPMZKK1ZP5z8I1dA05LXgMw6ftQwwv
	 ZnsWJZV6D6VLzO/mRId98ittfl6ck0iiKAQiSjcDRBmTW+7Y0wTImxDPhC5yNoaYZH
	 rkUCowG791R6lQcRXagvaFtqVKGYvggVWHn/9Ob5iqi5ujf+vWz8fBmOM2DMsQ8iQ4
	 6afhR/grlLpfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B59853AA943E;
	Wed,  3 Dec 2025 20:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bluez] profiles: Add bearer field to btd_profile
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176479380844.65731.3497562105859587991.git-patchwork-notify@kernel.org>
Date: Wed, 03 Dec 2025 20:30:08 +0000
References: <20251124-profile-bearer-type-v1-1-50b377b65048@amlogic.com>
In-Reply-To: <20251124-profile-bearer-type-v1-1-50b377b65048@amlogic.com>
To: Ye He <ye.he@amlogic.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 24 Nov 2025 10:55:18 +0800 you wrote:
> From: Ye He <ye.he@amlogic.com>
> 
> Add bearer filed into btd_profile to indicates which bearer
> type this profile belongs to. Thus we can distinct the services
> per bearer.
> 
> Signed-off-by: Ye He <ye.he@amlogic.com>
> 
> [...]

Here is the summary with links:
  - [bluez] profiles: Add bearer field to btd_profile
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=930df108f301

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


