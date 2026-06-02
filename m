Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E7E3F88B5;
	Tue,  2 Jun 2026 17:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420806; cv=none; b=hyhAX9rPX9rc03Mlcgo6i6w5uCeNfvBIFVXPZeckvsjzwp+QS5c0C2274cvx1hFl9t5GermlgWX3/F5ib3jUtxjCPmA6I/VAWrucovCypSl3Kk7fNSRBV5mqUoi/yRtXutoukwOvo4ylrf9XRRexD8Q845tFQKS1gmNawuK2K38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420806; c=relaxed/simple;
	bh=pK+6WJkoB6OLp3TvACok1tKfb0ny107AsOr3vlXAx38=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YENqpJC9siE8o+Pbh4PlrF2Xf73jr5gXLHf+JtrvLTPRiMCo+L7wSxUhr77gSfk+7iacTpxxGWf9PJdUlWdNvk7lZaonNLRtMU7KWYJDV1uBR1hZBSb2dPWEc8cAecmaHgCwNHMlsmJitEPDxJIcD63wuO6LJcbszoRFMhBXedw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cu3tKL0o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cu3tKL0o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C451F00893;
	Tue,  2 Jun 2026 17:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780420804;
	bh=UMPfDZeRjHs3nhBodXyN+Alewz0VyvLNp/Rv4CiyrWQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Cu3tKL0oyDGbba0OXGNHp3qHz5OX/Ayo6ZGS+u8/LsN/BgTW+aEWcFn4hVBQmBoVj
	 ejNBrWjrf2xdBf0Et5sxcHYka0GtyIvPecGKkn1MlbqYU4SZ3OqvyLKuJ0ogMKsbd0
	 OFai+KwZgsQjrudE7fDZfPnqC/oeWd/oD5Q05O74K6g2Qb5Lnnl43nssYa0dggI3sM
	 pYFwJabU0Cfu3rh+PytDCN/beSeBSRbOA8R3CxV+Muq3D1Rmrn9LelRAXoJ8qwhhGV
	 gZtr7kswEtxd0mDjeZM0DLvfH12uiqO3DsJA2zkw9EI+SLPqWyl5O6JNI/xrtaMZ7h
	 3+RhJYjAT8aKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D53DD3811A69;
	Tue,  2 Jun 2026 17:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] Bluetooth: Fix data-races in SCO/ISO connect paths
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178042080663.965718.10676040652075831964.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 17:20:06 +0000
References: <20260601111908.232707-1-suunj1331@gmail.com>
In-Reply-To: <20260601111908.232707-1-suunj1331@gmail.com>
To: SeungJu Cheon <suunj1331@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 me@brighamcampbell.com, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  1 Jun 2026 20:19:06 +0900 you wrote:
> The connect paths read socket address and config fields without
> lock_sock() and pass them to hci_get_route() and hci_connect_*(),
> while connect()/bind()/setsockopt() can update them concurrently.
> 
> Patch 1 covers ISO (iso_connect_bis/cis, iso_listen_bis,
> iso_conn_big_sync), patch 2 covers SCO (sco_connect).
> 
> [...]

Here is the summary with links:
  - [v2,1/2] Bluetooth: ISO: Fix data-race on iso_pi fields in hci_get_route calls
    https://git.kernel.org/bluetooth/bluetooth-next/c/961ea93b3ceb
  - [v2,2/2] Bluetooth: SCO: Fix data-race on sco_pi fields in sco_connect
    https://git.kernel.org/bluetooth/bluetooth-next/c/4a17208f1b99

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


