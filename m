Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5873402422;
	Tue, 11 Aug 2026 20:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786479079; cv=none; b=LMkK9I3+fL9z8j3Lsda2U7mqusgjEITQu0fBvPxrzD9pORgqgIMcaV4pjGvBrSjMdNmFRrsuZPy+XZ3uJedCwS2v4ZxCTALC+PHvDu3gAogDZuw+6X+gGdUFWK4t/JaEwdm2u/WTXyKPkFXoMykKmzRw7CY5BtXol+pJnCIl0p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786479079; c=relaxed/simple;
	bh=MQOjBf7afpIB8skuBLJzOZF3JOxBlDy/S0UpuoI8xGI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eRQo8wsITJ1RzOx/ig+/66GHADPMhP/yiYkr4Mz1TXjckRzwjEB027zFEiSiFDTMhyzgCZRD9lcjG9/cOgTPutTFWF+QnbLFJvdb7L/lQwv9go4gXEPtruZbMATNvVLnu2te0E/y3AjamieBYcfv3q8bmLnlmjmgGbgh7bsMTTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRkZmq5a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRkZmq5a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9331F000E9;
	Tue, 11 Aug 2026 20:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786479071;
	bh=sIpoHlKIdNeH0k247FWKc4VIxs/1wEco+RqHn3SjVCI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=iRkZmq5akQE41+03QnpWMZxY8NS3D1/rO4sFAjcIEm9/Jc7wM7re5LfRGQ5sf8kKo
	 0qaDsr7JaXi3vn5/PxJUqfNAczkL06PQx7BMczn+O2bwOXftx600AwSG/y7sSk+/xt
	 w3Cy1bKX+/J+J0W/5HC/VZMjHYLiDHErBbv1QNt7Hhcz2Wh5rMcZhHIJa0xdTnZbVV
	 GTEZdTCpXiVE50oa7+3JGmFqJrmtpSlhpy2QJWtXWwY+SmLep1aKghid7uvX6wms/F
	 j2Uhozk/DE3pBP3l52iUhbNEM/HBuZbSc4QR81aWD6kdGZ1RfoicjWNfNv7R2woHpU
	 OmYf1qB7j5gqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09C13809A0A;
	Tue, 11 Aug 2026 20:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: virtio_bt: Fix use-after-free and memory leak
 in probe error paths
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178647902738.1134064.8343131189969253325.git-patchwork-notify@kernel.org>
Date: Tue, 11 Aug 2026 20:10:27 +0000
References: 
 <20260811-virtio-bt-fix-probe-errors-v1-1-2f1acfde8336@uniontech.com>
In-Reply-To: 
 <20260811-virtio-bt-fix-probe-errors-v1-1-2f1acfde8336@uniontech.com>
To: ZhaoJinming <zhaojinming@uniontech.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 11 Aug 2026 16:47:37 +0800 you wrote:
> When virtbt_open_vdev() fails in virtbt_probe(), hci_free_dev(hdev) is
> called without first calling hci_unregister_dev(hdev). Since
> hci_register_dev() already succeeded, the HCI device remains registered
> while its memory is freed, leading to a use-after-free when accessed
> via sysfs or HCI sockets.
> 
> Additionally, the probe function leaks the virtio_bluetooth structure
> (vbt) in several error paths:
>   - When virtio_find_vqs() fails, vbt is not freed.
>   - When hci_alloc_dev() or hci_register_dev() fails, vbt is not freed.
>   - When virtbt_open_vdev() fails, vbt is not freed.
> 
> [...]

Here is the summary with links:
  - Bluetooth: virtio_bt: Fix use-after-free and memory leak in probe error paths
    https://git.kernel.org/bluetooth/bluetooth-next/c/444612a87229

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


