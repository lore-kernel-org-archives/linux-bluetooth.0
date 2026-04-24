Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3F172627
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777042844; cv=none; b=SkntU1TOzR7yS0NTiEa76rzQF+knDfTnJIMrsuff+bRVnf54fHPax3vBe6/rkHPbU7nw8CxKVYqW4lxST/c49wEcEKrVr4IlySt+IBx71ssSrooytjeKNP6uaBrryHv7Dq4YabGd15j8tehNGzFGCGByf7Qt8s8sFsokABa9CBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777042844; c=relaxed/simple;
	bh=aEuenoTGNxl5nZg5AVf8mAdQzMopef7r5L9KiBC34rw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lhZ597ZVn3eNeW/5CoocvSz7LzSRc7jCcbJsKgBTUEbiVOLWFZ68DSIeSmakeuZkwh6kiv49KVeizu9LwadIpJvGpyW4pkaXrn33TqTyw1KSK+yxUVbcua5YxdLreB0LHI4mySNHrSebQuP9iw1Upin/+lY5sLbUlSy1h3lsLlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqch2lvJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqch2lvJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F548C2BCB6;
	Fri, 24 Apr 2026 15:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777042844;
	bh=aEuenoTGNxl5nZg5AVf8mAdQzMopef7r5L9KiBC34rw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sqch2lvJPzHb+r7qZWxEakKmNXduOP+08XAiKHrnk+BjiGeVfyEG7im2uV6aGRUMn
	 D4Ul+o9oISv9ueNBunNRfaah2bnhVdmIOCpliNJeLSDBwHzup/Y3yDvoXvllVpJ3Dz
	 4S55vETJpzua26GwTrXKdNMU7PD86SODXxfMsZ00sAsQk8xmV8cooM5kzeEFI0Uocu
	 Qk2bttYKTVZeckr/vRrocZVt0XGppdjyHy3V3GRSZLicwp8Nps9pe1HsKZpsZRx55B
	 Nlgka7fVFPGowg+XEGWtuxQ+qC4dZQZ+ydFYPclLzxgkKr0cNFKTwMZ5sViHloyIdC
	 ZiXJJEzcdi80A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02F00381197D;
	Fri, 24 Apr 2026 15:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] src/shared: implement custom CCC callbacks for
 intercepting client notification subscriptions
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177704280479.1575268.8416790845102221858.git-patchwork-notify@kernel.org>
Date: Fri, 24 Apr 2026 15:00:04 +0000
References: <20260423150454.1908352-1-prathm@qti.qualcomm.com>
In-Reply-To: <20260423150454.1908352-1-prathm@qti.qualcomm.com>
To: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 23 Apr 2026 20:34:54 +0530 you wrote:
> From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
> 
> ---
>  src/shared/gatt-db.c | 119 ++++++++++++++++++++++++++++++++++++++++++-
>  src/shared/gatt-db.h |   4 ++
>  2 files changed, 122 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ] src/shared: implement custom CCC callbacks for intercepting client notification subscriptions
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=83ddf46ccc06

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


