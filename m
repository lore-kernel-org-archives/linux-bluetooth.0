Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC08D76056
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Sep 2024 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727103025; cv=none; b=UgZcvkRVYYxXWOnPzW/XUrSVLOa/lTSAXsoD00EDtwBJRRlkbrbyaUKhu3kabidldQGSbokQbykEsZOhxYNg6PMYfdt25mt+q+F88HaslG4jKQ5QcZwlQb6KD8so4i6Wz6xccUWjKd6smPCwiEBtUhzC12q0yWnpQgfPbvk4Bvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727103025; c=relaxed/simple;
	bh=Yl3i9gXdSM4d15xSBI4ubbFmRvvoDRpGVdSPtLyhIAo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UdPZYL+hO3GupjJxwUlWuJTDl8qSHROJmwJD+qWiCMnXBv60/ALhzuvhT+rMKJfqCQg1ruQCPIznXGs6ZTQPC8Bt6NEFG5ZDrwda/9ebDlIFnCYkeB7TewQMzbcUY5weDc1gmGsyz3ht74rbxG4+m7qbXEWaV+4r0L5fD0o0K+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfwLr25l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfwLr25l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A950C4CEC4;
	Mon, 23 Sep 2024 14:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727103024;
	bh=Yl3i9gXdSM4d15xSBI4ubbFmRvvoDRpGVdSPtLyhIAo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SfwLr25lPPd+9Iq4vclHO9+R10HpO4R6XGXAEMIXbvqdBGtKP4aaK9VLEjusT+7wU
	 kUwskswVZW+8wYcKrnOfsw3NIv5cdl9ksdztbZVo1o3RVYa+QDkV0V8AZJ8OHKe7Ui
	 CbSyyaXd8j2xXFMJvzkI7vcLLZ7ZGl7MVXHrKWZQFCswGLPdDoInBI4WKfSjUB81zC
	 62AFNf1OHz2iSNgPaLb1zNC7rmwIm7BaLXRDgaBvjEpN/AY+5od8P8fOxxvkwK9PfA
	 Wr3ks7b4bLERWDJxcn/WQuY2X+bM5mlix0evslzcUufhxOTWAsjwxdYPlu7SZjfTCo
	 hhap7yZL43pIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD143809A80;
	Mon, 23 Sep 2024 14:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] adapter: Cancel the service authorization when remote is
 disconnected
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172710302676.3378929.9779609352941355170.git-patchwork-notify@kernel.org>
Date: Mon, 23 Sep 2024 14:50:26 +0000
References: <20240922030417.140005-1-quic_chejiang@quicinc.com>
In-Reply-To: <20240922030417.140005-1-quic_chejiang@quicinc.com>
To: Cheng Jiang <quic_chejiang@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_jiaymao@quicinc.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 22 Sep 2024 11:04:17 +0800 you wrote:
> If the remote device drops the connection before DUT confirm the
> service authorization, the DUT still must wait for service
> authorization timeout before processing future request.
> 
> Cancel the service authorization request when connection is dropped.
> ---
>  src/adapter.c | 44 ++++++++++++++++++++++++--------------------
>  src/adapter.h |  2 ++
>  src/device.c  |  3 +++
>  3 files changed, 29 insertions(+), 20 deletions(-)

Here is the summary with links:
  - [v3] adapter: Cancel the service authorization when remote is disconnected
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5b6ffe0381e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


