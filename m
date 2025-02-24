Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C321A5B8B;
	Mon, 24 Feb 2025 20:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740430199; cv=none; b=nnahPhiVY1m2ZBR4qyiAnk5K9MoWZvSGxZg44UY2eEXAoObD1lXd3obutm1uIz0HWHmMfQeNuZMvNvt/Jw+bs4IDjDm++f5poHNRMdXIZOKdDEfgxKBS3TEBKP8SWudhD9fgZPJWoVyhJ4luAewQtNpamZqwgrLYBVJOKgMKR6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740430199; c=relaxed/simple;
	bh=4DeoMTUwAwNk+1Zkit2/Z5ObNi9JwLdCe6FB6g+IYsQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oBgwaN0MuiCFsxXa0sBaR9jYVBBjNeRXk9zn2iPjW/nhljaIwMAva/Uj9kf7wZIZ6GsNz7/T6FwZSmLmRGSybYQxIaVOpvmX+NLh+7u2lsV2MZmcxew1xHD7ImCqB5N6RoSCof2ZZ0b3b+Zwpichcr0hMv1rbriLX3hbdAwTbnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3GS5O/G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3GS5O/G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB0CC4CED6;
	Mon, 24 Feb 2025 20:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740430198;
	bh=4DeoMTUwAwNk+1Zkit2/Z5ObNi9JwLdCe6FB6g+IYsQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X3GS5O/G8Q3sHSap/slPOXKM4Cfp8XpCzJHPJAkQx+HZiiK9tdsaFnJCSdyt0hm47
	 3OVbiIqRA8SGBDiQqSagT0ZIEKyZly+GrRXyzeL04yZABqT7H/ch6qP/TrzTRm+O2J
	 0HE++dmWi3kGJOwrQFCpny3Ojiyp02BW8d7/2l5WN2Pj1cLexRFHRTnR8VbgX1R/h2
	 fA9GDGJ7kEsVhm85BxpDWz+IS6VQbgtKqnDPGJeT1TXOCu8cPIx+cn6YmIdfB1lU2h
	 Vop0EdVNigTj+yMR0MqhDjD5LQU1xXD5Q+NGxjbEymSOEHBVckeX7H5us3+RGiKSbn
	 t3d0USE/GBjGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71B83380CEFC;
	Mon, 24 Feb 2025 20:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bluetooth: btusb: Initialize .owner field of
 force_poll_sync_fops
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174043023026.3603925.16482304382442990350.git-patchwork-notify@kernel.org>
Date: Mon, 24 Feb 2025 20:50:30 +0000
References: <20250221213259.180833-1-salah.triki@gmail.com>
In-Reply-To: <20250221213259.180833-1-salah.triki@gmail.com>
To: Salah Triki <salah.triki@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 21 Feb 2025 22:32:59 +0100 you wrote:
> Initialize .owner field of force_poll_sync_fops to THIS_MODULE in order to
> prevent btusb from being unloaded while its operations are in use.
> 
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
>  drivers/bluetooth/btusb.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - bluetooth: btusb: Initialize .owner field of force_poll_sync_fops
    https://git.kernel.org/bluetooth/bluetooth-next/c/02aa832d1403

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


