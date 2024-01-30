Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B7078B53
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jan 2024 18:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706640027; cv=none; b=Xi6w3JBWqSd7rg7rDbUZq26QLgR+TZ3cjMKgMqSzSw+Ol+hLuT3i++qNYQaxB3r1/c76uCiCzZDRtYJZ+jveO/c1E49GlRGcBZ4JQBBChCfddQ1KibC0RXXEK1+/R1xvieXDwwF7R2DwhgenpQ8+D8lEauE9yUF718mYcpUDFz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706640027; c=relaxed/simple;
	bh=ytHmaqAXCqyUmS7J0O470n3D99ePQBv4Lf5UK4sv7MM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oEfRs0ZwZX9EyNFr8bYuX23cR3Rmk1W/Pi/LlR3M/D9jtmv2dTSn9LUoP1nboTyt+obMz8JQ7oCKgc96Ck6twX/gdMzO1HN7z+dVukix/KxwF1F9Uosy3Asw/5+0YXi+UmYtrTwnGg6kbebNDNpq0q1g4lIUV6Qi8T5AmEnGg1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ssgElbKL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ssgElbKL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93D36C433C7;
	Tue, 30 Jan 2024 18:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706640026;
	bh=ytHmaqAXCqyUmS7J0O470n3D99ePQBv4Lf5UK4sv7MM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ssgElbKLkC/v08ptH5wyr2YdxKYMu5aGo5I5aTpcDLXsrIqXlRdJQhuUoFXRXnIRD
	 wDW7csMCIUndmwZFgudj6ki1n4vQKDmyKU/EgcMN3Q6gxPncAO77XDD6hLrRWA0pWQ
	 nhZkKH+ibZrMnXtqV50vAxWcsAczozHgC9a163REFxGGJyMGGGQP5+QBBEY/r604ny
	 vYY8fvRFCa3LQqrw8K36egot92KD9jljA7QFDHCCn4B4ZFKjSttWKponBEqWwxlG5l
	 Tp+j11aP6AgiKNACkduwyr9V2Ox3JJ2xkt5nNxDrZqbTLvT01JXtL6Mvem8NfUndb8
	 u2Cxp+ctsZwpw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B6B0C3274C;
	Tue, 30 Jan 2024 18:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/4] Update bcast ep register and config props
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170664002650.26337.975019276194048908.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jan 2024 18:40:26 +0000
References: <20240130154412.3157-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20240130154412.3157-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
 vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com, luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 30 Jan 2024 17:44:08 +0200 you wrote:
> This patch removes unnecessary input prompts from broadcast ep register.
> It also adds support to provide stream config options at broadcast
> source endpoint config.
> 
> This is useful for a broadcast source supporting multiple streams,
> since each stream could require a different config.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/4] bap: Parse BIG handle at endpoint config
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2aecc09ada8b
  - [BlueZ,v2,2/4] shared/bap: Set bcast stream metadata
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5c90ef8d8247
  - [BlueZ,v2,3/4] shared/lc3: Add macro for Channel Allocation LTV len
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=711814570bad
  - [BlueZ,v2,4/4] client/player: Update bcast endpoint input prompts
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a692cc44dc87

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


