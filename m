Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F581F37BA
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jan 2025 15:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736262616; cv=none; b=A+FLiFjl+623XsvEK6Hbq6flcKbkjxYu9o3gnkeTeXow8isxyNQe4HHvaW1NRiL+7Z4yDdXdW3Yn2hNlZ8cbCsvsMq48GDEcRK4sMV/gFKbnTst/Fhc5nJ3qHqCl5bO887pS40Eo/kc7/bT2VcKeknipe3Y24TJedEhdiV6dOEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736262616; c=relaxed/simple;
	bh=aLw/dJYjcytTUn8vsibOV3wtH1Wk9ebZY86wQ7TcODw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fFTFd27edlEUs+pz8m0MpnYUAvbjQsvZYoUHVg01jqGqCxWtY7nMACpzzVRR+3EgcbuyyZeyUWAtuHrnh3wV99hefhqC5To5T3lnHiLHGt4nUPywD3YTxR6Kf8hSXEaZ7qRN0lHCi1XQ2MgFSmJOqhWboVGdZB5X1aE4RWnsIzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOgf2zQj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOgf2zQj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C732C4CED6;
	Tue,  7 Jan 2025 15:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736262615;
	bh=aLw/dJYjcytTUn8vsibOV3wtH1Wk9ebZY86wQ7TcODw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LOgf2zQjgRKS40fC64mloHNR21wxY4NgDfW/RlgqqGc7J9l9ngmgzFZtMyCMt9s6/
	 qVAEAwiXBKBbwnXMpcJNlBMY7zxC3qSBjfl5f081qAiBcxr3dTVIL3jSdNDHb9ULNG
	 6te9y3hS4D8HeiqO9T/F9EXQyhDYp8cn4VF7mhQEUQg6B+O2ZKovMDx/DueBl5GtAB
	 gqCnSK1nqiktjkck30KNXbE5N67BgA2GWBbjdb/XuhitY5kZVjCksxSei1gEGZSp2y
	 kljDqEFoqo3VmUdhjJQcdBq49yItDQ2Xz0LaNs9c82kjlPWu2LnXJmA8lb6+su1upZ
	 iiVJpagASrT5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF7E380A97E;
	Tue,  7 Jan 2025 15:10:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] client/player: Rework transport select for
 encrypted streams
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173626263676.4189790.10237155935534580861.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jan 2025 15:10:36 +0000
References: <20241220144458.27739-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20241220144458.27739-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, andrei.istodorescu@nxp.com,
 luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 20 Dec 2024 16:44:57 +0200 you wrote:
> This fixes the transport select flow in bluetoothctl: If the user tries
> to select multiple encrypted transports, the prompts for the Broadcast
> Code overlap, causing the UI to be distorted:
> 
> [11-AE-0A-C1-F4-30]# transport.select
>                      /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis1/fd0
>                      /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis2/fd1
> [] Enter brocast code[value/no]: Successfully linked transport
>                      /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis2/fd1
> [] Enter brocast code[value/no]: Borne House
> (null)Setting broadcast code succeeded
> (null)[CHG] Transport /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis1/fd0
>                      State: broadcasting
> (null)Select successful
> (null)
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] client/player: Rework transport select for encrypted streams
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d3018fe2dc58

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


