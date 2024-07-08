Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C891B81211
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jul 2024 21:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720473633; cv=none; b=d2M0kiEs9TMje/y+M1cdMZ/2SUSgSJNvQYREC2PB76+f45pM/oz75SK/sIZrPh/tV9WfBeO2TqqIW2xekEUMY39TiWBViQX1/PV56K0Bvw3RA0Cd9RMD6t9J2csUpgGARCF9wZqo/CKTU2v0B9b+gY9xZIQ7DtZ8ajsd/Doo+1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720473633; c=relaxed/simple;
	bh=IPcu77YcJep6JHerJs6iIRFvR417omQ6llLXxRwLLtM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hBoFLuUUbHiiFS0yWOu2+s0RPYPEjfSHXLnsFr5/A70Fhrn8JENb22WjqRF6d/nDupT+qewWYqe1XJxiDLjxGhAujd9a0qSgSsDbXq8r/diTitb7LuLdzFlEgyznfQcEbiVnhCRqLSgb+Tqlb8xS4faBAJX1kvN6JluNZnSdZ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLR2xOls; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLR2xOls"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A1F8C4AF0B;
	Mon,  8 Jul 2024 21:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720473633;
	bh=IPcu77YcJep6JHerJs6iIRFvR417omQ6llLXxRwLLtM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LLR2xOls5ZJnv2xkvq02Ll4KREIjzsPaUgYruN0zjY2D3khL5riiGIYv06/REXuZt
	 vmpU0RySp74O1WEzcCqK6h0pVN3rqH8g9yk9KbepTfNma0Q8zon7ztP2E5hD1yt1m1
	 7GOxP9zLpyJNbwsFGg2cIthpBvKk1ASekagOavILhb5ddtqp0TCbsbi/cm8kAEXKdI
	 rcRPNsO6pxJGd6M8m1CoaOjivOxPO0daIcSxcDFOxW/d2kuBd63wCx42+fHcKPVqiP
	 To6LeAEt7Votp+jkC0PByYoPtV1egwZYYElI4T5JAfWAwDyIg/ArQRG9gpfvwZT5gC
	 p4CSy5vN7GUtA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6BB64C433E9;
	Mon,  8 Jul 2024 21:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/5] Bluetooth: hci_core: Remove usage of hci_req_sync
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172047363343.9973.6453226407273005982.git-patchwork-notify@kernel.org>
Date: Mon, 08 Jul 2024 21:20:33 +0000
References: <20240702191157.1722089-1-luiz.dentz@gmail.com>
In-Reply-To: <20240702191157.1722089-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  2 Jul 2024 15:11:53 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> hci_request functions are considered deprecated so this replaces the
> usage of hci_req_sync with hci_inquiry_sync.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v2,1/5] Bluetooth: hci_core: Remove usage of hci_req_sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/ca90ffabe5a0
  - [v2,2/5] Bluetooth: hci_core: Don't use hci_prepare_cmd
    https://git.kernel.org/bluetooth/bluetooth-next/c/cac754c132f9
  - [v2,3/5] Bluetooth: hci_sync: Move handling of interleave_scan
    https://git.kernel.org/bluetooth/bluetooth-next/c/a7ba3b143b9b
  - [v2,4/5] Bluetooth: hci_sync: Remove remaining dependencies of hci_request
    https://git.kernel.org/bluetooth/bluetooth-next/c/25f60b6ca512
  - [v2,5/5] Bluetooth: Remove hci_request.{c,h}
    https://git.kernel.org/bluetooth/bluetooth-next/c/46de0fe98f5e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


