Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793216407;
	b=xvu1Q6hTccYxkv+GVR0mnYJkk+QX1YD7z3w0Pohwx1d0DGyzVQMxdI/IpB7YXFMIVwbD
	 FgpFZioMEce2jJbwB+gH+FishQf32xYT7nVKoCY6A2+3693gfQqTjrPTbYH+siNMgSg6F
	 /tUNAdhfQB9FccT3SlxO+SpukF/uEk7a98dCRNhANiaFqp8HISwN9SzECauP8UD5k/NIn
	 4ne4xbqQ0D8T/T4uAIfmPZ9PBErKay9CevXUxvCPJIa9UidhMnxFQ8z+0FgcrkxHhqWkj
	 MOTe2GDRurqn/r4KHuGQNBzqi/OE4gkrscndkOuQYA+lYnzpHX5owjL5qIm3SR/N/aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793216407;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=ZrXqopOLSxEUJjMcZQ43gj4y8VT4PGUkCNte6NUf4U8=;
	b=w2P1HZScN7bhM3+QMOlcsMJSdi5pycS6EmElXbQD93Wuv9vJVWcT7Otrunro0y8iagCa
	 ewx2ov+HTbyV7qGu3bA98z19k9E8KLKXiB+Oi/wC2Giqtm+vS2Hp/nCaByDXR9Vd6zBu9
	 poW6Z5Jxc+JawTPsqD6YTKFbYbym51VNGrbVzKbfqqA43b87Rsed7spq0M++TsW2n6tcx
	 x1siL+rBVw4eoDpGFW08vvcrHYQOtVpgKolZMxl6IlWaLckAKMsS07P7Q3jKCJHPFNCOm
	 iszhglFNUMWn/YW3YkZ3DnnMGHjHcaTenFTj/v3BhNsOuW8b5rQt7aTlCz0noYRwGXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="VMviZo7/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E1D60A260B
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 19:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VMviZo7/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A0A1F031E3;
	Wed, 28 Oct 2026 19:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793216406;
	bh=ZrXqopOLSxEUJjMcZQ43gj4y8VT4PGUkCNte6NUf4U8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VMviZo7/spwSgwEXi8C+nac8Cgucdn/Kj9oRqcWQIryKjBAzImmigDTj5wNJsA5FR
	 4eXR5BGE9aCUvPNjAmfgBRIN32CcO8ImhqOTCzjGIx8mZSxqhKN+k4HDamXUI1WQqE
	 s9wSX/3+MlYm5qSd5XzQG1PkSJetIskHhuhodrBwpuZsr3kR0qw8m67FinQE0oeNC3
	 HhQ+T5yF4VUHThCtyCjrrAtAUdkyCYuGvjDAjJhTy7HaYefhCUW5bi7eC7tIFP4Kyl
	 zB0jnvYW/+IvwkcZZTuWHkS96bQqBDEBRkW8LFJ7peIkhbxDMfk+7GAL0ODyMJnne1
	 Wn3GP0ub8iROw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BE4FB3AAA76F;
	Wed, 28 Oct 2026 19:40:06 +0000 (UTC)
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
Subject: Re: [PATCH v2] Bluetooth: btintel: check FIPS status before firmware
 download
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179321640558.1390808.2098882383641688916.git-patchwork-notify@kernel.org>
Date: Wed, 28 Oct 2026 19:40:05 +0000
References: <20261027131850.3652839-1-kiran.k@intel.com>
In-Reply-To: <20261027131850.3652839-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, chethan.tumkur.narayan@intel.com,
 chandrashekar.devegowda@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 27 Oct 2026 18:48:50 +0530 you wrote:
> Intel Bluetooth controllers (PCIe and USB) from Scorpius Peak2 onwards,
> except BlazarIW, report bootloader self-test results (CRC, security,
> and patch) in the INTEL_TLV_FIPS_STS TLV of the Intel Read Version
> event. Act on them before firmware download:
> 
>   1. CRC failure      -> abort download.
>   2. Security failure -> abort on USB / HW reset and retry on PCIe.
>   3. Patch failure    -> abort on USB / HW reset and retry on PCIe.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btintel: check FIPS status before firmware download
    https://git.kernel.org/bluetooth/bluetooth-next/c/1081a6ef8f1e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


