Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FDE1741D2;
	Tue, 21 Jan 2025 16:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737477611; cv=none; b=nUEIh2bmCtBBpRgIF5wfbrVJjqRfMEwW9wml8AwlGWymtViwXUmESnZBIB3CLP18g4r/7a/dgEetLg1MiDgbuZE8d++jLcU9md6yhjmt9chspNzVAMQEef7jawDosIGMOUYNnnEugFeWIcnsCzjXKVF+862X7DIQOM8WVX19D+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737477611; c=relaxed/simple;
	bh=n6OwF0LtgoRb+4gCwo/Yxj34ecr+BW/s6uOoxV5vMmk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EI3vrD3rbqcKEfby+p5TcrmKm47i9SrnmyG6kzHuYiILSJkruqvP+ckBWzlnb7H/HINR9QsO6mq2QWDG71VWULMlDgA7kmIMl1JV473qzsoLqJ0gB1i9o9r85iFR05SDfQ8KPe3V6Fhr55NHlA2wRycwDsLLVQN0+XdGqEfIgYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkRQIKUc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkRQIKUc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADF6C4CEDF;
	Tue, 21 Jan 2025 16:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737477610;
	bh=n6OwF0LtgoRb+4gCwo/Yxj34ecr+BW/s6uOoxV5vMmk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lkRQIKUcsP/6LY0rJsBfga/cvSR/cWw2GTYHCjdGg0zq/BalM1ysCPu075pG3n6x5
	 TgAkE48TCOsHMA7Y2/qb17dvIQt6Nzyt6HZ5YVNXMjCuan19GD834jqe6MaSKJ1L8u
	 1QWbhtFbZs6QXqXFIP0KtlN02T58zf8miQAh2qB09CRskS2u6Axm4Ps9S8c/y34gCo
	 L8QphVXUj3NdyZIKJNmfIkrjbqIXCTPYJD6fKiOrhO/SjiEo/aoYCGU7X10E30qPOz
	 /Tq15OBEqSU4dHnsa5R9Xc7aX14SzyFL3717IlVkR8u8eQCqSWpnOhW3wxTDjPLXfJ
	 On9WG2dgHLLmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71064380AA75;
	Tue, 21 Jan 2025 16:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] Bluetooth: btusb: mediatek: Add locks for
 usb_driver_claim_interface()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173747763400.49514.16130463515349826883.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jan 2025 16:40:34 +0000
References: <20250115193636.1.If8b655b5c6877bd9a1136ba0f1cd61cc6a4b6e9c@changeid>
In-Reply-To: <20250115193636.1.If8b655b5c6877bd9a1136ba0f1cd61cc6a4b6e9c@changeid>
To: Doug Anderson <dianders@chromium.org>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 angelogioacchino.delregno@collabora.com, chris.lu@mediatek.com,
 matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 15 Jan 2025 19:36:36 -0800 you wrote:
> The documentation for usb_driver_claim_interface() says that "the
> device lock" is needed when the function is called from places other
> than probe(). This appears to be the lock for the USB interface
> device. The Mediatek btusb code gets called via this path:
> 
>   Workqueue: hci0 hci_power_on [bluetooth]
>   Call trace:
>    usb_driver_claim_interface
>    btusb_mtk_claim_iso_intf
>    btusb_mtk_setup
>    hci_dev_open_sync
>    hci_power_on
>    process_scheduled_works
>    worker_thread
>    kthread
> 
> [...]

Here is the summary with links:
  - [1/2] Bluetooth: btusb: mediatek: Add locks for usb_driver_claim_interface()
    https://git.kernel.org/bluetooth/bluetooth-next/c/ec5570088c6a
  - [2/2] Bluetooth: btusb: mediatek: Add err code to btusb claim iso printout
    https://git.kernel.org/bluetooth/bluetooth-next/c/6ca1c15fcb92

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


