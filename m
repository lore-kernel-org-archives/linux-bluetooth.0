Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E32A482F8
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Dec 2023 19:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcWAEGMp"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EDCFFC433C9;
	Wed, 20 Dec 2023 19:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703101224;
	bh=JIPsLBLD2V5Zc1jXuUMvCevdx3brMnQGBvMcF5CCPKk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NcWAEGMp0S1iSWm2qTN8hkNimReSCkiUA5PspiU3q8Fyn5bTX4GRwPXJiyy3A28vM
	 kHExrDj4SyPT5kugnRh/xzsPYMu64AUP2wcFxhsmlF/epVn4uBEXdkqgjjd3xPSsMd
	 pSJTJGPF5km7QJURcRJDw1epyT3TIUjfTEC1tLN8gpCtbi/dMzcDwd4kF+Y+hbSePi
	 Sf1dVF/Xtd19abasl/yWEken4LYXgNo/Jz7spnVvUmRnGmYIWLDLOU3dXj/hz4I2bq
	 VhCsH5KdunnJLq2ps7bAOIPRFmVnLrrUlsa2rIkQe4rSM9CMBRzqiIkH6aXhlMJGxK
	 OA+HF8Da8UkkQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D11FDC561EE;
	Wed, 20 Dec 2023 19:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] adapter: Fix link key address type for old kernels
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170310122385.31881.15527247509488264907.git-patchwork-notify@kernel.org>
Date: Wed, 20 Dec 2023 19:40:23 +0000
References: <20231220174042.2335819-1-luiz.dentz@gmail.com>
In-Reply-To: <20231220174042.2335819-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 20 Dec 2023 12:40:42 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> On old kernels only BDADDR_BREDR is supported so this attempts to detect
> that and retry.
> 
> Fixes: https://github.com/bluez/bluez/issues/686
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] adapter: Fix link key address type for old kernels
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7ad5669402c9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


