Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E5D26ACC;
	Fri, 14 Jun 2024 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718384435; cv=none; b=BR9bGpNgu0buKw2na9klxEsHW1oabzOHc1FTqkCWZ1QN/Gt5zTgd2HXsnWWIw/qCgSpSGN6pIDB2oveQoqmrbDM/YUXod95f2sxt6X19jl6jSj1Ui70YBEP3ODRtWhzOHtb2ENcRw6pMmKthhuTs/f2syQJedwYOeTc5kMA6Ofo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718384435; c=relaxed/simple;
	bh=a8oOy1+tNkA3Y2PRZ0ckwQkaG3FhkE1hMUVvvLS4IQw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YlOEQmmdH9hvutmDP/KcZYrLrh9c2QjOvllZcZRiOt/ITm3wO3CHTq/XBFZjzqJMPcEaD2ALlTyb2IkCnpK8KdyxZib0nk1MnE46M35EhJHAmylcWRmssvTm22uyl+o19uO0Cdt14T//9Ze/cE8NXnKqYwggFeov9FulUIJoJYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKs5jGy7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKs5jGy7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C7F4C4AF1D;
	Fri, 14 Jun 2024 17:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718384435;
	bh=a8oOy1+tNkA3Y2PRZ0ckwQkaG3FhkE1hMUVvvLS4IQw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KKs5jGy7FgFJFYGvS3tKtPGeo4qwJjPa0JltvJd+aiP1oHanMoXRW4j3dWLKZGw8X
	 PyfTz/VcB5Zu8B4kXHBAaL0yLRQNs3FE65jiWOMJJwNG8+4U1gJiCHOJasfdHJPqO8
	 OuEhWgcSqaCws9azUq2H7vH8s/UfP1/cMpO8Rhg286m2vdMsdIKmr3BrGp2XUowSGf
	 eCJE0guLNCzLCc9vX1mxNbQIxwvrtXUjfpygnDMMnMXQUAkYy/GOrWKYIUWsQAILxw
	 cq5fhqitb0IQfZXHJ7/+WXfU/JgsJMQ0k19p1FZQcDoSGWXQ2CLyZ+it+BL8YnbGaa
	 m0IeCkOb+xP4w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19F03C43612;
	Fri, 14 Jun 2024 17:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btnxpuart: Enable Power Save feature on startup
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171838443510.31311.301309196068424307.git-patchwork-notify@kernel.org>
Date: Fri, 14 Jun 2024 17:00:35 +0000
References: <20240614082039.6465-1-neeraj.sanjaykale@nxp.com>
In-Reply-To: <20240614082039.6465-1-neeraj.sanjaykale@nxp.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com,
 ziniu.wang_1@nxp.com, haibo.chen@nxp.com, LnxRevLi@nxp.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 14 Jun 2024 13:50:39 +0530 you wrote:
> This sets the default power save mode setting to enabled.
> 
> The power save feature is now stable and stress test issues, such as the
> TX timeout error, have been resolved.
> commit c7ee0bc8db32 ("Bluetooth: btnxpuart: Resolve TX timeout error in
> power save stress test")
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btnxpuart: Enable Power Save feature on startup
    https://git.kernel.org/bluetooth/bluetooth-next/c/1db01d15e2da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


