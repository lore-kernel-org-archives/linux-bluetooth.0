Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDA2271A9D;
	Mon,  1 Dec 2025 20:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764619397; cv=none; b=FR8Ffvj7Xdj21lNjxSuw8MZTBtOLifgKnAaoAc5WoDOw9jwxcJfkUVN+VCP1JT9CNZ57idEnFAtr/7gq71xzDv4CK6WVm5WnBkaEDE6wxAPaklVYm3wCWp4DhICp/JFVGc3B4IB3zCkq8dwN1ak54n/FpT9WioCfHwOAViPahyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764619397; c=relaxed/simple;
	bh=lnJeJWQcwwGEBJKC/qrNEhrpfyyNTUVen9QkDbGLIp4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CiZon/0sVa2eyH6Vk07zClEy8RIErf1BpJFBYGG7Rcc2xa/x5gMj/W09tRYAy5QCJy6VUqpTXfilT3ojodKtqv1PWpxGtn+9PmW8zW83bBAdtpHwVnsmk5I0gZVFINh20Y9IMPVGxHV0Q3IMBqNBW376CxTPlqS3U2wav6upzw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxlWDRrE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxlWDRrE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA923C116C6;
	Mon,  1 Dec 2025 20:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764619396;
	bh=lnJeJWQcwwGEBJKC/qrNEhrpfyyNTUVen9QkDbGLIp4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SxlWDRrELbnxFHv8Wwom18iJNC53ByLrZvpLiepqBhb4cbqQOcp+9Eyw77zBuelqG
	 Z7CYL1oaMuOJD/b3E29NuZPKaLNXZhXmy0UfZlZ6vdr358qRi5ACP10GbuzN9iQ01g
	 OR6x4yTgKz/4ezobQWi94MW2bAP3SioAeqFYeaulsbpHlV5VPYTfLouQgDZPVuaZhW
	 x1hbDQ7ol6kq+n1MqU8YXT8p71mtol/zC9HQWyqPQlh6kBhzUwm8AcCEm1ueNvT7dB
	 x3qXYmfr4Tb1mm3WtiUMgoiyGGI05hit/On7dThNEq5ZcbzSIB4R6NnnJZhbMfoClj
	 D4RPn/6u9rifQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2830381196A;
	Mon,  1 Dec 2025 20:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Add new VID/PID 13d3/3533 for RTL8821CE
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176461921652.2515760.16193540104183875521.git-patchwork-notify@kernel.org>
Date: Mon, 01 Dec 2025 20:00:16 +0000
References: <20251119073338.713247-1-13875017792@163.com>
In-Reply-To: <20251119073338.713247-1-13875017792@163.com>
To: Gongwei Li <13875017792@163.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 ligongwei@kylinos.cn

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 19 Nov 2025 15:33:38 +0800 you wrote:
> From: Gongwei Li <ligongwei@kylinos.cn>
> 
> Add VID 13d3 & PID 3533 for Realtek RTL8821CE USB Bluetooth chip.
> 
> The information in /sys/kernel/debug/usb/devices about the Bluetooth
> device is listed as the below.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: Add new VID/PID 13d3/3533 for RTL8821CE
    https://git.kernel.org/bluetooth/bluetooth-next/c/b02695809572

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


