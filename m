Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A234443DA5B
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jan 2026 21:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769032211; cv=none; b=KjItEXeNy8lE104xGjcLkYD5bhjHlcN00Y9JyNmjor3d1cGwmxUzhrNSOEvERHcTiBsEb/B2hSgKqcs0F5gx4LIWa8ovGy8WXbBQDC+mKGiFHa+wQOgFBZvwWcc/QfjLuTr8ZGaJjEb1DxgjKQeVufYhMivvHvEmcd7ibViSNKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769032211; c=relaxed/simple;
	bh=Ze7x82kaFl962zMZlvrZpk0BBrWqVBiCLInLruVAJzM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=skWGtSbHLPv7CttMMr6psWNLq7Y3bzdNRl6IIUqKlGPEikt0Ihus0xoIvV+lAL479Ysc8I72H6XDTm5LTyRmEpDtd0lBmpeVLe+3oioceDH7+hYUWQVjldBPXk83+mNNJWlW19F1CpIcIgyY/jJ7IDRdiOGv9LFOcjh7vlFxqag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=morSh6Gs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="morSh6Gs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24424C4CEF1;
	Wed, 21 Jan 2026 21:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769032211;
	bh=Ze7x82kaFl962zMZlvrZpk0BBrWqVBiCLInLruVAJzM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=morSh6GsvWDzNJJWJyTHD2+25X+bYn8JyaZLO2n0kpd0hpu7m4gFB5Mdv21Q3jx+d
	 Jm5SHZB6jKck28Ht7QPiFGu6WALuy1iALX4KgDnaf7aqlqJMA/+MpuBkEg6eJTZ4MP
	 +pMyGOLtz1AY6OsuSgr8XYKyHC8ADhTuaw3XR/JFOwx+jM60BAt8gD86g4WMpa1G8+
	 tcc7ox7oIrfej7TCU1GtYVuIOeB9G6rL5dtSHamiH04gBP6UTQPBH2u+kad8FgmMZ+
	 mVr5YAOoJ4BpuRuT89Bhoqb8B2oCO0OlvZkR2a1ga/OkmG66UVDbWmxltqGms3XVi2
	 pJa1S5PhSBWyQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EA343808200;
	Wed, 21 Jan 2026 21:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Add device ID for Realtek RTL8761BU
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176903220784.1456135.12079577274468394259.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jan 2026 21:50:07 +0000
References: <20260120091304.6226-1-code@charlie.cat>
In-Reply-To: <20260120091304.6226-1-code@charlie.cat>
To: Jacopo Scannella <code@charlie.cat>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 20 Jan 2026 10:13:04 +0100 you wrote:
> Add USB device ID 0x2c0a:0x8761 to the btusb driver fo the Realtek
> RTL8761BU Bluetooth adapter.
> 
> Reference:
> https://www.startech.com/en-us/networking-io/av53c1-usb-bluetooth
> 
> Signed-off-by: Jacopo Scannella <code@charlie.cat>
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: Add device ID for Realtek RTL8761BU
    https://git.kernel.org/bluetooth/bluetooth-next/c/9f7f0a967558

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


