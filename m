Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079B43FDC05;
	Tue, 11 Aug 2026 20:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786479059; cv=none; b=p6cPpaqP0fQWAdlDjCUOft3+j3r9ObXrpVgj8KYy2VMl7Yk6lEskbxHkZwfNYmGvYzCaTrTsespYdvAYgLvqk+ouyW+euNSAzsBFqobWeqbdoTzaiNXWY4UXVzPIIGlGQ8qykAQN9JhkNMS9qHzi9KnT3vJ+Kuo5CeFaU8uoq2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786479059; c=relaxed/simple;
	bh=9a+QKCP0OfWHvvbFdFY6bK5ksJiF2o4NCSjMZeBwjkQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g1FYAxksGEaKeSeTpJLV9fYCunhfFnx2UEjP2q5Z0u70+p7FeGLy5eMjdWLZSxgjafPhFblJcY+BuBMuJ3uw2gPBeNinUE2spjgXnHuv7V/8MEccV0YTpqcg4V+sjo3bi7gVtfWQ1JGqYdmca9MkfFFAQfQQt7IakwmsW/sphnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLOb3V1r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLOb3V1r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A284A1F00A3A;
	Tue, 11 Aug 2026 20:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786479057;
	bh=jJSsAqNBcxyOlNcZ4emtygxRWd3+DT3fYL+n/wjGjcM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LLOb3V1r1rXCxnOGoRV986HL3/my77x/HnGkMy0wS/Q0n/ZFybyOWKWzg16GuVM4c
	 sGw128lMkVekVVGxl+uWVNBb6qtxAjGj4Xb9elVm+JamyGLnPWpgSQ7FeMN8WzsNgZ
	 mUeAIVkL+jI7e8L0Bwj15nT4yFQaSfZCGgKTJfCepy9hgyPSdoUOeZvtq8YzLHfWAw
	 g7auAugGnMiVsdQxOmUaV2buGbbIbMb2ahWaZfrOS4hRcz4WCB4nLmKtTV9YJj8MMz
	 im4b6CdLAe7OzSq8lHvlu0Km6jGbgMWZrJK602pUvdE6EwVElavcImeEN0hWu5e7ix
	 +Y3l9nUNnvKSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A9B3809A0A;
	Tue, 11 Aug 2026 20:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btmtksdio: fix deadlock in close and reset
 paths
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178647901335.1134064.2663051483826196708.git-patchwork-notify@kernel.org>
Date: Tue, 11 Aug 2026 20:10:13 +0000
References: 
 <81B94E6D2ACC0BFD+20260810-btmtksdio-deadlock-fix-v2-1-0eb31f9066d6@uniontech.com>
In-Reply-To: 
 <81B94E6D2ACC0BFD+20260810-btmtksdio-deadlock-fix-v2-1-0eb31f9066d6@uniontech.com>
To: ZhaoJinming <zhaojinming@uniontech.com>
Cc: luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
 marcel@holtmann.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 10 Aug 2026 18:22:38 +0800 you wrote:
> btmtksdio_close() and btmtksdio_reset() call cancel_work_sync() on
> bdev->txrx_work while holding the sdio host lock, which is also acquired
> by btmtksdio_txrx_work().  If txrx_work is queued when close/reset runs,
> a worker thread may start it after the host lock is taken and block in
> sdio_claim_host(), while cancel_work_sync() waits for the work to
> finish.  The host lock is only released after cancel_work_sync()
> returns, so both sides wait forever, deadlocking close/reset.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btmtksdio: fix deadlock in close and reset paths
    https://git.kernel.org/bluetooth/bluetooth-next/c/fca8fe614904

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


