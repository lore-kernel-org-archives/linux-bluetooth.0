Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F1915A4B8
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Apr 2024 17:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079029; cv=none; b=rtyZBDEc+k89G2XhOWLTrfijOIh3go32oI95kYIJhK+NxQ+Uct+dyo1iGWN9ZmT4/X5tdE8Q/tXz2vnubbu1skwa4Na+BtwSNq063IHAB74QmGZWHtaY6F7jpY5sIydXei0cYIZ80xw1ToUScUo0u1uyolEFAr55x7TMq+c6VXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079029; c=relaxed/simple;
	bh=tKPgiHI+KsPNz9aM93BpEqwDQvma1pue0RpljSjO9Qg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X7JQiDLeLdfALzqC931zRk+8CwMLLC+0OgH0GmfDjsS4BJGiYPt09sH0ohKqdGiCMUY+JfobYShyl+az8e+ELx2bvU7nfRyO5RQpt4QFMekv7OyBcrYWpka6hU7NH3OrcSSus3fvfCj6tVSoK/xrTfdmAQb79RqzcyDjEJVoxhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDLAjur6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDLAjur6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 848B0C433F1;
	Tue,  2 Apr 2024 17:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712079028;
	bh=tKPgiHI+KsPNz9aM93BpEqwDQvma1pue0RpljSjO9Qg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KDLAjur6UZtvNrpf/sekGlLi8ehyr5bdWi9AWRqaVNoGQeCaNLEQY2hnihtMS153p
	 4HDd6Uk+qnR/wbcEJSwZMuucszj+7a+8Hg61jD9K+3+KXTbRIuG79xSrNYRY2RWF0p
	 Hqglblo/nD6Jeu7hcHatsOs8klRPq6nq0puZcRg42PfHKT5zByTuSDdISVdFjkUAcA
	 fWvQenxNDKz8sFXqRgalD4Uxtja6GBuITY2d2Cu6mvAIDvYINjZQoaTQnidr4kngok
	 tUQeHhRSTRPNGp4JGMrvfWcdkcIxlEa+Ns1k2Spml/hJlo161ZCrk6iO3FsSEW3HRt
	 fuCQAjFJ12tAQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 75D46D9A14F;
	Tue,  2 Apr 2024 17:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] Bluetooth: ISO: Handle PA sync when no BIGInfo reports
 are generated
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171207902847.2394.4424463132171724658.git-patchwork-notify@kernel.org>
Date: Tue, 02 Apr 2024 17:30:28 +0000
References: <20240402113931.3164-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20240402113931.3164-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
 vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com, luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  2 Apr 2024 14:39:29 +0300 you wrote:
> In case of a Broadcast Source that has PA enabled but no active BIG,
> a Broadcast Sink needs to establish PA sync and parse BASE from PA
> reports.
> 
> This commit moves the allocation of a PA sync hcon from the BIGInfo
> advertising report event to the PA sync established event. After the
> first complete PA report, the hcon is notified to the ISO layer. A
> child socket is allocated and enqueued in the parent's accept queue.
> 
> [...]

Here is the summary with links:
  - [1/2] Bluetooth: ISO: Make iso_get_sock_listen generic
    (no matching commit)
  - [2/2] Bluetooth: ISO: Handle PA sync when no BIGInfo reports are generated
    https://git.kernel.org/bluetooth/bluetooth-next/c/3e3fa13686bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


