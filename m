Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369653A16A1;
	Thu,  6 Aug 2026 19:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786046146; cv=none; b=lbx82gPTCiNOb1kE8XBCnN9cUvb0zU9MztB04+x3oQ3qGzDhbySjMqHAu4563HsNjrwBpV7dMcKGxher7EbPnhoAoqkBoBbLEeXVagDrhsby8TJv2LEv08EvMGkwxergvx/yIV4HVGnfk0VZgs59sfhDa5ZWDLKSQOIR7SITsKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786046146; c=relaxed/simple;
	bh=jeU9ssJV3ZS3OnLPe3SpOEqwNjs+o9rHAnszTRG2DX8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H4dxn6bhvBNb08z5fQg+lt2Qds501k4DyLwcVif1sgbo0RU3p15TydmdsFGyRJWtyVHPRX9wFYFzFKg+2WftPkCz4MfOKTjqB3IdfPXZtwN5Twskm68zfnutQBB0+baprS7Zi5j1iL4VlLoZG96eNs5QPI7MoiTecGwDFOVyjqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBlnPVbN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBlnPVbN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C171F00ACF;
	Thu,  6 Aug 2026 19:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786046140;
	bh=KWxVHzghMt8BrI78Nak9x5lDFLmNssceSE/+Bgd4ank=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SBlnPVbNo8JzYA8EN6sAJcteF1EJh5dS3FeLMWAPATMCkmNm+KAdIcZSYl2sPEIy2
	 YP7FjVSfT7dGfO2YqaxjvPGpLRD0MjvivFJPrHAcQ8YWLNcdF7so042Zdtdmr5lqcB
	 8peLU7H27Wf0z47jj/XEssySxm8cLpQDOyrvOcWtuFHgUeMXJMAkro2umTIU8RJv+H
	 1lC0RJIrx3elO6PodIiYzyPkiVPHQ3JgAU217liBDKWXrDgxp1NiZyd/jcDVIZTiRM
	 Glmu9ZErlJaqeM0W1YY4CiHXp45/kfn5JW2Wc3Xyl6tGFNPT41/sGTX2q8rL0IwX+2
	 C3qTFPlQ5cJCA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199A33809A29;
	Thu,  6 Aug 2026 19:55:01 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bluetooth 0/4] Bluetooth: fix cmd_sync payload lifetimes
 on
 the cancel path
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178604609963.1449574.15912669243758957129.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 19:54:59 +0000
References: <20260806125957.698760-1-lilinmao@kylinos.cn>
In-Reply-To: <20260806125957.698760-1-lilinmao@kylinos.cn>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  6 Aug 2026 20:59:53 +0800 you wrote:
> The cmd_sync worker calls entry->destroy() after running a command, and
> _hci_cmd_sync_cancel_entry() does the same when an entry is cancelled --
> but only if a destroy callback was supplied. Without one it frees the
> work entry and leaves entry->data unreleased.
> 
> These four call sites pass a heap payload with a NULL destroy callback
> and free it inside the sync function instead, so each of them leaks when
> the entry is cancelled rather than run. hci_cmd_sync_clear() cancels
> every pending entry when the controller is unregistered.
> 
> [...]

Here is the summary with links:
  - [1/4] Bluetooth: hci_conn: fix the SCO setup context lifetime
    https://git.kernel.org/bluetooth/bluetooth-next/c/7645e748704a
  - [2/4] Bluetooth: hci_sync: free the advertising instance on the failure and cancel paths
    https://git.kernel.org/bluetooth/bluetooth-next/c/19aa86a8d171
  - [3/4] Bluetooth: MGMT: free the mesh send cancel command when it is cancelled
    https://git.kernel.org/bluetooth/bluetooth-next/c/ac0965fb4b86
  - [4/4] Bluetooth: MGMT: free the HCI command when it is cancelled
    https://git.kernel.org/bluetooth/bluetooth-next/c/f2afd8eadf5d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


