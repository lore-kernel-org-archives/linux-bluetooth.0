Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC5719BBA;
	Mon, 20 May 2024 19:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716234032; cv=none; b=NeQtocWdg91ZhrWHjhd0b8eK9H8x87Ao5yTSPu1vbY8Hz/dz5cZv4vsWMs6iAkP0mvt+UvCB1bEbz6UJ4JH63JxvlcJfrNQtHHIKkKaTdxLxCyuV3Lz6YJRMsxvtOmegLyZ1NfrEMW0CLrWjcn8OJdh23uFjaZ61Imn/U4bYml0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716234032; c=relaxed/simple;
	bh=KKvmUiNEkdDNOF+4LIuWQvPdLdakaCHzGqUIUcvsXaM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UrRs6xH2L1HXAORJ8eomo34y5uxaANa0+AqoFeO68q6zY2RAumSq7BqNNLB4sPgEMB7cJGu19Gga5RpEO4ogxfmvC7y4it2anIU+yukCMRn0kXltr8GdVdazk6SwhzQsPdDMhAbQbpC+woyTS3SKlnGpiDfn0QFep7Roip3Z60c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOg8RPra; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOg8RPra"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6872BC32789;
	Mon, 20 May 2024 19:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716234032;
	bh=KKvmUiNEkdDNOF+4LIuWQvPdLdakaCHzGqUIUcvsXaM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tOg8RPralfb5JUgiBhuOkvD4qy/awCGhqgdY6MgIl11YzgpkuA9WdJeVmkHfdWRTU
	 2UNInfTbEn7dUochGzuClWoz2e9EkfPTNzInitxgDHWT36v6jn2QPkRFZp6wxLUvix
	 uLG5SwvhtlyU678Wvx4FF8w3gS0HBYD+hc8u84rF4HBDSCrj8HbrXYHqHrjk29dEEH
	 eVDxf/hUE7XSWsHSAkDpIzf60lE0nAM7224xuHZBWhYEjRBOJSLR2qkjKN4yypKHWW
	 sOkGBv/bfxnoMBOVyCgCx8tPnJ306dHPmPpjmKfJjY0JBEv/V0HdjA2z8T2vqvD/XN
	 L3vPd8ifwFQgg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 58154C54BB0;
	Mon, 20 May 2024 19:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 1/5] Bluetooth: btmtk: add the function to get the fw name
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171623403235.10216.9445226154249031065.git-patchwork-notify@kernel.org>
Date: Mon, 20 May 2024 19:40:32 +0000
References: <ce0337178bf617d52ff320a36837d75bf537df2d.1715813148.git.sean.wang@kernel.org>
In-Reply-To: <ce0337178bf617d52ff320a36837d75bf537df2d.1715813148.git.sean.wang@kernel.org>
To: Sean Wang <sean.wang@kernel.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, sean.wang@mediatek.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 15 May 2024 16:15:17 -0700 you wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Include a shared function to get the firmware name, to prevent repeating
> code for similar chipsets.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> 
> [...]

Here is the summary with links:
  - [v5,1/5] Bluetooth: btmtk: add the function to get the fw name
    https://git.kernel.org/bluetooth/bluetooth-next/c/1a9f00aa23b8
  - [v5,2/5] Bluetooth: btmtk: apply the common btmtk_fw_get_filename
    https://git.kernel.org/bluetooth/bluetooth-next/c/8a5b9ee69fe6
  - [v5,3/5] Bluetooth: btusb: mediatek: refactor the function btusb_mtk_reset
    https://git.kernel.org/bluetooth/bluetooth-next/c/9d5a3b40987d
  - [v5,4/5] Bluetooth: btusb: mediatek: reset the controller before downloading the fw
    https://git.kernel.org/bluetooth/bluetooth-next/c/8f9fa6c70d35
  - [v5,5/5] Bluetooth: btusb: mediatek: add MT7922 subsystem reset
    https://git.kernel.org/bluetooth/bluetooth-next/c/2a6bc5724952

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


