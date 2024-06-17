Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A595198E9E
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jun 2024 19:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718651433; cv=none; b=FnE0a4umte1DgmKpdrQX6QOB6AB747glATBa0rXHFVzBXA7tEmd3+i6qM5hZuQu4TVtU3cXFfN5hsUc9xenBjLGXnihuTMXNwiJY439oB5RUrc3SeXDKHqsRzgWOUp4qMGKQwhEDRMDu3SOEQEEr4AlL53hYzJOWOrLN9SUUosg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718651433; c=relaxed/simple;
	bh=pHQw+gNmbZALWxFaOHC6OlZAvGipYGAnMP26IvQInh8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WUVeL/xSzldOk1fwvJPFhwc/h6aBphOCxuCAYqZRhHWHs1vvxGebearccvXhEvzJH4lCR75iRvux+DtSo93hlOYcOosiPhkxrgMlturqvcne6j6FAA6q+VyhfqsjltgVnmCj1FZUbLiP4jXrO+X3nVVQnTqZ+WccDA7fZFOaCJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYmDSjYO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYmDSjYO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6E56C4AF1A;
	Mon, 17 Jun 2024 19:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718651432;
	bh=pHQw+gNmbZALWxFaOHC6OlZAvGipYGAnMP26IvQInh8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FYmDSjYOK4IhrnQuL5CxhSZa63XzOhLDChddSk5j5aiQBeiaPtNy3RJxZT7tjT83Q
	 qb0Y01bckK2t3L4Z1U9lRu05tmNm7NIDARMmy/m9dw+Y1/vIjNvJ++Uo5NQkUHTAga
	 woy+hsl7jOpjxlMV4237eoNSpfW97V8+0Id3/WtxQpemxegBIEUKVhT4Lsp0ShEW+F
	 wjFzc6HjakbH1dGiAU4TJtk06ET6Kb25EuBFwTGU1XxPmq7C9UVsNr8hJMgl8owS7k
	 9DSlld4TV6u1k1W0uVkLMiQkTZXMNil6YQtGfXdKsJHUiMY7rsGaftz0tbZIbAxU6E
	 IZ63aHj9e3tpg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A9A8AC4167D;
	Mon, 17 Jun 2024 19:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] shared/bap: make BT_BAP_* direction defines valid
 bitmasks
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171865143269.1080.8483055150378303739.git-patchwork-notify@kernel.org>
Date: Mon, 17 Jun 2024 19:10:32 +0000
References: <8dded7c01676b68e3042dbd0021e97c198a03b49.1718643571.git.pav@iki.fi>
In-Reply-To: <8dded7c01676b68e3042dbd0021e97c198a03b49.1718643571.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 17 Jun 2024 19:59:40 +0300 you wrote:
> The directions appear to be intended as bitmasks, as
> bt_bap_stream_io_dir() will bitwise or linked stream directions.
> 
> Fix the defines to be separate bits.
> 
> Fixes confusion due to BT_BAP_BCAST_SOURCE == BT_BAP_SINK|BT_BAP_SOURCE,
> which causes e.g. unicast transports to be in PENDING state after QoS
> although this does not make sense for BAP unicast Client.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] shared/bap: make BT_BAP_* direction defines valid bitmasks
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=52bda9d45572

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


