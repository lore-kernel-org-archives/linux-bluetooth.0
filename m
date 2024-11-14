Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FAB1CD02
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Nov 2024 18:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731609619; cv=none; b=ZSrjtgIWr2QxJxqU9exw3FId3VyM3ThAbqDySiswDfLG/ZIUXHPjziAH6UVa+A3UOzSUrknq6trgd+DyvI8GZiWVJDe/y5ZOAjPSOrfKwAiazSHVY33f+Sr0TcfFbEf+sexuhpO/QhLTVWBGlf/8aRrvBB/ot//7Kh5z5rzMCns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731609619; c=relaxed/simple;
	bh=I6UeUMQ1nwLJGr9Mu6xDfaIsg4YAXlkVoHdyr6wns64=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EdwQe1g98FrQomuu4F0pTZ47dJQ8TqHh7DxpFFTYZRELYLpJ5caaykKrJSppIayeqloWsm1lHsB1Y2DHOj6+n3KDJhTWiIOQCBTLe1r5HGB/VcFKW4Z7dRrfbz3R8QGCUXQMmBYxtSMaNjZbk0Y8EhtmLtCx4zBZRTlOsrVSj8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCjtWW/J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCjtWW/J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665C9C4CECD;
	Thu, 14 Nov 2024 18:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731609618;
	bh=I6UeUMQ1nwLJGr9Mu6xDfaIsg4YAXlkVoHdyr6wns64=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HCjtWW/JcBfOFnrStBsFewDbM04xTAf7ztb4n6V4/llm+UrGhcVXMe3t6kJbcC6IE
	 6r7SCKAMx2hTNGCsQsUurS/+JL0WuIihavuRLbWoEK+uWvS++Ergyhsd/pHUY9Ra0r
	 YgmzbL2iahBeN/6wcsoRgrVwLul1HBZJucgUy0FhY9ROFWg2o+jqlQ6tJtnyJpBvXe
	 cH+cQTHRnxSSgMFkiBFvL4n0tcp7yg8tNfe82usNA/JzPjpDjA/Ff9OYBEVDcCml9w
	 lc2ThPtoFbWejT4vVW8Z46UEWVO8K377h0aUvV97CGxsPRw+bo4pM7TO4L/hMdISEA
	 h43wOJzOy4+SA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A983809A80;
	Thu, 14 Nov 2024 18:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: fix use-after-free in device_for_each_child()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173160962900.2019184.18095453937305231783.git-patchwork-notify@kernel.org>
Date: Thu, 14 Nov 2024 18:40:29 +0000
References: <20241113160949.1325502-1-luiz.dentz@gmail.com>
In-Reply-To: <20241113160949.1325502-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 13 Nov 2024 11:09:49 -0500 you wrote:
> From: Dmitry Antipov <dmantipov@yandex.ru>
> 
> Syzbot has reported the following KASAN splat:
> 
> BUG: KASAN: slab-use-after-free in device_for_each_child+0x18f/0x1a0
> Read of size 8 at addr ffff88801f605308 by task kbnepd bnep0/4980
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: fix use-after-free in device_for_each_child()
    https://git.kernel.org/bluetooth/bluetooth-next/c/29186974d7f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


