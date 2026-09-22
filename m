Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3040F55293C
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 15:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089277; cv=none; b=fUdb8WjkxRNYpMRTdG524aPdHzEgkZqr6vqVbqpeaYNMEPDrDRKq3uLoloU541WdXNABBJ/+p9wAxmFrWICgpF9aTZkjW+QiTg54bY36iAGvoLSRmj1iiWt4Zu67ElCtgmqWfymxTSECrCvOH8nyrqKQldd8RA0lcU+Rk7ftN8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089277; c=relaxed/simple;
	bh=1Jr2XaEK1o5HJook1ossOeDsQtEbhb1kzRZvIaE0H0o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lw+Mmc8JkR9m3qHUfQtpH2V4nludFyfLmF8ykq/AmXHW1wyO1figZISVLKcnSrr+G1dy1s4Odhe4moD97rNl4in1A1QReazBnNVKZPHZAEVs2eI51SIVYzAijGuGKVePtD1k/R6a58fdvMFkoFuickbQfOADLOf4Y0sMADqcpF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/GT6s4S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/GT6s4S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA4F1F000FF;
	Tue, 22 Sep 2026 15:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790089276;
	bh=3lnkJ++B7jsKtkwZiVScS0d0FY4J/qj7iw1RJKni8lE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=E/GT6s4SM01mhskUdiSL7B7Vu+jvvTad5oVv67BJUSmYTDzQrL6EmKR2asPf95S7E
	 Gx7ynhIP0E9OGe2C4kg1fPUEP+ijAFUMdMLi4uHQFu5fd5J/GEJbN99jCSJPK1Fji/
	 5lWUSYm/b+dMjxtVQ8qs0v2V1T2y7PEmv+4o/7tDsYJRr/i41bF5jxQPgHFIyqVRcv
	 4UBypq9k4VanNJESfiZSW4iLdKuSo/Uz/p/M0VQIpyFoJS3aXgn9FVlPJW1KD9vEIx
	 AENNY6U8mAYmG+O9KTmI6QeyBGwMHC40lBFUs0dj33vqWtkfyjuY2ZMWxfu4NTbAGo
	 bNPAZrfrs3tjg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A123811A4B;
	Tue, 22 Sep 2026 15:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 0/3] Bluetooth: btintel: security fixes
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179008920691.4126096.131663704074702408.git-patchwork-notify@kernel.org>
Date: Tue, 22 Sep 2026 15:00:06 +0000
References: <cover.1790053452.git.chandrashekar.devegowda@intel.com>
In-Reply-To: <cover.1790053452.git.chandrashekar.devegowda@intel.com>
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Cc: linux-bluetooth@vger.kernel.org, chethan.tumkur.narayan@intel.com,
 kiran.k@intel.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 22 Sep 2026 12:10:19 +0530 you wrote:
> Three small, independent fixes found by an internal audit of the Intel
> Bluetooth drivers:
> 
>   1. btintel: bound the "Exception info" print, which reads past a
>      controller-supplied buffer that is not NUL-terminated.
>   2. btintel_pcie: widen plen to u32 so HDR_SIZE + dlen cannot wrap
>      and defeat the RX length check.
>   3. btintel_pcie: reject TX packets larger than the DMA buffer
>      before they reach the memcpy() in the TX submit path.
> 
> [...]

Here is the summary with links:
  - [v1,1/3] Bluetooth: btintel: fix buffer over-read in btintel_hw_error()
    https://git.kernel.org/bluetooth/bluetooth-next/c/4145a13c1a04
  - [v1,2/3] Bluetooth: btintel_pcie: fix plen overflow in btintel_pcie_recv_frame()
    https://git.kernel.org/bluetooth/bluetooth-next/c/6d21e89e6977
  - [v1,3/3] Bluetooth: btintel_pcie: reject oversized TX packets in send_frame()
    https://git.kernel.org/bluetooth/bluetooth-next/c/2b036342b623

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


