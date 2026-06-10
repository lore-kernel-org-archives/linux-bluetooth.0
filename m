Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B55A356773
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 18:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781116811; cv=none; b=gmaYKu+PtJu6xBU50LXz3fT3g1hC4os+4cJlYBqzM/5C3Y8mD7/e0lIZF9GhHjt42K5w2z+aW0I6aKI3boUQNR9ftaoQmeQai3bvXsDVVZzfKoqShER98HZmffQk6h4MN2s8F2YO5KblGLYgtKcSOVbpA7R9MO4E7G7Z2mRt/tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781116811; c=relaxed/simple;
	bh=79DiP7IqAuBbgPoyybmw4aQei9Qh1197hMieMK1d21Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ISucC3AzU4R5fi5UjEfRHcVYQRhFGC/A9rPiev/egq14YYnMsioCuV1JAt6z7ZKjU7T/um94S7sLLrp1sg2Wi+VQ43wWj91f0CVtahnkf1trn+mLyhfF8WViE02p0FZ3Splp/rhSPi6WwTI2St9kCTt9qrtfqmZJPWf+TrA4tnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+DyMpca; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+DyMpca"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 141B71F00893;
	Wed, 10 Jun 2026 18:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781116810;
	bh=/CoQyu81MJ8TVtjVFcUA26SSdjqmt3VisMV8Cbw+650=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=H+DyMpcaMxY03FoM/dO07XJDQB3JXY8m1vuwjC376ZaaZ//C+9d+0/hkJKskow28I
	 Rg92IE29TXq/ICw7uG+twQb19DuJqHBHRyDob9g7FBIPJoPgsHUhAc2HgrC4g18sUz
	 +hWijQUEw0gwvJF1B0/X03h0m2w4rgCY8IbjnaaJRH48mgrHAyA2IupEnApIHMviQi
	 5VgL90uCWwrBqbqvb39x8/19Artjl09hwYuN+3bfD85ITd+Gi1hQRyLcZxS5sf04jn
	 tLz+eVA5JRQBqGnIL5Xi3h6FarxggeH47ciHtvzFRkCRyNMQffzF/9nEbHTjU2ebp3
	 wmg4Je0dMf/Gg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A0D3930DEB;
	Wed, 10 Jun 2026 18:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] avdtp: Return correct error when SEP is inuse
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178111680763.3588149.17020774142320738034.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 18:40:07 +0000
References: <20260609213013.3900808-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20260609213013.3900808-1-simon.mikuda@streamunlimited.com>
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  9 Jun 2026 23:30:13 +0200 you wrote:
> This fixes AVDTP/SNK/ACP/SIG/SMG/BI-08-C
> ---
>  profiles/audio/avdtp.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Here is the summary with links:
  - [BlueZ] avdtp: Return correct error when SEP is inuse
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=39ad431de60b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


