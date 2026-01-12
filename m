Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59828342C88
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Jan 2026 21:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768251686; cv=none; b=B2WBgqWoEeGaWcuaaGZEeitIcp65PQWLjIy6qfkcdPKpnCDvvtbWa9cauSTyHi9c3HTY/bui9xO9lfaizTLIfesuCSUox009NMZlkRAvpDuqFolpFG/dpOZtVGHJwH4o+Iwet1qr0Likvi3cocRpzmvpRwdKes8VqmhEfS9yG+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768251686; c=relaxed/simple;
	bh=JerJj+QLnJX7+4JEnJo0MGFJwL2UKjfInAER26B6cnk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kS5zMiSXd0T11GdlXzfeq9VU87EcXVHpbmkVARP3Pf5KAlHTPBO2+U1fVVvaHJEUfMUJTMewggjhQs/rhSuqZ3/T4cN/+hIiiX20Ovoms6o+FEWN9OYRsNoJAOyXrrLPeIS/wKvULAeR2rdJZXNTn9KdpXP19Iw+n4Msf4mdcQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0Hojfch; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0Hojfch"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFBAC19422;
	Mon, 12 Jan 2026 21:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768251686;
	bh=JerJj+QLnJX7+4JEnJo0MGFJwL2UKjfInAER26B6cnk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U0HojfchPgNdefG50WOI4dGJZKsz157XIZSy3sSJUwUWTgE8OJe79YWc7UX/T7bYe
	 xzknjD5cyVWHCunItTZJRM0BD6cqhYWKLrnlCz1ZySjxOPpEUq6VxlH6n1zGS1EpYJ
	 J66vG5zWr1l0pxZHvLtAKKPZtL4W9mpdY7hxcvp5p0hntkDfn8mmzAfpOXty6QuDFi
	 2s3qofKWgy8qjzEhlOZwTWGkX//0+cJ1YHH3ugJiRNP5t0cQuPtl4aBGMbADl5KFkz
	 FrIGAt2CyWVuSdLGTSipvcipOzK5pKb5m6/sOFqk1EGTF0lf7Nu1rvqF6vEMYSB5zo
	 3tshZbMdtYoLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2EE7380CFD5;
	Mon, 12 Jan 2026 20:58:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Use pm_ptr instead of #ifdef CONFIG_PM
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176825147953.1092878.16738898581734425946.git-patchwork-notify@kernel.org>
Date: Mon, 12 Jan 2026 20:57:59 +0000
References: <20260112105127.3664608-1-hadess@hadess.net>
In-Reply-To: <20260112105127.3664608-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 12 Jan 2026 11:51:13 +0100 you wrote:
> This increases build coverage and allows to drop an #ifdef.
> 
> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> ---
>  drivers/bluetooth/btusb.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Here is the summary with links:
  - Bluetooth: btusb: Use pm_ptr instead of #ifdef CONFIG_PM
    https://git.kernel.org/bluetooth/bluetooth-next/c/d1e94a4934e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


