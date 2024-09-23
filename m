Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9780519F13D;
	Mon, 23 Sep 2024 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727110830; cv=none; b=LNQrUHbAoVcVVK6xDw3Ntx+0uyxsJub9KYwxQnUzhrZcb7V5FvwiE4qFNrj6SvWO06S7RLFrambrZEG+6+OMNeO2OBkWT5K8J2DEK10QhOTv0O7Psyy2DM0ltr3poJXVeqpol94EEDcnbnRKFmFeh5Oq3ORBAlLeriLQ14lV+Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727110830; c=relaxed/simple;
	bh=Le+8/4rHrktyxAGJVfNrJFueZA8IoxlwKWX6I3aB9fo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TUTru9kJva+gClHMbsn+UBweJiO1ZjAg90cafHbQa99oApo59Q3Ij4l5VrSVOQQDbn58bNyLSa2BZcYF2wWxNOvbazatXWG5FUOBeyeBnBRNAJrMRzVlNICSt590RmFtuDuibbO8FX3wG6mUu4E8rTTrrr/pRsbdC/HMb2lxPGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rISBagsL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rISBagsL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21206C4CECE;
	Mon, 23 Sep 2024 17:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727110830;
	bh=Le+8/4rHrktyxAGJVfNrJFueZA8IoxlwKWX6I3aB9fo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rISBagsL1XNMFvHAODmsaDAUUZqPPrzSZ5nHIQrvwCLsbpPEVxFUYs/XmHEUnRBho
	 LGaTxK40CEaAEa7F8M+5EHj1ornVMBQXCAKvubez1Pl6UMmUGXEPSTVb+48Be/tB5I
	 bGql7+laWqD//n7xVykKHsmEVHUUy4At1uI3BuD+WyBA7cgmYVAwd/SgkAeq59+IxQ
	 0tlqcypbqJ5G3UTYMi7BN6VzvdbYriYLQO5jCfl0qdYH0WCUqEIGO/M+H9QgCRCUVG
	 E3qMe7enDwhTg0ZQZbsj9x02qL+awYErfG+W4ITifoq01ynpc9U4fG9JeaDGG8StpJ
	 BClpOH1Wy/xBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD4A3809A80;
	Mon, 23 Sep 2024 17:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/4] Bluetooth: btusb: Mediatek ISO interface cliam/release
 adjustment
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172711083224.3420231.16302017182425598923.git-patchwork-notify@kernel.org>
Date: Mon, 23 Sep 2024 17:00:32 +0000
References: <20240916113938.30285-1-chris.lu@mediatek.com>
In-Reply-To: <20240916113938.30285-1-chris.lu@mediatek.com>
To: Chris Lu <chris.lu@mediatek.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 sean.wang@mediatek.com, aaron.hou@mediatek.com, steve.lee@mediatek.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 16 Sep 2024 19:39:34 +0800 you wrote:
> MediaTek performs some test on the platform which can support LE audio and
> ISO data transmission with kernel driver. We found the additional interface
> claim and release flow issue need some adjustment.
> 
> These patches mainly add a callback function within the usb_disconnect function
> to prevent a kernel panic caused by interfaces not being released when the BT USB
> dongle is physically removed. Additionally, the condition for claiming/releasing
> ISO usb interface have also been adjusted to make driver works as expected.
> 
> [...]

Here is the summary with links:
  - [1/4] Bluetooth: btusb: mediatek: move Bluetooth power off in btusb_mtk_shutdown
    https://git.kernel.org/bluetooth/bluetooth-next/c/65e9c1bf2076
  - [2/4] Bluetooth: btusb: add callback function in btusb_disconnect
    https://git.kernel.org/bluetooth/bluetooth-next/c/bcfc09e8a15d
  - [3/4] Bluetooth: btusb: mediatek: add intf release flow in usb disconnect
    (no matching commit)
  - [4/4] Bluetooth: btusb: mediatek: change the conditions for claiming/releasing ISO interface
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


