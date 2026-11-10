Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327017;
	b=XpxcHYcae4JpjVm8SGmVuUlGQdoqUOULD7vz67nyco4U94ZTEfhkj6g77rdRFosEqrTI
	 cXbcbkNLqmyOnbgYMyHbgwppoRJTogq83pEskXrhPbm1NQ9sRi7YW//Xg1bK25PFbATHm
	 W7X6IT+FKnhW9e7GDAc8gnv448OwgHB2NV/1IY5S9SvRZFM/lhHAXKXv4n3TfZfebhEzz
	 htcz5DzjS5PrLmxTVhh2fmobj5APo7ngj+E77wHTEGeeS37/KaVtVweKfwzCs8jNmuhKr
	 H/GSTylFx828hUG0fugVGrAQL9O9TcuMQ5I4Z0Kwbk/OfUYuQJ6II5DH7hXgKjK92Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327017;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=3eZdXLlFwJzXpS1qIaDjxF033ww2XL0YZWUeFSyjE9A=;
	b=ujxMUymYdQVEZKwOUEwUGj4DcDoFdxg1khwLyzklpQi9RBKJMDpH7aLNcbYp5vGP0ujX
	 s+Di2hwb5n6pPnB/3tKpIESj19mQMt73Oexxj+PSa6mHKNA2u+xYOTY5ElYtTb9pqe37/
	 9BqmZFCTuL4jSB4O9AsGSVKpRhZE4r36I6ARUdviu+mqbZHPfz9xqZ4JKxUi8JVIhu9yN
	 Qd1s9vWwi0abKnDHUUlG4wI3+bKXbZ3us6d7PUtXMFxuMO4iNlVCDALsUC/sWhCGhR7M6
	 AUJ4OkAPgFC4o7PDkm+ZUEQPzdiEixtCv9yjpYbnPt0YYKhgGZvjV5rXDyB98iBkOyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SLXZ5auM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDB060A3811;
	Tue, 10 Nov 2026 16:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SLXZ5auM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC191F00902;
	Tue, 10 Nov 2026 16:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794327017;
	bh=3eZdXLlFwJzXpS1qIaDjxF033ww2XL0YZWUeFSyjE9A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SLXZ5auMw+RqIz6ZqPs8URzYf+7gSFioN+/dBzFgFmu/ZUVzUbVeX8zqUnn8SlFH2
	 ss8bv1Vk40by6Wp5rBmpkYmLmpRjrUgzjXtt1t6gR0DRNikH7KbeFiRqClGJKFMpJr
	 E5A9Qzw/43q8hBS+zHhoQQNgMW7B9LrzXFFAt+e8MqRqSiatNiQYWmGkUj8/+TFogC
	 CsMp1182F2U9apcn7z35L2eIYZOKXj3ztLchoCZyTR8a3JtP4gvdtoWashmsB4ur/C
	 jVeSxOeI+UqpqiGHFCvcI4fx8Y0dRxHGgnDdslBRXAfeWrhSubtCl2HESmQ4gqiXxW
	 mIlbBJlvB1QSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 20F8F39D267B;
	Tue, 10 Nov 2026 16:10:17 +0000 (UTC)
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
Subject: Re: [PATCH] Bluetooth: vhci: Flush suspend work after removing
 debugfs
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179432701567.4062787.206480705237565419.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 16:10:15 +0000
References: 
 <pm-bluetooth-objects-candidate-0146-v7-4a901c7fb65111f006fe@gmail.com>
In-Reply-To: 
 <pm-bluetooth-objects-candidate-0146-v7-4a901c7fb65111f006fe@gmail.com>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, jjzuming@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 25 Oct 2026 00:15:17 +0800 you wrote:
> The VHCI controller must remain alive until suspend_work finishes.
> vhci_release() flushes the work before removing the force_suspend
> debugfs entry, so an active writer can queue work after that flush.
> 
> A force_suspend write changing the suspend state can overlap the last
> close of /dev/vhci as follows:
> 
> [...]

Here is the summary with links:
  - Bluetooth: vhci: Flush suspend work after removing debugfs
    https://git.kernel.org/bluetooth/bluetooth-next/c/58d8a0955065

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


