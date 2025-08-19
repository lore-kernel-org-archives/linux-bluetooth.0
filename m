Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09FA25F973
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Aug 2025 14:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755613796; cv=none; b=hS0/8YTa6OAm5bio8h1jgVad0NkZktSfV9o5QasxUZxAIndpNpOFdo5Te/Wpo67ipd9O+dF8PH9+xmopLbQk/YntyTEM8K+jfBYmMKTsHvPAR5uaayp4XdKUZ87eN6eoMsipxgCo1zltJEHF28Jcsda2CmFmVTUPJP2ruAGEuvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755613796; c=relaxed/simple;
	bh=zuAU7JiBi8KHHlZ/pg/OU7b6z+yoa7HjQgru1OPlfJQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PPsOp4e2AE68E/qiarMAuzymrxv0+duDigJnBWdr3c5j8TYGUCGPVzbiMJzw3ggCA0Akq+chp1MYKEXLCsm9L7CMRxwYmJm8xoMHvcNo6RDpwrlByxBRZrj+9UpYcf+V55ydub8l7Q8Vmmq/uExmL5H2bOkxkVxjObGi4LP+HVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWFSr8pp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWFSr8pp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE64C113CF;
	Tue, 19 Aug 2025 14:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755613796;
	bh=zuAU7JiBi8KHHlZ/pg/OU7b6z+yoa7HjQgru1OPlfJQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EWFSr8ppFgNURmNy0s7BJnn9lr6bOQi0VaQ0Y2KU4rHxAgPGwNS4HFOdSdj/l9BQn
	 8aDaa3r0UGHS1SwP1ftcCl7Lc5uuyeYFmC6RLOUtA0YIWJhpkN2Y46Z69QXIFTTI3G
	 wfHJGwApIFxCFkk9wJplaFBEBDmJ/t45ofINPEHPisStfuppe0WdUaQwHF1jitnlHI
	 FbRCcj9TqC242CK+IeQlbuW35EMbiqDioPutm7JS5U7XmuC+j4wmSJGwFU/ixuCQun
	 OdmTqgH3AhFaAzvyWa/H8R38nzY+d+kGthPoDKpB58hunAphnrkMm4LQ9wSBPrkg97
	 dGJOKb7q06NEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D0B383BF58;
	Tue, 19 Aug 2025 14:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] Bluetooth: hci_event: Fix connection state issues
 during suspend/resume
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175561380625.3572360.2079025948323464029.git-patchwork-notify@kernel.org>
Date: Tue, 19 Aug 2025 14:30:06 +0000
References: <20250812155527.995119-1-ludovico.denittis@collabora.com>
In-Reply-To: <20250812155527.995119-1-ludovico.denittis@collabora.com>
To: Ludovico de Nittis <ludovico.denittis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 12 Aug 2025 17:55:25 +0200 you wrote:
> This patch series addresses connection state synchronization issues
> between the Bluetooth controller and kernel during suspend/resume cycles.
> 
> The problem seems to be visible when using devices that very quickly try
> to send multiple reconnect events without waiting enough for the host
> to fully resume from suspend.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] Bluetooth: hci_event: Treat UNKNOWN_CONN_ID on disconnect as success
    https://git.kernel.org/bluetooth/bluetooth-next/c/f6305e06185a
  - [v2,2/2] Bluetooth: hci_event: Mark connection as closed during suspend disconnect
    https://git.kernel.org/bluetooth/bluetooth-next/c/e090ee03a6ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


