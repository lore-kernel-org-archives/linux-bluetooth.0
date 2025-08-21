Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3998E2EC55A
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755784798; cv=none; b=kvTUc2sxjjyGSEpDsTPJxwcqXUWcGPX6/6UEEnGJ206u/zdqD8Z5Hx6TkjnB3XrFrpG13IU7xGa49JBx2Ub3NdKptl4cPvOhOO34DEorfPgQ62hE3tth4ylQ3iGjHbqcYzrlhtKsoy8FIoV+6uKC2Hp7srA+rke3jHN6hsJGMwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755784798; c=relaxed/simple;
	bh=wBs36GNxIqYrmVs/I1Qy195g3uXJY5mgUr1G0pOXacI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=unGnh2ygc43wj0ggN+cUNuwbsY22AVnCHfVLl44nYvNUX22eRMdUfcb7x/PDt3EMbNwNx1hjTM6AcYrgbMo+LysFfdeJoV4w9mgbws9Bi83SIwBfijuvuv4ys8mXbb2b+y76TcAcGVJiXXIT4wLLlp597XdZscJk178Z+G5yIJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohm3wWmf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohm3wWmf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3585C4CEEB;
	Thu, 21 Aug 2025 13:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755784797;
	bh=wBs36GNxIqYrmVs/I1Qy195g3uXJY5mgUr1G0pOXacI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ohm3wWmfxotTaQoOZmQe1vsI2QiVla1cKM40P8DkMP7sIEkwlkrpuf7uObYhVP8/n
	 uX8AoqXmmeesuASnmSj/12zUBuulS9nFL+VjmBwYiw7NfMP/PwceV+E9NlUEDGbQcJ
	 YPvB5Z0vSDl9CKeP6AeBRCyEmi2rasoa5TOm8wK+G5m6ftPMM7PzExIo3Q4iDSrWVl
	 lsVKrwkaU4AzYkL/GcaOBTktURz+P/la80AJQtzu/neoZwAPbqv1h6A2tVJ7e32tXI
	 xhtxJ35/mpdPuXggU97apgdABcK/alq6PLDYoLCCogegdLalPu3MgruWXzEbJdL2+4
	 kKHjBKBeqfdvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3463A383BF5B;
	Thu, 21 Aug 2025 14:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] adapter: Fix setting index in
 MGMT_OP_SET_EXP_FEATURE with debug_uuid
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175578480701.1053361.7750562726481072294.git-patchwork-notify@kernel.org>
Date: Thu, 21 Aug 2025 14:00:07 +0000
References: <20250820204117.1905780-1-luiz.dentz@gmail.com>
In-Reply-To: <20250820204117.1905780-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 20 Aug 2025 16:41:16 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Experimental debug feature requires use of MGMT_INDEX_NONE since it is
> not an adapter specific feature.
> ---
>  src/adapter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,v1] adapter: Fix setting index in MGMT_OP_SET_EXP_FEATURE with debug_uuid
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5f38ea159ea8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


