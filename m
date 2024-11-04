Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ACD1AB6EA
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Nov 2024 22:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730760622; cv=none; b=iHwSBFecCB7r0suprY0aT+hGQfbEh2dylOLsRMUubgcGZkJRbbjpeB3s7Ya8IczfsyBn4ObXOy2zR15HyOXUeacB3I2tRzayyQkWuylJ+/CFW/ebavxlSIyi739H6zt/t5D025jqc1MHdXrb7MqchKkHhO5uNwTN/tmyQLIkbfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730760622; c=relaxed/simple;
	bh=BbymEi+TKn15T/QTeBEAlWQbvQMU4nJSvyI70E+mYgg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oEN6TLgE3sU9E7PC+ckYrjGS8LjpdUhyIBDCTlizExhlaKd8td0o0gL3Zd6HL/cBwhuVfLQ5PXKwWiQr7YD3mpnGqoQGvxaHkDw2h4DAVjYf+algOqpsCHGmI120xMDZY5/YgUlXxoPAf+VDH0CEBQiEzDZ7ppMtGE8HPfZJZ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUxZ34Me; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUxZ34Me"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F18C4CECE;
	Mon,  4 Nov 2024 22:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730760622;
	bh=BbymEi+TKn15T/QTeBEAlWQbvQMU4nJSvyI70E+mYgg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MUxZ34MejnKJxBMJ8IJuarybEloiBDtyWpmNqpqBqHFBQU9fxcY6V6tH2a07VFHHT
	 sYmqEM1B9w/4iGElMcHHZOuwI65Z08igrbcdqogrzlfTMOBOQAUuQy8aXg6z7J6h2B
	 ZYzpvNsnn8q2UIZvwr/7rN1ySY873esla+BKq6dAg1P6oIVEfkt1/echkPHrQEfGTU
	 dOtC/OIX4VvZPGhSvfdHXILXkCrakf/bfEpe44nbI9WZDrx0gp28MMKbEkUysfCP86
	 ZMjy2FwVZJjOREkttZPNgoJsAMKYWkW3JB0q7BxiYA1k0Qe5/q34gQrXQ18fLWi/SX
	 wNcVbR0ceQg8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFDA3809A80;
	Mon,  4 Nov 2024 22:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] adapter: Fix up address type for all keys
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173076063080.44346.10440887145100851016.git-patchwork-notify@kernel.org>
Date: Mon, 04 Nov 2024 22:50:30 +0000
References: <20241104203549.772512-1-luiz.dentz@gmail.com>
In-Reply-To: <20241104203549.772512-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  4 Nov 2024 15:35:49 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> 66a8c522b64 ("adapter: Fix up address type when loading keys") didn't
> fix all instances of wrong address type being loaded, so peripheral LTK
> and IRK were still left with possible invalid types.
> ---
>  src/adapter.c | 44 +++++++++++++++++++++++++-------------------
>  1 file changed, 25 insertions(+), 19 deletions(-)

Here is the summary with links:
  - [BlueZ,v1] adapter: Fix up address type for all keys
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7322ec38fb65

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


