Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CA5356773
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 18:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781116812; cv=none; b=iHwHr2iNe1uHy7ka8lObO70OlYk7P38rWsZ4iUbUoOZb6UZAz9+GhoCpCrz98akaxUW9F6jO2t5HQYzCgAO0UdbnyvTMj9EqUL0D+8ViP1RGJzOW/SjZKV/VgttN3sCWPIzKBNN1fKKvUGgVcNeBSLrj2uq6THglNS9TyX0XX7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781116812; c=relaxed/simple;
	bh=ZtioOipYp1g6Eb56s+v6aFrZl2oG/ZRmGLOtZm4LWqk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qESp9g/pY/r4rRoZOh1h6rSGwMph5j4R1B4SWtH39v8IHnD8xlS3MtLRa1dK9Dk8vixWqZi6FYsZZYOHIKX7NFm87vg7085jKUsLaW/fRnZIoCkZkwpdQc8Bl0/+6UCpzFAvjU534mQqNjGH6JrCUE0MUpvX9F7u8osUq7mrxCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIdz7TLn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIdz7TLn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0691F00899;
	Wed, 10 Jun 2026 18:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781116811;
	bh=z8xmG1te6Zs2+hyVoIYx5uqrho7e40hNSN9nNtu9gS0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DIdz7TLn5ik7QI5DheiEaoSJpmmutUm7Fmygx8CBdFH3WBOoYAV/5sSbMd3xXo6FN
	 lSHue7S8XxAdGRAERUGiBfKbLWt5mhL/zJ8pjRTcTie9qp4oTdzpXQ36C9IBQ59KG2
	 Vf135MYyPzqK+K+ruUfETa9QMGzwxjVxtf/ufRVloT5hjzcDLgrmrS/wLDnMcJBXZc
	 Cj82+OUwXQ/BcF8lSbuUsZ6VYt1pTAK1AEqPBFz+eZ0fhqAk+Fausayy1oYRYQOAbW
	 iR+0zNv3u/5BvZHd+SDfiwu9qL/iPEnWaOFXhN5zbc3dLBUy1/gRJ5C9wlPgrJtMEg
	 nOwV67qECiT/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939203930DEB;
	Wed, 10 Jun 2026 18:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] avrcp: Abort continuing response on fragmented CT
 replies
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178111680913.3588149.12989657974958763377.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 18:40:09 +0000
References: <20260609212656.3900190-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20260609212656.3900190-1-simon.mikuda@streamunlimited.com>
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  9 Jun 2026 23:26:56 +0200 you wrote:
> Send AbortContinuingResponse when a Get Element Attributes reply
> arrives fragmented, as the CT side does not reassemble fragments.
> 
> Fixes PTS test AVRCP/CT/RCR/BV-03-C
> ---
>  profiles/audio/avrcp.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)

Here is the summary with links:
  - [BlueZ] avrcp: Abort continuing response on fragmented CT replies
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=249e2bedfacf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


