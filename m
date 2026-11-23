Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461021;
	b=zWmYVzvHOaelofSmpLfpgo8Dda7c/TrZtIh5xe+4cTk8RZMWJHmXK5e7bRBlBZi2e+oa
	 KNpk4Z2T6aHgGv8iDhq7n2swxXP+SV8XaB8TPpHlIAlZi1Z9G4CiUtqyVetUd495LkJBd
	 XNwBxs2l5Mmm1qv70ijUEpW6QGoE7sE8bIv3ZVRQTtW/jIkLPPBygoLgxlIUi6+LHAuHl
	 YVVGRRt84JLQW6eqPLJmFZj2/niM+EBEH0yeHtp0y8i4SXqFhPtB49f4/sr3eGerXJHpi
	 9kgHr0QHtD7LdysuNY5KwkK6sSmDRv7rZcVTav4D9e1LHLp+2teCxjJCAGObFf9MlSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461021;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=raApuxKsDxoG/K4XrU3BMbkPnjWIoAKfdauBzJJjmDw=;
	b=OV2rUQSYb6WUDusQJ8ki2TZQ2G65Uc55/X0PK2ZSIt7BFi15lFc2LqZp1yWy71J0YJm/
	 scz7YM/TABc2sM0Fy5SgMD9lBdM8yaheUjbUc059kF+beclis23MHht+d+UWfSviF6+yS
	 KvBwJyfkuK4gzorwJk9m5i7GG8AiZps8cgEnuHelmvyfZMBFgtxWteczsfF1O1C33UDXQ
	 juggS9Z3nUHZAKxR3Dec5q/S5RhdQV6U2kZFqtt5CPMzMBwM2aZmLlEPcQvigzMXpfbdD
	 Os+urW3TwLpKB5hdTrUwMri025+KdNf32+ODa+l9shNEsYTZx3wGjydqqYNfG+TYWyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b3Z0WOtk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF972606A31E
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 19:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b3Z0WOtk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B5A1F000C0;
	Mon, 23 Nov 2026 19:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795461021;
	bh=raApuxKsDxoG/K4XrU3BMbkPnjWIoAKfdauBzJJjmDw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=b3Z0WOtkvQPgyAs6T9doj5iIuN31z2chS3j6qfg3iStncYO9IP+8xmtKw5I7YxQdp
	 ssB9BYLCZash1iE5PgDL4AT27mazHiD1WCz+XYP7uitPB78MagT1w68uBHnqH9pxt4
	 GHPk3aNhBO8RpJIzJ4ZOLCI3yHfy9iIkmNKtNujcl9VNrFq2eoM4xIHro9P6aWDybj
	 K/jaOHIQzkRRmV+VPvmgvoyVto3m4zN0ayVwSRTflB5njGQ/L9kFYJQx5cEtmwkisa
	 FKVkkm0UiytEzm5AH/Pq8LBquG4jBE/kaT6TLK3JWJT7MWlLIIitmx2NzGMyBgXvXS
	 P6NcAjui9vw+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3CE392EE35;
	Mon, 23 Nov 2026 19:10:21 +0000 (UTC)
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
Subject: Re: [PATCH] Bluetooth: hci_conn: Terminate a PA sync while other PA
 syncs
 are open
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179546101977.3063022.11381743809812262957.git-patchwork-notify@kernel.org>
Date: Mon, 23 Nov 2026 19:10:19 +0000
References: <20261122201337.2853259-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20261122201337.2853259-1-simon.mikuda@streamunlimited.com>
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 22 Nov 2026 21:13:37 +0100 you wrote:
> hci_le_big_terminate() keeps a PA sync while another connection with
> HCI_CONN_PA_SYNC has the same BIG. The PA syncs a scan makes to read each
> BASE all have the same unset BIG, so one closed while another is open is
> never terminated:
> 
>     < LE Periodic Advertising Create Sync  50:1E:2D:9E:E7:92
>     > LE Periodic Advertising Sync Established  Sync handle: 40
>     < LE Periodic Advertising Create Sync  5C:B4:7E:26:20:81
>     > LE Periodic Advertising Sync Established  Sync handle: 41
>       (both sync sockets closed)
>     < LE Periodic Advertising Terminate Sync  Sync handle: 0x0029
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_conn: Terminate a PA sync while other PA syncs are open
    https://git.kernel.org/bluetooth/bluetooth-next/c/28c476588666

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


