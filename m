Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA10236F8E9;
	Wed, 27 May 2026 20:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779915003; cv=none; b=Vz5+NGzziCv22C4PLZyobReGpIGEfaJRHmYMRz9rVhW6Gd5RAKIOGNULP33n4swAPk4v9q6hI4bUtfhSrB/Ib+vcyjePHQww0Dhhiy3BRkD7IvgFbIlO/sYC9Yn3JYOQoYG4iTiQ8a3lMdiN7JYI8nNNCJuUqxrWQI0BdmskJNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779915003; c=relaxed/simple;
	bh=/62ekGubQTv6pYNmSUXzmcSlQ8HnBM8W6pXkAuWgzmE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g3qD9HxYUZRW1ZJgfvL/50Vdq+grgIl/wKoq/wDaYY6jJDuhG3KeszVvrT/nGWfLIZ/NrF2P6mro+5gQWX9L5rXaDiIEhZd5FNk6n3F8isjKCQEQt4Fv9ZVGdh0WAVLlKtTUO7qlBaR4TvEsdtDi8+VkFcWMVD3202f8c2matd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOtesAOA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOtesAOA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE441F000E9;
	Wed, 27 May 2026 20:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779915002;
	bh=qEBAM9SfO4BIwtvj1THdPP5cofZx8UWHGa09sxvmqf8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jOtesAOAw8MLCPRmUbwdlCQACVUFpohKGNHrai2JsxHng34Ao9B7M+bn6MKlOQ4o6
	 4OrBcQWzZ/9e/qM2BiAX/Lsn0BVCw50s3Vm5kjkgPp0b8isuCLqBIB1srQZk3nNu7i
	 tzARH+lvZvq0ZaZrgkzryT3O0u3VUYu6ZjY2fFPu8SzvJakvR39uRIaVZm+xPQwQO5
	 1ydUimkGf3tKxzwCs1IQJYJZ6Ct4OyHK8wCulBa42PBM8/KHq8xL0WSxZx3MT0uMJN
	 wsgXVj5vmIBAEMVjh0fucdS2vrAd5gG0/9ZVkxMNOFLsA76gHuwozBqPcstHgCtgBR
	 fLy1MWF6Cj+xA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0BC8380CFEF;
	Wed, 27 May 2026 20:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] Bluetooth: ISO: fix UAF in iso_recv_frame
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177991500739.647444.13417496259944971755.git-patchwork-notify@kernel.org>
Date: Wed, 27 May 2026 20:50:07 +0000
References: <20260527045919.39077-1-meatuni001@gmail.com>
In-Reply-To: <20260527045919.39077-1-meatuni001@gmail.com>
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, stable@vger.kernel.org,
 marcel@holtmann.org, luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 27 May 2026 04:59:17 +0000 you wrote:
> iso_recv_frame reads conn->sk under iso_conn_lock but releases the lock
> before using sk, with no reference held. A concurrent iso_sock_kill()
> can free sk in that window, causing use-after-free on sk->sk_state and
> sock_queue_rcv_skb().
> 
> Fix by replacing the bare pointer read with iso_sock_hold(conn), which
> calls sock_hold() while the spinlock is held, atomically elevating the
> refcount before the lock drops. Add a drop_put label so sock_put() is
> called on all exit paths where the hold succeeded.
> 
> [...]

Here is the summary with links:
  - [1/2] Bluetooth: ISO: fix UAF in iso_recv_frame
    https://git.kernel.org/bluetooth/bluetooth-next/c/7e3545cc3d1a
  - [2/2] Bluetooth: ISO: serialize iso_sock_clear_timer with socket lock
    https://git.kernel.org/bluetooth/bluetooth-next/c/7978ae58aafb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


