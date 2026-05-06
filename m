Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE8046AF2F
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 13:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778074259; cv=none; b=r+Tt24NaHoiVc7QBeBRHDmTTUhTb47vxjNz8PiVLZpPDKbtCGZrxmAsbIQC++biZaNdD8ayBgrsAwL+CsIFU+qjh4PjzuJOfEy+sjvNUI4NT+Y1p1xA/eo00+24ei8phIvpVJMMba9oK5mIV2MPGBY1JnRwmVFhHMdtInySgK0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778074259; c=relaxed/simple;
	bh=i3fs0++IBcfh/SGIgyasGg9DG8yR1CLG+32BQ9sUCHU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SM88ElIPMJfV1vnbzAcnaTPhgzW4SUcySTjV+gHQgBxKHnACSSU1zvPY71HmMhPvIPVKi+OWzB8tRbdUcDA1QwaKIC1jf0uc+xE7gKUIS8PVIEaH62cblMMOVeOdGlm5t+3vPWMJebjctNX3vvCy364nvuZJW4MBfKYhMjvN2lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmPzfyA/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmPzfyA/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4920C2BCB8;
	Wed,  6 May 2026 13:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778074258;
	bh=i3fs0++IBcfh/SGIgyasGg9DG8yR1CLG+32BQ9sUCHU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EmPzfyA/MDQ2Y+G5n+u8G2m6DVA7evcjlX78Wgad9YSvbkQFabEdalYMrTy1EjCpM
	 Nj/v+s35OKOApAxJ/UNeKcIHc9q/fafSeN9XBEbWrIVelYVNFm3OcrxPYi9X9yiV8u
	 Lfk8CnC3hsQ029yiLKvOBj9l2OdkjItL0ndUnb8uGuyPs5+reTDxrlZfgQXMk3yVoU
	 ablAJQwgPq3Kt5av9YzxgRkOTaT/VIX2uH8NfYTwg6uOumzqSc4CnrJ3COC2enReLc
	 JP4VuCtx1L80e4SuQ4SLOp/RlMCQJ02RiKvpCwDNdefD0A+2vAcVnDsGVFgcxji56k
	 cF157oMB2/XMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F3E39307BD;
	Wed,  6 May 2026 13:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/4] emulator/vhci: Add debug messages to error
 paths
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177807420855.2587487.15626470778604995731.git-patchwork-notify@kernel.org>
Date: Wed, 06 May 2026 13:30:08 +0000
References: <20260505204719.1348473-1-luiz.dentz@gmail.com>
In-Reply-To: <20260505204719.1348473-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  5 May 2026 16:47:16 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Add debug_callback, debug_destroy and debug_data fields to struct vhci
> so vhci_set_debug stores the callback locally in addition to passing it
> to btdev. Introduce a variadic vhci_debug() helper using util_debug_va
> and add debug messages to the following error paths:
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/4] emulator/vhci: Add debug messages to error paths
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d0d42d034f9f
  - [BlueZ,v1,2/4] emulator/hciemu: Add debug messages to error paths
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d4c965eec4d3
  - [BlueZ,v1,3/4] tools/gap-tester: Enable hciemu debug output
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=164941a6c145
  - [BlueZ,v1,4/4] tools/userchan-tester: Enable hciemu debug output
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e51115ccd4df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


