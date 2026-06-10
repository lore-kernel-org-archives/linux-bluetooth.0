Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAFD427A14;
	Wed, 10 Jun 2026 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106021; cv=none; b=r0cF1o8ickgFDxsqgDTLM7orC7XVHtStNGkJ8HbF43jo1Z2xYeQbxK/mQgvOlUILursNEFfAEwAk5YrbCiOTfozWc9NTwxonNTWUbaldk13zw8Qj+Ch9zyx0OeR0Q1cWWc5a1NSweSnPqp9YRSpX4++J6izrNbVBGUzBPLxyHoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106021; c=relaxed/simple;
	bh=/jBegppJb8h9Me5VUoUIK0jpxybIo3yH7dMTpxGN8mg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c6LpyL1osT/HQzL7R0nP8VN5Jom5v38gVtCkfGoFx5B4n+TUgLA5PYbSGhfH4+/OQCmrb1We9UxwRwGAbqnDg4VYVauric8iP4vZjE/njj+QaMjl/H3yR26mR7QN72Yrh/Cr04cRfcYslafsF2hNiAbt8IDEkBHwZVBEzUZ6cuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5KaQLrB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5KaQLrB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC8D1F00893;
	Wed, 10 Jun 2026 15:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781106019;
	bh=XHAzcT4a3vvcXW7mkRSR/NLK3slDhnFPCFDsyuNDJkE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=K5KaQLrBLZkooKvLPd5RH2w79co2QLv9+ThOlXdaHdLsI/g142hkF+r9TX5YCfjz/
	 Ls2/aCh92g761HhZ1dD5bmrPMBeyu9wnKRmUAi4KXdeNHArl/a3hMZwErDTXZADS8J
	 kp9ReKDAVJEEdmcYeplc42r2jTHmg/cQzsNv7ipbRdpALz0WrJz3C5rwtUSOci6UZN
	 N4yzvcWI92VxqEZ2/zSNNnQv8eJWRlJhMhbyKj8it22GPE2W6wbe8+DmOgnEBBldkF
	 TFEqJHa25PBdzW1dxfx3hq+Lz9ystmkCuA4fUjqjtUmng8P2WSx42qTLgnHMJ5/hba
	 jHrUUNwo7sUow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D091E3930D7A;
	Wed, 10 Jun 2026 15:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci: validate codec capability element length
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178110601738.3101197.1357128495665086310.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 15:40:17 +0000
References: 
 <20260608235627.1233330.bc5338ecae62.bluetooth-hci-codec-cap-short-oob@trailofbits.com>
In-Reply-To: 
 <20260608235627.1233330.bc5338ecae62.bluetooth-hci-codec-cap-short-oob@trailofbits.com>
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  8 Jun 2026 23:56:28 +0000 you wrote:
> Read Local Codec Capabilities returns a sequence of capability elements.
> Each element starts with a one-byte length followed by that many payload
> bytes.
> 
> hci_read_codec_capabilities() checks that the skb contains the length
> byte, but then validates only caps->len against the remaining skb
> length.  A malformed controller response with one remaining byte and
> caps->len set to one passes that check even though the element needs two
> bytes.  The parser then records a two-byte capability and copies one
> byte beyond the advertised response payload into the codec list.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci: validate codec capability element length
    https://git.kernel.org/bluetooth/bluetooth-next/c/246dc2ed724b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


