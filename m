Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFE32E634
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Jun 2024 18:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717613433; cv=none; b=sFhQIqiJFFf283EkWamUiKUivoAg8JO3OBkkEk3muWRCy5+1rAhVuuV8uZiyUApqCAmafjxJ9EW2lW+vWyh3Fm8iDhQ0RGBliQrJi5Rr+U/85tdBCc+BiCpUhFrhu+VluOjz6eLRdw/C5GXtcTcvm2F7+F4aoydcTL1ZkmNRFbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717613433; c=relaxed/simple;
	bh=/WulRu0EcqX8qIizoX6AczXqbJkp0IFw29frDKBjBp4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Sm/XMed0A7RpWM4fhzicbNM4tHzwtSLPNpze0LwtmbZia7iSe7m37WifDC4wFvqG2yjErN5yzgJbnSe+EO7XoCaI2r2IEd2wsNgjUhQzg6ulFrtVJGHoQBdIPxvv+nDl/zlhUUnVyC8SWwZzH7hPRsKLP37t2gRrx4hwu2HINR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvpL+M99; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvpL+M99"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80B39C32781;
	Wed,  5 Jun 2024 18:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717613432;
	bh=/WulRu0EcqX8qIizoX6AczXqbJkp0IFw29frDKBjBp4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lvpL+M990ygpHgmvNvhhbBDSUGpEWn0MZxKv4a2kX5KL7pRyM1DND6JoOvhq5gV5p
	 Dq00/LBLA8goBBvzO71VtWtbZHxS4rzlFZ/NAbxmwWQYiAKuOtLArSv6dlN8XLRGK9
	 lGoRyTii1BPK5a3qxU6gmFexD9lcnT+3Mghc9r4aqAILPoyPjvLa4PJ1KffuD2PBLZ
	 l9H+CgjZGY6vxqvJLhMPXWN3HlXExCyt+y/oj+CXkoJySohmckhnphBBOsqYND6Wqn
	 +Jq98I/dME34y+FT+50Eoc8C8E9WZIJDPTnsXCAvUcXUMf1YnQZsw8ERTM0aoVPl2Z
	 ubLHrxPLGBszg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 70980D3E997;
	Wed,  5 Jun 2024 18:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] Revert "adapter: add support for setting
 POLL_ERRQUEUE experimental feature"
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171761343245.31003.7172022283936124503.git-patchwork-notify@kernel.org>
Date: Wed, 05 Jun 2024 18:50:32 +0000
References: <20240605143920.498159-1-luiz.dentz@gmail.com>
In-Reply-To: <20240605143920.498159-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  5 Jun 2024 10:39:20 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This reverts commit e1c178f96a07fc43ad7523fdd4c93967843e4f60 as the
> changes required in the kernel were reverted as well.
> ---
>  src/adapter.c | 72 +++------------------------------------------------
>  src/adapter.h |  1 -
>  src/main.c    |  1 -
>  src/main.conf |  1 -
>  4 files changed, 3 insertions(+), 72 deletions(-)

Here is the summary with links:
  - [BlueZ,v1] Revert "adapter: add support for setting POLL_ERRQUEUE experimental feature"
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f63c6e9fa069

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


