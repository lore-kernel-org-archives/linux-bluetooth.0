Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EEB1F2397
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jan 2025 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736262617; cv=none; b=Csb6jVypIueazZ0JS53S0yFXAv/tc2YIjC/U8Eiin6NM4MKzB+jJ72uM3CdR18lkZy4L51zHGJ+w+gtBjAptUl6xHQXMzcOkJcG8xJBpfGVC6oIP4XIkuA2k/YgqXM5kQpkl5uDhDB7nB6pdJxXoWFdHsLxFVX/nwIUz8OhwoRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736262617; c=relaxed/simple;
	bh=aMW1QrosF00gyotiE76IYFjUIrFiD+bxAIFaOnxEt/w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z4JZnAWm+UkFkhhHmxoWIwSgkf1maoQkK8ePw2NvCUu3/Y0AJcic2KWmQ3tk4L30dEnaaWamhVC9qid+FrXNrINDjy3BUXPk99GsyHaEkCg4iNW//0CNgoL9E3nYonmHrT7ZC2x4y8FUX/wNgJuBpYGGB3fEcSamA6FxDJIRMKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a60US9fI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a60US9fI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95B2C4CED6;
	Tue,  7 Jan 2025 15:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736262617;
	bh=aMW1QrosF00gyotiE76IYFjUIrFiD+bxAIFaOnxEt/w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a60US9fIx48wAaaJqBcqZnCiCU4PWF+HmlDFmykkW4ASEQtOpt/N1OEWrDZj7XjNz
	 X7/0eUknF8iPY23sGhf+HslxNxukcyjOpoSGi80grobRm1iZs78toaQw4CCkKtQlRm
	 EnFzuyUsfD5B77fqxM1oNROeEbGlZjQalPrm6EJS/2YREun22NOQQAsUQ6mcMxQXaQ
	 x3tJuL4oxg0zanqVzS/ag+YYnxbtHwH4l7bTMIquE2AefbuHez1P2NgeB0ws2BS9Ag
	 U/2h845M3QZ1jtVaGFdyCl3cZY77lL3Y9sfWcjxXbgf0Aryq00XuzKH5Mp2K1008Xa
	 tL3GtV0isA+zQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C63380A97E;
	Tue,  7 Jan 2025 15:10:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/6] bass: Handle Modify Source opcode
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173626263799.4189790.4768212693346713784.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jan 2025 15:10:37 +0000
References: <20241220143106.27443-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20241220143106.27443-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, andrei.istodorescu@nxp.com,
 luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 20 Dec 2024 16:31:00 +0200 you wrote:
> A BAP Broadcast Assistant (BASS Client) can write the Modify Source opcode
> to the Broacast Audio Scan Control Point characteristic on a BAP Scan
> Delegator (BASS Server), to update information about a Broadcaster, such
> as metadata or PA/BIG sync requirements.
> 
> This patch adds support for handling the Modify Source opcode on the Scan
> Delegator.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/6] shared/bass: Fix clearing BIS sync index
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9b094c56fcf2
  - [BlueZ,2/6] shared/bass: Add API to set sync state
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=86081a10bdbf
  - [BlueZ,3/6] shared/bass: Add handler for Modify Source opcode
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=547b00910735
  - [BlueZ,4/6] bass: Create setups for all BISes in BASE
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ac06953bc200
  - [BlueZ,5/6] bass: Pass delegator reference to connect_cb
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=614f2fc800f5
  - [BlueZ,6/6] bass: Handle Modify Source opcode
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e83d3021e130

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


