Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA7B1607B9
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jul 2024 17:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719855028; cv=none; b=UqqWXP5Nq+GNVcoFGVlzu02xgwyde0LlJaBV9TGLokxUtWm+BLPmkI/wNxGwc5z+4eRZidrTZE2C6cli9u8eA2t7OFB/ylqkF5Gfkk7Ia/wOmTxHQevHYX3b01SD6YKCMao49n5DNy6B+q33RAFQ+t4gHqfAGIBdVsvIj/N4mMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719855028; c=relaxed/simple;
	bh=4BazE1h8if5oEqfKj6lBpBvAzLfQ5ct2Lw5pmYDeRfc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DvipqCaTHVbotXvizuE+/9veDKtMNSTr6n/3JPXHpysVppnsH5xe1TQI/QSB1eYaUPv4BnUMk/j+ULxW5GtSIoTNadSMTOLKpmjToK0+gxOIwoT8tb2gXfXbsILu1FoKDsNj6Ed78CWRL/jhfBRalMnXdGexjbBLLjIwbuxk6e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6yRtna1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6yRtna1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 613D2C32781;
	Mon,  1 Jul 2024 17:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719855028;
	bh=4BazE1h8if5oEqfKj6lBpBvAzLfQ5ct2Lw5pmYDeRfc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q6yRtna1H9kzN/JoILaOUBjKJKdBvaSJFLE3oxLeyBPtyN5XNMeMHdfCE7ADMTtNb
	 YnwFzAIboPVKk8cqgaLHD5AS0z/E+7dAH66kZld3+ossiCESWuXeCCBdy1MAvXPq4a
	 mWJAYgbsCRLcfiVWxWTXuyr1fagUiNhj3JSWQJKsrEc+tPT21cwSDL5FrpgKvkNrdj
	 +O883yFnz1d3TRk11kP5WAbVt5OAq+qf+Mg87Vb5ES+IjFmizzLvSi0dtn7siAM0db
	 psmMBqGADFGJyQLFJxPVxlg5ZkqBvEQ0OCBjc58Xqhzd5d9oCYCEtX7NneEhyfm4TM
	 RW65GrkqnspUQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4C8DDC4333A;
	Mon,  1 Jul 2024 17:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: Fix usage of __hci_cmd_sync_status
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171985502831.17789.4944550770901204148.git-patchwork-notify@kernel.org>
Date: Mon, 01 Jul 2024 17:30:28 +0000
References: <20240701161100.1317685-1-luiz.dentz@gmail.com>
In-Reply-To: <20240701161100.1317685-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  1 Jul 2024 12:11:00 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> __hci_cmd_sync_status shall only be used if hci_req_sync_lock is _not_
> required which is not the case of hci_dev_cmd so it needs to use
> hci_cmd_sync_status which uses hci_req_sync_lock internally.
> 
> Fixes: 6851d11d389c ("Bluetooth: Fix double free in hci_req_sync_complete")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: Fix usage of __hci_cmd_sync_status
    https://git.kernel.org/bluetooth/bluetooth-next/c/7b256038ca7c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


