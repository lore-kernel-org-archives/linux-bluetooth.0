Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BA01C2323
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719587430; cv=none; b=ScAp4qkQvfe2j07YRuoMGDdBFHruj3tb9efXOfELEWnbhcPRVXM8KRcXg/Bbj78C9rmxKfG3Qp6KhS7DlAXyeMp8Hl3CCxNt+FQccGtuvT3yxHEXuYVq0Q3Y3q9UB7DOTnuOhDehtBPCeEPfI8IS3mwgDI2N+0JR/Z72fT50nrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719587430; c=relaxed/simple;
	bh=IIU+R2vJ3lKb4B0qMr/vG7XzyJOO2+RCGZ958RbVLNI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pyYDjLI8iCYwpFk/f4OBLVN56lUVHQBVn1qzYN3GfPMPFzLY6TrrFr0nGDMPyz/rXgogy4lIPQQOGo1HgfNxDgQNpvQqL9jx6AqogmWskZFAWzTjpjdMsT3DpLxTX0zIK1UcXVARv6ll6Kn9Hvworri9RfTGmO1eA7oIsTy7YkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=haF91B8d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="haF91B8d"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F59FC4AF0C;
	Fri, 28 Jun 2024 15:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719587430;
	bh=IIU+R2vJ3lKb4B0qMr/vG7XzyJOO2+RCGZ958RbVLNI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=haF91B8dNzQ/JmE7x/FnBDoXEPoWjpLPWD6n4EtjbOjvwlzlEy3f2NyjzzzE7wx1t
	 otef27R1DyGmuApvKfKSIpYrwIxyqocygbTOLRj/v4ld4h6fgd1XXvIxEXP0zylc3F
	 t7kSBe4eIVN4KGKL+Hzw4R9/JGFgFUD3f6EI2QQk+5+kevwJ+w9SKPC7OI47/1JwzM
	 QA5UC3TiqM+Leco4pJg2O17kjNNc1Wm51OZf4G/yPF66sk4KlPKT17d77nz8wgGF7c
	 j/5cQBlJy8wKh+tL9Vrajd7gNim8LP7Ej2p2r9TQI+3BRA0blLHIiKH7bd9w0Ycfn2
	 pqPT6f1Yf+1MQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4AA36C43338;
	Fri, 28 Jun 2024 15:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] l2test: replace sprintf() with snprintf() in
 recv_mode()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171958743030.13318.17743473473022679453.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jun 2024 15:10:30 +0000
References: <20240628130142.549979-1-r.smirnov@omp.ru>
In-Reply-To: <20240628130142.549979-1-r.smirnov@omp.ru>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 28 Jun 2024 16:01:41 +0300 you wrote:
> Use snprintf() instead of sprintf() to avoid buffer overflow.
> 
> Found with the SVACE static analysis tool
> ---
>  tools/l2test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,v1] l2test: replace sprintf() with snprintf() in recv_mode()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0bd3d1505e3a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


