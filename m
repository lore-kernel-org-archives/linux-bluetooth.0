Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327010;
	b=i5y62gKAvCem6nGCSqyEC5QRLflKKMVCOs1OGaskIjrNRCs0fA1Eo/fQvccIThx/Ilv1
	 0m+5jRLbvNrSm22VsQ2Hxx58qTk46+htsTZFmKEQVG+gApW+KpVOrDrLQmsIpu5E4YoqR
	 jFqL/M7j3f4jBOdYqAW3DoZ0nEn3YTc5G2BPOux7Flpk77ojnKlfRObmHNRVldfVqoMMh
	 iZPD0HjbL1ysXLv2c6QgpoEYaf8SBhR8Qe24Vog4IBHdwKDj8deAnbJkVIk8jBTyPay0o
	 WuX92rVWybom0gsVSFFcWZuvhoLOJMk24L3B0mNwlmq3FDscgn82GhrbtePQSrwJ3Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327010;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=LvtwQ3qjKJ7hJQFkAMWUe7ov+nTg/5q48Rt8Dv4swxM=;
	b=Wv1Y5uh+ZYnDkyqNHfQCvvg6KE9ISkNgCbgRqu1K+z1NdlDZmaaNc9WkqFYeanLd9NIy
	 2jrbEvFru++Iv6hKG1TExITr4sLp22jWECTc0czkJ1M4u5GUYDLEcbnvYKcasU/2LQs1O
	 tUuRJjK8RaAuFjHelHatQNfx0PMUOTTXshiOGUZ8VMmWo0kh5Sd7/vvUt4FV58hxoB8cg
	 4a/wh0jsVPnFJFFHI89M6cLkaMK0ZT8GKJ5vqrvgH84Z7VOEpWSW1tcYQ7aIxYMAG444J
	 PHvAnjPNH05LKx/cIXX4HDKYRW8SknnTyE8oI2j3YobZBZHupOBEyKRHziEBkmYKomw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nsLpCg6I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE73606A32D;
	Tue, 10 Nov 2026 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nsLpCg6I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5FB61F0089F;
	Tue, 10 Nov 2026 16:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794327009;
	bh=LvtwQ3qjKJ7hJQFkAMWUe7ov+nTg/5q48Rt8Dv4swxM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nsLpCg6IV6ACWUe83fTmTFplzjWgz6295EAsfXCpVABpXdS+To9gs6GKalR8DEcHG
	 BOM4zko5TaVgIRlBc+L1RLkGQEmiab4uGFM/3XLpqeTD8JjhhERvpV022/qZ4nsjX/
	 myyEQa5WmrPAtZBYLaR28EFTzKHOmRd180WBS6jF1iMvLXyzhbFZauJ3wakdY5CtNe
	 x54mZJqZAbhLUgXhhRYWAuZyfPBUwmNJ2jvdydPIbEOrjPa8kLe26XD2FtRl2XzNOH
	 nJ0yJHDpk5jcCUIf8nPaNcJi5jNSDKvR0AskAkCJ6dhzC00a6czanoKilQy0fMU6pg
	 Ro3raEWLO+mLw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B0AF39D267B;
	Tue, 10 Nov 2026 16:10:09 +0000 (UTC)
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
Subject: Re: [PATCH v4 0/2] Bluetooth: hci_qca: Reopen the UART after enabling
 QCA2066
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179432700817.4062787.1917987587860059113.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 16:10:08 +0000
References: <20261110092929.234617-1-shuai.zhang@oss.qualcomm.com>
In-Reply-To: <20261110092929.234617-1-shuai.zhang@oss.qualcomm.com>
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: brgl@kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
 xiuzhuo.shang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
 jinwang.li@oss.qualcomm.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 10 Nov 2026 17:29:27 +0800 you wrote:
> QCA2066 does not reopen the UART after the controller is enabled, which
> causes RX/TX out-of-sync errors. The UART has to be reopened once the
> controller is powered on.
> 
> qca_regulator_init() already enables the controller and then reopens the
> UART, but QCA2066 does not go through it. QCA2066 was added with its own
> SoC type and handled in the default case.
> 
> [...]

Here is the summary with links:
  - [v4,1/2] Bluetooth: hci_qca: Reopen the UART after enabling QCA2066
    https://git.kernel.org/bluetooth/bluetooth-next/c/a57a255ce204
  - [v4,2/2] Bluetooth: hci_qca: Don't use the serdev port after a failed reopen
    https://git.kernel.org/bluetooth/bluetooth-next/c/45e28b01e4d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


