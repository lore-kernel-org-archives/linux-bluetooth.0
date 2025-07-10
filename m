Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38847194124
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 21:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752182984; cv=none; b=ikkJFZTlVh71kCW1pollJTfUpPhsb3KvqLdY8j5Bm45EcJ2QyaiZ3Wyl5wjVKoZF/eL9+EfkLBacA5N5YeeUm7GxDUBtaKBJkhmW/ndVHQ+BLl7ZtJ8ITdC/kLmlTz0DjbQo9lYoXSrEVPCWigw47eDxOkx/VTGdK3y8vVm4R4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752182984; c=relaxed/simple;
	bh=Yfy+7r+BeP93LQMe2Mgzv4AbxJgbB0C4U59qedEqjLs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lmT6V5UERTxV88ABtIpgGuR6DYuH4ITZqflCaHTcSOcF0k/knpk0tNo6rMhjPBHRUs8nhuV7Vyyl9BFd/gcYebTBxDcTPhXWvLJBGoleCjTBQbjMIYKUG5gJx5SmNDRAt1LlYsi3TOhXFwIxaPgHovTwmAxl+Jc1ghBc+lMriKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agjGRS6o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agjGRS6o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7464C4CEE3;
	Thu, 10 Jul 2025 21:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752182983;
	bh=Yfy+7r+BeP93LQMe2Mgzv4AbxJgbB0C4U59qedEqjLs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=agjGRS6oBLpbkitZ4b8+GfLVrp7qklndVnkTwex/KskexqJ8OLpqDf+iiWKkR7ZsM
	 IMuVErj8uhIXl3J5A8HPvj7N8diZEcZ6IhjGLmJWMCj0p0WPcJi4HPXUVSZu9TiTUP
	 hUDW8fnOub1ajYl1M0B9SOn4z7gJx4HhBwthql/cJdjw0RrTDrIxQLELQ92cOz4OM8
	 3LAPcXXPhjpfL3rjN9wczACO3aBoUJzoazwsG9cGoGBiq2c57KTwBUFOdO2LbRnELr
	 ATE9LTercexZhAhwulOze9Iey7wloIW8npMPRjCHDAC5CNYDKVXVJMdWBDs7ed+G8D
	 VO/gOWeUVuGgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34095383B266;
	Thu, 10 Jul 2025 21:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] build: Fix typo in configure option help string
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175218300601.1671646.18159970110470097250.git-patchwork-notify@kernel.org>
Date: Thu, 10 Jul 2025 21:30:06 +0000
References: <20250708171411.1927181-1-hadess@hadess.net>
In-Reply-To: <20250708171411.1927181-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  8 Jul 2025 19:14:08 +0200 you wrote:
> ---
>  configure.ac | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ] build: Fix typo in configure option help string
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=806dd732fcda

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


