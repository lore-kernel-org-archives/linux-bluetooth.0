Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5A043147;
	Tue,  9 Jul 2024 15:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720537233; cv=none; b=RFZGT1jugrzp2ELnf6WYXLOQW7wT9PrvySFWLpHVfoJFS8sK4i1+ZCsvOkAqI47JbtAJAQYvp75Rx4gmcSq4L+DDBMPiV8f7Xrgg5mcE0JknRmfO+rsrH54Q64l+rwmxAWaUwwofrJP8chjoOyP8+id9vI76HxdU7yhzU72aeNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720537233; c=relaxed/simple;
	bh=/Fu8FBcdO/VrzhrTCisC6PhcrDD1tYFVPd+i6LWd11k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d+W/x/chZb71HD/d1bxwwcOE4CKRBMrs0kv8sKahQK3QD4yfPaKAFReoxgQqUUeEL7rpTiQ3VZHF1LwsFtNx2DGf+Sk5nd4529eD1b7AA0Os3nkjV8NvmnxEcvIyh+kUkmmLi3E3pjqmD+xmFn3g/fxVxDYPcnYDcAM3tNfIHGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wo0GyXKv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wo0GyXKv"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D21FC32782;
	Tue,  9 Jul 2024 15:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720537233;
	bh=/Fu8FBcdO/VrzhrTCisC6PhcrDD1tYFVPd+i6LWd11k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Wo0GyXKviSWq5nfKvs7mzLgdz+v880IM37ggmvwyIt2KWi4hMoogZE6knV7tbGaO7
	 vKL8pcnifxjZWLMYiGCtyb9Qtge58gmPnSwi0Ygscbw5T2C/MyL7DBoJMegis9MMLC
	 Dx4KdrQIKFolsYJDDCxua4wNwyv8zid4i4pNrrYzG+KQqm+MsswM80Lvc5uwPG4x2z
	 cPwh+IqDrigAA3J+kLI5vAQE1f9Aq10uNQAzDJFrS0srnmI3+yYTMy6aTGYlaI1d9v
	 mNi6XBlowzSBatjaVq+9dGVI1YMUcmYMLecpsm6u6YIn7pyprvg7PFlYxuT0lt1lKA
	 wvv3BTuqMsInA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3673DC4332D;
	Tue,  9 Jul 2024 15:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 1/2] Bluetooth: btnxpuart: Add support for AW693 A1 chipset
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172053723321.16254.2744365904973150589.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jul 2024 15:00:33 +0000
References: <20240704132058.716164-1-neeraj.sanjaykale@nxp.com>
In-Reply-To: <20240704132058.716164-1-neeraj.sanjaykale@nxp.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com,
 ziniu.wang_1@nxp.com, haibo.chen@nxp.com, LnxRevLi@nxp.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  4 Jul 2024 18:50:57 +0530 you wrote:
> This adds support for AW693 A1 chipset with it's bootloader signature
> and firmware file.
> 
> No firmware name change needed for AW693 A0 chipset.
> 
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> 
> [...]

Here is the summary with links:
  - [v1,1/2] Bluetooth: btnxpuart: Add support for AW693 A1 chipset
    https://git.kernel.org/bluetooth/bluetooth-next/c/bb05292409dd
  - [v1,2/2] Bluetooth: btnxpuart: Add support for IW615 chipset
    https://git.kernel.org/bluetooth/bluetooth-next/c/203641085e98

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


