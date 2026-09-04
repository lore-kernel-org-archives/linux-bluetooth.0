Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD4650AC3E;
	Fri,  4 Sep 2026 16:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788541030; cv=none; b=H7Z+ueuXpBZGoUiivt3kvEJwAVLVcR/xYM6i/IDLfo8N6bL4y29fJ8MvPE/jR2UJPLRq+CSGgaiSIaHtgkrH5nSvdGzYjoJ06Gelh2Hv/gX9u/vaUl2lVVD3gJYpKYp9iX8Om9jF2LMVDIZK1RQZ8AExK+8fiuqnTlFC8NtqqsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788541030; c=relaxed/simple;
	bh=N/Ez1PS7YZ0kmdDQrrg63+3U/GnnKx1VXCodi2n8J20=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eKhcZGCZ5VagicN9fmqSiHu+5rJ0crKiSbZVq4MtC0ArPJGflRCx02LpQw6BIZMqdBplWbA9Mm8CzFWa598+J7cILNTqxqLkU+8igxKzlest684/y++uZVAy/wY7rL0SrrzUkkgkWObog1HdNlDxKQHgBD9jQobyMBObEGIPUTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJvz1p64; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJvz1p64"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5C61F00A3D;
	Fri,  4 Sep 2026 16:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788541028;
	bh=FynJtHXnHr/s/9tnayXAtyCjmExWB3RfiHJOkbSqKLw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NJvz1p64YnzVTzHnT4SA6FwHEt1fsdBX5VZF+FT6kLvtXX8oSyOit5cM1U3NJ14Qp
	 70Lkwl1+bJ9KnxEIX2HCActvPMYRzQRf/1YOs9w6gODpz6xnocu2YnfDqJcx74u6CS
	 8JqnZZgZXrTa0EmLSNpQ6XBhLVxjycwKtXSXeFGJ4ETTQVGHcxDnbW1cabbwaLAQMC
	 ueEv3hp0zBtL2puzxpbegtvVhAS7ejmV2ceRWu0xXadx7oho09xiBtKnyXPcrvk2Ks
	 SJ0wZqOaKwukWJTNGLqUxz4STksMNaJ7AZaYVnQz8d02AA2/GWlfMid/ftB7ZSNnuW
	 14FVGcHAMP6Sg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19BD43924A50;
	Fri,  4 Sep 2026 16:56:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 1/2] Bluetooth: btusb: mediatek: Fix leaked runtime PM
 reference in reset
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178854096871.344939.9581829532701269317.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 16:56:08 +0000
References: 
 <dac8ddf07cb1bb79c70d5a516f0ff7baf41eb462.1788507854.git.liujiajia@kylinos.cn>
In-Reply-To: 
 <dac8ddf07cb1bb79c70d5a516f0ff7baf41eb462.1788507854.git.liujiajia@kylinos.cn>
To: Jiajia Liu <liujiajia@kylinos.cn>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, yinghsu@chromium.org,
 apusaka@chromium.org, abhishekpandit@google.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, jing.cai@mediatek.com,
 sean.wang@mediatek.com, chris.lu@mediatek.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  4 Sep 2026 16:03:50 +0800 you wrote:
> MT7925 on HP Pro Mini 260 sometimes timed out during reloading driver
> and reset usb device. btusb_suspend is not called again after closing
> bluetooth interface.
> 
>  usbcore: registered new interface driver btusb
>  Bluetooth: hci0: HW/SW Version: 0x00000000, Build Time: 20260605184935
>  Bluetooth: hci0: Execution of wmt command timed out
>  Bluetooth: hci0: Failed to send wmt patch dwnld (-110)
>  Bluetooth: hci0: Failed to set up firmware (-110)
>  usb 3-10: reset high-speed USB device number 4 using xhci_hcd
>  Bluetooth: hci0: HW/SW Version: 0x00000000, Build Time: 20260605184935
>  Bluetooth: hci0: Device setup in 1856545 usecs
>  Bluetooth: hci0: AOSP extensions version v1.00
>  Bluetooth: hci0: AOSP quality report is supported
>  Bluetooth: MGMT ver 1.23
> 
> [...]

Here is the summary with links:
  - [v5,1/2] Bluetooth: btusb: mediatek: Fix leaked runtime PM reference in reset
    https://git.kernel.org/bluetooth/bluetooth-next/c/a78f54e23804
  - [v5,2/2] Bluetooth: btusb: Fix leaked runtime PM reference in btusb_reset
    https://git.kernel.org/bluetooth/bluetooth-next/c/71729d60938f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


