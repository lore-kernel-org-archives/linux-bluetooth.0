Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795626612;
	b=P1sFKuTVvlB1ew+n0oBYoL5XXRmR1ho8sHMPK0XH3dbOmI0fE9KB2LiGILtWiSO9rxCe
	 x79hhQ8CD2n5PCWu41lfcEAWiytk/EbYNU47UMZT7c1CZBszAFEe0yHlH2duFi/cHZGFH
	 vcLMePNuzgIGRlltqqwFUftfenxAykqCNOM8GPlVqvRYal5SY9CkxrJdSTE2uGnDHXcRL
	 L90oNALK+C1Jq3CCVP6hLB+FnUgyGYShN3d1uoZWLQCz1yFR6yLgzYGOzZuY3wFPw3Wc+
	 tK1qxQ9bneBVDqsOTTcKBVfZlwurK5lClST4SUTzE45NtQR3PQ9biTD7pzjEs0qSHQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626612;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=BbJqXQ1QmJY2x+AN3wLy0x36jm/lYRrXzfkVRCU3snw=;
	b=GCeyi9jC1R9FUfa9ZXK372ZMkQm5qlO6wguPGMSM0l6rucWviNF0qD9a5Ggu3MJKb592
	 mYM5h+omovy8FeYfs27JznSCk1hm426yNBj+0HIy4pTUrxJ1MV+zohWitW0k065R4YpvY
	 cDckXXLFqcSZ8gWF377FhzQgA8dBIGYoPO7sfg2iABtetdl+MpBS2BW3vtARlSC6o1mcs
	 VWuXRKMqIixGbWsXo8YvdDJqWkeL62w9m7cBJVdldv7kfZBkf4o2HAAxxaV+S7x7dV3+b
	 ODDS4A+lLMTrH/EZvz0ZUumhKSVdfQJpK6hxGViFR8vQ4RTXVGoccDS2sC8NjUnrrMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z6pQKB3x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81664606A326
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 17:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z6pQKB3x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD2041F000C0;
	Wed, 25 Nov 2026 17:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795626611;
	bh=BbJqXQ1QmJY2x+AN3wLy0x36jm/lYRrXzfkVRCU3snw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Z6pQKB3x1ix71If2LJ+jLKSLpQMUmeKBdHGQam0EnCR8+MsnrIx7dTUiUvIyQoTQ1
	 LVXVQ7/9+4adG8DhkPgn6+BT3J+uTB/E96PijNZ9SM7coO8AEHojFL24vX0T+JY11q
	 sqtY9JDKnz0Lq0q5qe0WBL6OQ0uGYqjDM7pzBMTyXFz8Pvr9otnHSiiuFpvv9daLW0
	 4zaAKsp93SDMoH7Yf0azNrZDF+lAd4rJojzYKPGAOMYwU1VNF6U0lkc86AMhYXzS9R
	 w+IZxrRBNACNO0CiCaQ2vRNe9qMwHVzokzxeRb4ga8S48uyifx8EyeouhZ30rSlG7E
	 eeCufdhj53z2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B435F380821E;
	Wed, 25 Nov 2026 17:10:11 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ v4 1/4] shared/bap: Remove broadcast sink PACs in
 bt_bap_remove_pac()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179562661063.1207837.9138567383887194432.git-patchwork-notify@kernel.org>
Date: Wed, 25 Nov 2026 17:10:10 +0000
References: <20261125170234.1648990-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20261125170234.1648990-1-simon.mikuda@streamunlimited.com>
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 25 Nov 2026 18:02:31 +0100 you wrote:
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
  - [BlueZ,v4,1/4] shared/bap: Remove broadcast sink PACs in bt_bap_remove_pac()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9de52c6b51c4
  - [BlueZ,v4,2/4] unit/test-bap: Check that a broadcast sink PAC can be removed
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b0ffc6b9241f
  - [BlueZ,v4,3/4] bap: Don't leak the io of a PA sync that failed
    (no matching commit)
  - [BlueZ,v4,4/4] bap: Close a pending PA or BIG sync when a sink session ends
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


