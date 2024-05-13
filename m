Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162EC153814
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 May 2024 14:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715609428; cv=none; b=Aotou1KcEICEImX/yEMDwHxp3SawNZh+Y9n2AcQuDleqRzSBkUdQo2FZFWPwBmx1xyQc5/nHfXO78em8jiizWTA7mFbE6YaIAeKFOmM6bmf0ZsdJxpf/W/atAoy2Y/loWTAALFcgBAW6TAZWDOwXx6fKhbcZ4C2cBxgxMMwTDKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715609428; c=relaxed/simple;
	bh=3LXZm6MiljU6uxEnBesbIndsI3pOb/r62ngKU0Wbgak=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tsfZs2mL4zbU3rVgw7q26TZH0Qf7ubsOVSYjVpo2PEeMPjc+qSiVPmAV0QQZ4mpGumxdjjkuGhEnli+bY6bcmF/nFCUVnhKKVZc9TUMS10GsSixhZ4E131GDI38aCIsVUa31lQOgtwjSt+nK1/PynWkAAnyrCfXL+EoN3NPKVSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWMhhTi1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWMhhTi1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BECDBC4AF10;
	Mon, 13 May 2024 14:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715609427;
	bh=3LXZm6MiljU6uxEnBesbIndsI3pOb/r62ngKU0Wbgak=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZWMhhTi1OLGcsBKMHwd1yUXuZA8p3IIsUUS1cehGVHhj8n1FgvjFOAzmUD4++IjyH
	 H1hFJOocXWDR2Q8AoJ4fGbzalNd61Vwn7h/opyk7/sJaRGvIH13+LyJ9YMS1Dwefd/
	 4e0zNNyW/5hScPox4VdzQIy17GaHqhEvsYYyyoF0oUGOrhgd0IsD+C0NoeIzHwRapv
	 v8xUAdDQG5na0YWdiJd7vvVZillKvcQx+kDza1tZ2W4a5iiqapZyHcrJzYnluq3E4T
	 I9fRnYfQ4lDwN+PXT6yvgqRqiNNPLb2UXo4DwKsWVP4aQFoFYcvmUMgXsva88i0HTS
	 VS4JWYD8xxOmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ADDB9C433E9;
	Mon, 13 May 2024 14:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] tools: fix using too small buffers in test-runner
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171560942770.21927.763537423012567620.git-patchwork-notify@kernel.org>
Date: Mon, 13 May 2024 14:10:27 +0000
References: <9b7b8130a4296de7e02435d7be3c6d00c4976427.1715423446.git.pav@iki.fi>
In-Reply-To: <9b7b8130a4296de7e02435d7be3c6d00c4976427.1715423446.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 11 May 2024 13:32:07 +0300 you wrote:
> Fix compiler warning:
> 
> tools/test-runner.c:309:57: error: 'sprintf' may write a terminating nul
>   past the end of the destination [-Werror=format-overflow=]
> ---
>  tools/test-runner.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [BlueZ] tools: fix using too small buffers in test-runner
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=24039249854e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


