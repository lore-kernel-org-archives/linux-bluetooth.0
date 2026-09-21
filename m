Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FF24AE115;
	Mon, 21 Sep 2026 14:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999880; cv=none; b=guuDdnAZhIp9QNqA2Zl2KzRrNu7d4DfKNnFSDJR+qS4LEg/5p1I1WPTst/WHIH+Q0mYpfa/iPzLg288YvmbslFbq0aBf1DrWpNkv+QSg48jos9WgTIrOPIlo1OXzab2Hxyn8Gz97g8sT/xPm7zopPETFdqJZLYB5tkqZDX9CujE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999880; c=relaxed/simple;
	bh=Ehym4n96rUZvpBrP8HSzMj25eBmSFVGkY6+/plprqhc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SokABEXnmLQ2GZSBiwwEyn7PDV/Kd/EIPxFVnhvA742rlSzJ8q0ypFdjGZ8NS8fZaLbo6dezNYshlRarqOwqeF5bSZLEPtc4oe+2/9DKXFf28pX1QahL6FuLmqSOxN/10vJ2MwzbMf6eQ6G8pVGqDxdN4V4i30r3I0lmXrMB0/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHKi+zJU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHKi+zJU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4AC1F000FF;
	Mon, 21 Sep 2026 14:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789999878;
	bh=ivNGp2q8KD+P9kEhu1jO5o74Tk0ERD8qvmT5KDgIyxM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AHKi+zJU+q/3G1Cso07AWPjsfRVn/t6peVk/+IxbMXn90PZzS0qrorQ7KpUGXVKel
	 xpEbgwpBc9qkDp729Ooo2ABxSECr0DX/CcuoTqJOFJFtABJrllUam4dmvIX88vtShJ
	 wgsmxNN09YzT7Vr/DIw8JVEsTZliXeGM6YTKlv+r4F8X6Znrf5p2+GLMYl7ZSQF7HD
	 ssfJlRSwUq+GMxCiWrnuWvaKQxz5srV6V3tBheXuBg9r5ozxCxHwoIQAZHHKHbjJBV
	 lVjYROKTuuX5AMmx9/BWRVsVAvWyuqlGc74+ky73l1ctezaNVHCq2DSu2PBH7Ysg6j
	 4pKgst3gODNZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938713926659;
	Mon, 21 Sep 2026 14:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: RFCOMM: fix NULL dereference of
 dlc->session in
 RFCOMM_CONNINFO
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178999981014.3047822.12082632672865973363.git-patchwork-notify@kernel.org>
Date: Mon, 21 Sep 2026 14:10:10 +0000
References: <20260919112518.3872094-1-benquike@gmail.com>
In-Reply-To: <20260919112518.3872094-1-benquike@gmail.com>
To: Hui Peng <benquike@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 19 Sep 2026 11:25:18 +0000 you wrote:
> The RFCOMM_CONNINFO getsockopt handler accepts a socket that is not
> connected as long as deferred setup is enabled:
> 
> 	if (sk->sk_state != BT_CONNECTED &&
> 				!rfcomm_pi(sk)->dlc->defer_setup) {
> 		err = -ENOTCONN;
> 		break;
> 	}
> 	l2cap_sk = rfcomm_pi(sk)->dlc->session->sock->sk;
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: RFCOMM: fix NULL dereference of dlc->session in RFCOMM_CONNINFO
    https://git.kernel.org/bluetooth/bluetooth-next/c/46f8ffd0a1f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


