Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7264A1E528
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jul 2024 15:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721056833; cv=none; b=eA7LefHw+uFHAf8O+o6C4vgbj9qJoF+xx7MqXSNgvtgvgWKOlqWsa2Z/iZRgmY6So6+vmglot5EajXxOoG1XMFny5UZzx51wtO5UH3d8o7YV64AZGGMIcCFkMLKK9iDgZMWp410mGsb64qtisWzAw9DQwP+5uSBpylLFrS+mvE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721056833; c=relaxed/simple;
	bh=kDK6cjgciObMBR4CH632wumzmpQC96ESTLeaBSEe3hU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mw/vj2bQagrpaQxpvw66prvwf5wcLdumJSl4fsk7KwUcCTN9F1yrHrAKGyTm0rrx5Nnhk/khWeCi40Mm7A122ZsIM3S3zmXv4D2MbwAnxp2muJB/oxJqslZp3KAWVMfbW0BJfba+4laCzP3Y10BzsSXve5h1bzJwfHCtaCYkfQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfZYweOi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfZYweOi"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7411C4AF0E;
	Mon, 15 Jul 2024 15:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721056832;
	bh=kDK6cjgciObMBR4CH632wumzmpQC96ESTLeaBSEe3hU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RfZYweOirCs+rva6MoZRev5uJ70ICAUzYknlDcUmT6wAdOq/MOJ/XzuQoxYzv1l2A
	 OU9f1WXdw4QY/4/nL4/ytME/+KSO9DeoYWy0f0tfioHa7aXfAeyF2JTebok0PkJhU0
	 aJM0x1FrS2TM0tFJSHzLPMmvQgRA0QAlAxYbcxG2kpXkDWY70Urkk/BGmXUTJiPpyv
	 a7NCx/j3DdnkCxDSZFp1MxTE6wcFk2SuFBM7IXqwS8bPuYxOgHrQMQ3S+4NRh3jCiH
	 1NV9zC0NcgEVFi9RkxgQuMJySQgVyvK021xb7E2bCixa5/JIYWjbJPuF7lsMk07WUU
	 brTkVFPJ+ggzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C3BF9C43443;
	Mon, 15 Jul 2024 15:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] shared/bap: Fix ASE notification order
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172105683279.9943.13390261019644217441.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jul 2024 15:20:32 +0000
References: <20240712193820.3945762-1-luiz.dentz@gmail.com>
In-Reply-To: <20240712193820.3945762-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 12 Jul 2024 15:38:20 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> When processing a CP operation the CP shall be notified ahead of
> the ASE itself:
> 
>   'If the server successfully completes a client-initiated ASE Control
>   operation for an ASE, the server shall send a notification of the ASE
>   Control Point characteristic value formatted as defined in Table 4.7.
>   The server shall then perform the behavior defined in Section 5.1
>   through Section 5.8 for that ASE Control operation and send
>   notifications of any ASE characteristic values written during that
>   ASE Control operation.'
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] shared/bap: Fix ASE notification order
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=73266377b018

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


