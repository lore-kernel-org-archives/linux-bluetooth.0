Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41B04908B3;
	Tue,  4 Aug 2026 17:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785865249; cv=none; b=B67aWBZekf3cfm0yKVSNV+UCliduNSBnuxDYsQEa1mpr4H8LMdfqThKP729rj709zxTI5v1r5trctT+FvWASUjfr29FdX/hgIaDWZczcLQ7MvQ5iMN1cFcFjS5z3AaMc0g0fQQtx7byc6agepC45Mk/8i2pNN4QDO/2k+IrO2CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785865249; c=relaxed/simple;
	bh=z2GZfp+qWgwmKFeiOKZtDfWIfx7pavnWFIScUoFh9xM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PbP5guqXzEJjEu378gL8y7nfLj3aHzvu9Mficru+OHBimwkV2RXY3oj13csrD5045OaTzqS6WhK9Eha0TbKTFK4Cfh8v+sUOM1htELMRQh8uvb5QU/rZHkgmSeBqDjINzohNth91SOhms93BoInQDkhiUtrDNQRc3ZtPiMlvSHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+RdzYn0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+RdzYn0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CFB1F00A3A;
	Tue,  4 Aug 2026 17:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785865247;
	bh=rx0JR9eOxUr8P9PC0GIOgE2FbJVyQxMtVkXr6EisFVU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=I+RdzYn0+Qi+2hhfCpO1bqTtENe+8hGjRxhXkLebGAGUCbCqj6Ju6dbc1+ElzrTAK
	 /p3Qfaz9sdslEGZ+Fyx5ptMQZpeMkyHAgfHV2R9dc1eUkekOcqOFKd0gwJGWyDniZ0
	 SwHQ2g6pgO7IygAuTLRM9TBHdy82e7FRv/fU9NqGdxLEIvX7bTLocRT8mzEB3Gfl3k
	 KhwMfLxheD3DRO7M09XsKVLGhxPSuKc3yY7lr5EsvudbA9TbdBg6Sw5SNKuwkEogv9
	 cK1U3/Mmlv1sflPLLvffbjATbYumNHIRSl4WqyhDe9HISNzx+eTLKE3MI1JE1gfUDs
	 tlRg7J7sAsP4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198573926272;
	Tue,  4 Aug 2026 17:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btmrvl: fix event packet length validation
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178586520763.3702995.8912183304786882050.git-patchwork-notify@kernel.org>
Date: Tue, 04 Aug 2026 17:40:07 +0000
References: <20260804094632.87581-1-m.szyprowski@samsung.com>
In-Reply-To: <20260804094632.87581-1-m.szyprowski@samsung.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 marcel@holtmann.org, luiz.dentz@gmail.com, liqiang01@kylinos.cn

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  4 Aug 2026 11:46:30 +0200 you wrote:
> The event length validation added by 75e574f6a212 commit used a single
> check against sizeof(*event), which assumed every event type uses the
> maximum payload size. Unfortunately event packet length depends on the
> type of the received event, so it must be checked separately for each
> event type to avoid rejecting some known well-formed events.
> 
> Fixes: 75e574f6a212 ("Bluetooth: btmrvl: validate event packet lengths")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> [...]

Here is the summary with links:
  - Bluetooth: btmrvl: fix event packet length validation
    https://git.kernel.org/bluetooth/bluetooth-next/c/d56d51cc0cb6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


