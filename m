Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93B6EEA9;
	Mon, 24 Feb 2025 21:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740430800; cv=none; b=KS6kx5ZAfC8Duy055WQMoA3Imq8uzPBLy05Qb3jxAxTkf918JKKHYSZr7V8zM31CIJWVRB3xAsyWGWqCBx/7EX/9mQ6BzBvWJYpbZoBAohOdujBf4gpr42KwoqD9H6Sb4W/J2NGEXIWU15j9RHXfGNucqjkGoURt+MtE5vv4FR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740430800; c=relaxed/simple;
	bh=1NWuUJYlBH4z8CLnCuFgDe9PmgNjtMn3ihoud+NaoFQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rehlRnwOKFm8g2Hm4PTWrWJnZklmEuY1CHPd7ewvzlNQ2jvAsK5ct2Gw9cLnzagZ0QYgRlPCbwTtEsWf3G7rf1SAjYQq23wpxSb71n+UJzxDjo193VFZ3z+0EuUJyvTaW17tQ/KFFn//IdGj3NIzmoc80PS4rHgGkkbtMWsbe4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKJE2Nyq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKJE2Nyq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4343BC4CEDD;
	Mon, 24 Feb 2025 21:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740430800;
	bh=1NWuUJYlBH4z8CLnCuFgDe9PmgNjtMn3ihoud+NaoFQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jKJE2NyqR29Kt023x1gm6GHxQM7pqiwXfSsuxPIHyrOnrissYnlWvUJkdHkXvqFnN
	 VTtglcilgltURoaGmYj80s/JFMl3wIsh0RTmwup8CF1lhCSC/GlAF1lXBsnsn9wmrG
	 Wz8HEV+AnMJa9axgQJpr0Cg4pIUa8y1//W0F+GqX2DcOanm6CmJgHAk5BRtSwfljNb
	 yIVV6o1s2WD+plV5mhe/UybjBjcIwoU7gpK1nt6STNWQF9A3RnpSForPL0gCG9Ll4J
	 KTQee+lBd289/cmy9z3JL1RS65moR2f2XpS/zm84KqjqWwqYI+VKPaGbU+LNtQG9Fc
	 eFeGiPwj7/4Ug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0E6380CEFC;
	Mon, 24 Feb 2025 21:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] bluetooth: btnxpuart: Support for controller wakeup
 gpio config
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174043083176.3606604.9199619659831675695.git-patchwork-notify@kernel.org>
Date: Mon, 24 Feb 2025 21:00:31 +0000
References: <20250219091512.290231-1-loic.poulain@linaro.org>
In-Reply-To: <20250219091512.290231-1-loic.poulain@linaro.org>
To: Loic Poulain <loic.poulain@linaro.org>
Cc: marcel@holtmann.org, neeraj.sanjaykale@nxp.com, robh@kernel.org,
 krzk+dt@kernel.org, linux-bluetooth@vger.kernel.org,
 devicetree@vger.kernel.org, amitkumar.karwar@nxp.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 19 Feb 2025 10:15:11 +0100 you wrote:
> When using the out-of-band WAKE_IN and WAKE_OUT pins, we have to tell
> the firmware which pins to use (from controller point of view). This
> allows to report remote wakeup support when WAKE_OUT(c2h) is configured.
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> ---
>  v2: - Move pin properties read in ps_setup
>      - Display warning in case of wakein prop without related gpio
> 
> [...]

Here is the summary with links:
  - [v2,1/2] bluetooth: btnxpuart: Support for controller wakeup gpio config
    https://git.kernel.org/bluetooth/bluetooth-next/c/f66b266e3e4f
  - [v2,2/2] dt-bindings: net: bluetooth: nxp: Add wakeup pin properties
    https://git.kernel.org/bluetooth/bluetooth-next/c/c3bb10f6d38a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


