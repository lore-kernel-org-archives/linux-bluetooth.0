Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAEE1FB1
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 22:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760481025; cv=none; b=YaEPrs3l1XaXUsNapVg8GE83thiN/fOiy9kkRmlMYXdsRjHPWd1vP+Kv3IoPXoWrEpdxHWK5zGZNFE1bQtAdcyVOuADvZFDb8K+xswmejKAC7uy13Trh+jOagjRyVVheZrjABFymzN0i/t/7YZt8AuQ5lbfvqPS3Al3fUpM1Kv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760481025; c=relaxed/simple;
	bh=DeAGAa7H9gSQU3gwlLP9TR7eSTv22tfrZqluHJQLSOQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eXnjh8wFr0wmFIiQ3ksSJ9mT6Te8KjMmdUOO1V926g0EmDOS9iyVnnNUNSHjvrMURZeU6DT46jv0ysHPmTKSV3pM1SMzlQdCdDPZVfJgUNfWnZO5xhLrTEwRU9vl7nS7Rx2owoKCEyn3m7rXi9k7WUUKARk+KrzsVCeIL/RIPQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fe6SkwNC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fe6SkwNC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C75C4CEE7;
	Tue, 14 Oct 2025 22:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760481025;
	bh=DeAGAa7H9gSQU3gwlLP9TR7eSTv22tfrZqluHJQLSOQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Fe6SkwNCpWduHlAtR2lBvxG8kLSYTcdgQXIZPA/ePlPiuj7iQ9IjTt15XzUazPusk
	 +qCOk4hvgs6FP1sQk/1cu127GOpK5IKzAibyztlCJOiwu7Eac9xAUkYIP3RS+TM7dD
	 pKE5+I8TZxkVzVq61t+nbwWI1Apuw5rVmqvWSTukWftMJkRif+viFbXKQpgXtf5/ps
	 iPRvfMzo0zZ2m9szG/jxUtZagtogZK+ZM9OdhnFxX78o55v0Qpx0h1lmZeY2elEc6C
	 m4c9ERuaFXM5KkQZQiQ7iJ9pEDdiNdCf6DV6wzYL9/6YBa/PJneCHktvKbht+nnPON
	 1wn5ekYBqcDBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE491380AAFF;
	Tue, 14 Oct 2025 22:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] client/player: Add 'auto' option to
 transport.acquire
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176048101050.129201.312768935066778309.git-patchwork-notify@kernel.org>
Date: Tue, 14 Oct 2025 22:30:10 +0000
References: <20251014194855.384197-1-luiz.dentz@gmail.com>
In-Reply-To: <20251014194855.384197-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 14 Oct 2025 15:48:54 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This enables transport.acquire auto which enables to overwrite the
> default behavior of prompting when endpoint is registering without
> setting auto accept.
> ---
>  client/player.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [BlueZ,v1,1/2] client/player: Add 'auto' option to transport.acquire
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fb183b2805ee
  - [BlueZ,v1,2/2] client/player: Add 'auto' option to transport.select
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5d2616a70c5e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


