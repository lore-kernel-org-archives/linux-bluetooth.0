Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F911A00F0
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jul 2025 17:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753811990; cv=none; b=sdzoz6uAaKIX/HUM0EQ0uVHzQmEu7/kl3gQzkg7KdaEh8x72/xtvv/HqNjVHkZ/VFCEizZeqViV3OtwkompwrKpzAaNTJqgxZ5OgJb9kzUlak5+zKs5MyoSzARf9fL9NILKNevg3j06tOGeXmE+FBOjuae/RZ3fFo8sAWGIX3T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753811990; c=relaxed/simple;
	bh=Q6Jvvfc7h9+X30gRuCbJD3qtXpWgvyJXF3aknpWerDg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YFmSOke1KuRvFwH5viwFCSSsxF+UQxdyl4nudm7PYG3N1a5XTKy6tLneSKC0IvbANiB+bipQu8DTVkX5wBPWd0z+ADtfRtg3Z4SX1ktBWGnd1vydsxSo912po4VxxsaaFitkaspfx57+A9SlFlbfzEukDD15/rIfAGiMN8iFs/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WU1atbm4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WU1atbm4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0565C4CEEF;
	Tue, 29 Jul 2025 17:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753811989;
	bh=Q6Jvvfc7h9+X30gRuCbJD3qtXpWgvyJXF3aknpWerDg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WU1atbm4LeekeX4yWxbw6roMKFO1pp8bmCahMYkwA/qVyk4Emp45+ekPzExsRyC7L
	 VZtEHn0eiWDeo4zSWZRrrRnGZ/QOxEN0LwZRxD7kNvlZGoDIud0wJGJFdrmmGg+5dx
	 2s53amfiLArv8TN6BDIGsNLj8/mGwCRuWTwRpLNjKayLe+vyyrsrebuKzJiegfDmp8
	 wMAZaGTQpWI/4NN+gSTztRFoSyidje0WE4/ZOFESsD1NnsYYW9jLLyfJr3YT2CrWnd
	 ryEJrZqVGVHLzPaoueatUhsCUzMepzq24pBRp1P8q+8O3/n6/yQh4DGN9gtV0RZvhi
	 j3GzJ5S59Jl/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D62383BF5F;
	Tue, 29 Jul 2025 18:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/4] Bluetooth: hci_sync: Fix scan state after PA Sync
 has
 been established
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175381200601.1565327.12851414855688463521.git-patchwork-notify@kernel.org>
Date: Tue, 29 Jul 2025 18:00:06 +0000
References: <20250729162453.221656-1-luiz.dentz@gmail.com>
In-Reply-To: <20250729162453.221656-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 29 Jul 2025 12:24:50 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Passive scanning is used to program the address of the peer to be
> synchronized, so once HCI_EV_LE_PA_SYNC_ESTABLISHED is received it
> needs to be updated after clearing HCI_PA_SYNC then call
> hci_update_passive_scan_sync to return it to its original state.
> 
> [...]

Here is the summary with links:
  - [v2,1/4] Bluetooth: hci_sync: Fix scan state after PA Sync has been established
    https://git.kernel.org/bluetooth/bluetooth-next/c/b0d370caf293
  - [v2,2/4] Bluetooth: ISO: Fix getname not returning broadcast fields
    https://git.kernel.org/bluetooth/bluetooth-next/c/8c76f275057b
  - [v2,3/4] Bluetooth: hci_conn: Fix running bis_cleanup for hci_conn->type PA_LINK
    https://git.kernel.org/bluetooth/bluetooth-next/c/11ced36e047b
  - [v2,4/4] Bluetooth: hci_conn: Fix not cleaning up Broadcaster/Broadcast Source
    https://git.kernel.org/bluetooth/bluetooth-next/c/c5080200bb6e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


