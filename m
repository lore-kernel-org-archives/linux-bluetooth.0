Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5B71FBCA7
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Sep 2025 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758635413; cv=none; b=BoDZ6s8oylAZH8QuUMK2q7lppQpQkOtCXF7YpjiJuD78L13vHcaE8BMewvpOnbPSXtQAtWH5dYKTmdImTgAdZ6i8xsjFKK1khGISv5vTarTo0AZwubg8sWTvIwCP4HXmdd/LdA8qsNJhOlNirzo2zdk3H0bqoOGZK5DD5uFW2L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758635413; c=relaxed/simple;
	bh=yojxz/H0oL3BT8IslfxgvA9ED/CTah6KIBv0McC34cY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KC++qZcTXsPKw3wQRJCRM/zRgVGJGKWCO08RtyF9gshsMfDb9Zb6hjy9k/I0x/J4r4AidYJ1n4ZwiQJYYFJ9mqOphkR3k4ZEISsLxbmL1p2g9Xgfsr8wlgjgacKX2J0EQhnNk9iIkGzXpE0A1nUu0jSZZzAh+qAeXwlMALRceIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUHQfMLy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUHQfMLy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E2C4C4CEF5;
	Tue, 23 Sep 2025 13:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758635413;
	bh=yojxz/H0oL3BT8IslfxgvA9ED/CTah6KIBv0McC34cY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oUHQfMLyuMZrpBtxsAqBxVNNlhC7tV5Fak5tUlP9aIa9Y2aIFdbDWy837qpKjj92B
	 DCPIrMLjB9jM0gLoyWq1VIKskz4lr9PNTIrUTTkkGG1A+RNwgNEpyo4VuiXk+Sgozs
	 MKjy5oYdFUYDazupG87gtB1IC0vlY9thHj+DkXgeuwiCnqj7iDHlWTGX/+4+8oHyE1
	 g+NX7fhc9qZBoXYG68qRpR9oLxPUwRj9gDFKgAgHlgotyQbxjeNQbmMrtkE/eOL4aG
	 CrZ4oVn5nyRz1pTe58TAKEU8wrT2zTDgGY1gYdboVu03lpcz6HstqhqpOmVhgyfUha
	 fw2cO9hiTzx7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EABF839D0C20;
	Tue, 23 Sep 2025 13:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: ISO: Fix possible UAF on iso_conn_free
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175863541060.1433266.6164175899804120508.git-patchwork-notify@kernel.org>
Date: Tue, 23 Sep 2025 13:50:10 +0000
References: <20250922203107.3112454-1-luiz.dentz@gmail.com>
In-Reply-To: <20250922203107.3112454-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 22 Sep 2025 16:31:06 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This attempt to fix similar issue to sco_conn_free where if the
> conn->sk is not set to NULL may lead to UAF on iso_conn_free.
> 
> Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: ISO: Fix possible UAF on iso_conn_free
    https://git.kernel.org/bluetooth/bluetooth-next/c/f5a7fea12bc1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


