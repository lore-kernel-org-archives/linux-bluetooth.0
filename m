Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CCE344045;
	Fri, 24 Oct 2025 17:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761327028; cv=none; b=OcZ1EK9uiF5T5RL0Q5u/96IpYxqquGfrA6YcvNNqdfz9V3lG5qlALi9VsDlpBxoQ0Eh5gnp3C7BHoR3fEi57MM2wQWlAoJI45T+wygddzzPpA0CPF2Z7Jr7FmzYe2EptHJdKjrj65f+I8K49Cpg6zB+1ZJHGNycF97DdZkLMy10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761327028; c=relaxed/simple;
	bh=drm/TfgoPBtAPCtcEc+4TmIotN9G0M9XeP/tAhy85r0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ltSAGR0UBUiXhScZFSjtBcbNNLQ6XkMFFFU/1tUZCuplncb4Xtvrh6RrL7wT856fmJ//SjoWHdxQshjCIbFvbJYw9e1cH6B5IDvWHVYVI4WigkAXNmcFCjakx5JwAPrS91JMTQK3Pb9Hhrd4oBPzh2CoUv2muQO3FiU0FG+1rTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6WKWomU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6WKWomU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0812C4CEF7;
	Fri, 24 Oct 2025 17:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761327027;
	bh=drm/TfgoPBtAPCtcEc+4TmIotN9G0M9XeP/tAhy85r0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t6WKWomUXQSVoOppq5JV2QVxiKGC3RT8AEHiidqOozt/awzht3mOFMYqTtvtOtKvn
	 JJcCwyDZNqmkguuO7yZAZl9xL5AbsMwioWzBdpXg5IP9h43tBWwwhKCduIkPbtyj4f
	 Q2nYrOf/q7iRV89r/dM6ziO9ZCPck9eyGbJZHnJ97aUZAyt4bXal3qnXPHwVnnugib
	 y5yXIuHbYuqbWDpQ0DZDYYQVO2zfqDmgwPxAsR//7bj6RSutmC6zr+XhAGpF+tcMSC
	 HUS6M7+A1Hd3dekYBdn6HwzTCyyx52uEAZxiBgPpJEgMjXO3g77k0521gAPv24xF1Y
	 cOtCcLwn2o6mg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFBF380AA4A;
	Fri, 24 Oct 2025 17:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: hci_event: validate skb length for unknown
 CC
 opcode
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176132700750.4002741.10364505901519162594.git-patchwork-notify@kernel.org>
Date: Fri, 24 Oct 2025 17:30:07 +0000
References: <20251024162912.221224-2-rpthibeault@gmail.com>
In-Reply-To: <20251024162912.221224-2-rpthibeault@gmail.com>
To: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+a9a4bedfca6aa9d7fa24@syzkaller.appspotmail.com,
 linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com, khalid@kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 24 Oct 2025 12:29:10 -0400 you wrote:
> In hci_cmd_complete_evt(), if the command complete event has an unknown
> opcode, we assume the first byte of the remaining skb->data contains the
> return status. However, parameter data has previously been pulled in
> hci_event_func(), which may leave the skb empty. If so, using skb->data[0]
> for the return status uses un-init memory.
> 
> The fix is to check skb->len before using skb->data.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: hci_event: validate skb length for unknown CC opcode
    https://git.kernel.org/bluetooth/bluetooth-next/c/a91f1b634866

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


