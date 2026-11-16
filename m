Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851414;
	b=vxNQxbYBsZPg3pDG/5voI2Yzy4vx6SsnLhbBAhjdpP61wQOF/7S9Jn7Miq04gD8/VrzY
	 nJZUxOVP2QZiMBg78r4a4Na0Ca32xgRbhN6NkdNFKL4GegJ9KRPJ9CU/gb3bVRGxBMNfV
	 gMa1NlFXBpAf+1328fFpSz3NS6q1lywJTnsRT6bPLoVaX2o1rQIiUW72S0H1zsr0736dG
	 wnOCJs/6n3ynP0OwH/iopktvR9LJSypw8G7+80YXLKfdzjcOghcxCwiowQtb+QLxvagtL
	 48EdievFaAm8qUmVouVCjPBAvEUksH8ccUXmbUYNBITGMwBoIx9YFDPEc2crnEp/MjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851414;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=mC9teK5ZqbAZxiwnLuP5xP95B3QIDT1cCX8Cxr/RNdM=;
	b=THV5XCQZMtN5PZuV5JW36iRpTyLNwTO2i6E3sj0YJPZl8dJjuD7r/alZquJHrty1GC/r
	 pWaQThNCUFTZ9VTSA86pXL/QRhhtB3y4q1qyTOrOx/GelSf1yHxCFV+eMSR2VqYdPUAy/
	 Is7VyhbxhZ9sQ2hfi4j2ZbUKM+X7ZZwObhgA6Y8b4zzOyx1cV6yey0arhahotfa/wLKuK
	 H+1TNoycey6uzOJdJIKFExcTn36njB0U4txs48nGKMgHXReBCtAdKJpXu5y9DWo9Zjzea
	 TPekcCex9PKCzgpv10/vir+QvFtoC5ETy3lmLxDTqz9WfQZij88rohMCYnYD3VkoFPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hJKiZ62V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BC9606A885
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 17:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hJKiZ62V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42AA91F000C4;
	Mon, 16 Nov 2026 17:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794851414;
	bh=mC9teK5ZqbAZxiwnLuP5xP95B3QIDT1cCX8Cxr/RNdM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hJKiZ62VbWHh3VJwAitG03L0i6Uqct8bj1ZuED2UILudsgCcWOq7MumUIUSZM8RIi
	 78bNOxmj8ZCPYhlw5oOK4Grhri4lJuoU00WPTB+lM0Awpob0jdWLqiJngI2sSdDKxa
	 r76wni5R01t1/jRYtgD7i0fhfaIUR9UHyPPqQgHTXTlqRQ1qkEnr/J5iaaT7Q5xFBw
	 Iw5d+HXrTf5kNJfje0n5aNhFwUKBu/y8glbVmVPXv8AYZZQP+nvh3EvPBYfSmYRW72
	 6EgUbpjaNbzXiTMHrh33x/39hFVrKTCDC7GMlZ8K5rQ4yL822VZhbiJYr5bgq7d9Th
	 GoFepJeSQGgiw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A1F5391AFAF;
	Mon, 16 Nov 2026 17:50:14 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ v3 1/6] shared/bap: Add bt_bap_foreach_stream and
 bt_bap_stream_get_rpac
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179485141277.3796096.15931277410024589978.git-patchwork-notify@kernel.org>
Date: Mon, 16 Nov 2026 17:50:12 +0000
References: 
 <f5fd668c6dc3b7a9044f218935da759b862e54f6.1794428234.git.luiz.von.dentz@intel.com>
In-Reply-To: 
 <f5fd668c6dc3b7a9044f218935da759b862e54f6.1794428234.git.luiz.von.dentz@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 11 Nov 2026 15:37:28 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Allow iterating over the streams of a session and getting the remote
> PAC of a stream, so streams can be found by their remote endpoint.
> 
> Assisted-by: Claude:claude-opus-5-5
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,1/6] shared/bap: Add bt_bap_foreach_stream and bt_bap_stream_get_rpac
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=36dba202daea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


