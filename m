Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3B34E3234
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 17:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617886; cv=none; b=RxGYsY/C3TzLKY/CiT40UKjFTpsAfEZOeirGdaFXZWje4kqbSLZCtWaIXXGYGlEH7D9umOc86BlUPCurlcTbLIfBdx/f6MN8E1ZfuOPGDTFLn065uY9WvZdW3H845BKxgLXEKpXqtGX82y28zC7lVBOc+md1oVkSlGnhN8wDoYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617886; c=relaxed/simple;
	bh=Yjxxwsg/uOrsFT3u54eku5NdD2mYTohdZyrAyEVIYec=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mviceMTCsm0GZEqZByYqxjjADUIn4G/wWWZWeKPzOWZMskcvI/TSV30L+gUd1dLMade0saqejet7Au90L/bictWe+IYWZNWhz+0ZLlVV4GWk2qXrrTTncH4oAkojQdLLtEH4Gdi9JIiGR4XlcvckFvmKmhcmiMEiIWum1hyYyeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LA6fVvbY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LA6fVvbY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CCA01F00893;
	Mon, 28 Sep 2026 17:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790617885;
	bh=mLLm8vIU6clVuxpTLaIB6NthPmhM0FDYv3INNDiR+ek=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LA6fVvbYMIjFL8Ty9pZwY64tLyzV5xlTLwTmpXE3GNAiv2eCVoSegz6KlIX2gagLZ
	 SZm5UTtn7dFH/rHpUjxuJ6iqGnpdlGdzWL8Y3xgwRkKle+KI0NeBof/mvEhZHaTt4W
	 wTMAQG+NiG93b72Erd+XrtFG5mfsxVEsrM06B6yx8OC88eBsZPG4ihmqi9gAoFFaj/
	 r6Mr/GbB53Euy5NoJmpPOfd9sOmfkT2BxseHprw670hGY0gzGS75Q4NyOfMTcfvaKZ
	 s4GKH6/SwjDaTQmCygyBaVn5yxC5MwWXG7/MAIXx43ysdCdwHChJgFKh6GyOASZOxG
	 EC+JmQ/V+S2aQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 196B13924A77;
	Mon, 28 Sep 2026 17:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] doc/qualification: Add MCP/MCS PICS files
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179061780964.50268.16025490268260239462.git-patchwork-notify@kernel.org>
Date: Mon, 28 Sep 2026 17:50:09 +0000
References: <20260925124942.3347628-1-frederic.danis@collabora.com>
In-Reply-To: <20260925124942.3347628-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 25 Sep 2026 14:49:41 +0200 you wrote:
> ---
>  doc/qualification/mcp-pics.rst | 569 +++++++++++++++++++++++++++++++++
>  doc/qualification/mcs-pics.rst | 513 +++++++++++++++++++++++++++++
>  2 files changed, 1082 insertions(+)
>  create mode 100644 doc/qualification/mcp-pics.rst
>  create mode 100644 doc/qualification/mcs-pics.rst

Here is the summary with links:
  - [BlueZ,1/2] doc/qualification: Add MCP/MCS PICS files
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=83d3eb1f54a8
  - [BlueZ,2/2] doc/qualification: add MCS tests documentation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b409d054248e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


