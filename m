Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C64A4E36C6;
	Fri,  9 Oct 2026 14:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791555622; cv=none; b=Bs4FUxL8p1CZduJr+NNzq8v44GfjWcGmvGcQSsqk5dNBS5Fy4SElfLGaCTvRK54BSo4fs4E+rz9jjXfCjy4Jo/Osfp7PI5mha4QvnViyRJy+9JwfoNNlfHkPshMl7qG2dSzRmHUYu311ImEv7FWh1fB68D1sGrEy/Nvtr6ET+HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791555622; c=relaxed/simple;
	bh=FvfAGvyPVson4CBUuc8Wj1Q99/0b3J0JtzQGTHXgW14=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D/PBWzb6nTV+KmzUug3a7SCrW1KAdnj0bR/yNfOa/8ngEyyC+tLiO7CTQVWAYFEcky16FSedUZ7YhQHwXJ3L+o6t/Lbt4AYenDIMrEzgRasyjsWnaB6k/VLdV/YdzPHXRsJ8hgnnKMxygWUWuCWEkB3q3CfcGunMYBrplMjpSMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUug6/81; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUug6/81"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082C91F0089B;
	Fri,  9 Oct 2026 14:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791555609;
	bh=TSzLnejUKSxrQhuFU859msNyigKXKCSPMc5oNobtJAg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=aUug6/81Pd3UKYFr4UroI1xuBnarAWQA2PvHFq7q8kufz870C/m+InK4gNSL2qwjB
	 Sj1OC1AORs6amI+cDsGgDCTV6GRQ5AnJHFFNNatfQ/5P0EzH9/b3VcfwIbalKslPHx
	 /6k3objsdXOTlX6v4J+Ij6yrgEAen3JmDY2w6AGb3kLrRBzLlH2NyZsHkvn8S73HLv
	 wjeAz2edfQ53UbFQi1MwU+xpUTj1aH8Q78WLX4+gFlJNI3uyTGDDHRip3hlEUkv/k2
	 b62VrPuxXsEfO3CUXiLKF/zjM9VlnD3fK4s2l2opkVYtyYmrd3oxJeK5lyqCT54AUj
	 pI3NLVKYPUTuA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F157539253CC;
	Fri,  9 Oct 2026 14:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: 6lowpan: Drain RCU readers on registration
 failure
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179155560751.812174.8668330528853448667.git-patchwork-notify@kernel.org>
Date: Fri, 09 Oct 2026 14:20:07 +0000
References: 
 <pm-bluetooth-objects-candidate-0230-v4-fd2c82b141a5bc3c5841@gmail.com>
In-Reply-To: 
 <pm-bluetooth-objects-candidate-0230-v4-fd2c82b141a5bc3c5841@gmail.com>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, jjzuming@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  8 Oct 2026 12:11:35 +0800 you wrote:
> A lowpan_btle_dev is embedded in its net_device allocation and must
> remain alive until readers of bt_6lowpan_devices have left their RCU
> sections. setup_netdev() publishes it before registration, but its
> error path only unlinks it before calling free_netdev().
> 
> If a second controller's registration fails while multicast is sent
> on an existing 6LoWPAN interface, send_mcast_pkt() can already have
> selected the new entry. It reads entry->netdev before checking which
> interface owns it. An early failure, such as allocating the device's
> name node, leaves NETREG_UNINITIALIZED, so free_netdev() releases the
> storage immediately.
> 
> [...]

Here is the summary with links:
  - Bluetooth: 6lowpan: Drain RCU readers on registration failure
    https://git.kernel.org/bluetooth/bluetooth-next/c/f664d75735b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


