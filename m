Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11DD3ACF11
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 22:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779143394; cv=none; b=C7wWaf5F0W9/tqMOK2qNJxJrU77buV43Fu0egUMYd03nntz/ZzxpD/mOhD3Plu7wwERBYs7EaDs8MVXEksLJNBdw0QPyyd9OOdk0KtyOraCUZ4BhGV5Y7bmsXEd1nreAQIguXKwAo2LFthV5QheXNco8yWfs8HVH8OSq7Zbm8Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779143394; c=relaxed/simple;
	bh=UKVEKFh74E/EQ08N2Hox7HcDXeSZ0dmOcSGbGDkxpm8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OHIjkC+J/6Yw+0SOF+zEcTe1yXu5SILZ4bp8MhpLKZvXG0IZrYg28a8UUw9muXXZu4wLbo/QDvudIEZjB5JQRj9LOlENGQ+yB12db04YrZLEt34Rz3GyGSmyVEF5ZfgTl5wzoDuvzyksKtSGv9rTUpW9Rkx6wUho4AaOyA1D1rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNnQ/a1B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNnQ/a1B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D12C2BCB7;
	Mon, 18 May 2026 22:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779143394;
	bh=UKVEKFh74E/EQ08N2Hox7HcDXeSZ0dmOcSGbGDkxpm8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rNnQ/a1BezPqUL/LHDHblH2cteTihtXWoEJdLfNhwonUUDgnH94SjqumVg1UxEvNJ
	 +Ejj8T53hVCYGkqfYicqnYMPIi9NoTBGCIBc/OS5AhJughfsEa4tZDvGcrODuWoyW8
	 ypPGAl9gi0WUSRcaMyTappu1OWVxC5b1D/Qp5715TcMSYZfD0Ezk1zm5i2kcB9vJdE
	 WL6bZqSGvqS48SuZZtLBDBO/cEFMZzmSlUOhwyojifhE+hS4MRhBPGfLnAeGjshjAz
	 WwCQM/t3pS8JTPBchy1k3fy82uSkClHkZsdyB/59El+fZj32i4IQDXRczik6jhhD3O
	 QKr/xdmykpkmw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1992F3930CBC;
	Mon, 18 May 2026 22:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] device: fix inverted NULL check in gatt_db clone
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177914340564.1994926.16942800321099150405.git-patchwork-notify@kernel.org>
Date: Mon, 18 May 2026 22:30:05 +0000
References: <tencent_017770C54B37BDA20BEEC119272E1AED0608@qq.com>
In-Reply-To: <tencent_017770C54B37BDA20BEEC119272E1AED0608@qq.com>
To: Zhao Dongdong <winter91@foxmail.com>
Cc: linux-bluetooth@vger.kernel.org, zhaodongdong@kylinos.cn

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 18 May 2026 14:45:32 +0800 you wrote:
> From: Zhao Dongdong <zhaodongdong@kylinos.cn>
> 
> gatt_db_clone() returns NULL on failure so the condition was inverted.
> With the old check a successful clone (non-NULL) would return false and
> skip swapping the device's GATT database, while a failure (NULL) would
> fall through and dereference a NULL pointer a few lines below.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] device: fix inverted NULL check in gatt_db clone
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=757cd98f4186

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


