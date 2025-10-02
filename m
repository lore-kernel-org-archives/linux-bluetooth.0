Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9A225B662
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Oct 2025 16:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759422618; cv=none; b=qsyYK6aRCbcaAc0LWZB9DtCQUygnWuSG1b1ayIqQKo1SffB4hqUDVnMINGCqSB5BW8t5ZzZRk/6RUHkgIQnzSz5G5iTBjv+fU37E8olBg9PZNrxoYN2ZSBBQwQ5EdAiCBEMj8dKstYuZRfH8ghDdbSZOOvn4hlMsu5zup576HDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759422618; c=relaxed/simple;
	bh=lQPjaJoSHX8Q8QttWH6uhnTX/R7bq0wFYDFGlZXiTMU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WPM1Nvrbxqp/3gfcfY3Xru7kF7+Bk0F2aCicopey+s+08QksA0M5lFXUXfOcY2KZR3v+lnsmJZpv96tb82HGLif0F4N1zFKoXQi+4csyeGjPc1ntNz7ULu7G/BbrobOgqOxSYEWQnQ9JTaPT43GXZ+PkQn/PhuTLmYT9ntR5Fv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVNuzCUt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVNuzCUt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 807DBC4CEFB;
	Thu,  2 Oct 2025 16:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759422617;
	bh=lQPjaJoSHX8Q8QttWH6uhnTX/R7bq0wFYDFGlZXiTMU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aVNuzCUt01CHCrG8wDIdPBUxLKER1iOlBB3jGmNNC0nZ8o3HqBqmTRkWX2hPOSY4B
	 MlwWSyWiCmkX32vVTx/9Xa7l0Tgy2Lv+Z/gYWQ1Fzk6HYMIyebGQFOwNAsc7M9rlcT
	 0CyikG+zElSw8rkLDCwqxjjI+J/mBd8wtO9WoubV4JPFdsb1qHatBVSS9JJj8wrgCn
	 AT7g0riIb+EVg9sfB/cGCEVZCoyJNElvbabmT+OQsiqrSOGg/9G+cQmdAeAop3zlzu
	 bSwOLasEXrpQR0UX+3A+60hYLr65K+AHKZyfIyLSVt5fyxJXI/FEDBMbG69cfCCttI
	 VZ9F1ff9KPbAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE05A39D0C1A;
	Thu,  2 Oct 2025 16:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 1/2] shared/bass: Fix permissions not requiring
 encryption
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175942260924.2981110.5494733385154066766.git-patchwork-notify@kernel.org>
Date: Thu, 02 Oct 2025 16:30:09 +0000
References: <20251002155855.241787-1-luiz.dentz@gmail.com>
In-Reply-To: <20251002155855.241787-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  2 Oct 2025 11:58:54 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Both Broadcast Audio Scan Control Point and Broadcast Receive State do
> require encryption:
> 
> https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/24670-BASS-html5/out/en/index-en.html#UUID-dd95da9a-6ac0-3f45-7e34-13fa9e04d41c
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,1/2] shared/bass: Fix permissions not requiring encryption
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=faca31657e1b
  - [BlueZ,v3,2/2] client/player: Set QoS.Encryption if QoS.BCode is set
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3e55476bf6c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


