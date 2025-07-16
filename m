Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824621531E8;
	Wed, 16 Jul 2025 18:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752692386; cv=none; b=JS3fhp8gJFHm4WG4tjMr251f8f6KlSlYG3W2BEAbtEzR+XdsWqdfLFgz6rG+rjxsvF8LYHpdBwWOe/0TFQKX9QLeah0VEu/YEze+PEX0BJxtHPLKhnOBQThXW0/b4zZNo29YgJZTfuqXstn0MplduKVCBnNVE3HNVvlgFXbZYl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752692386; c=relaxed/simple;
	bh=ilzWyNdx0uAC4CcFaoFtUw8gBdcNq+o4lK/ViNQhbbM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oXNnWMZRWRk8Ks26pwi6aq9Z4CdUVo9Z2hvjeCeNGDdJQAN2tscYwC4bYmiU2HdmJ2Gdjx3coUr91fMavLcUrjZo+U3qsjToCFHmXkbBwIkWbzuOKw/ryUuHGbLtVzuYf3I4iYKMdv47HYYkHXhC53pSZRDBuUoIr7wGGXGGi0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZziudMxs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZziudMxs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32915C4CEF1;
	Wed, 16 Jul 2025 18:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752692386;
	bh=ilzWyNdx0uAC4CcFaoFtUw8gBdcNq+o4lK/ViNQhbbM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZziudMxsAkJWGlfAWbzrffeyAvgzcP4nYqLzqg0/BVPS0/cuEj1tyt61UAjWaJXhr
	 9rMBCuAqorOssJxL3vH/GVXGCB5PBGKqPlS2R1hz3VunWIqq5BKUkq3c/Sw4Td1MPY
	 41LM0fGlgjH1jd2Zv4kDiMvfcQS3MbDj6KPeo8vlFH0/Q1Gil4h4qZuatJG6CELjlQ
	 +eU5xc0kzv3Bi91AzwemPggNdcrXmGhuAzvUv9qeGgUxu/6OFW9P8wwDciwNkF5jSP
	 y+cl9L+04m5Cu24Qt045D+6rCW4We5KOZbdBxeqdZTPsKF3EelJUMNR4I3jJJl232X
	 sQ1W5Af70KUMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCD5383BA33;
	Wed, 16 Jul 2025 19:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] Bluetooth: btusb: Sort WCN6855 device IDs and add one
 more ID
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175269240650.1291922.1087894854405140890.git-patchwork-notify@kernel.org>
Date: Wed, 16 Jul 2025 19:00:06 +0000
References: <20250715-q_newid-v1-0-8a1120c61fc9@oss.qualcomm.com>
In-Reply-To: <20250715-q_newid-v1-0-8a1120c61fc9@oss.qualcomm.com>
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, zijun_hu@icloud.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zijun.Hu@oss.qualcomm.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 15 Jul 2025 07:27:06 -0700 you wrote:
> This patch series is to:
> 1) Sort WCN6855 device IDs by VID and PID
> 2) Add one more WCN6855 device ID
> 
> Signed-off-by: Zijun Hu <Zijun.Hu@oss.qualcomm.com>
> ---
> Zijun Hu (2):
>       Bluetooth: btusb: Sort WCN6855 device IDs by VID and PID
>       Bluetooth: btusb: Add one more ID 0x28de:0x1401 for Qualcomm WCN6855
> 
> [...]

Here is the summary with links:
  - [1/2] Bluetooth: btusb: Sort WCN6855 device IDs by VID and PID
    https://git.kernel.org/bluetooth/bluetooth-next/c/108c86fadc41
  - [2/2] Bluetooth: btusb: Add one more ID 0x28de:0x1401 for Qualcomm WCN6855
    https://git.kernel.org/bluetooth/bluetooth-next/c/315fda1e9eb0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


