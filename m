Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B8E3EE1C4
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 11:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782472615; cv=none; b=qqrZh+QuKloqG2cV3a7Umb3xzACoBqvVF9lqn8Yq0TJoFbJW172xLXatsdhhVzSg1oX7i+EVw/mZvmml298EA4D2EjdyIuJSbOPUMZdILF2kegICk5A1GAf7Z5JRswjeJAzNJQukHB0+/hIrBh8kGxbEsmcx+PzmUbxpa39Yp4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782472615; c=relaxed/simple;
	bh=v+TndBZy5KnThowX1GfESG7diSQw+1p4LSlkVLcZDXM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UdmP5SAeuwETgc4faqaDcfFdtohRTqtUqQ/bGb6whru7WCbkuTIhCOtRhNmJKUF8T3GLe6PuCz7z4iPgVJLiU2xw7i5X7/3PBfhou8u4CRudV1fZpLRa6UBJdUdxSRJeIL9QJ0/SPPc5YtU5BNzyc2XgntwhlCV38poR4ML3kXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9VShxZ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9VShxZ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FBF71F00A3E;
	Fri, 26 Jun 2026 11:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782472614;
	bh=safwV2MfulnkRlfMP8iFK9usMXmxvNwXCvWJlTx2ybU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=M9VShxZ4A+KuLHCFxx6lA1S/Cys57dns0zv8RbYIGnmAUSXeYFPMZf/tJXMLiQGkB
	 sjcMYXUs3kZisWxspgOikkl2RHUdKNgj7Sl0SmMUbv5klYmz7Qy7i9r0Ycsx8pBZOv
	 2W4FP9T2zrxTCCmL1LGmTweIR8Gxj6KFZfookttBTmSn/rzrhBQFoygJ9z2n3v0H5j
	 zxl9SPPYaJ+4C8SQa1U2wQhSJluvfQ1k5fx9h83DbGcZ6D0qSEoaPYcXZrwb2ckRaR
	 51XB9bFLR/MdK5MPtyrDTlrIxk9BywP7t6rAwP27KJ3YSryQWe9Z+juHKlhyeDj/tX
	 43/6wvvoRtK1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56CB739389EE;
	Fri, 26 Jun 2026 11:16:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Add IMC Networks MT7922 device
 0x13d3:0x3625
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178247260103.3816447.1706941256221118720.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 11:16:41 +0000
References: <20260623114937.6385-1-monesss315@gmail.com>
In-Reply-To: <20260623114937.6385-1-monesss315@gmail.com>
To: Gustavo Evgucci <monesss315@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 23 Jun 2026 14:49:37 +0300 you wrote:
> From: Gustavo Evgucci <monesss315@gmail.com>
> 
> The IMC Networks MT7922 Bluetooth adapter with USB ID 13d3:3625 is not
> recognized as a MediaTek device because it is missing from the btusb
> device ID table. As a result, btmtk firmware loading is never triggered
> and the HCI reset command times out with -ETIMEDOUT.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: Add IMC Networks MT7922 device 0x13d3:0x3625
    https://git.kernel.org/bluetooth/bluetooth-next/c/ddd25808d4c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


