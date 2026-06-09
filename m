Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9501F4C8E
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018423; cv=none; b=U+oSSVYSJsLXmreZ8TDvcAOSAAmVArprP1KrtUhRbEQ8m4F78digOTFcMx571sl8E5PXmFLOh5yU3V8FcvOIpcDxUNbhEoj4LAuK38SxKnmaMQUvUcRdUDYlTIFCjWGzM+NmG2oRnVGKkAtAb0z+/16Pwe38A2lIZQYOBT+XKkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018423; c=relaxed/simple;
	bh=hyC2SN8JLbQaKdYHVhV5PRhFyBnW+nDH6hITwVDuWXs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iG1DVh8P+L2HrY5q4+nqLmujZ6+eT37fygfCs155z5gTGZVRcYjkYm7WTXmVkCN0FKzEfrhItrK6ZmdkhAmedHi2ENkwDBP/le4RRh+MpIXvCigSl4VrYOPGy2KOc74LQGyR7nYBcg/qCSHLEVHr+rlry9Ui2A9cnM2dGcSSXbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZE97w3V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZE97w3V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0275F1F00893;
	Tue,  9 Jun 2026 15:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781018422;
	bh=prprYiraCMHPQ0CnZGqu4XRb2cjmagEXYMM5NDv+b50=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NZE97w3V/v+1gZqm55n7FClAKIa84rUhx1QKic9yzIvGPE+PSYKQPei13X8RzCeQu
	 RTLIGBBHxzIWzrIyUmzOY1aqpvyliDfg7LKFp4ng3k8iJXP0BNX3IR/Df4PceYVjEG
	 hsnOnDGkvyxPqUACdGUDor2zUAjwZngcSCRjNzK7nBBDXmPSrDfVxoZBvO3LQCxNFr
	 pC7QsFQWA4e7B8RKi8X5Uxfv+73WYauxIbFlk3rWzPRG+GoHrCdZ/3sV77j27bZAmg
	 Jclflg1mptRw95TYP7lGyg7Wc/jSIcO2S83Rawtn59dZFw3ef+JAIFoDvPM8mHDNeQ
	 WNorY3dqRtp3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939A33930901;
	Tue,  9 Jun 2026 15:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] shared/hci: Avoid redundant BPF filter
 updates
 on duplicate events
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178101842013.2087958.16375442136756190126.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jun 2026 15:20:20 +0000
References: <20260608205009.97585-1-luiz.dentz@gmail.com>
In-Reply-To: <20260608205009.97585-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  8 Jun 2026 16:50:08 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Skip updating the BPF socket filter in bt_hci_register and
> bt_hci_register_subevent when the event/subevent is already
> registered, since it is already part of the filter.
> 
> Similarly, skip updating the filter in bt_hci_unregister and
> bt_hci_unregister_subevent when other handlers for the same
> event/subevent still remain in the queue.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/2] shared/hci: Avoid redundant BPF filter updates on duplicate events
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=27eb493882ae
  - [BlueZ,v1,2/2] shared/hci: Debounce SO_ATTACH_FILTER with timeout_add(0)
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9320e1cb4749

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


