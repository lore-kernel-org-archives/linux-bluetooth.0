Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B511313298
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 17:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775238023; cv=none; b=g2mjPTy6I183SGFTySdTnC1SzGHNjuCraQ83VwXQJSAhbnX72QtitRuR7odELqsowtBLupOr2NoeJaiweHBhLbzo0ZF60C0MLJOxwmaYuCec7vqK/E15m/g8YNpNBwCnug8TbNctXeBX/pIe6VLAxhZq+0b6mg36f9dLuWWhHWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775238023; c=relaxed/simple;
	bh=wdUNYrwca1EVINSZ8kvKXs9G+CTTn7Xm3r4f2V1dAfk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kXJVQ1ITq/gsf89+pjXNhfWw+OUZAWnKjYdFcfdDxKfGG8U5EvvtpNiy9MaBzlMOAgJRzj65SRTBycnnxxo6vcQdf3iZ4wqzRiGfJfVsG2hJGz23cKttcRZ/hgA0MKHgpG+3Ly6USX9vQEtZ5JN/G4hQuyBIcJdpWSCi7xBF7K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQiCX+wl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQiCX+wl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4BD0C4CEF7;
	Fri,  3 Apr 2026 17:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775238022;
	bh=wdUNYrwca1EVINSZ8kvKXs9G+CTTn7Xm3r4f2V1dAfk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UQiCX+wlCUc00q8c4Jho+giGErmK+Lz9mMjVmU0d7+bTUZEJBnid1pOwW7WxVluM5
	 6KwWHkXc+M2b049q8K+M00X9+Hqmy0r/97KxIpduY3sBB6Yo8ya2phh6fdZOi04nEq
	 o5sAiE1E7UI9H8xEsXemEqYarEcOA0Yzh38vmiWgH4zt7S6rQvFcx7Hy/KWa4S+bTY
	 meLcZ9J/9X12qO6iL3caw55G0EC3ZFbP/Gnx4xomj4lKufYJwkr1381kDkLGT02UTR
	 NTHBxqSaWvW282xnf+nTt4PniwJ0iYxXCmQs72dJKFhyVFTpOGV2uTGt0G4sUrnuaJ
	 1nXTVCgGwuDDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F3C3809A14;
	Fri,  3 Apr 2026 17:40:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RFC PATCH BlueZ 1/3] doc/btmon: Add Channel Sounding protocol
 flow
 documentation
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177523800454.1392290.8846670733664067420.git-patchwork-notify@kernel.org>
Date: Fri, 03 Apr 2026 17:40:04 +0000
References: <20260402175624.2442647-1-luiz.dentz@gmail.com>
In-Reply-To: <20260402175624.2442647-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  2 Apr 2026 13:56:20 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Add btmon-cs.rst documenting the complete CS protocol flow as seen
> in btmon traces.  Covers capability exchange, security enable,
> configuration, procedure parameters, enable/disable, subevent
> results with all four step modes (Mode 0-3), result status fields,
> FAE table exchange, channel classification, CS test mode, the
> typical setup sequence, and common issues.
> 
> [...]

Here is the summary with links:
  - [RFC,BlueZ,1/3] doc/btmon: Add Channel Sounding protocol flow documentation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=10730536e5b5
  - [RFC,BlueZ,2/3] doc/btmon: Add RAS/RAP protocol flow to Channel Sounding documentation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b499a284d08a
  - [RFC,BlueZ,3/3] doc/btmon: Add CS and RAS state machines and combined flow charts
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=00dfd32af38a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


