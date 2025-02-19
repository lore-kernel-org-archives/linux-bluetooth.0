Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F98235347
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Feb 2025 20:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997003; cv=none; b=XdLHVYugdBNjTa8cVt1UktZleoWWJgPWf8QfB9Cvp+9kDZK0XTfAtFcjA5Aj9mbVgdn/FFXU9HnCu0a/KNRvYdaUqPbJazQm+pTT8/G01bIxorqTVGgC0mOkfJ3opi7lCxFK8TwffvRDSgC6xFU2GG+nAudXFCcvPUaplhsCZF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997003; c=relaxed/simple;
	bh=datHZfcUybw33+imLyEbpOJGWwB2CvFA6N6e9zUjvR8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XcYqS4YgXg22af+D0lM7v3oOXpin6vQHlqObcd3HvJNIe9TxMD6f2jI6WsJDMjj8x3N7wUkOzDUvrIeCDSJMzPK1MEAdFzsCxfQ+44/vvrSst39AyrAvsfH+JjT712CO4CgHYHxfulXqDQ8pAbCn1wf50N1PERzTt+3bFj6UpXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUJNxwh1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUJNxwh1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F1C7C4CEDD;
	Wed, 19 Feb 2025 20:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739997002;
	bh=datHZfcUybw33+imLyEbpOJGWwB2CvFA6N6e9zUjvR8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YUJNxwh1rmHYbnmxQr35QqC5mzPIjyZhknj9CFWXL1i53eCI6z1lusfMDmaQEhUdB
	 f+KIPpaVYbzWAb0hQj9NAJKwoHSlf+Bpkw1I3D3sC4RmcrCGr5ZM00T3k4yWoQS1GR
	 Cf3vDCh+qSDy6XScpksE4NK3ymaASRp0bQNhBBLaZ5xl7+YSmkreNqabYRc/g5f2F/
	 Ecg4S+4rr5RTmPMC2Q1oNmQuf+lostGS+AJfK5xPLx7fmphmwmPuW0GbAbgg2vqY7g
	 HqKKtuv1wpOE+LLyVbPHrwrL6NrX/Yp7j1VLfGQXZGucKFZO7oufag9oVDieTXupdZ
	 ryXh3H5tkHm1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34FE8380AAE9;
	Wed, 19 Feb 2025 20:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] shared/vcp: fix setting volume back to current value
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173999703300.735166.15893100926640358870.git-patchwork-notify@kernel.org>
Date: Wed, 19 Feb 2025 20:30:33 +0000
References: <11cdbf4619d9eda9cd40c84728a2f5cc87d42d2e.1739720857.git.pav@iki.fi>
In-Reply-To: <11cdbf4619d9eda9cd40c84728a2f5cc87d42d2e.1739720857.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 16 Feb 2025 17:48:54 +0200 you wrote:
> If there is a volume change request in flight, always update pending
> volume. Otherwise, setting the value back to old value before
> notification arrives, is wrongly ignored.
> 
> Fixes: e77884accdb2 ("shared/vcp: have only one volume change in flight at a time")
> ---
>  src/shared/vcp.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [BlueZ] shared/vcp: fix setting volume back to current value
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=65fbc47143a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


