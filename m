Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795626611;
	b=MEcbwNGC68wVFrPPC0dJl8ibN2qXsOSSMvAeqXFKda/m/X3oLUm3y0+kuXoyTJX+Ybp7
	 IjGmYAjBVuvUgBnTivbnrnOJc6w64W7fynuZqSUN66o94iQatfSMJXNbKOSaPiqI8k9Uz
	 Sfwnrwj157xjfxa6uqOP2TvtjAGftK0sKHLenVB7foZ+dBkGtXSn8SUsYYYY/N9yYA+Gc
	 C2omMXZ345B8+TXOd1g9gOZNFEa/iPhOAZjgGdf7y5XH36NaoMD1H7yappAv19fQ7hLdO
	 riM9PNkDeTXpkivK435loikaXacnIBCG57mHPPvKnDDE67A3Fkv9V067ZOgMrotvegw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626611;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=a2uppcrQHSb6ZHMqzszYjmfmczECdqgTsthz+56Yuxc=;
	b=L9UkiWXDYqLLVtq5YsowHwamYsNbIZ2HTZZ4UJ+IDfD1FK0uvWoORDFzRPdu33/zoWcf
	 cSHVz/C/mB4A+wAoZErvITchWTmpl+2E+u49NKZ+zZdytmlGtqsBHOJmecRi/yUqJ1IUn
	 Ekocbp2iFKWQtquSvY3rSwECoTiCqa33tS03G0VQAZqpoJN9XeYrs3EKHzl+TL3nbgqde
	 e+88ByJAPnAC/mbpB4BjPd1cRxKvnB3J3wSQ0/tmu4haQOC+hpyp7dBQy5qVZiqE8trU/
	 cJIU75S0b/7sXLA8RokE4KgQTvL/xOjgNYgwkWz6Cbb4hRWMI/IIjxMzh7x5NaY3l6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dRzj6etU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777AA606A326
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 17:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dRzj6etU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF851F000C0;
	Wed, 25 Nov 2026 17:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795626610;
	bh=a2uppcrQHSb6ZHMqzszYjmfmczECdqgTsthz+56Yuxc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dRzj6etU8l4KXOPKFyGvioqJvhXXRc3iR6Pi3kIVGPlZU6rjNjBEkrN3jShNSS9x4
	 thUL+mAa5W4GEwmvB0Y6vJcrwCIuGb32+Sj3qNS0KnV/4dM0c8jXtCubT3gCqp9/NW
	 S5Qi+7lzrHC9h2tOI0tgoRybE/u/4SwEqWdvmmpPeahYqafTwg73fEXfWw9Ih5YI1X
	 ucjjVxzX+jMytP5x6ZuHkDH8ACwtdBuZr8sFSdJhYtFXnfPssZ7FEKWHoO73iIApOR
	 cz/zucU+ptG9mzHi/x+re8TV8fQhvo+UbTapAwOOc2lXkpHPLi5uyCO7rSgxIWWNs9
	 7pF46UWjrQ56g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 927AF380821E;
	Wed, 25 Nov 2026 17:10:10 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ v3 1/4] shared/bap: Remove broadcast sink PACs in
 bt_bap_remove_pac()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179562660940.1207837.11592746206680106533.git-patchwork-notify@kernel.org>
Date: Wed, 25 Nov 2026 17:10:09 +0000
References: <20261124150922.341655-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20261124150922.341655-1-simon.mikuda@streamunlimited.com>
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 24 Nov 2026 16:09:19 +0100 you wrote:
> bt_bap_remove_pac() looked for the PAC in the sink, source and broadcast
> source lists only, so a broadcast sink PAC stayed in broadcast_sinks
> after its endpoint was freed. When the endpoint owner goes away, like
> WirePlumber restarting, the next BIGInfo matches the stale PAC and
> bluetoothd crashes:
> 
>   pac_bcast_config (endpoint=<freed>) at profiles/audio/media.c
>   pac_config () at profiles/audio/media.c
>   bap_bcast_config () at src/shared/bap.c
>   bt_bap_stream_config () at src/shared/bap.c
>   create_stream_for_bis () at profiles/audio/bap.c
>   bis_handler () at profiles/audio/bap.c
>   bt_bap_parse_base () at src/shared/bap.c
>   big_info_report_cb () at profiles/audio/bap.c
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,1/4] shared/bap: Remove broadcast sink PACs in bt_bap_remove_pac()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9de52c6b51c4
  - [BlueZ,v3,2/4] unit/test-bap: Check that a broadcast sink PAC can be removed
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b0ffc6b9241f
  - [BlueZ,v3,3/4] bap: Don't leak the io of a PA sync that failed
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2d690b7b42ed
  - [BlueZ,v3,4/4] bap: Close a pending PA or BIG sync when a sink session ends
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=79162c108911

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


