Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851415;
	b=nF0bXMRnM3kjGOSV49VhKvDLDmxKLS8Q+455nSqS3nRTVofcDXHYJi5NChuGon2Yqafj
	 KT8bnVksQnLgWFCOIDM7aB0gbkV6x0A0ZRSg27kVYYCQvtstWK7L26e7NW9hxEnZvRmzR
	 zJb1/MdXkMio569Iv36r0tLWDIN5bqALkpAT2N7VvSwp/8q4NSZ5kFL0KuI5tlIjsKBoZ
	 Q/8A5eCmBFXzcVrp7vTMtboBb5KUlzwHofKHrhJdwocSRq2mcsCUhMplcdVrNwDruQWMT
	 kkSBARi6dlit0Fcmbe7V73bALZjvzcr1h/y8ElNBs/bb+wfPj7w+kxCSQ5+tMXQBXLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851415;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=jAZnZfgykIBcnKvFHBggOTL2AU0K5VKo85i00y6+Wd8=;
	b=J6q7yoCYRqmZGe+qVCggoeaiId7c3clwGKtB3BImm9ADM/+QUgRjIUviNzKnqyK9GZcI
	 UCWMTr0H0/ea7skmld+UMUXWvdzPI3jkzVv/DKRecvJ6IVCpENMHP6SPStR1D1lWDCcuU
	 3PtV5HyxPb937UN9OakOSqlXBelMuPH5l0cBMETEQQ8/dzX+IiNzVxQMVdCSIqOlDXw5f
	 FtUUHo37Nj9jA+eKJ/VAAQ85gbTlbA+J2ZEZUnnY8xASgjzYlGtSZaDsIeCpcU2B3uWas
	 DhGW+l/NNPvIzGAs4/7zPJB9l4vlL73ENtXH2bk8rwbeBp5YJ9CoMrPEBiRZPAdASUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IB3EH9bS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA1C606A329
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 17:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IB3EH9bS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB841F000C4;
	Mon, 16 Nov 2026 17:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794851415;
	bh=jAZnZfgykIBcnKvFHBggOTL2AU0K5VKo85i00y6+Wd8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IB3EH9bSwJfOla7m/fWw9E4l/KiFLbfdVfeS8Ov9XD7h6i1p/Sm/0/LrC0Yb4tjwL
	 3D14eLdo/2adg4M4txwmwdMhzUVg5yPM38jeUlbquyMfHz1tfUjXRg5NuIps60N+Ci
	 al+JAvDj7tqSjjAfZs8PLGUrr6VKp0KIORktJnWgM3FYAtc8wP7MrXRem0yqiz0P7X
	 gnKcpD4u7vIsCpYyrlLmRPD9aHrmyMGrNcvN6NkqQegz0RkFHbmxhDUex6hfJT//CW
	 Om/6tR16noDIhNUeUHSG7FOCZuQDGLlNG/4y0WfBu+uM7Vl0HhFWzhoYBLp4fE/MPo
	 9zSGnVwMDwMhw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B43F6391AFAF;
	Mon, 16 Nov 2026 17:50:15 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ v6 0/6] bap: Release cached ASEs on
 ClearConfiguration
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179485141426.3796096.10783730872129856781.git-patchwork-notify@kernel.org>
Date: Mon, 16 Nov 2026 17:50:14 +0000
References: <cover.1794586887.git.luiz.von.dentz@intel.com>
In-Reply-To: <cover.1794586887.git.luiz.von.dentz@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 13 Nov 2026 11:37:52 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> An acceptor may keep an ASE in Codec Configured, caching its codec
> configuration, once the initiator removes the transport. The initiator
> then has no way to get rid of it, as it no longer has a transport to
> release.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v6,1/6] shared/bap: Add bt_bap_foreach_stream and bt_bap_stream_get_rpac
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=36dba202daea
  - [BlueZ,v6,2/6] shared/bap: Update the remote PAC when reusing an ASE
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=be6c46a679fd
  - [BlueZ,v6,3/6] bap: Release cached ASEs on ClearConfiguration of an endpoint
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=008ad1062431
  - [BlueZ,v6,4/6] client/player: Add endpoint.clear command
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4d6b6de326ee
  - [BlueZ,v6,5/6] doc/functional-bap: Document clearing a cached configuration
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=aae21a5e6d50
  - [BlueZ,v6,6/6] test: functional: Cover clearing a cached configuration
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=549ae613d637

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


