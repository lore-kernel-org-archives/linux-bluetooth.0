Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A7E264A65
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 21:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749589799; cv=none; b=Rgl0ZfsFKseM2OlHLX0AdmgneVt2DPS7h4epzYUJQlM5CQ/vrvwsVMA+wzBGR48GTh3kBJCc0FKyLaL6ouAYpLlzakKCpD+2XmkXNy+YOnjzdRoM1BhmWv7zybhK3dNSPujI1yV0LrbpQ+FuBukRGT/0Q03++XC8Pt/F3Wm77vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749589799; c=relaxed/simple;
	bh=dwKH0fkJtkyeoEiw5w+45xVm9CS+j46415YJomTp+Pw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fY1dIunwC+nNxLjPxMUWUZrq+Rw06zJaflcAOaGpRS7pPwmCVwU8ZrvClEvWL5v51d4qtOVs3r3vh/NFZQ9HNXUNclPQ3vAFNtTIY2K4qLh7V+abBcIzPHrHMnaOHT+tLenvVh/NQ14X6EHJezmVgh/aKHN8Ujfdbt1IBkp4hQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eig9nz7g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eig9nz7g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5533BC4CEED;
	Tue, 10 Jun 2025 21:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749589799;
	bh=dwKH0fkJtkyeoEiw5w+45xVm9CS+j46415YJomTp+Pw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eig9nz7gxj32ZOCRCxNqzs6UnJVL5uwAu9BLZyEYzpzMcPDFTMcApEFFcWFKZrbdN
	 /VuHBxNck4xEMd1sTPCBIxjzRHQI5M3h/dk/KjYjnBTjwG3WncUt69aK8TElddFxUv
	 F8/kWpyR0B3ZgejwzZ+WdaBqfc/NYsNjYXxjws+JfldOl8BuDr2+sUjYBR7lsj6z47
	 9/rFGPI6w/sT3u2NSafHThG66oztKcpfGVsWn2vZUHZQ9dXXkm6jypi6YSRzlPButY
	 L7sVQ4OvZfaI97kpw8SvAkFqS6CrbiYIhox1j4iem6wMFjCpqRo0mOHnFMD/OZD2+3
	 l674AGxZU05lw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE0238111E3;
	Tue, 10 Jun 2025 21:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/2] btdev: Fix not setting sid on
 BT_HCI_EVT_LE_PA_SYNC_ESTABLISHED
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174958982951.2610421.10704209660457128763.git-patchwork-notify@kernel.org>
Date: Tue, 10 Jun 2025 21:10:29 +0000
References: <20250610180244.1133512-1-luiz.dentz@gmail.com>
In-Reply-To: <20250610180244.1133512-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 10 Jun 2025 14:02:43 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The event BT_HCI_EVT_LE_PA_SYNC_ESTABLISHED shall set the SID accourding
> to the value set in the periodic advertisement it is synchronized since
> the kernel will use that to complete the connection and notify the
> socket.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/2] btdev: Fix not setting sid on BT_HCI_EVT_LE_PA_SYNC_ESTABLISHED
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4bae390858d0
  - [BlueZ,v2,2/2] iso-tester: Add more tests for getpeername
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1e9dae575047

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


