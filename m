Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92961D5CCC
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Mar 2025 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741798199; cv=none; b=P6WpK+MPVWn7kr7F3WnA3QDQjwXApkcmJxd6ziCDJntX+srffbqvy5ymhOsKtRviG+xpnFT8JxXrUKYbaf0cxQEFnOpEFdFZiqviwAHGcZ9l+i1GEiUMhiZnU/+OwEk+tR8RKkCgaiafpyxvg1z0S1sZ87v60lbXKvmyelLpU5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741798199; c=relaxed/simple;
	bh=Kfq3RQoCeAvREOYZk8TlSXRaGQhxPKa9DovEOOWrots=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AOM3PHLuUxHZS7Nzc8coLJCJrNlz76HtmUfSEeL2R1wgiKhgUHhLEG8H4Ws5IWR6yFCRL5ByOUV214jeZRlOBcq4ZRMCfCFWhDFCQPS6aPaxXC/yR520jNJTFMxUN1Rz3EhuVsAQF5E/XXOQAM+NcmqyAJrpo/WGQJYbhlMeHS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFg4I/xE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFg4I/xE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48141C4CEEA;
	Wed, 12 Mar 2025 16:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741798199;
	bh=Kfq3RQoCeAvREOYZk8TlSXRaGQhxPKa9DovEOOWrots=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YFg4I/xEv4lzvqhXwZ2WoiTTY+p22eugyYKACqjMMzNZT1xSYcaxujeN0d18vQSj3
	 y37zrn2dJdCORmVHpTUD/TCUs/ETSQn7K8URqrOFb+lJa6g8udsQv/Hwna0Lsmev6x
	 AwW0FeuyJP61tAi9MmLk6rF+K6TWNnB7L0CBu2+0pk+JQDKF6gMtbPgpTkq1eE7Fd+
	 aCwYdBTR4PoUQAf4x5jukYyNCDNJwZoH1+fA0tU0H/2Lm7svBHm7xAOnNjxitkvGHm
	 6+Z4dE/A17J8AnEEwQ8mOfspscpBpjwxX7ywerJ3mj/5a5PzQvckWbrQMXnSkeP3AS
	 AUNyDmnulbEcQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC00380DBDF;
	Wed, 12 Mar 2025 16:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] Avoid spurious warnings when dbus.service stops
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174179823373.864475.12714041460000642755.git-patchwork-notify@kernel.org>
Date: Wed, 12 Mar 2025 16:50:33 +0000
References: <20250310114719.4141881-1-kernel.org@pileofstuff.org>
In-Reply-To: <20250310114719.4141881-1-kernel.org@pileofstuff.org>
To: Andrew Sayers <kernel.org@pileofstuff.org>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 10 Mar 2025 11:47:19 +0000 you wrote:
> The systemd services generates a warning when it loses
> ownership of its D-Bus name, which happens routinely
> when dbus.service exits (e.g. when the user logs out).
> ---
>  tools/mpris-proxy.service.in | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ] Avoid spurious warnings when dbus.service stops
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8e835a685935

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


