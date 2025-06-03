Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683A4239E8B
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 14:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748962199; cv=none; b=nT1fHxNokD8Le7i0j0GDdu9V1cMEg7ZwmNSQP8nW3ux7TcU7FZ2+4iLDs/e3SAm2mUvxWb6U08QQhri0+QDscPt/gEEFoRXgCBRQp5L9/95Fe7DedFlNIb2YisuE1LybsaxV2q8z+nVepCLXMlJrxlJtG7upM2F8rH69nxOdyy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748962199; c=relaxed/simple;
	bh=pic7SPEVL4mcd0ETh3JUzr6LjLqBs0y+XtYbGX2ctrQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sxdhWPKVVUMYXVYkreSRpcjTM09g/tIP2xNO1nit3B5r8NYjJHIjD/B34S6RhoHWGGZlrQw/ZUhuojuCRZCkDQatZwed9GsKPzYoE/DIJryFsRft4Nq8TD+7qFCg8AfF6fdXFfkw6bmGXsA8kR6P6JpmSHaPtcNLzhcR6kYYuxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1lBE4zv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1lBE4zv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7075C4CEEE;
	Tue,  3 Jun 2025 14:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748962198;
	bh=pic7SPEVL4mcd0ETh3JUzr6LjLqBs0y+XtYbGX2ctrQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H1lBE4zvwMm8OxLhcu3LtgGizKBqhiR2CXBH4UYm6C8JpgJr3YvdKlOl16unWdOP5
	 u9Bx15HX5uMH27Au3dUcJvEY3NTm1OAGVpz+EVJwsFeY2m92kz0KGc8VIAwJyNxtxX
	 xyQLbpn1X15xHWrsSZJqgog8y+M9tZJAMhD5YW5xvm3D4Z26a4U15qF+CY9FNqLBd4
	 8pF4OnzFM6izM7RZypdDHICiQxMfJg3X6Vkm0uAxvlks0dAByGGr+P2R0vleOnG6e7
	 CTDmL26xFO6e3W8CgIZu1WdfKhEEiuXB8xYYsQfHpiX8JfmF7tOf30wjP35Ha6pd2E
	 ZkbaV82GW/apQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C2D380DBEC;
	Tue,  3 Jun 2025 14:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/3] Bluetooth: btintel_pcie: Fix driver not posting
 maximum rx buffers
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174896223124.1544228.5358123033567261072.git-patchwork-notify@kernel.org>
Date: Tue, 03 Jun 2025 14:50:31 +0000
References: <20250601032824.572001-1-kiran.k@intel.com>
In-Reply-To: <20250601032824.572001-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com,
 vijay.satija@intel.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun,  1 Jun 2025 08:58:22 +0530 you wrote:
> The driver was posting only 6 rx buffers, despite the maximum rx buffers
> being defined as 16. Having fewer RX buffers caused firmware exceptions
> in HID use cases when events arrived in bursts.
> 
> Exception seen on android 6.12 kernel.
> 
> E Bluetooth: hci0: Received hw exception interrupt
> E Bluetooth: hci0: Received gp1 mailbox interrupt
> D Bluetooth: hci0: 00000000: ff 3e 87 80 03 01 01 01 03 01 0c 0d 02 1c 10 0e
> D Bluetooth: hci0: 00000010: 01 00 05 14 66 b0 28 b0 c0 b0 28 b0 ac af 28 b0
> D Bluetooth: hci0: 00000020: 14 f1 28 b0 00 00 00 00 fa 04 00 00 00 00 40 10
> D Bluetooth: hci0: 00000030: 08 00 00 00 7a 7a 7a 7a 47 00 fb a0 10 00 00 00
> D Bluetooth: hci0: 00000000: 10 01 0a
> E Bluetooth: hci0: ---- Dump of debug registers —
> E Bluetooth: hci0: boot stage: 0xe0fb0047
> E Bluetooth: hci0: ipc status: 0x00000004
> E Bluetooth: hci0: ipc control: 0x00000000
> E Bluetooth: hci0: ipc sleep control: 0x00000000
> E Bluetooth: hci0: mbox_1: 0x00badbad
> E Bluetooth: hci0: mbox_2: 0x0000101c
> E Bluetooth: hci0: mbox_3: 0x00000008
> E Bluetooth: hci0: mbox_4: 0x7a7a7a7a
> 
> [...]

Here is the summary with links:
  - [v2,1/3] Bluetooth: btintel_pcie: Fix driver not posting maximum rx buffers
    https://git.kernel.org/bluetooth/bluetooth-next/c/31b3d39c89f9
  - [v2,2/3] Bluetooth: btintel_pcie: Increase the tx and rx descriptor count
    https://git.kernel.org/bluetooth/bluetooth-next/c/e849b59c9db0
  - [v2,3/3] Bluetooth: btintel_pcie: Reduce driver buffer posting to prevent race condition
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


