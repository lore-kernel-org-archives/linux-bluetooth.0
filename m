Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B26F57C9F;
	Wed,  7 Jan 2026 16:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767802411; cv=none; b=kjZnPrHwNMejVmehQyYIen5fGoPt9h2VlLA+J89kas2xs1ks8jsWydya/MOf61vumdvWmHxHhk8hzPUiCrbEg/pKuJwCVGlL6CNv+O7HvpvdOQL9yuU/ujsn0mTXUVgponUrFRqAScONvnUUoq0MnsR6Ry8yLr3sh7qVFkaTl3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767802411; c=relaxed/simple;
	bh=V6gOIwm6342c3yGry2Km7WcUIa+wggiZSRjxm1m4kH0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OsF/iZkWQ8EFcu03qllod0JIjStFNtdkRmrM8JjqpmXXTyOvmEK4Lpo9jUX+aWFSrplV1kjT+GVUKTqXtdSNQcuEWBX0kIFdKROd6yKqo+lejN3rvNSIaQNmwdlXJ+zfPXNmzTKnAApN7zcoFHpo/PSAH2YOtxA8QyhHTW5/W2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pSVLkPWy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSVLkPWy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6BBC4CEF1;
	Wed,  7 Jan 2026 16:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767802410;
	bh=V6gOIwm6342c3yGry2Km7WcUIa+wggiZSRjxm1m4kH0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pSVLkPWyq181bjmei9mV3jcKVcCkhfPr6Q+XNX+olX9OZNKXmDSbAdWuEkAtaav/a
	 7+f0EtUPvtFmob4+y1ZqEtuwyDw9ifQ1+1HpPZ5GZU+hb5PD48V+HJDOpJpUTXYbhl
	 g2Kevn/mbO1aPQ2mcH3TstT5svdHmoBdioP90a5Ys0VfLf2z8uES5r+Rotl+qwc+0y
	 7BTuoNlsopHOdEFU4ZjqH00xBou0l3EOKxtwI/ZbfAO1aZ37vHtH3/wjw29ioSVH0E
	 KLblXckqouMDP0S84Q/7kG9hQBBvVFjinAGH5KgrDejaR/zCHcfRgXUi8SnHdsBfIM
	 k+5KktAg1l8qw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9576839FEB7C;
	Wed,  7 Jan 2026 16:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_sync: enable PA Sync Lost event
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176780220752.2838947.769832971851801138.git-patchwork-notify@kernel.org>
Date: Wed, 07 Jan 2026 16:10:07 +0000
References: <20251219-enable_pa_sync_lost_mask-v1-1-2769917f44e2@amlogic.com>
In-Reply-To: <20251219-enable_pa_sync_lost_mask-v1-1-2769917f44e2@amlogic.com>
To: Yang Li <yang.li@amlogic.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 19 Dec 2025 10:43:09 +0800 you wrote:
> From: Yang Li <yang.li@amlogic.com>
> 
> Enable the PA Sync Lost event mask to ensure
> PA sync loss is properly reported and handled.
> 
> Fixes 59e5396a2579 ("Bluetooth: hci_event: Fix not handling PA Sync Lost event")
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_sync: enable PA Sync Lost event
    https://git.kernel.org/bluetooth/bluetooth-next/c/3d57712f01eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


