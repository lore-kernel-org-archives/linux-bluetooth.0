Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FF430CDA1
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Nov 2025 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764174045; cv=none; b=ei1ccJVurqLfP7fHDbrEhto+z/81bFrXcZdGGIEw0Or0a1M0kFeB7sSSHFHO2Ry75BEeafEf7piSKpWfzTs569FXmMJolpXTaHJtP6vwa7zdAW1eB2TT/+DOyzSBGIlp45QMBED5cCcMsxuLaqbNAeCc5iTuVO5c8easLosqbdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764174045; c=relaxed/simple;
	bh=o8IuoBvzxN9oUw7yC4fzPBROn1Z1alPwbsHNzO/jUcU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N9BHiCNsIRQ+uNjQIaHY3J69wltdhXh/H52NuJMRce3tRLNY+yF9RqjiPOgND2RhLB+N1CPEPr3ayq/oFqi5YSQElrHDDvTE+EH2cCzgnoIoHKXDPmdxFtQrGi33HVM2TODWyJoXppimQB5pPBI95mtpq3zMejSA3uiBQ85i6pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKQEiHNt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKQEiHNt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548A6C4CEF7;
	Wed, 26 Nov 2025 16:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764174045;
	bh=o8IuoBvzxN9oUw7yC4fzPBROn1Z1alPwbsHNzO/jUcU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZKQEiHNtYp5tuazpA7bED5JfYIJOFMMj/JhdJFmH8xg0/eS8Eu0DVWTZokcFnbta9
	 uAstx74dTO3GzJwcs1yvNP0gda611CZ/5Jtwwmol0DnJDVISYPNwIyb5x+y5JzzaeW
	 Se4tJROi1xqt35yFKWH7yQuF+l07b/vExrEYCuV98KIJjaBxxQ/EvZ40K99Rrl1UAi
	 WKySh9KNn2Ifb10awk+8XOF+sNkO8dKIvhYAKS+bot497OoofOSq7UCSpDM9d9Kf4X
	 UodLMcbGQpd0zhXqZjrQr2XWVpd5lgY+7FO0niW/3SB0bwLKsOv7A+FVrcTKCGOfrZ
	 CPdgArYqiP/7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 719AE380CEEC;
	Wed, 26 Nov 2025 16:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 00/10] Add TMAP & GMAP information services
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176417400728.1749268.5224595081449204444.git-patchwork-notify@kernel.org>
Date: Wed, 26 Nov 2025 16:20:07 +0000
References: <cover.1763914558.git.pav@iki.fi>
In-Reply-To: <cover.1763914558.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 23 Nov 2025 18:17:05 +0200 you wrote:
> Add support for TMAP and GMAP services. They contain only device
> audio capability bitmasks.
> 
> Expose the values from remote devices in
> org.bluez.MediaEndpoint->SupportedFeatures
> 
> Not sure if this should be org.bluez.Device->SupportedFeatures instead.
> 
> [...]

Here is the summary with links:
  - [BlueZ,01/10] shared/tmap: add TMAP Service
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=12e32efac2e4
  - [BlueZ,02/10] test-tmap: add test for TMAP Service
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7b93dae26a57
  - [BlueZ,03/10] tmap: add TMAP profile
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0f56b20f9196
  - [BlueZ,04/10] bap: have unicast client wait for VCS & TMAS
    (no matching commit)
  - [BlueZ,05/10] shared/gmap: add GMAP Service
    (no matching commit)
  - [BlueZ,06/10] test-gmap: add test for GMAP Service
    (no matching commit)
  - [BlueZ,07/10] gmap: Add GMAP profile
    (no matching commit)
  - [BlueZ,08/10] bap: unicast client wait for GMAP service
    (no matching commit)
  - [BlueZ,09/10] doc: org.bluez.MediaEndpoint: add SupportedFeatures
    (no matching commit)
  - [BlueZ,10/10] bap: add SupportedFeatures for MediaEndpoints
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


