Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D40397350
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 18:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780596606; cv=none; b=iCI1GFhcFGDAzb/Erqi4lwjUs9USEiCHlfhbPAVKSA0DjsOktvGQkvLYNVX/ayHPJ/gSRaUrDCxrcDzsQKPORJJo3V4zGs2kO6DFwuBfRpc/yZBmkAtaXrJ0PkJh/4v/zBRPhsggbUfAxQRG85pbIthNNku3vh0QN+nYVMiDUuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780596606; c=relaxed/simple;
	bh=U6zt22Uhpe4BcdWCfy3+svayvbwIZAt+TdRJRe9YNvM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k743oycCW5H5jFg8i6uDfXGwyPskgW9crRqLh6eBw9jeqTi2vmSdHh8WbjZCPQaf8NZ+ypPyNqE+CqlommWA8SRkVir45VsVYLv//t4seAu08R46Zdkh277r2MqMUy7TggpuJm9QkC7RbKZSWyD9mMB9Ly4xk6Fy7mo8n21GpRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHgFhGzt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHgFhGzt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447001F00898;
	Thu,  4 Jun 2026 18:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780596605;
	bh=O27Px9xvfo4bWbHGWgC3162Wl6UAT5X9sqCuP9khIcU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dHgFhGztr4/ZSBxe2vcoFGRTmj8OR5+LlJoK1M6+UTJoly6V3EiAjVKOLqLWPw285
	 FVLqf+NTfU+2ex1qsf+uaRuYYFqmw8pmb+olDyZ96p+9O0YL17gAcgcGxnxD6oU538
	 7WDDBKqfhLrjS6SktMbZUCDIVs51iuW8LAIZE9YhN8u9h82eMAo4qD+z/H9Zr83mrD
	 L9aNrqjfB59gyopEy4CUfQ2KmTPl5Ysk1TlnaG7097Ei1t+q85SFeQNsAgpDN1xFe3
	 QHW/z8Yz1F6o1aIKkWzw23BbN3IIb5aVpjavkam8ROAN91LHL+BnUH4sCRMPHHs0e8
	 tqbMCnCXB0Mlw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A033930A14;
	Thu,  4 Jun 2026 18:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ] build: Support libical 4.0
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178059660613.2966613.1193010785386035445.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 18:10:06 +0000
References: <20260604080139.1264222-1-hadess@hadess.net>
In-Reply-To: <20260604080139.1264222-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org, fundawang@yeah.net

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  4 Jun 2026 10:01:35 +0200 you wrote:
> From: Funda Wang <fundawang@yeah.net>
> 
> libical 4.0 split off some vcal related functions to a separate shared
> library, libicalvcal. As libicalvcal depends on libical itself, first
> check for libicalvcal being available, and if it fails, check for
> just libical.
> 
> [...]

Here is the summary with links:
  - [BlueZ] build: Support libical 4.0
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e60d07255327

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


