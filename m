Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795029613;
	b=GY+8ytFLayYEeuflHc7afmLZypOLJG63pFTBBMDo1EKm0237BWowuFL+7+burZ5j+th2
	 KLMJvVUsA/fi650k8flzEHHqPvBHdTaycN8hIGyXeL4TKkgQ18sD2bBnm2fX9Kd7Kl3/a
	 UXJm87l/fmbyfNwHwL1XpJvIu7FQuBpz7BnqROHxfEobqB+H9tTfllcszYWsFC9cKxgpg
	 a0mtV1wIxgWrP2fLnY5DIDbXGHgTup6JgetVWztiicO/Vtsl6x6muPuwVguEZrQTZaoRt
	 MsM4iE8AOLnED8+5aSyzvmFdzjJLDkTSCtZRZEGokYIiLheRKggQG621pN/FOgG2IJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029613;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=ukMnfCdm2fx/0hOktIl2o9jmg6UxSWT4xdPnDchBBY8=;
	b=hrd852W1gRe9hAX57mrW8DgJGqDe5v6tel2JcwEsRPjsIRnYmpnvOv0Jv2ccwZWu3kPk
	 6Hzzqcje8KA2mBdlux2JX4FcKuBMrlLHpu9/lJ6WYZg2GRbyxgbOWoJ3Fyf7i7nl0Zw7U
	 /CrxkiWKls8WZ0xXDQellcB/o4A1gFU6BlAV48yscuX1SeDoKCvw7HyBb7Y7pbpo38GxQ
	 K7gsnAbjO6lSAzkVnPApRkkm+lo9skZ+wcIRiyMuWBL3iQS7MvYpHmDk1B9Uvg0CLzma2
	 SZxah4Sh3yM995Wc0Cr5NIdP/ydAMLxvZ6R27FlsJ7QQkZcRv22m3wlyb09IpyJUjqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BBHnWBIh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC34606A333
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 19:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BBHnWBIh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD2981F000C5;
	Wed, 18 Nov 2026 19:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795029612;
	bh=ukMnfCdm2fx/0hOktIl2o9jmg6UxSWT4xdPnDchBBY8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BBHnWBIhaWq2hXiYzsU2JXBB1xG+OsgCRTwlkTbSVfgX3ICau8QIJcMIdrF+pgP4g
	 Ci8oia12RMp8hGrJmnO71cxi9obAbIJA1aC7gYR2rqqWlkRYZmceuJY+2b7RWFdclf
	 eb3gaE/NclnEuhbCuiLiYR66hPbI+urL6r2VHdh+4THMJjf6t2OVmhYkFXR9YWks/L
	 yJa6bPQpJpSaCupkQKrOWM2JAkplQdNj0PGSQpekqoJx3oJb+2GD9FLi+coWKPv4DP
	 fQjG5PCixyQdU1aaxAYWx837RkRMp9KyWqxHmBxfYvOtCfmZW64ZqYh+cmJcbNC26Y
	 ie/Exliy+0p1A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B445E3808210;
	Wed, 18 Nov 2026 19:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ RESEND] adapter: Set Audio service class bit for
 A2DP
 sink
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179502961127.2490531.2700850366323998767.git-patchwork-notify@kernel.org>
Date: Wed, 18 Nov 2026 19:20:11 +0000
References: <7d8bc3183903a1016c6b69bc64dfd4f275891ada.camel@bang-olufsen.dk>
In-Reply-To: <7d8bc3183903a1016c6b69bc64dfd4f275891ada.camel@bang-olufsen.dk>
To: Mathias Grelck Johnsen <MAJO@bang-olufsen.dk>
Cc: linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 17 Nov 2026 08:49:56 +0000 you wrote:
> From: Mathias Johnsen <majo@bang-olufsen.dk>
> 
> Problem: The Nintendo Switch refuses to connect to a device that does
> not advertise the CoD 'Audio' (0x20) service class bit. It completes
> pairing, takes the link key, then terminates the ACL with reason 0x13
> without ever authenticating, encrypting, or connecting AVDTP on PSM 25.
> 
> [...]

Here is the summary with links:
  - [BlueZ,RESEND] adapter: Set Audio service class bit for A2DP sink
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8808f4f417f9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


