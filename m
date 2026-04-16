Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865EE346FB5
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 13:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776347436; cv=none; b=ZBtaziiN77teKE1Ko7jH+2l0qrcdbVl7gd26ATMyFnVmme5vIMDBdXQEyDoHcqzSO8TGmXJjsVP7ZLJoSNl18+Nauh2A8bbAVg/zKazRgPHhMb2BjggHZGbVyaLH0JzsYBRlBcc/yp2X9z3cM41Geiclct/WIXt1oUhbeCDTvdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776347436; c=relaxed/simple;
	bh=cz9LP7NhvksU0fVgxEvUJeNvN5V9FbVSJEAAooqgSUY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ny0yV3pLZeVyPOytXYyj7DVo+u4dwPMSedSE6EmWfThV/Wy2eX13K6JpiT2BlkCVcAzXrvKgdPxwxXPVBJs75Tx3Znf58BANyYcjbjb9QsKMwTtkRArBHuKDGdMYv0H9Oy/gD6qIWZEyT9mYkLm785p9WTSnYPCDXdRmYUTcIhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMaX+TIc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMaX+TIc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2811DC2BCAF;
	Thu, 16 Apr 2026 13:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776347436;
	bh=cz9LP7NhvksU0fVgxEvUJeNvN5V9FbVSJEAAooqgSUY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NMaX+TIcsisfaJvSalpgVI3yLOZlqCdebkmkt/dPKHzkbBmSfUTg7mYy5ScSHfMYh
	 zdGh0tRld0DUJKcZbJFuEFDkbEzatDSBcfVmi5pULTsc9u1CN5e9wV55FACvAvsmej
	 70+wc24jJm56m5RFHJnru5+loBcYo5G4+6Yiw8YiRBy/jDJuZ5c6nMg3RocN8jYDSK
	 prbKDNSrVcwceLCV8BMYNchC8uiJVLbQMO7txKldktw/mwV0cQy24wl/acEeCDkngV
	 8fUiCQ0knZ6Som37lv/2vu/rszRU9SX2bHLNAA56lrw+Epw4Xp2teAt/8JCP8lbyTW
	 IFRBOu2yzPOYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DA2380AA60;
	Thu, 16 Apr 2026 13:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/3] monitor: Add L2CAP channel details to
 analyze
 output
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177634740480.2827737.2643221147708039593.git-patchwork-notify@kernel.org>
Date: Thu, 16 Apr 2026 13:50:04 +0000
References: <20260415205818.594024-1-luiz.dentz@gmail.com>
In-Reply-To: <20260415205818.594024-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 15 Apr 2026 16:58:16 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Enhance btmon analyze mode to display richer per-channel information:
> 
> - Add MTU, MPS, and mode fields to struct l2cap_chan
> - Parse Configure Request/Response options for BR/EDR channels to
>   extract MTU (option 0x01) and mode (option 0x04)
> - Add l2cap_le_sig() to parse LE signaling (CID 5) for LE Credit
>   Based Connection Request/Response and Enhanced Credit Connection
>   Request, extracting PSM, MTU, MPS, and mode
> - Display fixed channel names (ATT, L2CAP Signaling, SMP) for CID <= 7
> - Show PSM in both decimal and hex format
> - Print mode, MTU, and MPS for dynamic channels
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/3] monitor: Add L2CAP channel details to analyze output
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6b4c21721c80
  - [BlueZ,v1,2/3] monitor: Use wall-clock duration for throughput and add min/max speed
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ebeceecd3ccb
  - [BlueZ,v1,3/3] doc: Add throughput estimation section to btmon-l2cap.rst
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f360d9e4428d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


