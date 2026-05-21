Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79377175A79
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 13:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779370197; cv=none; b=hYMnYeUiPidv6UMqgafXI+Ud1LS/QwPnQsOZiWXt2EQEBx00hfwTv35A6eAECy1GaM399tJOX/vbc0qKsi/7PBcHmKxqKXt0ZrDBvAIFKkOLxZrsZOlAIuASdIcUu9WTMDYtigN+86hC4fDrIYGhhXFehFq6OFd5ZViKbJU+5sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779370197; c=relaxed/simple;
	bh=v2PotGKJ8BWZc/5NPlWKDt+KBaaoDnQKecw5hCrTsFE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WXbp58TtDgew2PCeT7cQ35O3iOYzu4hMWzKdkSFmlfpwOJ0n5IlPmjMcXpbtaCLrlaxIZtzYZz5DruyCwctV1ohRXk0ugYVsADjCEV81fSdqkZDyd2leG10JdSYlJbizZkVi9guZcQvEfR7adksEOzU3dhGMKEOyV5HOSMv7sXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fb+eLcTU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fb+eLcTU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611571F000E9;
	Thu, 21 May 2026 13:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779370196;
	bh=lSWph1PkPZ+ccwZFf9Wa/x3uBBoqMXit/FtHzPa1HAU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Fb+eLcTUOW5blEUd0yh8Tw8Bj0gtmKq21EB0lVxPsUbrRfWV5XTiKQfEWSDsQHg3g
	 SzR971KaxRQL1mQGkOnR9TN7uwnQckUmrAfRfTMyTGlgdfl1FzRa/T2Cv6z2be529k
	 gFyZzjCCNGBptr6qMTQRfiw7w1bFQy16Kmyn8dlMpZcv1Nflb/AeISKcqHjcboUWCW
	 9lijEveq5mHATmHXpTBJ8FKXN2E6cx//dPfI+a898sItYc0CjhiQSZmDKIfSUAxhcJ
	 nwce/UZt7cRQDzwLmAk3V8oZMq+2Cb5tQxQTckoHcJOjmljB6pf42oDLk+ohPZGa8A
	 qh3oy4RhNylJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 812FC3930DE1;
	Thu, 21 May 2026 13:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/3] client/btpclient: Add GAP extended advertising
 support
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177937020614.309926.17020443890346502033.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 13:30:06 +0000
References: <20260519105519.226648-1-frederic.danis@collabora.com>
In-Reply-To: <20260519105519.226648-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 19 May 2026 12:55:16 +0200 you wrote:
> The BTP_OP_GAP_SET_EXTENDED_ADVERTISING command is used by at least the
> BAP/USR/DISC/BV-01-C test.
> 
> Since this opcode is defined as 0x21 (33), it does not fit into the
> current fixed-size command bitmap. This series refactors the way
> btpclient reports supported auto-PTS commands so it can grow the bitmap
> dynamically as needed.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/3] client/btpclient: refactor read-commands bitmap building
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0e55974d713b
  - [BlueZ,2/3] client/btpclient: Replace advertising defines by shared ones
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9074d38c5fed
  - [BlueZ,3/3] client/btpclient: Add BTP_OP_GAP_SET_EXTENDED_ADVERTISING support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=588a0267d8fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


