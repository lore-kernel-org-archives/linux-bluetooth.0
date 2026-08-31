Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD454A8FC5;
	Mon, 31 Aug 2026 17:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788196870; cv=none; b=NOimd/1uo9rqR+ftC0PurOmD+DMucHbiMN1h5nBtvJ3qlvEKu5cfek/tBm/if3iqjVj3f36ZKiCJnzwYO+HsBhuc7Ku7NRZPL9dp+I8+xiFiOhokKJMPvK5D2QPEq8E0hxOicKtDAsDRUlO0bIy2W51eQCDD3QV8SyKgF2mTCnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788196870; c=relaxed/simple;
	bh=YT6ozfv8YVDewZ1mCeFkZBkab72Lp9PPnJmu2sYJuK0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FZMI6B/PQrXR9h1m+Hjl65G4W/1WZxhpCiaMzX0YE5bzzev3P9kVNbSCdOyCTYJI0TagJ+u2asE34R2jxuxe/raeHxMvzeYWzgvxq8k+XY3vTn4RRhgZFly6WEZnzULhJsVSSgNx6lj12j+pP8bZK9zpW7X1/0ZSKTsf7e3igKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2Y/ar5G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2Y/ar5G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E57B1F000E9;
	Mon, 31 Aug 2026 17:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788196869;
	bh=VpEqtD2PxFTkpfP6/JkpSRSjFHyw6Xfi6IrNt7fMuac=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=j2Y/ar5GiQysvn6C6GMcBv5rynyKA/lfK32/zYjbwmmqx6rPTWYIcYQcuuAO6m2Cd
	 DP3lTsymk0wR1yF4+OuQ28PHtbiaiAwM/ydD9rjtoj8fCT+aZBPmM/uZxBQ3qtwg7I
	 anVWj1p/INELvsPYjV4kmZZbesj5AjeKqULNCPMVh/cwHWT4aPAaDAO6irq3abiznN
	 IfPFgi1NRZGwwqs9YDNlmMjN4g0eD6HehDqhlsK7m8ZbTKLcbJmxWVT0TWCj2O5rFn
	 q9PJUX7OQ0fWa2DMVi3iMv+s+IAhick9R5YsxS27cHhii1W0sJCWrUR2SaiKm6sgyV
	 9nt5rLFafYZxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939323924458;
	Mon, 31 Aug 2026 17:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] Bluetooth: btmtksdio: Stop discarding the hardware
 device
 id
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178819681225.671757.15863608623551543473.git-patchwork-notify@kernel.org>
Date: Mon, 31 Aug 2026 17:20:12 +0000
References: <20260825033634.499118-1-chris.lu@mediatek.com>
In-Reply-To: <20260825033634.499118-1-chris.lu@mediatek.com>
To: Chris Lu <chris.lu@mediatek.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 sean.wang@mediatek.com, will-cy.Lee@mediatek.com, ss.wu@mediatek.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 25 Aug 2026 11:36:32 +0800 you wrote:
> btmtksdio_setup() reads the device id from register 0x70010200 and then
> throws it away twice: an snprintf() overwrites the filename that
> btmtk_fw_get_filename() derived from it, and mt79xx_setup() passes a
> hardcoded 0 on to btmtk_setup_firmware_79xx().
> 
> Neither matters on supported hardware, since the device ids that would
> make a difference - 0x6639, 0x7925 and a flavored 0x7961 - all belong to
> parts with no SDIO interface. So this targets bluetooth-next with no
> Fixes: tags. What it buys is that the two functions stop silently ignoring
> their input, which is a trap for the next chip added to this driver.
> 
> [...]

Here is the summary with links:
  - [1/2] Bluetooth: btmtksdio: Remove redundant firmware filename override
    https://git.kernel.org/bluetooth/bluetooth-next/c/4988456a75ea
  - [2/2] Bluetooth: btmtksdio: Pass the hardware device id to mt79xx_setup()
    https://git.kernel.org/bluetooth/bluetooth-next/c/afe439f35546

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


