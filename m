Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB234644F
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Dec 2023 20:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msL87mrn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03340C433CA;
	Fri, 15 Dec 2023 20:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702673426;
	bh=HRFkC5olybEq1TbLjcAIK+TSeb01ryYmg3SFMn7VuT8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=msL87mrndBsyeXPrbjdNrDae5qfLIzuNV0S8UtIR8Oz9INGKsmdJgdMw3Aqs/DjYz
	 TIPkgvQwzsPOR8/z6RwYvURL8WfMcikAzCDiuIVoEZyxtLqwm0gN/hKRNwZHHwKQsE
	 aC6y36myDeYeyqWv9Gd7/6EOOpsPWdzaF9KyX7fzKhYWTJDX4KiXdPwh9oM1f812Tc
	 9RTjThRCewIn7dwCDrCOdbCQtVAWugc6EdTMj3pTr/gdL2YH4qZi28XUqXnWc/Yq/8
	 F2I0BZ0drkJtma5VSrwAirsgHHAT0hS2zR8/uWPan6bsrV2Ek3x8HALi239kGXYlKb
	 JzON4Ca5g2eGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DDC25DD4EF7;
	Fri, 15 Dec 2023 20:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] bap: Don't attempt to release if old state was
 releasing
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170267342590.29572.16538751872537097543.git-patchwork-notify@kernel.org>
Date: Fri, 15 Dec 2023 20:50:25 +0000
References: <20231208221219.54529-1-luiz.dentz@gmail.com>
In-Reply-To: <20231208221219.54529-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  8 Dec 2023 17:12:13 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If the old state was releasing there is no reason to call
> bt_bap_stream_release yet again when IO could not be created as that
> will likely create a loop situation when the remote stack caches the
> codec configuration.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] bap: Don't attempt to release if old state was releasing
    (no matching commit)
  - [BlueZ,v2,2/6] shared/bap: Make bt_bap_select match the channel map
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e7e8b2a3d7ca
  - [BlueZ,v2,3/6] org.bluez.MediaEndpoint: Add ChannelAllocation to SelectProperties
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=07efa6d35b26
  - [BlueZ,v2,4/6] shared/bap: Make bt_bap_select select a location
    (no matching commit)
  - [BlueZ,v2,5/6] shared/bap: Fix stream IO linking
    (no matching commit)
  - [BlueZ,v2,6/6] client/player: Use ChannelAllocation given on SelectProperties
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e01208dac67f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


