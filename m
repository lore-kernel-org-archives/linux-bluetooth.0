Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6201DB940
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Dec 2024 22:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733179816; cv=none; b=Zfo2amhNOaR9arhtwDjbfbKLfOCHQCcQm0a7mTPjzbiQ94UU5QAV3act2MZRdtfQetj1AlWsGgZkqyaYmRUaZC338KC4gDJ1nOumVwFaCfbmmUQI4dgKFYXYP8sLd5Ys0YwYuomGKhK+ygywFwy+sEQntdXvuXDTC2mqtVJxMw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733179816; c=relaxed/simple;
	bh=W3Wl1bXWOrPMB4ic/ab+uVn2vg4WaeoScydRq9MUlrg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ErZY/2giCfCjxB7hOeNMTjn+7kUVc/M0n367B+HzSFbeiMRZz5kpOm/AqKZS6ToRz05rgszdlKScevvRUHEZikgX0KtO/j3MbBWBW0CKDazTLy+upXvMsV/+9MRAvAlw+i1wk62YcH+6+nCBDzh43rFUhDrl8TDk/0Xr1epaXZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qnZKNMrz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnZKNMrz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E82C4CED2;
	Mon,  2 Dec 2024 22:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733179815;
	bh=W3Wl1bXWOrPMB4ic/ab+uVn2vg4WaeoScydRq9MUlrg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qnZKNMrzUeVlv9+6L8guLwkbiFjtyEE2Aj452kUNrgV+ZKExUu2II86lsMQIvboC1
	 AQgGkOddfrNUz1hvsfdRbhGaKbjA27bx+qfBJDVvJwdlTQEtoODRPDZ+5Cqymy3LJI
	 Ln2OyUO8vVkVulhYF/Ye4TAZlnDInSyfLAWJiMSUpaflWQridM1OJKe3tbHahl9VhX
	 y42KyLYFIJnb/4q4/GishpulvmDxwePKNFTbuc/lu6fAj2S93nUV72PVDp7E45avj6
	 GSYfErxydfSGxdh27qnFdGcuaQOUTAV7O73xyakavolyKiu4eT5dY7ChmYucf8ATdP
	 rXailb3seey1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F153806656;
	Mon,  2 Dec 2024 22:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/2] iso-tester: Add test for ISO Broadcaster Receiver
 Defer Reconnect
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173317983002.3919304.8302027415594883551.git-patchwork-notify@kernel.org>
Date: Mon, 02 Dec 2024 22:50:30 +0000
References: <20241128160101.15187-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20241128160101.15187-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, andrei.istodorescu@nxp.com,
 luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 28 Nov 2024 18:00:59 +0200 you wrote:
> This adds a test for a Broadcast Receiver terminating BIG sync and
> re-establishing it, while keeping PA sync alive:
> 
> ISO Broadcaster Receiver Defer Reconnect - Success
> 
> This depends on the kernel support added in
> https://patchwork.kernel.org/project/bluetooth/patch/20241128155405.14910-2-iulia.tanasescu@nxp.com/
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/2] btdev: Unlink local BIS before removing
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7d84f84cf41c
  - [BlueZ,2/2] iso-tester: Add test for ISO Broadcaster Receiver Defer Reconnect
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=756d69fd3db8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


