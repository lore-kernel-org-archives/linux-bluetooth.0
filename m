Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723412;
	b=YYvibvpwKSkFNDYgalWETpeTAk6mnJR/3sSigzOUKupgW76gNZRHMQQCgB3ADLYI5CD+
	 76NussNCVrm2NQPGRFgnDaxsXm+Y6DN5VSBNWoux1BoMJKP9I5vFB1sIsvDTRCau0eaG1
	 b6T4SYwVRdRK+3dx4INX2y5XgDlTSYOubjOlQ+LEkYUr2EBxHqvskkxk+DEwfN8VOp3yA
	 FF5ZJiM/PLe2MDtB2pgmPresM7a9tjXaZlzdITWxAjJYVeXbe7b4yVjSpsC8awa99lkoI
	 li4dPPBfSrlB4Ep2znnr0n/yZ+cGZP4WxfUqqxvxiehg+Pt5d46ub5RmNEAl9IMxd9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723412;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=oDjzaqeYA8B8BYXNpkcqPC6dggTAzQ9qFtqNdDkhKrc=;
	b=07T41N9ufzI257iOErdGwK+rtdoDTkTIFskqATQaFa6COSzdmbeNkvRenwResInP8mDS
	 1XCDT9mIqojF1Tb/Jkc8dG5ozV3F3GzflVl8l29N1NnUrxzb18LmaoVeGuwhwhYpWUsAr
	 qcLakzaumJpE+bGZ6LbgcmUUR6OM7YDjQm6As49xOohz3XQHtdVIXkI86I0jlHOa2lfSO
	 nA3COr0byo+wpXC5zWRwEnNjlFFkTdUcKFkGxIqDuv16I4DOmVuXURCSYrCx2ysjAEhk8
	 QJLCo+EmGOpeHteh0vhNyiWz4KQXjrCawSid86Y3CK5MEj1xL7yIt5eDSyZF0B34/yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HBWlwW6n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9351606D824
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 16:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HBWlwW6n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8834F1F00A02;
	Tue,  3 Nov 2026 16:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793723411;
	bh=oDjzaqeYA8B8BYXNpkcqPC6dggTAzQ9qFtqNdDkhKrc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HBWlwW6nTVsgaTluN6MYqOLhur0VcBeCjhEw/xwgK2ucFly/6ueXXAYSseZcR8WSY
	 dpqxgpBQCx4rnvXNVQ7XMV2Vu/MExCn47hhsi9NsM4tqTvRTbJDWi4unPtB+NUIvd5
	 LZLJDULRhsI/Hndl6OGGesbV0eYjoe/cOuhky3yvhTiD77g8ueVMGpB6EMW+DkC+4n
	 JLv7IuQF6H+diUBkbLbXiFZEP5oOTT1Ifo+lt2B7lYhcY5M/R8OCF5uz4tFkmbZDXP
	 NZ6Ob3XINtNBiaYH8/5/Wq9PeCx5e3B4MzKpI72T8N6IzCui7X0T8+iiO2oDEH5IF1
	 aVaViMmg05jhg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D150391AFF6;
	Tue,  3 Nov 2026 16:30:11 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ v2 0/6] Fix linked transports of an ASE not enabled
 yet
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179372341004.1736455.15818678357433071838.git-patchwork-notify@kernel.org>
Date: Tue, 03 Nov 2026 16:30:10 +0000
References: <20261102215457.2553416-1-luiz.dentz@gmail.com>
In-Reply-To: <20261102215457.2553416-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  2 Nov 2026 16:54:51 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> When acting as an acceptor, a remote initiator may enable only one ASE of
> a bidirectional CIS first, e.g. a phone in a voice call enabling the
> Source ASE of a headset before its Sink ASE. Once the CIS is established,
> the transport of the Sink ASE, still in QoS Configured, was set pending
> along with its link, so an audio server would acquire it and either get
> NotAuthorized, failing the working link as well, or have it made active
> through the link while its ASE is not enabled.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/6] client/scripts: Add bap-duplex-lc3.bt
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e75d5491cc20
  - [BlueZ,v2,2/6] doc/functional-bap: Document the duplex unicast test cases
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=93c141cf6b3f
  - [BlueZ,v2,3/6] test: functional: Cover enabling one ASE of a bidirectional CIS
    (no matching commit)
  - [BlueZ,v2,4/6] shared/bap: Add bt_bap_stream_is_client
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a0154796fe33
  - [BlueZ,v2,5/6] transport: Don't set linked transports pending before they are enabled
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=37371e853271
  - [BlueZ,v2,6/6] transport: Don't disable desynchronized links on release
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f72ff35595a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


