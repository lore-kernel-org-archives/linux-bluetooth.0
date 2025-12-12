Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C954D3254A7
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 15:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765553595; cv=none; b=G7fBYVYDlFhV7+Gw/JU308SNLXns6OhJxXdNtJSUf/t85g0C6TBEGi1jf69ehZ8n5TeoLw8tNu0Jb4i4b9phVinbfbwwYTD+ozVYFIuMO+luOmaWujUlsdnDcSi8VIy5iCnDl+zZ2FBGGcCcgpl25XpEZ2d6GcPygakQ8i1DYIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765553595; c=relaxed/simple;
	bh=pRSF2LHA8Gk4XFSps0SFEXzNYWLRbyLF3ALxd2PnQJU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mEYu+ASLRA0poHDf1QCeYaIp8KtGLn9KUXtgz00tZ1LeLLsh7kfwKUTeT2nnrftYeXHtw6SOi1XTKbNdxaMmLEQZhjNa11gfYJxA39MGuFMXzX3Hifn7NRRsMfmK2EcO2x782vk0kwWspdYdZoLnK4fpUSp56ZP0PqZr5vcYnwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFLF/WtV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFLF/WtV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37EF5C16AAE;
	Fri, 12 Dec 2025 15:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765553595;
	bh=pRSF2LHA8Gk4XFSps0SFEXzNYWLRbyLF3ALxd2PnQJU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EFLF/WtVo6SGaVeyUJT3STfp3tXipE2xz/yDdKBoUGWc00b5qqWh2J6w16Z9CiRk4
	 k9osWD6awNObmE7AgalcyeWc59eD+NjdeuaoXhnx/9TqkuRdlZRqs6HHvJMvuFx8VZ
	 sAELQVdSqpvyCCP1yjD6+PMId+34rR3u2vAgL1VyTnhoPBQRPsO0BtP8p1XM7GLae2
	 oVvMvKtc9ybWSk1GFC8gaizf9OoOSOxn6rFvCDTM4OMknusRpXbT2SeEqSntXm792Q
	 62J70Gxr8EW50o98Yn8vnXGQ/M/o2oJsCIIwdciLsxtaR3QiJ0sJIGs3Cb6QaGsW3B
	 LKGJ9TcgyWctQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78918380A945;
	Fri, 12 Dec 2025 15:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v5 0/7] mcp: support multiple MCP and implement
 local
 GMCS
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176555340827.2197478.11697119782094429177.git-patchwork-notify@kernel.org>
Date: Fri, 12 Dec 2025 15:30:08 +0000
References: <cover.1765484150.git.pav@iki.fi>
In-Reply-To: <cover.1765484150.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 11 Dec 2025 22:15:52 +0200 you wrote:
> v5:
> - fix -D_FORTIFY_SOURCE false positive vs. strncpy in the old avctp code
>   in testbot environment
> 
> v4:
> - move uinput-util.h to src/shared + adapt accordingly
> - improve debug logs in profile
> 
> [...]

Here is the summary with links:
  - [BlueZ,v5,1/7] shared/mcp: support multiple MCP, and add non-stub MCS server
    (no matching commit)
  - [BlueZ,v5,2/7] test-mcp: add tests for MCP / MCS
    (no matching commit)
  - [BlueZ,v5,3/7] mcp: adapt to new MCP API to support multiple remote MCS services
    (no matching commit)
  - [BlueZ,v5,4/7] shared/uinput-util: extract uinput utility function from AVCTP
    (no matching commit)
  - [BlueZ,v5,5/7] avctp: use uinput utilities from src/shared
    (no matching commit)
  - [BlueZ,v5,6/7] mcp: add local GMCS service that emits uinput media keys
    (no matching commit)
  - [BlueZ,v5,7/7] shared/gatt-client: fix notify_data leak in notify_data_write_ccc
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a2ef82f1aaa9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


