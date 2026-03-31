Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA2413D51C
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774967423; cv=none; b=pOucVWHl3BsyIzDGld7C8P7nzLD3lEPPI1X6bgt2e5Ev/rKO4gVmnjfFVV2pxM8ku5tmXDdlDyqwZB1QPUkoOe70Ow2K+AiUaEdrTM9MEpZG43bYq0/opK0vhrqGpTzPy18RCOpkdeyh9fAemTzkZhTso5NDbfQs1I47BisKlIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774967423; c=relaxed/simple;
	bh=mV5b4qeKSa2+wxOdA/JETLHQbPg+9AzJ2Qtq7ce9OkM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hQ76vHcoFT8IntszA4FdyUPjM3IfLRLLOBkfuN/eLpJ6gaIgkNH5FQDGuJEVIwU8VvQmRlYxQ4YxxgG0fGFUaekQGVGNiJ/N78oCMvWXrBxCd891TujXEa18DsW9KeQi9LL+fjfO11x0/ZG7tCfr+za+N9PcZn+NllWgmiEdRpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0qiXupG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0qiXupG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3467AC19424;
	Tue, 31 Mar 2026 14:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774967423;
	bh=mV5b4qeKSa2+wxOdA/JETLHQbPg+9AzJ2Qtq7ce9OkM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m0qiXupGJv+c2Kh/5RF6SzyEW46qZ1EwEp9u6w8LoXO4NjU1h3w/Q+vJM8rZ6OkD9
	 DROwWcOSLqZjukaAuZYrKqANB/mqEqpN6w5EZ357nkReV15p/tgKeGBX9HlTQgff4R
	 ZtX26wRLMkle4AQlo+PdO+DZzktWdgBf5RSdwj0nDSuP9xyRtIAMuqoMVUzKPQiAjl
	 BaVlR/5oEKCI70OGoksfH8YKzWHOLjYk+Tpt6lpOiH1plw/9nlWZzagKwsTbhJmIbY
	 GFrmtocNcnN+zuwmqvu7qj6pItXIzYV00lANwK9dl7L2R/5Lenebl8jBJ+hJLP42ce
	 +oBu2+nIsVTAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C973809A05;
	Tue, 31 Mar 2026 14:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: hci_event: fix potential UAF in
 hci_le_remote_conn_param_req_evt
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177496740678.2731558.6481712395779908532.git-patchwork-notify@kernel.org>
Date: Tue, 31 Mar 2026 14:30:06 +0000
References: 
 <17828eea9008f1b9e03c7e234fbf6be4ca9f8f91.1774787574.git.pav@iki.fi>
In-Reply-To: 
 <17828eea9008f1b9e03c7e234fbf6be4ca9f8f91.1774787574.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 29 Mar 2026 16:43:02 +0300 you wrote:
> hci_conn lookup and field access must be covered by hdev lock in
> hci_le_remote_conn_param_req_evt, otherwise it's possible it is freed
> concurrently.
> 
> Extend the hci_dev_lock critical section to cover all conn usage.
> 
> Fixes: 95118dd4edfec ("Bluetooth: hci_event: Use of a function table to handle LE subevents")
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: hci_event: fix potential UAF in hci_le_remote_conn_param_req_evt
    https://git.kernel.org/bluetooth/bluetooth-next/c/22edb157ba3c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


