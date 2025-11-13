Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D03E35B156
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 16:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763050247; cv=none; b=j44bZZM0RbAW4dit5IqnmsvV0FwQjZtpIPPUV8b78e8IIeSvFVIvhXzmzJ+mg1NyMU2XB7jVoSttm5LhL7gggUInh3DTlNfdfbgas8w9Ois1bmvEzbqbjwowsRQdRjxmjsoSm4p9V9NvvOb5HZg/j9RE5vBO8n47cikS5/1HUic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763050247; c=relaxed/simple;
	bh=WR9HldCywjVTTfLslfnk+ZuFTaWnUV3zFmd7IDVQGOE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Tl0THZyZwLs/59td0hhHaPhfGHn9kR4Ba/oa/nDoRxnA/5fqiT/OwNYsXF8Xe42Rr4q9kOHgUXrrYGKiHbWQwdJ/iFxR+AUM1Iixjz8RcvTSds5CajmtzowQfYZ507AzMja3uN62UUYT0i3rSwcvugpEOf/xmHwr4pmfFo1W0KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rXtFC24j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXtFC24j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21570C4CEF1;
	Thu, 13 Nov 2025 16:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763050246;
	bh=WR9HldCywjVTTfLslfnk+ZuFTaWnUV3zFmd7IDVQGOE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rXtFC24j9r5e9zCRLPxjczIUAYBriPB6oVIJcjYNqknL24LzXEpH7VCYNhqO2x+tB
	 T6ZxRYL4o92kZGIANARobMbwfxTqYZUouinYOxIRB1KNOMlfqDHv58bDyrSXAnsxZU
	 /62sR5vdUn3NiyCjQt/rGJ0cPRDOuVd6KkpZqZItmuJ/T1UbSQM6TkXnOKC55mz40g
	 VOkrqM79Xt5Oxe0eHoPW49GZYGUpu6oi2rGNjZWOebSfHOcrJ075UZmM+1yKnJ1NHZ
	 tXjUVT2ekVrYnAVDiFR9R5/7sx2wbTiBBhafclvqwP3Vm0XmtYTWxd9ZQ9kimA3Z6E
	 CXEv+5X3nrbnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71391380DBD2;
	Thu, 13 Nov 2025 16:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: hci_core: Fix triggering cmd_timer for
 HCI_OP_NOP
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176305021524.908070.8065577142674388282.git-patchwork-notify@kernel.org>
Date: Thu, 13 Nov 2025 16:10:15 +0000
References: <20251113151224.2598720-1-luiz.dentz@gmail.com>
In-Reply-To: <20251113151224.2598720-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 13 Nov 2025 10:12:24 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> HCI_OP_NOP means no command was actually sent so there is no point in
> triggering cmd_timer which may cause a hdev->reset in the process since
> it is assumed that the controller is stuck processing a command.
> 
> Fixes: e2d471b7806b ("Bluetooth: ISO: Fix not using SID from adv report")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: hci_core: Fix triggering cmd_timer for HCI_OP_NOP
    https://git.kernel.org/bluetooth/bluetooth-next/c/486a25d25a4b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


