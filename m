Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794859210;
	b=Se5G3oSbq1xLX2o61SbOgVPkVBJS+hmPUN9OShPF1vHo0T6OcX4mPtncKV26s/B75Lxn
	 M/kJYdzA0LJhCwzvVJKQp63MH49vTug4/fCYblVlGkh5KnQ8fPJWgXsUHOPv8n7m0ijL0
	 5s9Abwfw902XmlIA3bJR1DZaEGjTuBYcLItZhUjSYePdRq0CzDjTBAVtSFsDSYjPq4Jpk
	 T6fYFiUH1Frnc14tLo2VFgj5z1+YDGMBbJGqpyIQuF73wF43HQ8DQTdy9fFvO50TmsBwt
	 xcbR/srI32wuMVRmlchipgcVnaxeZqwSmJLbNqoj9408lpsBpch2NIbugj2+nLiX94g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859210;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=FXarD/sWCqs3V+pgiIPS80vJhRmzxK86i2RI/8aJ4LM=;
	b=WYBGtzHOIBfVo9cy4lu5mMQTKzw62TP3fXnXc7xVrclL4gt3dKvxVcUWnSyu77qszm7K
	 OXjll/wBbF/60PgJMDoCH1+qA9xR56mbMN/9XbYypZ2WE11V9Jc1wmhhVc3U4xBAxgPky
	 TBzedjxE5QajC+MS9KT8K3DMEwkAf9lA3AP4SoyCWJm8ijybH/jvJwN/i2L2HZMOWndeH
	 zZ1IRV7Z47FVQlk5tWWsS7P/WA8oWsL+mHq7XyMjuTK4itVHAKYnisehTNRx+BxPtC1bw
	 QnR/d2NvZJni+mcgL+LXNuF53h2sOCeGW0YTVylwi4gLzsRQHbi79ONeXYPe2R9gIrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y5ZTRisC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A4D606A323
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 20:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y5ZTRisC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E5B1F000C4;
	Mon, 16 Nov 2026 20:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794859210;
	bh=FXarD/sWCqs3V+pgiIPS80vJhRmzxK86i2RI/8aJ4LM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Y5ZTRisCg/F9BdS0lS4LWP9ZlB/3KOOT+ktlyWtszTaXn6CsgKCEkRryQ3FAAF+Ig
	 z8na7AP4GCWUzWOQ5boQPjXCseB2bNPI92FN6iHyokqdrSYM1gx71lY1AIqNqE0vLm
	 +74nt2gpst35h5a24tOWH2Bjs/H38HDXkbikJ2gsvIUmtIkLp9Vxy5C9jltA0WSKBJ
	 4fOPzkCRnO2+a+/SwSQcrpnHH2nyYTQ6AnN8tKTdRl0dYLJzepiC7V6i6NyqcjFiP5
	 LVkVaSFPPjr7rQFmYgxOfT5c/XHU8xJZ48tecxB+lV+ArM8z+LCaWHssXAsdj1Us9c
	 jQ/Yyn34zz8zA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 77404391AFCC;
	Mon, 16 Nov 2026 20:00:10 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ] audio/media: Add hfp-hf supported feature flag
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179485920902.3860040.2800611396448887038.git-patchwork-notify@kernel.org>
Date: Mon, 16 Nov 2026 20:00:09 +0000
References: <20261115101946.69033-1-frederic.danis@collabora.com>
In-Reply-To: <20261115101946.69033-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 15 Nov 2026 11:19:46 +0100 you wrote:
> From: Frédéric Danis <frederic.danis.oss@gmail.com>
> 
> This flag is set when HFP HF internal plugin is started.
> It allows external applications like PipeWire to know that HFP HF can
> be managed by BlueZ and they have to register endpoints for the
> supported codecs.
> 
> [...]

Here is the summary with links:
  - [BlueZ] audio/media: Add hfp-hf supported feature flag
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8df2ed315f20

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


