Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD939E567
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 14:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712846383; cv=none; b=WxxMPO9Nd/yF3WHqc2Z79u8VFPr2FE9P3OUWDSTyvuW4CLk5ssPPYe4r7/UA8nLIf3KcvtgV3qcnw+Q+gkgyByvF0WPd9Zu0mdzhzQl/rppOILbX8AkFTTWXoznC4IcuxyrFPTDy0OAB8P9ss1xEUb4ydv/xVM3uMdYSv26QdAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712846383; c=relaxed/simple;
	bh=/G9F22GLxBImnccCBrpfKxClX++u9MHAGT/YPI+EgdY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UagXwJq18RKTCPCkOvuNqS4mpoHkH2HXabtO4/LvxUeaOWhyZMiZGb7QyMwhfTeWe67tlBZzYlVBII2teOHacvqg6+rTlUKyx2qJmGqSBjj7VHrKymmDwEYV9GUuahJsKfTO3uzZ0fOREUjh8Yy7YanVKfQKwE7Eo4s9nfq6LAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXeP4fhc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXeP4fhc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C587C072AA;
	Thu, 11 Apr 2024 14:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712846383;
	bh=/G9F22GLxBImnccCBrpfKxClX++u9MHAGT/YPI+EgdY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hXeP4fhcogkTRJp+PVRkyd38DDtQNAMulegJ128fPiihSmrJvS4RLq4epbvteWPzP
	 1ohxp2W7/yztcoHOE7HFEGamOuo0IKC2AE8LHLg8DMAMGkuMEHcTcgobc8Ha7VZ+AD
	 n8sMHtctyAciN9/A6AnNB2uDd/+/O2LBZd7drOZgwCuv82Hmrac4BVo9ZH43UpInY7
	 rGjYfj/NX+pP4co4pX0woH1fT2T4hQ+XJk+mPuRNAZSeCtim8u5YpPjBH7HP0bdLbW
	 gNfPePESHfYcEwZIgKLm2X1MJcDXymo87UMal+dnSzV9lGKxLu07xMY0E1c4vpaSrx
	 YwNL17+jkr1nA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 37FA6C4339F;
	Thu, 11 Apr 2024 14:39:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 RESEND] Bluetooth: btusb: Fix triggering coredump
 implementation for QCA
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171284638322.18150.7773628914846691694.git-patchwork-notify@kernel.org>
Date: Thu, 11 Apr 2024 14:39:43 +0000
References: <1711354309-27605-1-git-send-email-quic_zijuhu@quicinc.com>
In-Reply-To: <1711354309-27605-1-git-send-email-quic_zijuhu@quicinc.com>
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org, linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 25 Mar 2024 16:11:49 +0800 you wrote:
> btusb_coredump_qca() uses __hci_cmd_sync() to send a vendor-specific
> command to trigger firmware coredump, but the command does not
> have any event as its sync response, so it is not suitable to use
> __hci_cmd_sync(), fixed by using __hci_cmd_send().
> 
> Fixes: 20981ce2d5a5 ("Bluetooth: btusb: Add WCN6855 devcoredump support")
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> [...]

Here is the summary with links:
  - [v2,RESEND] Bluetooth: btusb: Fix triggering coredump implementation for QCA
    https://git.kernel.org/bluetooth/bluetooth-next/c/e00fc2700a3f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


