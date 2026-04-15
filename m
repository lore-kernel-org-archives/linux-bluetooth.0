Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D8414E2F2
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 21:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776286837; cv=none; b=n9UvXXta0tmVhsVez566UA7bGdYxN7KtbKSZM7bSEvkkFve4N47MIoT+5T0mZ11feXPaaF/AultDZvgqxT0Lloodx3YGp8mD4ALKGOMIWukgMTHIIYg5Wppq5I5NGIsT4LDOSgrE4UuA/AUddCwvIiToVxMYaXYiCFzgf6ZtApQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776286837; c=relaxed/simple;
	bh=cAucEbL91qlooF4omaKpkMfvL4baB6rijq/0ZQOwz3Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X1Ejh+KwymjBMZTBu5woopBqqxCbN1qTCVeqmegLQu1RHciFB8zNksJ5ncDp6qFGDKctrDnMuHQ94swTgfcsk33PdXDrK07cL5WGfIJnk2HMjCodIb2GuhC60obc1rMI7E49+zu/QYU7BippuzjwBuZEIWnLR8NoOdmYpcGGAM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrjsRJB3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrjsRJB3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36431C19424;
	Wed, 15 Apr 2026 21:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776286837;
	bh=cAucEbL91qlooF4omaKpkMfvL4baB6rijq/0ZQOwz3Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZrjsRJB35BiSyZfcJkN/P6edIvS2D0Wxj8TobrGD4WNqdcJYxe47BrgU9a/vFxpbm
	 J90gLfobuZWYR63TTOl30ppuBWwsbnlz+l/VdCqKX62yhgPHff+KqQxwj//OtTX8ZK
	 LlNIxJM73F/HNPpq99R++zOzcps7RMLkx6N2lKGGRbB/Srm7Pg18WTUZPqC1Clnozt
	 Qu8G3eWzxkJ5aGOfQKW1lHWRDo8FmqMyp/slqWGAwkTa0z78Z1St224i9uPg++OA/a
	 LrDndW72F8vzmkDDdH6ifRFTGejR59W+uwUDPAqrnssDJFgUGSHq+GdiAId98houSt
	 TkoVyeJqYeTcA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E10380A963;
	Wed, 15 Apr 2026 21:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: l2cap: fix MPS check in l2cap_ecred_reconf_req
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177628680629.2439002.124743646489985763.git-patchwork-notify@kernel.org>
Date: Wed, 15 Apr 2026 21:00:06 +0000
References: <20260415104355.76524-1-phx0fer@gmail.com>
In-Reply-To: <20260415104355.76524-1-phx0fer@gmail.com>
To: Dudu Lu <phx0fer@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 15 Apr 2026 18:43:55 +0800 you wrote:
> The L2CAP specification states that if more than one channel is being
> reconfigured, the MPS shall not be decreased. The current check has
> two issues:
> 
> 1) The comparison uses >= (greater-than-or-equal), which incorrectly
>    rejects reconfiguration requests where the MPS stays the same.
>    Since the spec says MPS "shall be greater than or equal to the
>    current MPS", only a strict decrease (remote_mps > mps) should be
>    rejected. Keeping the same MPS is valid.
> 
> [...]

Here is the summary with links:
  - Bluetooth: l2cap: fix MPS check in l2cap_ecred_reconf_req
    https://git.kernel.org/bluetooth/bluetooth-next/c/b1de65fd5f81

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


