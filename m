Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794859215;
	b=JT0pEyknvAc4YaRUDFKgXiVimzDxaHNqwtdcWyyPqSuhGljmvypJtarxBZ0y8T8NDZO5
	 pzxtapuqmV6DBmmGOP48wkzw9T1L2Wg+cumCV4QxXgFzfKIq6uQ+2PFL/ruDtDJ9g2an2
	 Oe5z4DB6FdMI3QtZ3jEdl/DJTZKb53AYNLWoJiEksIdJPevgBo2/APlL4exBMojO9Xd6A
	 6u4ACwgg53yBA5xRzZ44OaatG0PozNczq40VvX6G35Qdqwlw09pJX+MWNM/iGltAx6Rn4
	 Ij1rqCQJErnFBBChQuLy47CYStK0mM4Wf9BMoNQKh119mddGH/unLJR3eFyvBp9xZWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859215;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=E7ds0rKjFLjTwWVGDmGaZsSO96540U10FJ94t9XZeXE=;
	b=bnnXp2gFFOXyfKWW4fVsOKLGR5XGNLvYE5MdX8inwXjseFBdUv84/dAUn/vNkTDtk1+q
	 VfDiwiv/mZ8FU3rCZXc6uQz3pzXZL/IGGAKjzcnzwVIPRs5uQ71Wvrgjw4vLlhFV+WTM0
	 BCazaMwCuRInnp5InCIvkK4TWG75OlnQTgC8ZphCS4Q9i8CPNsNd96qmaWLM2AHm4m6r2
	 GOJZFeYh5I6yCOBxEfSYL4SGSnOZH+8zryWvEr1w4w0SvFchVApLFfawlmCpAruvC8IdI
	 D3Ag/nboNLyOnK04oAwfSECS9n9yjUhKgO3BZ3TmtDqfJfqJbQzibwdP9UNzv0uMGnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aJapWJiR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFFB606A32C
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 20:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aJapWJiR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A7D1F000D0;
	Mon, 16 Nov 2026 20:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794859215;
	bh=E7ds0rKjFLjTwWVGDmGaZsSO96540U10FJ94t9XZeXE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=aJapWJiRCJ9T1Zjgf5z2gHk5HWIyk5DlrTYIYiwmSmTWeNVyTvGNpnRFM3HgJCOKp
	 FvclAssMmBC/m9ZQNa2OqEYpCzmi/cMDLnnbIUP0ZXR4YUr2i8wT5C9vqq1EPV+Km4
	 aCj8uylTaC5hAB08I7C/6kIoyievqqiEyNjzVTP1gxk/ZbqtfE8gbI64BY5b4SAtt/
	 w6bzxTdq6tdEWiO4bMqVGSmJwse7KL6Ir/wGvExuaOfZQKxnyqqMVgAIyl4JA4cwTB
	 1rN3u5kgH5zGyKMOBnmJJd6aTrQesZYHi4o01nA3hOuZIxmmet8ThG8TiG73ghDnoW
	 qIrl6dUBJHeGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F13E4391AFCC;
	Mon, 16 Nov 2026 20:00:14 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ v3 RESEND] avrcp: Poll GetPlayStatus when position
 changed event unsupported
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179485921352.3860040.5845821355706416129.git-patchwork-notify@kernel.org>
Date: Mon, 16 Nov 2026 20:00:13 +0000
References: <20261116093308.79430-1-frederic.danis@collabora.com>
In-Reply-To: <20261116093308.79430-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 16 Nov 2026 10:33:08 +0100 you wrote:
> Some remote targets do not support the AVRCP_EVENT_PLAYBACK_POS_CHANGED
> notification, meaning bluetoothd never learns about track position
> updates for such devices.
> 
> When this event is not present in the capabilities reported by the
> remote, fall back to polling AVRCP_GET_PLAY_STATUS once a second so
> the media player position stays in sync. Polling is only kept running
> while playback is actively progressing (playing) and is stopped
> otherwise, and is torn down on session destruction.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,RESEND] avrcp: Poll GetPlayStatus when position changed event unsupported
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8a3bdbb1f5c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


