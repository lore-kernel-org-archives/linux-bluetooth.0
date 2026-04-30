Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C405E47AF6A;
	Thu, 30 Apr 2026 17:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777571788; cv=none; b=bHJ/ZsL8ghl3+MpSf/iq+ZavY3AB5XJmQ8rXDMtpXuYFo+8SjwQ2DGAiklXuw/riVSXPN3FpygJpvZCwtZMY1qv5sOKbXzI4ebaG6MzTJRsiXk5td+KgFBDUWS0VRNfOfGorkaQtkrshLEsdb2WurCpw9qSn6rZAadC0ZXWdqiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777571788; c=relaxed/simple;
	bh=EA0msFXeBuGRj3d5sQ1BzW/pV4HIoOiLwuUI0Cfsfa4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OKjskuNXhMhLN48NB2zuvp//GyTVKN2qjKWUFueiuAEFx2DFTJoFI0EoMqzuw09KMBl5S4TFizumrPz3lfCMg8EsfN6xqLHW00+PtxkeGKGGzf2veA+OcN186SnAw5CzHvZJ1SSBfpN9xUHAap/mAFPvlRGBm9rCSe6+rbJ1mZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rs471xfc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rs471xfc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893CEC2BCB8;
	Thu, 30 Apr 2026 17:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777571788;
	bh=EA0msFXeBuGRj3d5sQ1BzW/pV4HIoOiLwuUI0Cfsfa4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rs471xfccK3M4ZjTkRHlZaRKKs3qUVF6D5LjJgkp7btjjZJtZXv7zKs9K3Gvxntdd
	 5PoyyF+OiNDsKRLQy1rkboYdFJEST9Vggwo2vylsFTmJ5TY6hY1WqYxghuEkcfnI53
	 oCGpA45WiU5Dd3Rm0QWIkYS92XnqyMqHBgQKLZZsRlXoNsR4aLEG67Dxy5F6AaSa5o
	 q8BlBQutQ0KIbwStm3Mbsd1fbVBhfyMHOBMKTlp4sRPTJfQF3gLydYiUDUbzvjiMMS
	 xrSneVsc039YTy5/y8ub/BT/yLoE7hbGYBlFaVPPbooHs5m+nzmUVboxJn66xIpTJ6
	 R+kStCuCeSOdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD0E380AA62;
	Thu, 30 Apr 2026 17:55:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth-next 2026-04-13
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177757174279.3109994.7737953345656205435.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 17:55:42 +0000
References: <20260413132247.320961-1-luiz.dentz@gmail.com>
In-Reply-To: <20260413132247.320961-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 Apr 2026 09:22:47 -0400 you wrote:
> The following changes since commit 42f9b4c6ef19e71d2c7d9bfd3c5037d4fe434ad7:
> 
>   tools: ynl: tests: fix leading space on Makefile target (2026-04-09 20:41:40 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2026-04-13
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth-next 2026-04-13
    https://git.kernel.org/bluetooth/bluetooth-next/c/e9dc62f25ba6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


