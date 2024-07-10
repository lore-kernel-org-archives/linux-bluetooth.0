Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC73193477
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 14:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720621835; cv=none; b=Pz2GYfZOaSCWYJmjA0F0Beiwm61ZNSqrFM/4DXFe6ssukP62Rfqqf0ONaFM184nLg+cyClQcrNdaxtgYDVEdwA39tpKynkGPEnEkyGtF4xT75/DD2NwJ1ROJjCugt+aRkkx2wtbvkp6BlIeSVAk+YtEyDzj5OOdD/2P/PhS2PKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720621835; c=relaxed/simple;
	bh=kk2d3xswrIiH5AzlNx1Y6BbAHqShtMf+JWud3Xv+EJY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZQsasoXskRYS/Wgdok4eNWC9W4Ga1tPVZddkMjTT8n/6DVyzgGk+64OZCuufOzaNMyiBgRRoweWGOxJuz6IzjfQ3xbrZcLlR78mK/mdf0PuDzRMR8aqdeCy8G+i2tnVLWtuWXNtTnIfUdKHJw/4fOH3OAYiOyl3B5uGvWHPBDUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+3q+/N/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+3q+/N/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70A34C4AF0F;
	Wed, 10 Jul 2024 14:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720621835;
	bh=kk2d3xswrIiH5AzlNx1Y6BbAHqShtMf+JWud3Xv+EJY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V+3q+/N/AeJbu9HIH51uT0D/159k+yizAiIEA84s2JC+ibstGbDUyS+HA31xvq/9h
	 Bi3DILdDNQXdWL/Oq+hzwKRxnjeJGr6NErIbyPNN/nLsh2wRSYV/1aDvfwMCW3P4a0
	 KAYGY4lqAE6JEZgS7Xqwh8PCCrdpES6thUcxZGQU+hd8DpdfdIvSII6Wx4KV+nX7Pe
	 qIt2UB4B9XZ983pIxnev7WiHrWRvx+wG8bOK/+cGBkb80RrSYsUPyFqcMw9e12hLDn
	 kYCvqw9m+etvVjwtu7IzVmfZ00SJOYjUquaoZ0wM4kHw6HIB2NW2EqC0O0CQWlc89P
	 PHPebN6+bXvdg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64DE7DAE95D;
	Wed, 10 Jul 2024 14:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] gatt: add return value check of io_get_fd() to
 sock_io_send()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172062183540.19459.1459155742526050452.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jul 2024 14:30:35 +0000
References: <20240702134106.102024-1-r.smirnov@omp.ru>
In-Reply-To: <20240702134106.102024-1-r.smirnov@omp.ru>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 2 Jul 2024 16:41:06 +0300 you wrote:
> It is necessary to add a return value check.
> 
> Found with the SVACE static analysis tool.
> ---
>  src/gatt-database.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,v1] gatt: add return value check of io_get_fd() to sock_io_send()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e56fc72fc667

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


