Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793830827;
	b=RdpsOyzrxIaQz1DvBEmZStSUKZ6HhUHLynpI6S/VkZAXWJgRGANbhIxEy/TDhlcTEfNR
	 aOIHy4jntTSF+5yOkLJOVFeduLJZeBOKayz3x5ueR0OFPXuZcI9aHMjOcnnE1U1dmdJPv
	 I64DxZ302l0DSHVJWjmdxfbizyf//Mdvj4mtrzJnUM8PYi9+8xFagKH9D0GADoX4azsLJ
	 VHlPzbaPRmFFlCbFo6j/FGh3MOqByrywu7U3kC83IDbDxclO92QFEOGZIjUGU9BpuOy61
	 l9fIoc68EfJ0uBqj+zAuR5W0b9KpPdE2JSnhUom674//6nuXEF76C5JXkkIrYGC8YZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793830827;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=k8m1ft/HEsASnyAsoytyRld6KpMVlVnsxyzHUrDxgJw=;
	b=I3deg45DZ/+DJyzlPeYXKW524h4Iwj4k+b0vBwVMSszZbSk+aGUEmws9DuMn14ggCpV/
	 7w9NEwyZ55KQagu1qp8TjbfWtKG1vgy/VnFNnu8RhLr5HNcNMk1vqG+w0NBZOtY9kW9kq
	 T9hztANG1OcHPoyRaFHuuqFU8eNnF4UCWmlSdTAfJpNETJvPTy4vFR+5TcRzmqrbrRkHY
	 BkvpACoaOakiCmTI10M7l+u4+D42LA/SNDua9LOOxVz5KyV7ZzIOtOsq6qM8gDAHxMks0
	 +FW7Ob4xP14IXlAQUAXiPmQxggXA8YXuTf7PEUmXQUfpeoOranYEv8bPmLNIvnd38gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VAe2ARzv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4227D606B2E0;
	Wed,  4 Nov 2026 22:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VAe2ARzv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AFA31F00A1F;
	Wed,  4 Nov 2026 22:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793830827;
	bh=k8m1ft/HEsASnyAsoytyRld6KpMVlVnsxyzHUrDxgJw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VAe2ARzvufSZ6HOGmOxqG7T+J3uWTaHL/FeXzcnAKtSCLrKEe0GTAidU0rw8scOIU
	 GNa/GgKmS5JRJwZCFREDII3E83Q3tiLs+pP5sa68l30OnfHQ7xAuDhOpaZSgT9uVPi
	 FVCHdiy23ydpcyj/8RoUrFsA06AOK5aQ1Af9hPppmJUhIpkE3HbD3kUeyiXCUKtP8d
	 rjNi80OHNPCdtjpNl4NBtbG9xqlqodhv4njdeF4sTm0wI7mYmhOth5hC7cnfHNpv25
	 7NLzGaRy96H6U4hDlQdgWvHw+0xCS3galGAofXZ6OIVlZddU9WWbXFPCCZeHoFwBR3
	 WQTZHVXCN66rw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 031B838003E1;
	Wed,  4 Nov 2026 22:20:27 +0000 (UTC)
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
Subject: Re: [PATCH] Bluetooth: qca: Disable SoC debug logging for WCN3950
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179383082559.3253812.14222626454934978611.git-patchwork-notify@kernel.org>
Date: Wed, 04 Nov 2026 22:20:25 +0000
References: <20261103103414.803861-1-valorcool@gmail.com>
In-Reply-To: <20261103103414.803861-1-valorcool@gmail.com>
To: Stanislavs Nilovs <valorcool@gmail.com>
Cc: brgl@kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  3 Nov 2026 12:34:14 +0200 you wrote:
> Added WCN3950 module to the switch-case to disable SoC debug packets.
> 
> Fixes: 590deccf4c06 ("Bluetooth: hci_qca: Disable SoC debug logging for WCN3991")
> Signed-off-by: Stanislavs Nilovs <valorcool@gmail.com>
> ---
>  drivers/bluetooth/btqca.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - Bluetooth: qca: Disable SoC debug logging for WCN3950
    https://git.kernel.org/bluetooth/bluetooth-next/c/d97b618b6675

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


