Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64F53AE6F4
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 19:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781551810; cv=none; b=a2HgCQ7ltKpPD84ATWcSXeuat9xM9wolD7Q5/t+WQA/vQjn1yw1opfGk/odG/aDzT3EyZaZkZyTh0i3+QFzxdYHR1AzevXQ22SQfVYSSIOb63BlEufk84Pkg4iKDqynRJooUvaCrmrymmE14RGv30Z0ejP3JjJTZvKuNCVdqg5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781551810; c=relaxed/simple;
	bh=R+R5JGM9313EA1YXf6uNdOHdC0ciEnateLlSQseXpvU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SzNnvGKmrcgbjzdx8Bn4M+cVGRHIRNcpMJDnfNqdZmeF9AelnGk62Z/fsqyQpLf6MwQtMF8od2/LoJ0WS/w4BVeNpJB5ilu2M2sANfQmObREN5rsQfWOkAOihvMywUNcIkiq8V/jjt7msDWs8kK+S/H2DWSgH4iEIbGUVDFwc8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etVtDBgW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etVtDBgW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BB01F000E9;
	Mon, 15 Jun 2026 19:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781551809;
	bh=LDi8GYFlic8FpCHDdM+f23/XQn6TjVHfV5mh1OafFv4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=etVtDBgWT0n+TJr1R8NSM6FxmvKUpR/fDmaQvjPo6K+w1zO3Vf1l+TulGXONRUuZX
	 7ETChd//86kWw4xU8wB38LXz0nplFF/x10ZkkApMMg+BCjGkaC+IgA6yRhhE7F/10f
	 Vq5Tb9FbZZR8zw7Q5C+9qEzoT6/4aYDXx6IKOQBZVsczPQ5lfyvtTSlcjlQpY5jv2s
	 u9M5WscspiKFXffyt0SZJeD/I4Dtiszpn3kU6F10yRfKm6+7O6AYZgRFyUejp9cDwa
	 oBhtlY+e+ZmbQ6znsD9h+yohD/qaeV8rP1iEzn6xiZPxMdoYwRiPRuPFcqBXxpbbcr
	 K5+ePKzr7szGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A3E3839A06;
	Mon, 15 Jun 2026 19:30:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 1/2] shared/bap: Initialize ucast/bcast IDs as
 unset
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178155180439.261971.4637861728508977400.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 19:30:04 +0000
References: <20260614105016.1147112-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20260614105016.1147112-1-simon.mikuda@streamunlimited.com>
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 14 Jun 2026 12:50:15 +0200 you wrote:
> Also change some lines where CIS should be used instead of CIG
> ---
>  src/shared/bap.c | 13 +++++++++++++
>  unit/test-bap.c  |  4 ++--
>  2 files changed, 15 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [BlueZ,v3,1/2] shared/bap: Initialize ucast/bcast IDs as unset
    (no matching commit)
  - [BlueZ,v3,2/2] shared/bap: Don't link server ucast streams before CIS IDs are assigned
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5297cf2b6af6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


