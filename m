Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6371321B9F6;
	Thu, 21 May 2026 15:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779377411; cv=none; b=kJJRE0WLr0RUQgvbbcQrcxNAA/UzT/cfVuYRFuSFaEk7R7JkJaBX+melpbq+O6twn42OKRleS+MdvwRAwEmsOoVDk70PD3NCzqrntHi2z1/5yLfxoV4by+RQghiiNHZ3kkzhS2Jsb7KwOVf44sde3ijkLx4egaJ5S7uaUUK0J30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779377411; c=relaxed/simple;
	bh=otlNBy5uFE0/T7c3GqC1TfuG6DpqvH5OKWSSeg9pZzA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cuZvUnwMuvSLuyUXTRopSReFhPWoQSvpZM3Rhk47j/8rhcDSP03IiKMKJUwZd7eo0YwavTPB5xbJl83t3Jjccfk32JdGmSvjbf+vZnZM6kSO/EkhvHeGyM05y5x9t6gDgY1PqZ7EsAO7CvlHl7HOLucvhrbc24TorPBxe3IWCyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NE+QGGZP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NE+QGGZP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054701F00A3B;
	Thu, 21 May 2026 15:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779377410;
	bh=z8/MiZU1IUBpOtYJJGKz2o96s5ea7NWEcWYxykF9vqo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NE+QGGZPde43kl4MT/JfyFYNO4eV6i+/d0u9uvvn99F1GO/6JpXsO3ge1BxUcR+7N
	 WxbLCV0njbEOOvfDITYOTqNdFk4rEEABwZYdhTvi472jdtZWwVsJfx6FAEvxL7LURb
	 kBY5bRzEd+0/82YvGsBAEaN6lOnRNtAJ5GO2gjzuUfIMCLwLoCh2Zp9I4/A5vW8KJ5
	 V7djyc7slTw1CMye7Rcqdvg22mOg5bPB0IxNWdZCgvXvWsemSv3bRjyg6hfMB6qIrV
	 b4LFmMjKE3bxaZ6+a2I7Ky2R9xvYs+KV1WvwblxsJTFEv815CBV0qYuB/YNxq8uCU8
	 I/lkoaaZKWPCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1984B3930E02;
	Thu, 21 May 2026 15:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: btusb: Allow firmware re-download when
 version
 matches
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177937741964.384060.1194018588221994045.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 15:30:19 +0000
References: <20260521052547.2862803-1-shuaz@qti.qualcomm.com>
In-Reply-To: <20260521052547.2862803-1-shuaz@qti.qualcomm.com>
To: Shuai Zhang <shuaz@qti.qualcomm.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
 quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
 jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com,
 shuai.zhang@oss.qualcomm.com, stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 21 May 2026 13:25:47 +0800 you wrote:
> From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
> 
> The Bluetooth host decides whether to download firmware by reading the
> controller firmware download completion flag and firmware version
> information.
> 
> If a USB error occurs during the firmware download process (for example
> due to a USB disconnect), the download is aborted immediately. An
> incomplete firmware transfer does not cause the controller to set the
> download completion flag, but the firmware version information may be
> updated at an early stage of the download process.
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: btusb: Allow firmware re-download when version matches
    https://git.kernel.org/bluetooth/bluetooth-next/c/3c2c428f25e2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


