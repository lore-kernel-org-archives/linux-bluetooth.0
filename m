Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960432E5B09
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 21:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769462411; cv=none; b=emMUDi4+Pe/z7fjD5U4kexIff1A1zUDjdS3sSGFhkTyC53sr3odTIDnAlK1RHknMzkCzvc27FkkKD+tFUNrFBITJwnQnfbYVEqitHvuFzl4X8+YbnedKMpgkndIpwuyARbW5hsz5AM6DBVkER6LV0dSpqHglBYAEcABrIYkiNZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769462411; c=relaxed/simple;
	bh=LVYddu0vlOUOMXr0UMoKh8k4qnohFe5xRFw+EyL8IXU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VjHwZfUQeGDBZK8qUBRgec74JDHsvlXbSMOsV/PC+uGXtqx0WZWylxtjtRaXZvQxkeWLwgb/qMehFt5s8wqQ9Fu/JyWL+3vM/W1nDDU/FBLYTqXmD/QvEbf2nOjRli1QQ1CfiPHLEnnQKEVWxQz9ygL2taBZuE29FkqLet/qxEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmZLMy0q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmZLMy0q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A31DC19425;
	Mon, 26 Jan 2026 21:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769462411;
	bh=LVYddu0vlOUOMXr0UMoKh8k4qnohFe5xRFw+EyL8IXU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dmZLMy0qF+zWwHnERyhMnMPf60IiJPNqSDrPvs4roUnLct+9pHF5P4abfd6gBy1sU
	 GtNfFUN3YMW7qtvx20Fjn7gVAHYe0xfgzq5UdSUHgaL9rQJnBkwWqxWGDB5akaoI++
	 TNPbh9+yWaV9aNKqPCOK5WRcMUXg/tP1igV7bnhufl4wOTtL+bXgGB2Yar0TV/WWpy
	 q6MlvGmsXRUnh1eRY5Hv9ic+XNoTGrjQ5d9+kgpzJjEmUP2vdFyRm4tcMSpgWHgd/Y
	 PsuT6alI/jqQ+CFZsu7FGX/3IAxpD7vTPJekYezNJd7w6pQHT3xtV8e350kCBqKyjx
	 bmkfYH0oak9oA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8D27380A958;
	Mon, 26 Jan 2026 21:20:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: L2CAP: Fix not tracking outstanding TX
 ident
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176946240461.182938.11009851765941243105.git-patchwork-notify@kernel.org>
Date: Mon, 26 Jan 2026 21:20:04 +0000
References: <20260126175340.3576865-1-luiz.dentz@gmail.com>
In-Reply-To: <20260126175340.3576865-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 26 Jan 2026 12:53:40 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This attempts to proper track outstanding request by using struct ida
> and allocating from it in l2cap_get_ident using ida_alloc_range which
> would reuse ids as they are free, then upon completion release
> the id using ida_free.
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: L2CAP: Fix not tracking outstanding TX ident
    https://git.kernel.org/bluetooth/bluetooth-next/c/8e7c7cb168a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


