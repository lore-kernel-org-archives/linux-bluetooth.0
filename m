Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80662219A9B
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 17:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755191998; cv=none; b=PrrVkDrQV0nCddSsjAx3ozk2Z+p1qtN2LUkz4+HOiB2cArapTJAq2Vta1iahgTItXEeBtzdD/OzJIIRmny4BkUw56/rMC1Fm8pINp3xDH2EAWM8VYjqV0YK6BdPb7E71FP53vkdx05Poglscw2eiW8leRdkGb7qJLH6/7YijZxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755191998; c=relaxed/simple;
	bh=i+1UjDq7zr/7TbI8iLbYeFlsLOJIeU/dvMSQse9dt5w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=myFUY5FRs3tWB6DpnsNboC+Jw3JKeH66+haajzhQ1YVNJ/Jph4lmvJOnbWWAs6mMe7XTu37XSHzYk8IEcc18EBk7vlFwtDTgEiYcOwQAz//gAWVjlNp/vWxQljT1H5UdYseilQzgf/Py9LNPDnIIpIhLm+fUE0OYPRdOB8k3s/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgGFdzX2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgGFdzX2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17114C4CEED;
	Thu, 14 Aug 2025 17:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755191998;
	bh=i+1UjDq7zr/7TbI8iLbYeFlsLOJIeU/dvMSQse9dt5w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jgGFdzX2Mr3M8P2pAB4Pzz0QsqTGTYRuY1aGvyHbp1UCcpOHKcOtLuw/DD19ObVLw
	 16/8mWJ//4vaZPWsuvlnD5Z+ziXeKCZtbUEqjDSdmpAcFg3yhhxFlPA04nfPvxL2Rh
	 8cZs/A21IqqPa9OixSetgotvHTcHVpmc1BUN+gEo3SQwGcjg+bO6xJVrPSFIId7Ype
	 Zp8goqmYKocX4k9BKzxa9SjhN9iMvOhPzQ2P8x2O54yPQXTvtkBreMUXKsbP7li/N3
	 oNYL6ndUgyWZaV79Mdi7bsj1uvcpKqB3UQTgY7Gfi24APJmd7IYKsuwolT5sMdS0bp
	 0uoL1xlFuG3HA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEA339D0C97;
	Thu, 14 Aug 2025 17:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] monitor: Print unacked frame when releasing them
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175519200950.380512.10064199577915217402.git-patchwork-notify@kernel.org>
Date: Thu, 14 Aug 2025 17:20:09 +0000
References: <20250814154156.8221-1-luiz.dentz@gmail.com>
In-Reply-To: <20250814154156.8221-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 14 Aug 2025 11:41:56 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This attempts to print the frame number of frames considered unacked
> (missing NOCP):
> 
> > HCI Event: Disconnect Complete (0x05) plen 4
>         Status: Success (0x00)
>         Handle: 2304 Address: XX:XX:XX:XX:XX:XX
>         Reason: Connection Terminated By Local Host (0x16)
>         [0]#102132 unacked
>         [1]#102137 unacked
>         [2]#102139 unacked
>         [3]#102141 unacked
>         [4]#102143 unacked
>         [5]#102145 unacked
>         [6]#102147 unacked
>         [7]#102150 unacked
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] monitor: Print unacked frame when releasing them
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ce82168f9f70

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


