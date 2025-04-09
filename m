Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793AD26ACB
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Apr 2025 22:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744237815; cv=none; b=tclyqdb0JlYb+fvxG2xwpgtHJANPOUUNugpIZO9c7SZROeFaUgkPMvA9rzWOz5yAqkmHkQ8w6aXghLE7s1KzI2OSVOcUmnjwbd5Bi0GaCaAbTxpsRWBT9P3WUKJeQ2Gg1I1V++vTwgUgQuwPd6Xrw1jbBZpJZvbJfcyUgI5bfrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744237815; c=relaxed/simple;
	bh=ya3bpkTl1nnYi5gIbyhLzo2fN8URuz/rGnJEU2f3zxs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lk1pAEbAeYU75c+f1rVIRNIyqNdgcWtA79CEa0AFPjCIIfKvMI7OzXznZ6bYWPDrJolU3coT9I+GBCcxk3V3UTGkp+cQPtIiVbYqIHmPQEVJx/sI2k/0FIIwBoPgiG/31IwFmXpivJw/K+qbT9qufvVS0ipCJ2XbbqIXwG2ZLFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyaNk9hw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyaNk9hw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAEF8C4CEE2;
	Wed,  9 Apr 2025 22:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744237815;
	bh=ya3bpkTl1nnYi5gIbyhLzo2fN8URuz/rGnJEU2f3zxs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AyaNk9hwf6TKsrn7IEIrbrYVw3ZUkH6WZvM4w0zq5XR4sT7Q9wKmR/FKJ+XLIkuKP
	 d3PHBB+sYbcjc7PeWjPhtx8u7CHldQ7vbR5KYJWloo9iec5VI0yro645/NUaaPgG6N
	 9+DJa8OWUbYlwy0hJYQqdyo9rM2Pd6KnAvd+EWWE3vd1tpiHu5pMIMRZwvhdVRQ4gD
	 wIt8E/FlV91F2k/w6kaGHaxoYgZH54vveu8Okr9bwz5ZtNRgyyBDtIG0kEA3oejshd
	 2gF8AHab3Xa1+HYb5sXS3cj2ECZyGkkYmzjSLaLMwnfJ+bbPx/ROb9FsIKHKFMBKTj
	 DEfDYHBGYKfww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE3538111DC;
	Wed,  9 Apr 2025 22:30:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] btdev: Fix checking for BR/EDR scan enable rather
 than LE for PA
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174423785224.2970064.268125301847206570.git-patchwork-notify@kernel.org>
Date: Wed, 09 Apr 2025 22:30:52 +0000
References: <20250409192148.305768-1-luiz.dentz@gmail.com>
In-Reply-To: <20250409192148.305768-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  9 Apr 2025 15:21:48 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> PA is exclusive to LE so le_scan_enable flag shall be checked not
> scan_enable.
> ---
>  emulator/btdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,v1] btdev: Fix checking for BR/EDR scan enable rather than LE for PA
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f8e7bcfdfb83

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


