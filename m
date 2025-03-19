Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1837D17A2F0
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Mar 2025 19:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742414399; cv=none; b=OwEG/xZCaPf4KcK3nJwpNqaD18ngEf7oxP7GGE44uuN5A/yFXDPTGtLrmfk6Y7vsTjYYCHSyc8E5LlJ2jn1Qf3Ryzfwjx3+rFcuYdK1vqgbBCltzkIOoxGWy/r0K1k3J0ZzVXX3tuNRtEUTTEpemaGEspYZJoDyv5YJUejJ7AnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742414399; c=relaxed/simple;
	bh=I6bhRdGLBjD0m9d3i/sNwETr/RfYNEHojBiXyFzpId0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pJ+Do5w0boPGW/RBiZPO8Uo8BjF0D/6OwFezP8WrCK2lchbwuKKZcgjYNnxkwLbu+P9JOUtRjNcUN9QXyqmGAVxelkvRM7Q9AC9eHnPBYwgyPvOMzwwTXNWXxGhjFoVxV1WmFjsmsx3eaR/IpkQrphkcNB7bPx7K04qJCExPzEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5CTVmJo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5CTVmJo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D323C4CEE4;
	Wed, 19 Mar 2025 19:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742414398;
	bh=I6bhRdGLBjD0m9d3i/sNwETr/RfYNEHojBiXyFzpId0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f5CTVmJozqDfdk67rx9wLZ6jms49KsB9jWfaRPfwp9fWGb8PHl7p6M3z6okGqk+vH
	 Gpc3eLqYLEPazD2/HQ2xzL1dBaKnFIvo2vClF6crZATDvY+46vOVQgEyoVoOn2LGdR
	 0+zgMEaMIbf/j+IcG4q0HR0TEYyAE7bfl/ploWWgCiXOrzZHxkJt7Y55JrEn83wE+l
	 ycXToGtmBNDecoHOPUSi9M1IxWkguqtUm+KcV+uNU9CyxkLvTmvIb6c9bMogh4R/6/
	 sJkurVqu8zhm4kjOWOEJJHYSXSZFFR2g/BbcosuQArepaDeuNoZfJHlesB/j6xgJnW
	 hM3CU2dNvEnxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FDD3806654;
	Wed, 19 Mar 2025 20:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] profiles/avrcp: Fix AVRCP PDU parameters length don't
 match
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174241443400.1175967.3093241329997633774.git-patchwork-notify@kernel.org>
Date: Wed, 19 Mar 2025 20:00:34 +0000
References: <20250319121112.166754-1-frederic.danis@collabora.com>
In-Reply-To: <20250319121112.166754-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 19 Mar 2025 13:11:12 +0100 you wrote:
> This is required for passing PTS test case AVRCP/TG/VLH/BI-01-C
> (To verify the behavior of the TG receiving an invalid SetAbsoluteVolume
> command).
> ---
>  profiles/audio/avrcp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ] profiles/avrcp: Fix AVRCP PDU parameters length don't match
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e88f914ea700

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


