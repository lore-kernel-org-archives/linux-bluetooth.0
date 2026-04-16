Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BE0324B1E
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 16:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776356441; cv=none; b=u0fYcrpsJjFDcU2TD4QPzyiP/6OlvadmyB27euMnQYJHkeJpIBwIaT74I6zAghydVQM+LCgaQp5O+8xXcYpJGSGHngzrzm3MTJ+5IdsyZuGvYXBU0+YSICNKGbITLc94iOYHrOH4uxcwUQer2pvMsOn3n+Egbu/QvZ0r2wXrcHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776356441; c=relaxed/simple;
	bh=ulfuZELYfuACowhYVp3BaPAjeaB9JqAF9C5B1tSTrBk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B0olCKQgwpaGlzYnzOvVVygY49+e6YuSWhg6VnrAZTTAZSKzz8i56eNgvmwa/8ukr44+RSGIefQAaxJuHCuYfkPxjGb0hOvtp+/YEwViXS4JEQt+bslX4fi1Poa9jCrfOw0zYQrDVaUMQHu8mLJJacj03wszEKBV5xQrAmr0q+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crRxCjmg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crRxCjmg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02ABCC2BCAF;
	Thu, 16 Apr 2026 16:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776356441;
	bh=ulfuZELYfuACowhYVp3BaPAjeaB9JqAF9C5B1tSTrBk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=crRxCjmglZYs4parfQYi9Er8NWERBmiS6h1pE+mwOoqqVCmlZB10kpRmnOdyZuO32
	 GPbQS44+9ZbScx/sNCrYKGjGkyfqIRgecTNMfV4j0QH0yD124xGgWh9e1zD3cqPZTe
	 p3PQd3GCdN892esFu0gSZTW7k64/fPsriHFT6ilIxeA3i2Q+EZKYL/kl0ypSY2Zy5r
	 QlybXGNXho8E7ro/jtWZm1VrNSD0KoVKrqr8TfbNjDvEqQuqtYWOG0lfY47rOOEvP7
	 PgitTvSiG7IxqnMC8PlPHk7MCt9zlw8mhjOk6ddj10p+3LUDBHVn5s47q5QQUUTflQ
	 QrRd2oPC6EuUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9D19380AA67;
	Thu, 16 Apr 2026 16:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 RESEND] Bluetooth: L2CAP: Fix null-ptr-deref in
 l2cap_sock_state_change_cb()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177635640929.3303094.16953315834130915561.git-patchwork-notify@kernel.org>
Date: Thu, 16 Apr 2026 16:20:09 +0000
References: <20260415205205.2366630-1-oss@fourdim.xyz>
In-Reply-To: <20260415205205.2366630-1-oss@fourdim.xyz>
To: Siwei Zhang <oss@fourdim.xyz>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 15 Apr 2026 16:51:36 -0400 you wrote:
> Add the same NULL guard already present in
> l2cap_sock_resume_cb() and l2cap_sock_ready_cb().
> 
> Fixes: 89bc500e41fc ("Bluetooth: Add state tracking to struct l2cap_chan")
> Cc: stable@kernel.org
> Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
> 
> [...]

Here is the summary with links:
  - [v2,RESEND] Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_state_change_cb()
    https://git.kernel.org/bluetooth/bluetooth-next/c/e95f060809df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


