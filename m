Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF2A12FF8F;
	Mon,  3 Jun 2024 13:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717419630; cv=none; b=SHEOdhFt87G6S2bFF0uT4y72aqi8bZfBBeKOfaQAHY//dozqEa25zflMPGuOVlkIO1zH37KPSqzzjP7RrjRheNDhGTC5R9A2pRaJpaDtuLNPu5Fq5YKBp6GDKBoquy2WGIXhM8jzsjoUZtNNZHppyx2FWn3ecamH4cYLPtKVMfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717419630; c=relaxed/simple;
	bh=VNKgUSfzKmIN8sW92eU0450tuP/32atN00WNWDD8y2k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pdyGqpLY9912Mhvsc0OafeA7ujXrAM0xJVEX5eVmYtTsgNV76mYqiBFxRRBp7/EHX9oSyLkdnTTlKoCAw7Gl34tDQrnGAO5dGqoT7Msd171CoDDnWvWxJfAVPFQFSsj185+OeE4oFVjjspeu62VoPvKn2DTFufdNlgqcBqKmop8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqYcJM1Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqYcJM1Q"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D550C4AF0A;
	Mon,  3 Jun 2024 13:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717419630;
	bh=VNKgUSfzKmIN8sW92eU0450tuP/32atN00WNWDD8y2k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FqYcJM1QGwKunAzolLm03wuXOmYhUmXeaGNXhQljHhYgoy2BtBjGSjjofwYXReY9F
	 hYZtTaA103Io1ebvw4QQEiiVn4sMcw7ySx/kpUl7laWrtYF0uxRtfkt+F3jWMVMnPU
	 u5N644UcPPinA2rpZtmEXCeEsmQAVmvgAQw7Fo8DroBag7XYV+lk6FEpidbF4Ii04O
	 o4CfYcVQRvzE90RbEdZQWLjZ7Ttz4K27qz35dPZR0C+BvSGcyd7tQvK3v3mi4y/+6Q
	 lCDIOoZnfbtDl2njGvItlPAai2gEepjyWkx3DecNzABTNTTmHDFwlTporWp5yBkRxO
	 Cw6S20wVaKVTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 208A2C59A4C;
	Mon,  3 Jun 2024 13:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: iso: remove unused struct 'iso_list_data'
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171741963012.17349.10173582992476486602.git-patchwork-notify@kernel.org>
Date: Mon, 03 Jun 2024 13:00:30 +0000
References: <20240531232614.302215-1-linux@treblig.org>
In-Reply-To: <20240531232614.302215-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat,  1 Jun 2024 00:26:14 +0100 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'iso_list_data' has been unused since the original
> commit ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type").
> 
> Remove it.
> 
> [...]

Here is the summary with links:
  - Bluetooth: iso: remove unused struct 'iso_list_data'
    https://git.kernel.org/bluetooth/bluetooth-next/c/d8b6a4e3ad78

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


