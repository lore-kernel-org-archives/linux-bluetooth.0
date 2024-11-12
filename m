Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EE02071E6
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Nov 2024 16:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731429625; cv=none; b=KWDw/oR/8G8MGi5ItdVYm3TIWBR2fkEjEkIejVCsic1y5enKUsJGbhlgj8mctjnmv6wLFvqKle9QUdVewRJlYFgAP9UNM8biajhPAcUxIlUvNb851GSxJ1jcIEqBwSPngTXFLq24UB0TqWOVyYh3UIHKSrjUT5iZOZuhCbBRt1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731429625; c=relaxed/simple;
	bh=PTxvTdWhSIylXwo7o/pGnGEWUjpsQB0r2cP/+iwbxd4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J4yPv2HPBWgF5tXIqMt0AcmGsZEPIE/4IgU6Xl4+DpdJW+Gqv4ViYoGrCLkzFB47uU6VKek2P2dShtJmCXTrxIIDAXcW3YNbi5HAOkEwSqrcJVYRkPSyZbVDiP52sRuLajwGAfbjJ/RUXF4UoPAACGoqu1jTx/iVeIzoX8nQXYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nw0x42wQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nw0x42wQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FE7C4CECD;
	Tue, 12 Nov 2024 16:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731429624;
	bh=PTxvTdWhSIylXwo7o/pGnGEWUjpsQB0r2cP/+iwbxd4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nw0x42wQWGuwqyLMySvyJnAJuNeafzHoir9krlf8CzVolTfU6MlYLXNV+BaCD+AK5
	 54M6LAGgUC9Iw1I7Q0YKlTYdYV9yme++kxuDHZhuqDtC7KeeT1YHl01lUPvgyGEtl1
	 FEIIIpBbDJkb9ASY/NsDKiSscWap2+3iWYCVWuBkBEnGhHN5vryaYzYU5GJnKZZCrC
	 3kg7Nk5LUcaWGGp6+qhftjXW2OpV6i7PuXBi81b7yxXVT4enmQUNK3mIGn013WCU7G
	 oo4AkE3hzOBmUyRvhJYP4LQY5nArXGrbGZxpikcHnxrxYwOhwsKot4SdDT/UCARA85
	 09rdYzt9na3Og==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD3E3809A80;
	Tue, 12 Nov 2024 16:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btintel: Direct exception event to bluetooth
 stack
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173142963473.591115.5854207280004105892.git-patchwork-notify@kernel.org>
Date: Tue, 12 Nov 2024 16:40:34 +0000
References: <20241022091134.791527-1-kiran.k@intel.com>
In-Reply-To: <20241022091134.791527-1-kiran.k@intel.com>
To: K@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	Kiran <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com,
 vijay.satija@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 22 Oct 2024 14:41:34 +0530 you wrote:
> Have exception event part of HCI traces which helps for debug.
> 
> snoop traces:
> > HCI Event: Vendor (0xff) plen 79
>         Vendor Prefix (0x8780)
>       Intel Extended Telemetry (0x03)
>         Unknown extended telemetry event type (0xde)
>         01 01 de
>         Unknown extended subevent 0x07
>         01 01 de 07 01 de 06 1c ef be ad de ef be ad de
>         ef be ad de ef be ad de ef be ad de ef be ad de
>         ef be ad de 05 14 ef be ad de ef be ad de ef be
>         ad de ef be ad de ef be ad de 43 10 ef be ad de
>         ef be ad de ef be ad de ef be ad de
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btintel: Direct exception event to bluetooth stack
    https://git.kernel.org/bluetooth/bluetooth-next/c/e88b020190bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


