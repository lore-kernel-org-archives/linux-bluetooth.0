Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0A543C049;
	Wed, 21 Jan 2026 21:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769032209; cv=none; b=c9PsZh+7AyNtm8yAo3fsSGAsmSwGW3OTqXBDTjXPS1rLiWq+qW6wqjiaqSK7DQS0ZNauXA+VBz67TVnlL7KiUhcOY8cXuWSxTbYi+fb4d24tO1Jw8NxPT7Ql/cjIUF+lccwmvqw9KJDznBxXu+gvsoE1c2cEfnk7dsopcSMH5oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769032209; c=relaxed/simple;
	bh=ZhGM+rvPOUj+Vn+hxLcVi9PlH4NC3dxHqLvW9bfXBHE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=amb/SsXES2YgGP8R9TCv61DhAV8pU2LiBC2Ibn7q4vUgFMiFi/eHfXPxPzmg5DKmXOnVCtnmo2NYTu/ydllb6TSxuTAAJPw7m71eFZ31ehs5GiWRnRSLkb/WTbCGNXFecgr4DKMqiM8gGMthfZGKf7J+MF0x3r1lHeOfZ9jGD1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUp+6+ww; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUp+6+ww"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3921EC16AAE;
	Wed, 21 Jan 2026 21:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769032208;
	bh=ZhGM+rvPOUj+Vn+hxLcVi9PlH4NC3dxHqLvW9bfXBHE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QUp+6+wwpp1x5qriRWXAqHtlP8zdXsU4gYcLUf2k4H2Wkx1BIjMoLm/M2VON+NLMu
	 tH9T98T8poAFM6A0uL1JwdDMedUalv7Oqi3GjATEOl9PbaiME47VtkAQZDwMQ9R8V5
	 XmKDn8lvXoM5Sc1TFPoz/DpOzDztqK+r/YyQXH/BcdKAVG7/EaDhzSBXtpaJhWz0SP
	 ZLwtlOh7eR69XTg2BbwyLvMPShJ7xjFNj97lE996J5Id+CmAOg8Ccj3c6vndN+I/F9
	 9Wa23qGRoY4D2XI6D7HKm4f4muSyotp/kRq8xyZZZgEuh7S9Mx3ieASYiYH5L8Fcv+
	 4enecV+xx6QTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EB603808200;
	Wed, 21 Jan 2026 21:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Remove duplicate entry for
 0x13d3/0x3618
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176903220511.1456135.1922961963959203429.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jan 2026 21:50:05 +0000
References: <20260121025220.2827845-1-lilinmao@kylinos.cn>
In-Reply-To: <20260121025220.2827845-1-lilinmao@kylinos.cn>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 21 Jan 2026 10:52:20 +0800 you wrote:
> The USB device ID 0x13d3/0x3618 is listed twice in the device table.
> Remove the duplicate entry and keep the one under the correct
> "Realtek 8852BT/8852BE-VT Bluetooth devices" section.
> 
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
> ---
>  drivers/bluetooth/btusb.c | 2 --
>  1 file changed, 2 deletions(-)

Here is the summary with links:
  - Bluetooth: btusb: Remove duplicate entry for 0x13d3/0x3618
    https://git.kernel.org/bluetooth/bluetooth-next/c/41a4d0f1b5f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


