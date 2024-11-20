Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB99A1EB3D
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 15:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732116023; cv=none; b=JcHzM+CgnlrVWjVH0EZ/T0p4GE+T98ayWVV47zOzifWmBXmd8iUS3ZGkKFx1Qy1zoSWMEBObATthqwx8FlxGddpM2BWP6Si4NjRxr5BG4I68xZeXlUFf5bw8h9ZeiFOGGEfxxFg1QGYQSxjrsTlW4NnRptZD6UX3O73qB33PKF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732116023; c=relaxed/simple;
	bh=QNHG/l8vwS7QTA3B4969tkxwKsde7//I0i15FZAzBf4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X9GJ9Qw+dlLn7T8E1mvFWn9b1Ae+3O010axUcjjgpeEMHjOPMZLOHfae4dPHfrEUEdVvDDGreTc5BE0xlbqqxq3A7mNoPHTeN1pxWh3zuuidARHU6Lj06C84TifJp7IBt9Jc074gaZe6dCiCz33SPW8vV83FnQEB8Olx3qeX9qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKSP6oXv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKSP6oXv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B38C4CECD;
	Wed, 20 Nov 2024 15:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732116023;
	bh=QNHG/l8vwS7QTA3B4969tkxwKsde7//I0i15FZAzBf4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OKSP6oXv8Qo3xmfoNtoN2RGa1RrALwkjYl63/am+dFCnDt9zrEkbVOIK2fmzeL5x6
	 /gCzKqpTy6pIyb0HAUTVyZXgY/Yl+z7s7FsnMIRtPXIsQwDPSEESanLKBgmGKqLjPC
	 E2aqhI3j2021W2v+e2EOnhmPbbBpMRtwz7BcGShgOUsQ3PGGAftwQEL7o03EgNrAVc
	 sBKxe++ZfnZ5D4yLnDVpYkpK5xHaHLk5+st46yFbJF5kHjgvYgZDEKqWV1WPMJFoJp
	 A6iX9R8ZnUkaga0rDheh+vjSM4ZlIszuouChLwBnamOvYGAws8fdAw+pzjUS5Xc5bC
	 HauKDB5ZihWoA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710853809A80;
	Wed, 20 Nov 2024 15:20:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/3] shared/ad: fix -std=c23 build failure
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173211603499.1254308.7434114672920825795.git-patchwork-notify@kernel.org>
Date: Wed, 20 Nov 2024 15:20:34 +0000
References: <Zz3eAJcwA--0n5lf@c8d99ad60702>
In-Reply-To: <Zz3eAJcwA--0n5lf@c8d99ad60702>
To: Rudi Heitbaum <rudi@heitbaum.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 20 Nov 2024 13:02:56 +0000 you wrote:
> gcc-15 switched to -std=c23 by default:
> 
>     https://gcc.gnu.org/git/?p=gcc.git;a=commitdiff;h=55e3bd376b2214e200fa76d12b67ff259b06c212
> 
> As a result `bluez` fails the build as:
> 
>     src/shared/ad.c:1090:24: error: incompatible types when returning type '_Bool' but 'const char *' was expected
>      1090 |                 return false;
>           |                        ^~~~~
> 
> [...]

Here is the summary with links:
  - [1/3] shared/ad: fix -std=c23 build failure
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=da5b5b0ecb1e
  - [2/3] shared/shell: fix -std=c23 build failure
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4d60826865c7
  - [3/3] shared/gatt-helpers: fix -std=c23 build failure
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6f3111eb680d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


