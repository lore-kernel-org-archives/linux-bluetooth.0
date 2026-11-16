Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794859212;
	b=RG1z/QUQ3gpZlonbAwIUMDjIKyHM8wcZVpnVVrMLamyWh7iwTvGqWjYNiNhNkill7K/L
	 v7vt3EOMhhgM8cgzM75mR7yW/RuhOtuLZ6BicNtIqcMschfjOL0fD39l8aDgMcJQM/OM+
	 v3PMeKcb2TxenuGTuE/geMZuNKexi5U0ViY9MKkO8+F9HRODd0kfEpUGRvwaRi3X5i2d5
	 NKPjcfkX0xwl9xuEE+ijr2Ft8jk8IvRiStey0NLUvPhrt+7v7Xaqw3f1Z+yFhA6siNds0
	 AGcCQm+J2gMe0yGFnA3SdOqll9GOF5HX3H1VdmU7cXaHnvM6JU+uAeb9RHjcjOjVPgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859212;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=pGQeZFgVbQPZefupieXTwlqLBLyBWq9EFyGOoqW1BiY=;
	b=5UOxVj9d7VEjhQUDrZu0GhqwKzAOFx9lz5oH8oOsGTjWZ1m7vD2BVT5m7tnK4DxsWdPb
	 RS+QUhn2lOKa+g2WbMu6B9L0a087Q4juyHjLj0ZUAvMO57w8f7TCHP/aWEZUa/y3pw3Wx
	 jZrZ6ank0oAztzuyhXlsuDe7OnC4g+jI0ppA411ZG3S1/weGfI+1SPmz0i2T017/SObY1
	 XAVCSNsikl1tCEkTh+QLy2ZyX8KjbiA7D9OTWmy7lAApn1GwTB2gaYYrytSOi4kMRAoTJ
	 hxabUcO87jiTO9nQA6fl06029JLaCLKLVxpwPezrXPXeULQYyF3Sk97NDX1fXdmsytQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LCllPTXF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F20606A322
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 20:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LCllPTXF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076A41F000C4;
	Mon, 16 Nov 2026 20:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794859212;
	bh=pGQeZFgVbQPZefupieXTwlqLBLyBWq9EFyGOoqW1BiY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LCllPTXF2VUghlF7oN0F3Qra2xrZaNreiNTf3cB0xT5VNRtrzFEkEvH7uYq5jxRCR
	 CRt39aZMWHJNC9rbVZI4bNCoMkvt8HZagP1E+BoK5MXWoHDEKeqsBTITRvkK9wa+gp
	 q25KlgkCLShBK1W/pLQW3no8Q/oG+nX437b4Yc6Ao9qYl8+LlbKMUoNtBmxOyjHRCv
	 QiX/PQgxgBmNu50xgI9ZgQ6q/+/gcBMjgWEYFTluNwVc8O/AGf8sgTiw5zEa7NQEsa
	 xHfhH5hb1UG3uxNN1EUGxr4kVntjYonzWxhcYdj1DGE4kTMgHcZZJEnJDaxB5ju/AY
	 yuQRIQ6dZyfBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F13FA391AFCC;
	Mon, 16 Nov 2026 20:00:11 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ] audio/hfp-hf: Fix org.bluez.Telephony1.Dial reply
 message
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179485921052.3860040.15567379850134557342.git-patchwork-notify@kernel.org>
Date: Mon, 16 Nov 2026 20:00:10 +0000
References: <20261115101907.68963-1-frederic.danis@collabora.com>
In-Reply-To: <20261115101907.68963-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 15 Nov 2026 11:19:07 +0100 you wrote:
> From: Frédéric Danis <frederic.danis.oss@gmail.com>
> 
> An org.bluez.Call1 object is expected to be returned on
> org.bluez.Telephony1.Dial() success.
> ---
>  profiles/audio/hfp-hf.c | 51 ++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 48 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [BlueZ] audio/hfp-hf: Fix org.bluez.Telephony1.Dial reply message
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b5deaf496419

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


