Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5C61EF392
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2025 15:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740756001; cv=none; b=HHCh9sbgt01ez0FfCuL54rHi8IART2BFoPwZpkd9AJwrQBVJNyxEH5IFA73D/LcgwoX2ZeHJoHLph70e/IqLoaO/SC2r0Uw9mXdpzJdEUIfE7ZBE2IRk+coKqMFlraVVjoEJ4tXUk0aIlHrCo+bFpTBNqkDlmcYOQcxebqbC+gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740756001; c=relaxed/simple;
	bh=vYbn7b16QVbsnNqcO/TUCyT2e8ZMYeXLqDR/dXaxML8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bOfkd+wQUBEInlPVV7uB9M+c1wbVqJALZsh3D/Xd+z7RWxC8CXN/a+V6VBAV3/JjaE4ULFz4bR3jT/lJpYZzvSM3hBY56MEN280y2NHwZZJcFva+qLuRecDB6r7JUpkWzr45OP7fCJDWPWUCCIeF/4nK+P24TpYuE1n5BzcKKEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPmpRq0/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPmpRq0/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C66A2C4CED6;
	Fri, 28 Feb 2025 15:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740756000;
	bh=vYbn7b16QVbsnNqcO/TUCyT2e8ZMYeXLqDR/dXaxML8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FPmpRq0/M1Q1NC9xegkQH1MaJZzUrOM9woIlq68toqIKXzyfj2yIOn+jyh//HfGi0
	 8el3wcbNk8L2M3Mi3eLVXE4eC75axykKz7Oi632pzR8zHee+As8bjZ+k/uYMOAd1ts
	 ryvZPAEDhyflD++Ap5EgXx/bbjUqVCMbaZEi9E9wZzMBm+/R919tPjc49elfFw4mfH
	 ywGW3FsleQpC5WgH5cgZAlO0Ic/2HD3BVF8fBhJV2yaZ5oVA0fkQimasvhDM5r76hb
	 YUcskKgJuoWR6sJrsYCK3GlzOCN05kevYt1DToUmi/FX/B/On8UUFDyGLAlLgk4BMl
	 Exy/N3fnZX7wg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F60380CFF6;
	Fri, 28 Feb 2025 15:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] obex: Add null check for data pointer for PCE
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174075603301.2174793.9172875534823106531.git-patchwork-notify@kernel.org>
Date: Fri, 28 Feb 2025 15:20:33 +0000
References: <20250228062554.3102800-1-quic_amisjain@quicinc.com>
In-Reply-To: <20250228062554.3102800-1-quic_amisjain@quicinc.com>
To: Amisha Jain <quic_amisjain@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com,
 quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 28 Feb 2025 11:55:54 +0530 you wrote:
> Incase of legacy server, when the 'supported fetures bit' attribute
> is NULL, Add the check to avoid any invalid memory access.
> 
> ---
>  obexd/client/pbap.c | 3 +++
>  1 file changed, 3 insertions(+)

Here is the summary with links:
  - [v1] obex: Add null check for data pointer for PCE
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8d1c5165fcd8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


