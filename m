Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2B520EB
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Jun 2025 19:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749495893; cv=none; b=PI7UoJmQKLmvlwyuBPpJlEShYPIIhq8Xn2+jQX7c/tFOpKbOBKW5Qotm00MX3tWABGJ2175lXpx96TQCjTIIC3wRCU+LRXuIEWLgToHUMSlD6Qw3tWI4rXqGeZhT21lCtfVW3shUkmV8306BUbkK6/Vcw7WqGCUssRMGu5ygEts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749495893; c=relaxed/simple;
	bh=Wn70VptxxJAd4mzNxBsu1e5HQHbBdBxJaQ9eH8pk6dw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MiimO3VCXnfNquLobsNAqpkDGyM926G8I9ztXbSyDsiPF7NHtFlmgEVjaPbMIIrq7Y2M/9CJQutGb15y5FrJEHFU+M/5DI2bDPLxkd5V0VdC8Jie+3Nel/4pgST7TSJgYxZTOfCgUWC+4OBF4KFDoOwxp+Fx4H6xNCk2GRtN+98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHVqmH4w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHVqmH4w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FE3C4CEEB;
	Mon,  9 Jun 2025 19:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749495892;
	bh=Wn70VptxxJAd4mzNxBsu1e5HQHbBdBxJaQ9eH8pk6dw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JHVqmH4wiSxdnNpoDHSTOvtgZ+IkQ2mNnjTx5J9bi3+6rhfxpJYnJf3J/6NB2DsSX
	 UJratdcOR23lMcwl6UjIzgx889VEOGPZJ9zLA+PtEM/S5Uu3+avME+ZdePy2TyYjqr
	 /NRR0QA5UtshK6wSFtcEFPvFo4rxpWaXnjLJIkFDffogrpVsmdD9ClmZMY2x18qZrw
	 6Ds7pOZj6rn/AbdAAV0U0SN5BcKiE15BF2ACsbD8KG5JVM/p5AZVbLdZFWbM8PfI0i
	 0J4H42AAeUmHh7Bj/8bdDYDu+qxGQW1VoH5OobriKCrYwcGFxucegeyFoeoIx/okLZ
	 wwceNmiS31Nhw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D6A3822D49;
	Mon,  9 Jun 2025 19:05:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 00/10] BAP stream reconfiguration
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174949592323.1356526.392113193265628757.git-patchwork-notify@kernel.org>
Date: Mon, 09 Jun 2025 19:05:23 +0000
References: <cover.1749418319.git.pav@iki.fi>
In-Reply-To: <cover.1749418319.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  9 Jun 2025 00:32:12 +0300 you wrote:
> Implement ClearConfiguration() and Reconfigure() for BAP unicast
> MediaEndpoints.
> 
> v3:
> 
> - Add bt_bap_stream_lock(), instead of bt_bap_stream_discard()
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,01/10] bap: do not try QoS before links are updated & io created
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7d8eaa56b8cb
  - [BlueZ,v3,02/10] shared/bap: detach ucast io on RELEASING and unlink streams
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2f853e4d86d8
  - [BlueZ,v3,03/10] shared/bap: add client ASE reuse and upper level stream locking
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d1eb496cc605
  - [BlueZ,v3,04/10] bap: lock streams when used
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=40b91712b932
  - [BlueZ,v3,05/10] bap: add ready callback for setup configuration
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ebed99caa7a1
  - [BlueZ,v3,06/10] bap: support removing streams with ClearConfiguration()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9e0dc968de50
  - [BlueZ,v3,07/10] bap: add callback at the end of ucast client select/config
    (no matching commit)
  - [BlueZ,v3,08/10] bap: implement Reconfigure()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=128b0695e2b5
  - [BlueZ,v3,09/10] bap: don't show error when releasing stream
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1d3907561f8e
  - [BlueZ,v3,10/10] bap: delay QoS & IO creation if CIG is busy or setups configuring
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7feff47a9fbe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


