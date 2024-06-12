Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF62B170835
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jun 2024 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718212832; cv=none; b=b7tHFTiTjext8327gR0qCQ805bPnfyjmexQN2hL6wARQP30F35X3ltasHjq3oRuD647oFEqVSZ7RH4U3rQExrUNuk37gya8tNIcPDYJRouaWe/GiUoKnmLgqqGfQmkq68rxS4meCxu3PZiU8TDHA3MvuHI7Nj2UGJ216ozB7weE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718212832; c=relaxed/simple;
	bh=xz+ab1ZiDE4/3qcmOFcn4YWvx4rXriL86Mx8ii2DG+o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p+46nmE+Q3tvS919iJ+M+uWmgB6ztcMJ/EEXn3Cqx/A1a8+Th5Pi59qzdGKDXBIZf0x4R1/oj8xq0swfBBTGrkh0V2g3GSPZvEZjciVW0DqWTUrhmYE6xt53S419x/vIxpRTCC6Xu9uet7otoiQ5S1cbyeTtQ9c+kNsW2W2xSk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BK4K7tgq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BK4K7tgq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3620AC32786;
	Wed, 12 Jun 2024 17:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718212831;
	bh=xz+ab1ZiDE4/3qcmOFcn4YWvx4rXriL86Mx8ii2DG+o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BK4K7tgqPpKAcVX2lhTpoiUGLIpBLg1Iy/IVaVvawY2fEyP8hLw86et8KEqRJkTm/
	 tlLa1tk+DL0IaV5xnhbRyk4CJaf1KVtVASK3/TuI3knmu70kp6/TIwVSLBrNlUxly2
	 SiXwq04G2g96zMueSfIviDqtjk9GWOB+GVDzFtRL5BEIW3zA91e8riVOYrEyTCzyx5
	 UIfvTk2WA0/+hCeSyh7Vci2J4YapxH3huoI/jwD2Y+NuWhsauAPVfh5YlOvG/0H9bh
	 HkpdafjGJt7zKxLbHBubmO+BvI1B6MjSY45H4hTGwrUFGVhcf58cQo0Oyj91QjZWXg
	 TIalGhP2umVgg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1E801C43619;
	Wed, 12 Jun 2024 17:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] shared/gatt-db: Fix gatt_db_clone
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171821283112.2681.1974354839395586455.git-patchwork-notify@kernel.org>
Date: Wed, 12 Jun 2024 17:20:31 +0000
References: <20240611163542.1161789-1-luiz.dentz@gmail.com>
In-Reply-To: <20240611163542.1161789-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 11 Jun 2024 12:35:41 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The process of cloning an existing db shall also clone certain values
> that are considered when calculating the hash since the resulting clone
> shall have the same hash.
> ---
>  src/shared/gatt-db.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [BlueZ,v1,1/2] shared/gatt-db: Fix gatt_db_clone
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a37e475f7252
  - [BlueZ,v1,2/2] settings: Add more debug logs
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=891552999317

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


