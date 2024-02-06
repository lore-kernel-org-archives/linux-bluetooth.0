Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016861C298
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Feb 2024 22:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707258632; cv=none; b=qLtat/pGF+RqXqMz4zgSIVWn0Fe3k7CHPUawHggQKmcyUG5Ocus+sZ+R4HNIj9xqMDCSdr+OsCeYId/kIC3HoDYi+CQn51B4sZh2RFJB1RrQVKCnU28CUUgPnDXTiQi5GQwrNLEsk8KMBFqkHkFiNJRdTbjkhc7hhOW4fbyJjMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707258632; c=relaxed/simple;
	bh=1KY8FIaUjonXtIqchjPkI7TVXQQflRWfaB9SOtm/Kww=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HDH14OtV3fnunRURrxoq2t81bNOdr+S2k+TTs3A7p7NMKHrzh927i/7w32d3TbhsO8qVqY1wa/5SuLSbgMUBG4Ik/11FR/YhbYZIpeMfCRQPrf8uJdSwn7dtbH8/+GOgP6eki2bAwpJ7CbP/Yj7P2yT043BEV7BsAio1i0Ac62U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHD7fdUW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHD7fdUW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98722C433F1;
	Tue,  6 Feb 2024 22:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707258631;
	bh=1KY8FIaUjonXtIqchjPkI7TVXQQflRWfaB9SOtm/Kww=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oHD7fdUWNHkAdFGqnuKxpg2BEaMFxvqQG698OqpMR8+mvUVgm6wjf+k3EHaaI2qPn
	 /ElKiiZbmIeZa4a7Et4D+fMK2XoLZ7YiR4DFE1ALzAxUgfqQJPoc+WEGDfjtanlSbD
	 /O38x1atuIClrShIC8qV1bfuKnz4lSDGYKrJRN0W5V31cLVQbuxZ5jhBaIyBFgoysd
	 jxBFIJXr+QENbSATAVVjvoqlqxcPTxiN827s2pri/HARum5qKrauLhGrwPGXhGnNwO
	 4QQUYAXCP/ZNTNjPGKZ0ROPquOrgWtbpiJr+ofc4Uo7kuYykB/UW/o6tqrl9fCI4tn
	 OZXFqQNhymV+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 79A46E2F2F9;
	Tue,  6 Feb 2024 22:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/2] monitor: parse Google's Opus A2DP vendor codec
 capabilities
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170725863149.29070.7791471042080457848.git-patchwork-notify@kernel.org>
Date: Tue, 06 Feb 2024 22:30:31 +0000
References: <5ae678a1c4353818744a6bff31b21055371d2592.1707152569.git.pav@iki.fi>
In-Reply-To: <5ae678a1c4353818744a6bff31b21055371d2592.1707152569.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  5 Feb 2024 19:03:16 +0200 you wrote:
> Support parsing Opus (Google) A2DP vendor codec capabilities.
> AOSP & Google Pixel Buds Pro has this implemented.
> 
> > ACL Data RX: Handle 256 flags 0x02 dlen 21       #419 [hci0] 26.905032
>       Channel: 65 len 17 [PSM 25 mode Basic (0x00)] {chan 4}
>       AVDTP: Get All Capabilities (0x0c) Response Accept (0x02) type 0x00 label 3 nosp 0
>         Service Category: Media Transport (0x01)
>         Service Category: Media Codec (0x07)
>           Media Type: Audio (0x00)
>           Media Codec: Non-A2DP (0xff)
>             Vendor ID: Google (0x000000e0)
>             Vendor Specific Codec ID: Opus (Google) (0x0001)
>               Frequency: 0x80
>                 48000
>               Frame Duration: 0x18
>                 10 ms
>                 20 ms
>               Channel Mode: 0x07
>                 Mono
>                 Stereo
>                 Dual Mono
>               Reserved: 0x60
>         Service Category: Delay Reporting (0x08)
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/2] monitor: parse Google's Opus A2DP vendor codec capabilities
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c3613b8a933d
  - [BlueZ,v2,2/2] client/player: parse Google's Opus A2DP vendor codec capabilities
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1c60eb02e6c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


