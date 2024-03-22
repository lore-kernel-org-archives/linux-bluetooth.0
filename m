Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5882E3EB
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Mar 2024 10:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711102232; cv=none; b=p8sAKDezpUYrliLGMB37sA3Gk4IbkbHpwcs7GBkUxSYPpM/eN63JkUOKglnrYceaKfjnCEq650WVwWCw+gLsImLhAz7rZuDP4N9QFW4Mr6Jp8CjjjFj6ecB9jol6GZkFyYU1XKyC00OVT3RrGJBa9JhlZ4qwPzgPKJas90E8fkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711102232; c=relaxed/simple;
	bh=U83cE4G3o7a9IqDZvhQBhOJWBHrsZPaPI1zI5Hjk2tA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Wxsjrxxlo2dnyuTeqqoxydijFVXl88MFiRIgnJoBb+5NhfRd2+ytpPMhvfqAwZrC+xrLgQrJYIwUSQyPa2g829kEVaGjPeF718I8xoufq6YvvsheD9iWykY9HIabJiKuJ+KrjzZBMF99YFn8K/48niZLhe8ccOGh5lCi3d4dZMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfPL7Sia; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfPL7Sia"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3FE1BC43390;
	Fri, 22 Mar 2024 10:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711102232;
	bh=U83cE4G3o7a9IqDZvhQBhOJWBHrsZPaPI1zI5Hjk2tA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lfPL7Siad+CTc30Tb5Jts7DhUq6pA6wJf6IcgkaNLsKsNl2gEJ+1Ih0Qwi9rSZx6U
	 r1N6f/zD8/qgudf0QEDZSAS5xXl+SYFblq5D0LIuuXC+XVc2E1Lop1V8rg3vMN2PRt
	 jlX/fZyqIVMZdxz5PrcaO/AqwfGc5w0wT1CliPvfEmsUn6BY+B47TGkkfXqPtUXdyC
	 Z77hVeyTpTpwcANIWdjIk+sUySkoL+rWadNJiVxI3cOrYq9ZD5fvVW0IqfgjzfV11n
	 hWrs91jLPQmu6qkLEF4TtjWGegPq1X0gHoA69xoIF1azVS5vLyobmeG3Cvghyy9sdS
	 1VuV2MkmTMCzA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2CA10D982F8;
	Fri, 22 Mar 2024 10:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ] obexd: Remove redundant judgments and fix code style
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171110223217.5004.10195724040717201859.git-patchwork-notify@kernel.org>
Date: Fri, 22 Mar 2024 10:10:32 +0000
References: <20240321021925.513182-1-youwan@nfschina.com>
In-Reply-To: <20240321021925.513182-1-youwan@nfschina.com>
To: Youwan Wang <youwan@nfschina.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 21 Mar 2024 10:19:25 +0800 you wrote:
> Signed-off-by: Youwan Wang <youwan@nfschina.com>
> ---
>  obexd/src/manager.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Here is the summary with links:
  - [BlueZ] obexd: Remove redundant judgments and fix code style
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=97fa2525fb10

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


