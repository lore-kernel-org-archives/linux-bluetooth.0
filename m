Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513EF3F9D2
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 18:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755022195; cv=none; b=VZGJAqV3x/UYTx1T+/x5EJjynQbxvroYfsuDtgCZPzGSRiXGI5XHitcpY592lr042sl7rZVPKCs9Lu1fwhr35vxhj5UjDBzIDVZ5iLrylyvw6P70aIFVdUS2Pl068B9Pscsqwnb2m8BCTFKAksWa+2vVSXWl6AugPCf3TFRXDZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755022195; c=relaxed/simple;
	bh=9o8qE05uFMnZpEQyqsoZNDdoTfd/Vqfg1KdikDdXKiU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nvvK2EfRFCfdobi4f6858ojrHNPiodv8J8L7Dm1Kjyfx6gekEKWxXgiUg1sKnlIj8MkY1rF1xhMpqHbmXaDdBatQSTUL8F+VO73DjYrvMusLtqhEBJpCFVcmxn66YZt2Iegn7HFvfhmrltxBbVTCF6BSTnYpJRepcewHDq/lvfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3qm4ZEL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3qm4ZEL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E869DC4CEF7;
	Tue, 12 Aug 2025 18:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755022194;
	bh=9o8qE05uFMnZpEQyqsoZNDdoTfd/Vqfg1KdikDdXKiU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F3qm4ZELpTzYAKeAB+kpyyNbiR5YxUFQTr8UPEhGvKqJCeH1xzy2DFD7VY18Kg9XS
	 gJs1UNxG3Ehb5aj2TKuFAagbB1kZVsKUw8px2YkJy0ojuHd7yrynDesyUD78/VCSb7
	 hTcYCmi+BzxbYtuXaMiWFen39MRSey9rQeHV2BuaMNXFmDsa2kQdcGf03DpRxi8CJu
	 o77m3P10j+CnYQN/CxqO3UlLdYTm31JKNVD7Z5Vy4UI/UvWASQWnbRzCkqKrOgD1nJ
	 MIY3+RdpIXG3BDIri6VASRW6YPeUWR5lHAoRMlZt3CP1Tn/6p2vardTprJLdPY3sBB
	 paMyVJyvZUrLw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B56383BF51;
	Tue, 12 Aug 2025 18:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bluez v4 0/2] audio: Don't initialize media transport
 volume from media player
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175502220698.2767383.8444233719893678441.git-patchwork-notify@kernel.org>
Date: Tue, 12 Aug 2025 18:10:06 +0000
References: 
 <20250806-audio-no-reuse-media-player-volume-v4-0-a59d9a4848c1@qtmlabs.xyz>
In-Reply-To: 
 <20250806-audio-no-reuse-media-player-volume-v4-0-a59d9a4848c1@qtmlabs.xyz>
To: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 06 Aug 2025 09:22:45 +0700 you wrote:
> Fixes an issue where if a Bluetooth headphone with hardware volume
> control was connected while mpris-proxy was running, disconnected and
> replaced with a different one without hardware volume control, the
> latter will be erroneously recognized as hardware volume
> control capable.
> 
> 
> [...]

Here is the summary with links:
  - [bluez,v4,1/2] audio: Don't initialize media transport volume from media player
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5db6d2fef66f
  - [bluez,v4,2/2] audio: Remove media_player.volume
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9cdbad590b74

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


