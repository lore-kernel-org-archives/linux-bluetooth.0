Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794428410;
	b=GQIwnbaxeSj6MJqzk1UEZAez1U4kAUg/2P35764UO4iHKrSZ+Y4wXnig0slT7/rNkZDW
	 sfzsj6WYBNeizUs+ZFKXIoY7UEW92lcP2EhIt9HccD80andmurDRzuoyOJvojbbBs7P9z
	 0LpeyNcsQZRG4LbR0YtkdKoQZTVLJfp2DhLeGzUyYOi0hMzc2Wzys1zkQdRnG79CmRDre
	 1RfpljSyk+ZDlRaYHe4Ibyh1O/UDQhkieBUAsTfG7qqm+tRPn7dvuTntSzOfUZTySYkSS
	 BPGUZVgk69KP9d13euh6d9ZOUACHAkF1zG5KfCokDicH8OkZwC5MpXLJ6GorG+/aIsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794428410;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=FMS46IdSO1trNZAYe6qNxADJ8xUPjgMaYYobGQ/NDPI=;
	b=S6SHEG8skVSYjWsl8p8laUX9gnv3JHsHJ4DYFzC6q59ZHVhVdG3sbuppLSgmTCLvgDAd
	 9CKPb1Qi0ZTCMaUEshkaTyzk/BPojb5MOeo6zu7H3Iu/uXXTC57KgHI9cDlgIkmFzGV+R
	 tEtMtA/rueK0FUuzC8ayph7vxdF3/DcfNEn5wapeJvYmnx8VCt0M95Dk111D+7nor0VFq
	 g6Z/0R8WbbROFvZ4195IN6pgRHoKajoKuJ9Dzmc8vd8Bejeh8HwfFFHKnOqPp0IJ1ZwnF
	 LnEpZwtILReppkH4Qtde7j7PnUhECEun9xNNI2K5CC9wHK6fPz5+TjYa1Nt18VuNeLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QZX6QMtO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8CF606A886;
	Wed, 11 Nov 2026 20:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QZX6QMtO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682B31F00A05;
	Wed, 11 Nov 2026 20:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794428410;
	bh=FMS46IdSO1trNZAYe6qNxADJ8xUPjgMaYYobGQ/NDPI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QZX6QMtO06bZFnaNBGTExPDgFfmnUzzZU/qc6x/4qPboXMAbtPP1wo9br01/v/hRZ
	 7516I/BM1YUhhCuodqfVgN7Wz0QPB95gn2AmywSWS8CVoOX/Vjl2HO9EY7xJk3pUBz
	 XJ5Z1vP5cJYZ/6UdR7W2VXGFt6njoy0Fi65fpMvl0EMv7VnLiT+DTudN/oaDeDc5qh
	 v/R787tn4jle6jF8+5PII98uKJ6ClKyQez0VrdB5otMEfCmb+kdCbhJvwWVdLRVgUr
	 QoFKwViz+WTyZIh8IdyIpt7T3UuHN3x5DfKd+EMIZw4oIQG99jKdOF2CQ6U3BCFNYD
	 xwlhkzv0LJKgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5E058391AF9B;
	Wed, 11 Nov 2026 20:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: SMP: Fail if local and remote public key X
 coords
 match
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179442840892.1623293.2866290567513278884.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 20:20:08 +0000
References: <20261111094518.1359684-1-jlee@suse.com>
In-Reply-To: <20261111094518.1359684-1-jlee@suse.com>
To: Chun-Yi Lee <joeyli.kernel@gmail.com>
Cc: luiz.dentz@gmail.com, linux-kernel@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, jlee@suse.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 11 Nov 2026 17:45:18 +0800 you wrote:
> From: Chun-Yi Lee <jlee@suse.com>
> 
> The commit 6d19628f539f ("Bluetooth: SMP: Fail if remote and local public keys are identical")
>  patch be introduced since v5.13. Looks this patch can handle the
> CVE-2021-37577 issue. However, it only checks if the full 64-byte
> public key (X and Y coordinates) is identical, which is insufficient.
> 
> [...]

Here is the summary with links:
  - Bluetooth: SMP: Fail if local and remote public key X coords match
    https://git.kernel.org/bluetooth/bluetooth-next/c/fd038b82c71b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


