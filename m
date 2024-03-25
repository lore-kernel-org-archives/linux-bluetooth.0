Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFA51BF2F
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2024 19:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711395628; cv=none; b=ONFG7XgUkPS3uk0aWgBSE+l+r3bIXRChG7l0E4S9T5eEsldHn6R5ddGBS+8rMO4fR5mbTIbSq+EVrkR/iQrnYknnHNTpAYWYeH7VzCA6mHIewMxyPc6A9FA/WNHgT7lV5oCCMhEUhSMnnn4o+WmQvflqdWbdY8HPJeFVKBgzknk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711395628; c=relaxed/simple;
	bh=bBZ7dFNasZ6Guic/nlWRxQXkFsm4ZkhBB+jbiHSycRg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ML9Q+WrKs8nTWWSuqte4JpS0Mkqa3KLvhsL4uvkifIuulb58CChjwfrB6WLifx2Iuas1xkSn6QDyMjB9D0oN9Fk8XXHT0vVEsowQCqNCndqV6P8KwsMzyhpil93gtN9Scmzo+LvOuRUsdSf8tWR2HAtgbK55aUatoudmc8HaJhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pFQhslkG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFQhslkG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41CF8C43399;
	Mon, 25 Mar 2024 19:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711395628;
	bh=bBZ7dFNasZ6Guic/nlWRxQXkFsm4ZkhBB+jbiHSycRg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pFQhslkGa09zwAK7KivDzd7Pp8Ry1sKgrkN7mmsQuTe2K8wk2mMlniF6UDzcH5G+J
	 dqKjtpuybcma+j3BQXprL80lbut+Ng/wm0L1YXS1NhTzPM40tJ/uBovV3pHOnug6C+
	 ucmaX1bHC/xB59QnKiMos8eLBVp7PY93q+aUQTj7VE5/B+wsBELJwPMnGss9FzOxdR
	 Ht9i3U8GYNMszm0ozSCM5z8EoOBGpI/umLiFdAoN20l2r9IUK2fOmQP/Mdr5OMb7cA
	 lGmzeh1ClmIzq7+dHn09kjVipLsvEXgrmrr3moi3TkD0rFn/x2qvHSq21Wb4jK1SC1
	 UlbPyAPcsoi0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 255D0D2D0EA;
	Mon, 25 Mar 2024 19:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Bluez PATCH] Advertising: Emit features property update
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171139562814.16755.8791358547578372825.git-patchwork-notify@kernel.org>
Date: Mon, 25 Mar 2024 19:40:28 +0000
References: <20240325181004.Bluez.1.I8b0ed6ef2fa5a273f990a5c9f0872aaa539b8b39@changeid>
In-Reply-To: <20240325181004.Bluez.1.I8b0ed6ef2fa5a273f990a5c9f0872aaa539b8b39@changeid>
To: Howard Chung <howardchung@google.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 johan.hedberg@gmail.com, marcel@holtmann.org,
 chromeos-bluetooth-upstreaming@chromium.org, apusaka@chromium.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 25 Mar 2024 18:10:04 +0800 you wrote:
> From: Yun-Hao Chung <howardchung@google.com>
> 
> Advertising manager has some properties that relies on kernel
> information. Once we received the information from kernel, we should
> emit property update.
> 
> Reviewed-by: apusaka <apusaka@chromium.org>
> 
> [...]

Here is the summary with links:
  - [Bluez] Advertising: Emit features property update
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=150bd6e81b35

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


