Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC38117E904
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jul 2024 15:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019433; cv=none; b=paLt9iaNGfA82L1dojy5bC1HfZwKPFJFtbH3QqeIAU+JDqagwYdrcp2OQNhlKKMk/K720iPXVjVBTyc6Hc5+tRE6bC5t3rAHYYVZ/pdTGyv5Cp4IoWmar6+rVBybD8Vbd2KgpkX0SI6g7Nvidq2iqiv108brBQYTtFNtxPVDep4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019433; c=relaxed/simple;
	bh=VOInmrN/8J4ePMI9k74Bj86TqBg7oJRsowZ8+AuIV8g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bpVHcGnq3FixsMv2ji0iiVxUBMIZSjOhvhQT9kUIByQH18Iu+t9zeIGd9x3pNdA9e88adLiFYwo1uKEzXFNGnJ7iDV4LVyqqY10qI/aIu0kgwSPV6q0buB/YceiAZ4gxhDHHPvWQZydL3vpJMxJvcamG64CRfHdE95a7CC5xHJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0hdtLHL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0hdtLHL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D57CC4AF12;
	Wed,  3 Jul 2024 15:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720019433;
	bh=VOInmrN/8J4ePMI9k74Bj86TqBg7oJRsowZ8+AuIV8g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L0hdtLHLN1KnQZzanNEgjjf80FPKDhvTd0JCy7TzCd0qf7LwSlULn6yWKzFpw01BN
	 KCUmrBkIvLdZxDKEzRAFf5lUc0nSajbpidtIlHT9zAqg0sLXfbi2S/3wOHspq08C7g
	 wKd2ajDDMnilUoxbtlhh0Qv3zJhDFX5fXXup+loSnZrN1litA1x+iUwbq8ZLiEgvet
	 ruRMnkn7pUupCNERa+VF0f8MOXZDwjAOlRRfSv9HLgrb3O+TGoifufMJWskW2bB5hz
	 znphAVkiel4pAxAjGyK6WQ1LyC/hOkUspAMhytIsxEQZ747py11XW5DY0L4JGH+IhE
	 RSHXXRVH9XZpg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8168AC43614;
	Wed,  3 Jul 2024 15:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] core/gatt: add return value check of io_get_fd() to
 sock_read()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172001943352.18626.7883178972533821631.git-patchwork-notify@kernel.org>
Date: Wed, 03 Jul 2024 15:10:33 +0000
References: <20240702125157.87719-1-r.smirnov@omp.ru>
In-Reply-To: <20240702125157.87719-1-r.smirnov@omp.ru>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 2 Jul 2024 15:51:57 +0300 you wrote:
> It is necessary to add a return value check.
> 
> Found with the SVACE static analysis tool.
> ---
>  src/gatt-client.c | 5 +++++
>  1 file changed, 5 insertions(+)

Here is the summary with links:
  - [BlueZ,v1] core/gatt: add return value check of io_get_fd() to sock_read()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=605e078556d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


