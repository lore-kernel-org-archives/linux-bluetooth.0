Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE26149DF4
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jun 2024 12:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719319829; cv=none; b=QBrLX75rKTPVLB3qDss4j0Qvv56v8NDBtp3UmWtHezfo5ejAOKk8yHPZt78RiQ6ZPMZDfU5pCtoIA1b9ShhQT3uo/n1q98G/CnyNUDS0YX4X2BM281ZbW1piRxJQW3YTdcT8Pk2rlyUeBMMGtvvnXcMB3QtnwLLsU1O10+gNQuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719319829; c=relaxed/simple;
	bh=L5xtqFVDiZaCKJfj5SW1NcLLl4c2Xws2Tab+OdEmFpU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Dmusy6F64xnD4hkhmeVFEyb8J8VgzQ0DBcTvKicXSDG5K623tb+jk2tzeXUBFgBJTLU2vhtBkGyM2wOQkpLNleqAGvdwq3SsCuXKuWcb7wk03g7uwci3kn3KL9FmBWWgrgP/kmtmK6qHUJpdEdMn7KFPnVsLY2Iolj9iXoNRftw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIhGoBL3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIhGoBL3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB42BC32781;
	Tue, 25 Jun 2024 12:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719319828;
	bh=L5xtqFVDiZaCKJfj5SW1NcLLl4c2Xws2Tab+OdEmFpU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GIhGoBL3EeSJOBD62YchqgZWAviBhkSz4SQaPAJdIzVGFNpGSMQEXPRG0TnyAgEiA
	 qwKVlxQUSCsxdbKsmk2O80DG5wugeQ3LfDo2Vh5XXIjiFiLaQSbVQGnLyo0WSXy2vD
	 Utz72FAS0oT5Pmck8cEOLkilAfCGNJq3hHIxJEDiHlYD+eWfj2hnrwyNggD3yVsz8L
	 yXuHzr3bFKSlCU47Ck3dND9lTZlThE8gFS1W0GTtiukO/jXK/UcBJSk0SodDGoSGWm
	 e6dlNgB2Zn8ZH7FcqdO8IfFm5D7pGNFM3hTkJ2G+PDPFai2apmnLXG2+ZPhhXjHuI6
	 K+rDAvqRA1uaA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B829AC54BD4;
	Tue, 25 Jun 2024 12:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] hog-lib: Fix passing wrong parameters to
 bt_uhid_get_report_reply
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171931982875.28840.16944816176250751419.git-patchwork-notify@kernel.org>
Date: Tue, 25 Jun 2024 12:50:28 +0000
References: <20240624201324.3891633-1-luiz.dentz@gmail.com>
In-Reply-To: <20240624201324.3891633-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 24 Jun 2024 16:13:24 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The parameters of bt_uhid_get_report_reply are number followed by
> status, not status followed by number, so the order needs to be
> swapped.
> 
> Fixes: https://github.com/bluez/bluez/issues/880
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] hog-lib: Fix passing wrong parameters to bt_uhid_get_report_reply
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5ebaeab4164f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


