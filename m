Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990EF1863E
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 14:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720621835; cv=none; b=bt949wInteGRBTNcGBFcE182RHNv7EdJaJ2ofAeHX0hOX0VrlghGgZc8Mdu3aciR/fhRxgWUsHV782g8CrqQDLJ+EKpzkRmYobjTzLIb9kM6iyikT5mPOkEU8pY3mNe/Nab4QttGK2j50NF8TU9EVM5RCyFB2KVv+Hb1XazB3xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720621835; c=relaxed/simple;
	bh=jXEz1mzlv8atM/p3jWFhHz31WscDzfrhaTldNRVhKw0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PF/jJ8Q8KyP0qAuyc5PnlRAwedEvYhhrkounxOURY9zv7/yqE3HbSCRPrMmv0+70eh3d44wG/epRgk8aGCqxlhLodnq7sMvfP9yOAzI4NzuNtFNbnGxG9uVxr8R8JRniGFtiLaMljWsrGWUEvjAZ1MqjMt8A6r6bU6OXH1/Hsls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AeDaa52R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeDaa52R"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E9E9C32786;
	Wed, 10 Jul 2024 14:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720621835;
	bh=jXEz1mzlv8atM/p3jWFhHz31WscDzfrhaTldNRVhKw0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AeDaa52RDn/e28d6pjVrMSQ/YduTWd1YTSFdHNzl3Adhgu6z8rONZntbBdzUOyFhP
	 gV+CoXNf3O/Fqu6xxprXnfPTXUOIT07JyOQw58fnBsZI4rVNnWKRLY9m/Y9rbbQBQx
	 ddlzqIx82GBuk72rbky29U8nmepSzUfbTJPgmlOc4IrtcyQfmS/LbZiuaBne4/WrgY
	 F6LwfJOKORKO/LHzs77fm/UfC9W8yHOf+XniyW2pghKYFj9nY1nenY/VRzmhRluv+Y
	 e+84OYGmgb7Nqj2pjqTQQxBKLhe937S8oF22muso71iRhOYOceescde2x8zo6nvct3
	 Ljfn05dzq2poA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 39F0DDAE95C;
	Wed, 10 Jul 2024 14:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 resend 0/6] fix errors found by SVACE static analyzer
 #1
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172062183522.19459.12570679145696179198.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jul 2024 14:30:35 +0000
References: <20240710113151.49296-1-r.smirnov@omp.ru>
In-Reply-To: <20240710113151.49296-1-r.smirnov@omp.ru>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 10 Jul 2024 14:31:43 +0300 you wrote:
> Several bug fixes.
> 
> Previous emails:
> https://lore.kernel.org/linux-bluetooth/20240702085508.30513-1-r.smirnov@omp.ru/
> https://lore.kernel.org/linux-bluetooth/20240702134106.102024-1-r.smirnov@omp.ru/
> https://lore.kernel.org/linux-bluetooth/20240704090756.31351-1-r.smirnov@omp.ru/
> https://lore.kernel.org/linux-bluetooth/20240704104928.43336-1-r.smirnov@omp.ru/
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,resend,1/6] gatt: add return value check of io_get_fd() to sock_io_send()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e56fc72fc667
  - [BlueZ,v2,resend,2/6] shared/vcp: add NULL checks to foreach_aics_service()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ba70a116d971
  - [BlueZ,v2,resend,3/6] client/player: add error code handling to transport_recv()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=12525371ef08
  - [BlueZ,v2,resend,4/6] shared/vcp: prevent dereferencing of NULL pointers
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7ffc08dd78d6
  - [BlueZ,v2,resend,5/6] client/player: fix the order of args in cmd_register_endpoint()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=cf3d80a01f1f
  - [BlueZ,v2,resend,6/6] shared/gatt-client: add NULL check to discover_secondary_cb()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7a45038dc1e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


