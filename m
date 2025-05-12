Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC735228C9D
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 May 2025 16:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747068592; cv=none; b=OG+2tJsoaBFLAqq0eg+T8lr9mMh9qKXlv1NNv9SbkgQ8F6jI/QH8S0ZRyfODRaTq8r+hEmx2k+yLcZBGpyn768OAVd5k+yFBDoX9JRvyiCShxFye2Qm552Xapl3zGdUopSTYCmIL/rDkAknr8JKlgg9em11FexluJv4Ib65Pj3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747068592; c=relaxed/simple;
	bh=NBVYvEXvHcxWWdG9IGo8QEdqnLcHH2qUEz9H7Rh+6iU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G+Lynywg1VHZm4Qpvo6UeQ5jvNqt48tkcF3lRXqdYvoxPvxFaupQuD5LJxIqwwLFiAZgU5xa9gmiPx8olVRcnAOka8FmQP36rIFLdNb60PlWRgU37dn1NW9BFbC4yxyDp/ZVDkz8QU3bnjrNJWFrNos/KQ3OU16vLdJG2o07goI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ho/Xhwks; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ho/Xhwks"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78582C4CEE7;
	Mon, 12 May 2025 16:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747068591;
	bh=NBVYvEXvHcxWWdG9IGo8QEdqnLcHH2qUEz9H7Rh+6iU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ho/XhwksK96LnRSxDlsmA94BDmhUtjnlQ8PHG8wU+YwFCmLlQ9oDiDSMErjjxgz07
	 vOoGO9HlnKB7OvIPDQr7zbI8QsSLT7QnBn6dYseJPXf8SI29WK3MvR54sF/lxZEiaN
	 M3iJNKPx759fYPL/xUxJNnDlm4B1b11lX1PYTJm2JGzHFKGEE9P6qehijVTwRooJF0
	 tAnZ4OSYwbzntuLTbCj22v9yCds3VQbR5hJS1M5KwildEyJ+I50ZiA3EbzD0GFJIIV
	 h/Nt2YHGMnaROXxT8oUp3qqGlXbHK0j+X3kzJp74ofkiHtzH7ZZMmFP9xf+Fe3ft8k
	 LXO732aNeKxMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E2E39D6555;
	Mon, 12 May 2025 16:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] shared/asha: Fix bad parens in a comparison
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174706862925.1011404.9209557276518737253.git-patchwork-notify@kernel.org>
Date: Mon, 12 May 2025 16:50:29 +0000
References: <20250509205341.557936-1-arun@asymptotic.io>
In-Reply-To: <20250509205341.557936-1-arun@asymptotic.io>
To: Arun Raghavan <arun@asymptotic.io>
Cc: linux-bluetooth@vger.kernel.org, sanchayan@asymptotic.io

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  9 May 2025 16:53:41 -0400 you wrote:
> The last parameter to the memcmp was incorrectly the result of the
> comparison rather than the sizeof()'s value.
> ---
>  src/shared/asha.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ] shared/asha: Fix bad parens in a comparison
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5a112d14e423

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


