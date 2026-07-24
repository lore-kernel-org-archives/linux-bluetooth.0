Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA7844E65C;
	Fri, 24 Jul 2026 19:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784919670; cv=none; b=Nra9DS7YBkRD8JysBXOx/aALFc6HCtddx2UJ/Loe8G50/SD8czOjjXB/yx3EB+96N1Z5YhmGOz2U//+prHMl6116/seuI1uPTdzmj4c3LoXIGOyIGVJTpalA14zpsNj5o8W4vITZspidsn8dfERzIP1VoDMhm3oypIJdUN1JRdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784919670; c=relaxed/simple;
	bh=uA+payxIkbTBDnK+Zyg42T7kLR9xq56EMymWa3xX/Ow=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ldvup2W6CwRcRKzu9AVr4i1BIfnEqxZzEZN1mlzeXU9WG0ExZ3OatyCmJZpH8mlxjkCuCGuvq+Q4HAuS5Vapc/T545UMYGvaFf7fDOOZx6UXjCMJrZs+blqqC8pbyOfEaoRIljyij2moAFCtZsg3NiE53/IqCXSD/JBKRWTEMUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lunt6sHy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lunt6sHy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C231F00ACF;
	Fri, 24 Jul 2026 19:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784919651;
	bh=hFFeam8cO1f4cd30ovZTfy2d9N8B3b31/tAfa+IHZic=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lunt6sHygyykyXuycpIH8CnI4fnQcFJBjvm/1+jn5V30TVCvDk8w6YR//K/Qtpg1A
	 Oo6hiyR8oPyYK5lKv6y5usJuJRPk2xFVzD79AHatJ/4RLYDGc7U0wB841DetTn6KHC
	 3/n7tU6gSRDBAmjCS5LzqixSJr5nOo5PF6nadrfI2fEQNHFtc/n/d5geFJZx2RJR7+
	 vTwZv2FfNwWQpyFk1bZOL3thS2a9az/yBgtFcW7XMc4UAwc5OXxtt0/6nxRXrawqHh
	 c6+wr4rnL+6X6xvLiFGrd23053exDGcRhEJdssZ3nDRPhahljY8KFB/ODFNm7OXFGh
	 MZnKCo1d0lszQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93C81380CEF6;
	Fri, 24 Jul 2026 19:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btrsi: Move set_bt_context after successful
 HCI
 registration
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178491961823.3273549.5264850910757463763.git-patchwork-notify@kernel.org>
Date: Fri, 24 Jul 2026 19:00:18 +0000
References: <20260722083136.175650-1-chenchangcheng@kylinos.cn>
In-Reply-To: <20260722083136.175650-1-chenchangcheng@kylinos.cn>
To: Chen Changcheng <chenchangcheng@kylinos.cn>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 ccc194101@163.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 22 Jul 2026 16:31:36 +0800 you wrote:
> In rsi_hci_attach(), ops->set_bt_context() stores the newly allocated
> h_adapter into common->bt_adapter before hci_alloc_dev() and
> hci_register_dev() are called. If either of these fails, h_adapter
> is freed but common->bt_adapter remains a non-NULL dangling pointer.
> 
> This causes a deterministically reachable use-after-free when the
> device operates in a BT+WiFi coexistence mode and CONFIG_RSI_COEX
> is enabled. The following software-only trigger paths exist:
> 
> [...]

Here is the summary with links:
  - Bluetooth: btrsi: Move set_bt_context after successful HCI registration
    https://git.kernel.org/bluetooth/bluetooth-next/c/17abcfc57c8a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


