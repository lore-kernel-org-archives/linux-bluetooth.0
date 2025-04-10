Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02191EF37E;
	Thu, 10 Apr 2025 17:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744304997; cv=none; b=rmrOjRpMNfH/NkVNi304HixTWxk2C+Ru0p8pwZvQTHqzK4mdzbYi4o7PHuExHKbpWAcTG4om1OKQILhKi1rvAUtrOh219RLsuzLwoUwnvmQJh5nMPaaUB3ZGXXfvjl7rmOYmqSEIjn+CmDYL4/U9tpwG5VhcD7HcMs/AuSjWCE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744304997; c=relaxed/simple;
	bh=9+nMyQCYKZANlH9EIcmhK3mecsDX2e4WtxOXzOv8sLs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eQS/bRXi6jN5ajlI/EjL/ApCEMX2SScJiftVpUeX7fvf+7HUBIzwlvSc33jwPQXvwqn94y4P4AC6ckB65kIDCgv64+KnStx3AzhvyKFsYieZUtIxOhJkNBUJY2rjyNfBgMY7jeHLQXeluEJOA6zaQUMvvy0I24QHXCMPkUTkdpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZk5/AmH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZk5/AmH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684B2C4CEDD;
	Thu, 10 Apr 2025 17:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744304996;
	bh=9+nMyQCYKZANlH9EIcmhK3mecsDX2e4WtxOXzOv8sLs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GZk5/AmHhSZx4qZ4cR5oBlNTY9g4v0b8aTUWBIA0AZzQ1+oaM+tdnR8eovR8HdQuI
	 b1zaAMTxbRj4czDqNxDqBsV2o5IjltxQH1nNwXO+OkfJvXsbJJg9XwqoTECGj/xU37
	 jAYgC2KP6a7hMMaK5uv0Z6ktUysHCDMS67kDU+ubSxcKd0XuN+nIhsbrtEdz3ErvUF
	 5z0h2IsKZDUpNQGaj1O8urc+Ke6wBkvgSfiNJkopdi7eQPsj8b6dRU9hC/uHgI6n1P
	 5FA+J7yOCErQzdUeCmZmakf816lygwX/fXWKPY5KElbNYWfIiIExAAYjCmC0ak79Sb
	 uOfY3WhZ433kQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34595380CEF4;
	Thu, 10 Apr 2025 17:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] Bluetooth: btmrvl_sdio: Fix wakeup source leaks on device
 unbind
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174430503404.3757803.3784966096528810575.git-patchwork-notify@kernel.org>
Date: Thu, 10 Apr 2025 17:10:34 +0000
References: <20250406201017.47727-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250406201017.47727-1-krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun,  6 Apr 2025 22:10:16 +0200 you wrote:
> Device can be unbound or probe can fail, so driver must also release
> memory for the wakeup source.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/bluetooth/btmrvl_sdio.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [1/2] Bluetooth: btmrvl_sdio: Fix wakeup source leaks on device unbind
    https://git.kernel.org/bluetooth/bluetooth-next/c/e760c4024eae
  - [2/2] Bluetooth: btmtksdio: Fix wakeup source leaks on device unbind
    https://git.kernel.org/bluetooth/bluetooth-next/c/0be454533788

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


