Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C78170849
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Aug 2024 20:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722976146; cv=none; b=VJDCemNJr7qiITXri9/WM486l3fZNSUbaKdck0K0t7OeRTDTGMrYSt57rYihbGy2izwAK/HMczkU/Bowc6MXl8MF9I65uT+PFaoR7hA8wNdu8V868+kP9fglFNRsVHggbxqQFXH4fS1gnEVMGgdGs0Ks477ouSn6sOT4Wy+pI0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722976146; c=relaxed/simple;
	bh=7m4qcmGRFacsL633u0qC1Kku2cObZnR9hi98rkpt3l8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j/Iod3vZzyxKW8W7/rxhhYVEj9fYfYJbWO4BWhlFgr5Yee037k5u9T5TjsBPHbHpL8GQZE2jwxGNnkF+GoN2WeO/zF/GBt2Uds0EfuiCeqXYFQtLVSw2zgk6WwGGVon2I8aFcGmz3WckZZ4ekrLRbGp2E8WPnURbhEyKul+0ve8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZ3vkUR/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZ3vkUR/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73FD6C32786;
	Tue,  6 Aug 2024 20:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722976146;
	bh=7m4qcmGRFacsL633u0qC1Kku2cObZnR9hi98rkpt3l8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aZ3vkUR/crZLN6Ha3nJuSCEDOtNGs4xVkaKu2C2U/ps7IPiXqd9fUiXUqLdrd2yOZ
	 ljSLT55chVDJKeWOs7neSMKcjApYpBsQFiw7TI3Ya45o2J8xYunjp4j+KnoEz5Z5yA
	 E+Y8v8csEP4UhZxcTnAZ45h5c4Kc0OwWpj8kWiaE+1EeSoJeDH2Tqre+fYOcD80FAL
	 0/SMoTWhACUYapQLaQtfRuPdZ7elz+igKj+krrUNa8i4LpRza6QygiEq9IdBCfqXfQ
	 hOiZrpDZbPG9W3pMaXVDOzNxPprpdgVPLF75SZynq1eJQs/vNowuKCYMUQJCj1nQIb
	 Leomg0+Kn6sTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 737A43824F34;
	Tue,  6 Aug 2024 20:29:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/7] Implement the MediaAssistant "Push" command
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172297614525.1692635.2982747127568994700.git-patchwork-notify@kernel.org>
Date: Tue, 06 Aug 2024 20:29:05 +0000
References: <20240805120429.67606-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20240805120429.67606-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, vlad.pruteanu@nxp.com,
 andrei.istodorescu@nxp.com, luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  5 Aug 2024 15:04:22 +0300 you wrote:
> This implements the MediaAssistant "Push" command, in BlueZ and
> bluetoothctl assistant submenu.
> 
> After issuing the "Push" command, the user is prompted to enter
> any stream metadata to be sent to the peer. If the "auto" value
> is chosen, the default metadata found in the BASE will be sent.
> Otherwise, the LTVs found in the BASE will be overwritten by the
> user input.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/7] shared/bass: Add API to send GATT write command
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a626ae163fd7
  - [BlueZ,2/7] device: Add support to iterate through service data
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=11fce8b09897
  - [BlueZ,3/7] bass: Store Broadcast ID inside assistant struct
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a426c3617109
  - [BlueZ,4/7] shared/bass: Add APIs to register bcast src changed cb
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fc9c4f2313b7
  - [BlueZ,5/7] shared/bass: Add additional defines
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=15811387144c
  - [BlueZ,6/7] bass: Implement MediaAssistant Push method
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=117b993f3d68
  - [BlueZ,7/7] assistant: Implement MediaAssistant Push command
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e1aa24a43949

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


