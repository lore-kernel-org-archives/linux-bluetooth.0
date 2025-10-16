Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AF9298CBE
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 20:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760647222; cv=none; b=QzFaw1uzC2gO6n+Vkq/U7VpAzUnvizdMDRIfnxXbnuPojJmGad/WMsgBlyXR7VGHU3BpQRs+5bHSRnaZp0H49bKv/Skqjlk/54V7Y3MJUJvP41580uYf4zNQkX6jXORvFbamCvRWIkWTGOG8y1RyW7NaTNrAhnFjd+/jf9fKgaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760647222; c=relaxed/simple;
	bh=fulU4Nuwg+oI0VSmbZOb2RaEaRR63h/3l/W9C1K+3rQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fQ7bxoQ6oeVLY4Yb5eouasgnvlsVy66R0RQUDLoru2OgIyNGpUbLPvtTpDv6El7WR5huCAB1l2+NFqlPywt7aRvCVMZq4vZ2hytQJhvTOyJ+LJev/cYZtNKi/DJNj8TxwB24DMndD6JoVjVgY6d/D0VCd7fxiqKFxwTnjsHkTHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oE0VaRzL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oE0VaRzL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99EDFC4CEF1;
	Thu, 16 Oct 2025 20:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760647221;
	bh=fulU4Nuwg+oI0VSmbZOb2RaEaRR63h/3l/W9C1K+3rQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oE0VaRzLCgGNi1MdfpRrABK+fspaEdkTDYYoTjxQdxOsztrHjH5kf6i2GzNPZAQ6L
	 nuRRPeuLpjqVhfIgtbRJyRrq5xXZoB91pXDI6QcDVf6Bu9kEpfoueXTcrOhF1zwaC6
	 V8KHEykMLzO6vha/As/PWHR7Es8EOcSq7lHDQZCHuv6anQ1zdyk+QkQIK+vXzBV65G
	 HqNPZY/jeUwR64Lqegy3e1Wrb15ma0pEBsScEPJjzwYNDItybqb/b8WbLi9PjrUxMd
	 oLxDeoVlagFOWtnup7liiLwf3aIAmupWv45XlKjRrC26yh3cFmJJKbLHeArJ7Piq7K
	 tLxpcHTeGcXLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0CC39D0C18;
	Thu, 16 Oct 2025 20:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] mgmt-tester: Fix handle value
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176064720576.1897680.86006101191064828.git-patchwork-notify@kernel.org>
Date: Thu, 16 Oct 2025 20:40:05 +0000
References: <20251016131514.92485-1-luiz.dentz@gmail.com>
In-Reply-To: <20251016131514.92485-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 16 Oct 2025 09:15:14 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Recent changes to emulator has changed the ACL handles to start at
> handle 0x0001 in order to use dedicated ranges for different link
> types.
> ---
>  tools/mgmt-tester.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,v1] mgmt-tester: Fix handle value
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8d181e4e4a06

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


