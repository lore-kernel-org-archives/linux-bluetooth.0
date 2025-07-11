Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5382AD21;
	Fri, 11 Jul 2025 13:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752241786; cv=none; b=qLUHGZsAHG0QXrknaz7rM/BxqjyPjODPRsueLE+rpZ43BZ7oZ8gHNjyVXw4hnAORktMUDvhjx81Dl1BbbfxR0zRoRLkW4KJ6Ub4QcNUAqVQR4QAPEEIxD8/E8VcC5DXNMrLj1qYi7Hfn0iajGid5oVjLx+3TZvIpb/FY6l6LuRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752241786; c=relaxed/simple;
	bh=UFDdrcPLJ6i3OpdTDDcWFXhe3Rcu0dfIq/WI277FTg8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W8JDpHdK5bNuyhLaKs8q2/sBfHv4kEtJM3Onv2KtKXFEbxH229n7ET1FXUNb+KuYmYmqFHzFAczBC38//VXSOWzS+HimxKtJOKmRG5DM2KUIDpPqlCoRx5E/dvV5rlv6hBSR3/tSOq99huqHVZ+EnUIQOFMxS3sPNOqD+4ndI8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYGeJrjW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYGeJrjW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D79C4CEED;
	Fri, 11 Jul 2025 13:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752241785;
	bh=UFDdrcPLJ6i3OpdTDDcWFXhe3Rcu0dfIq/WI277FTg8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pYGeJrjWQVIu+bKZ0c0vIUzaOvxTuILhU0KhapNdUtv1MTN6U13fHW/wuQiFhwD2I
	 /Xjq7f6hES4/vGj4NHJmGsx01bLRWX5LsvDlhsWcDAzYavBEqcPhYfIka2rQWJdKTf
	 Osf+b0isdeIEr2VuDC8alh9nTnawn0/72ZQfUmrD453me1m8QifPMGnmaG7PHet+PP
	 0u6OjAUn2n9tv0ebc9B9YQQ8I0mA1pZvzyuxD8Cc3w9fUYjIcf3MUMJl8R2ruuboUz
	 mP7AgJRu/80QHpzDTc7KQ0N76hGk/NsglE1jLpgtabdjAYREJcF/NSXzysJG1lKxWS
	 N3k566Gvm9Ywg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id DD392383B275;
	Fri, 11 Jul 2025 13:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/7] Bluetooth: Fix typos
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175224180783.2277896.14693656286247860875.git-patchwork-notify@kernel.org>
Date: Fri, 11 Jul 2025 13:50:07 +0000
References: <20250703171815.1011001-1-hadess@hadess.net>
In-Reply-To: <20250703171815.1011001-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: trivial@kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com,
 sean.wang@mediatek.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, sven@kernel.org, j@jannau.net,
 alyssa@rosenzweig.io, neal@gompa.dev, johan.hedberg@gmail.com,
 mingo@kernel.org, tglx@linutronix.de, viro@zeniv.linux.org.uk,
 kees@kernel.org, erick.archer@outlook.com, chris.lu@mediatek.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 asahi@lists.linux.dev

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  3 Jul 2025 19:16:54 +0200 you wrote:
> Found using codespell.
> 
> Probably best taken in through the Bluetooth tree.
> 
> Changes since v1:
> - Added whether typos were in comments or log strings
> - Fix typo in typo fix ("btrtl: Fix typo")
> 
> [...]

Here is the summary with links:
  - [v2,1/7] Bluetooth: btintel: Fix typo in comment
    https://git.kernel.org/bluetooth/bluetooth-next/c/728beb9bb8b3
  - [v2,2/7] Bluetooth: btmtk: Fix typo in log string
    https://git.kernel.org/bluetooth/bluetooth-next/c/03b2d5bf4881
  - [v2,3/7] Bluetooth: btrtl: Fix typo in comment
    https://git.kernel.org/bluetooth/bluetooth-next/c/5d12ca753070
  - [v2,4/7] Bluetooth: hci_bcm4377: Fix typo in comment
    https://git.kernel.org/bluetooth/bluetooth-next/c/aa0d0b408a5a
  - [v2,5/7] Bluetooth: aosp: Fix typo in comment
    https://git.kernel.org/bluetooth/bluetooth-next/c/033ea129991b
  - [v2,6/7] Bluetooth: RFCOMM: Fix typos in comments
    https://git.kernel.org/bluetooth/bluetooth-next/c/b14c362ad112
  - [v2,7/7] Bluetooth: Fix typos in comments
    https://git.kernel.org/bluetooth/bluetooth-next/c/c819e415efb3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


