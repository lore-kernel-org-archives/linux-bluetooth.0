Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD69353B35F;
	Tue, 29 Sep 2026 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790694634; cv=none; b=up23Bmfi7thCvpZDuRAh7djJtcsdxamGUzILjbXe3V03syM/FCWmkCBaR4oNZRY94kU3fs1SAr0oCkEdj5cY+t/UJCFeHwZ4jiQCybK423yld28/CsBxF1ZMnfYM+I10IF4NARTPkoChD8IlpN4utK20fajVxccPe7jtDPksnNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790694634; c=relaxed/simple;
	bh=qiglyspOJ3tBAjMUY2ntRIcaRcMrWqgG2o48AeDldBY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aeC2TuFx0hajqTP5a5zGWYVfmKSnIeg9B60QsFQP1HVY4nL8y8iPdwNiQLetygSUlza8MXlCSMiNv5W/Dvozu8h28gUQ7TupHxtgbjM5aJHsNTIgiIHNrJm94nneLm+9orwYZn2Ma8cfDhr3+a+/reBkpdyDL+V19cDh1GHsHBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXAzUbFo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXAzUbFo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097381F00899;
	Tue, 29 Sep 2026 15:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790694615;
	bh=jMaoWHA4i0PsY4ooBTUWn6KGH8qh1m2tGFWo1JLyUdg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XXAzUbFoESVJ1aztloYeTL79HcnPxmQ6eSKYIMOG1dB64bVAv8blBC+b40qkqxvSz
	 48jMWx9d6dyX9WhTI7n4BfRX7Akwjph9f4PTklYeZFDLgvL6x5IV35/H6A+BvkzsyP
	 Vwx8a/xn6J57d/ewL0jx5oedIdWWzXXOsNlm9q3B/OhKV15nDk9XVaHK/JBKvUDYz6
	 glq5M0sFlEC1Ge5pneNdsRR3eN25i2L9Ub3Ir6NrhpzTKFdXeRLw3PHa8Y0VKRWvZl
	 hWAmOWosPW4XVU2IDt+ihgs4r/DQmTMdaBY3N4Da0C94aMgM8+BbMYUDIWhv1haLqh
	 Ke73DIHni6RUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F151F3927049;
	Tue, 29 Sep 2026 15:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] Bluetooth: btintel_pcie: fix stale cache in
 set_dxstate
 fallback check
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179069461352.983246.11748091968845078723.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 15:10:13 +0000
References: <20260903192245.135310-2-vladimirkondratyev2@gmail.com>
In-Reply-To: <20260903192245.135310-2-vladimirkondratyev2@gmail.com>
To: yCduIhFgkD <vladimirkondratyev2@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, pmenzel@molgen.mpg.de,
 chandrashekar.devegowda@intel.com, arnd@arndb.de, kiran.k@intel.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, lsa.uz@pm.me

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  3 Sep 2026 21:22:38 +0200 you wrote:
> btintel_pcie returns -16 (EBUSY) during suspend, causing the entire
> suspend operation to abort on Intel Lunar Lake hardware. The system
> immediately resumes
> after every suspend attempt:
>   Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry,
> retry count 0
>   Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry,
> retry count 1
>   Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry,
> retry count 2
>   btintel_pcie 0000:00:14.7: PM: pci_pm_suspend(): btintel_pcie_suspend
> [btintel_pcie] returns -16
>   btintel_pcie 0000:00:14.7: PM: dpm_run_callback(): pci_pm_suspend
> returns -16
>   btintel_pcie 0000:00:14.7: PM: failed to suspend async: error -16
>   PM: Some devices failed to suspend, or early wake event detected
> 
> [...]

Here is the summary with links:
  - [v4] Bluetooth: btintel_pcie: fix stale cache in set_dxstate fallback check
    https://git.kernel.org/bluetooth/bluetooth-next/c/20dfccf8d854

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


