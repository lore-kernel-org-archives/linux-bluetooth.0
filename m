Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CF03B530F;
	Thu, 26 Mar 2026 21:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774561218; cv=none; b=Fhm+VDaOHdoknw9JA8jmpSsw0Y63bU/j8/9a0JltpPd847POPb9FR0yaS8rquDOtuQ9NYg+Ux9elxSQzJ9B38gYtYeVQtK8W9q2p+XDdBX6vpZFsrAZOkPlCDRvjdCy/LcLifoQ+M69W1SZn8xgaE+oVT9yASurkMvbgj0Ybskw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774561218; c=relaxed/simple;
	bh=+lEnbrU6mIz2GRGSbVMp6wug2LlsBdWBUt3tA3pl+rg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cKH6FxgIkNf3EV5ksKsk86v8HMyAv4nehR0PjpY0pywvXvUggH6bSSdY20/2SI3Rojr+NCtC1xRVFGhSrlOabYKCY1sBv9lILHYxKVThsQw5hZ3iQlSn5H9m8emaanJ6RlGkHqw8BNM8M78Y0FtdRboHVoRAX+WzOD1BQj+41ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHqGPH7m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHqGPH7m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DB8C116C6;
	Thu, 26 Mar 2026 21:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774561218;
	bh=+lEnbrU6mIz2GRGSbVMp6wug2LlsBdWBUt3tA3pl+rg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RHqGPH7mGqzMw52tFfM2daSMzDInDy1SqsmcTKke3OHP8rWVoRfP4L2orIyvT3MO4
	 sWlSa/jAuxGiSGLpKeSenB/VC2DLLEi+xXCfk/G56i2Rw/hZWac/BUBIZnC5gAUwvS
	 h1cYmcMCLvdnd3XTrvuqiq8yXCUBiEUWy9iBy8XapJZPO6xqnf+RmgN2MlywBkR0lR
	 I0qEKpaAqIjMA7tyG5+Q5Zx22/sD405cMiQkotFvWEkDclbhPSAXkj0SspB+dTIvGk
	 VIIjla9F0KnD2XfypXlnhhG5KQCHk9Auap1X8wQtHl2O8JcIhNmEsO5zRrfrovHzOj
	 1zsjT9KipHYyQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EFC39F280C;
	Thu, 26 Mar 2026 21:40:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: SCO: fix race conditions in
 sco_sock_connect()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177456120454.3188441.6495487267009938914.git-patchwork-notify@kernel.org>
Date: Thu, 26 Mar 2026 21:40:04 +0000
References: <20260326151645.27909-1-zzzccc427@gmail.com>
In-Reply-To: <20260326151645.27909-1-zzzccc427@gmail.com>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 26 Mar 2026 23:16:45 +0800 you wrote:
> sco_sock_connect() checks sk_state and sk_type without holding
> the socket lock. Two concurrent connect() syscalls on the same
> socket can both pass the check and enter sco_connect(), leading
> to use-after-free.
> 
> The buggy scenario involves three participants and was confirmed
> with additional logging instrumentation:
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: SCO: fix race conditions in sco_sock_connect()
    https://git.kernel.org/bluetooth/bluetooth-next/c/401702ac8a51

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


