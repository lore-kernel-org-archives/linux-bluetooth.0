Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8256F29BDA5;
	Mon, 11 Aug 2025 16:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928956; cv=none; b=Kw/frFnHILXFvBX6BN+/aaHLXO5HbdOW2qDj+RKWpbm8HM5HydcVqVjmdYQ5wgg0BuBEkQVsfEJ9qbKfiQj7sCma+A6MRu2iT/J635NV4Fl5kNrt5QsYMEHWflIKiB+Jh9D8PSTIBt8xakrXnHkbFIDkJ1cN+nRQl4PxDhY0Mro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928956; c=relaxed/simple;
	bh=o1gIah4K7Il1XlQ8OgE/fAmwguOP6eQWUa5LNbztNgA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NQECvMZhyXnJVLvwD5ig/SAcr+YoCAO4VeJ/fNZELu3p+Hk+Y29oR2SDAKfaafKFgtb/z9T0ZWxC/AtifqVjYsU0JN1Ec26en/c/Bw+8Y202U4bKcQPGvO0IwLiQoVqiCbN8G7NrROimUx4qeGvJnm7jXUMs6+5KzauCmxjrsUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSAlGCy7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSAlGCy7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5D5C4CEED;
	Mon, 11 Aug 2025 16:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754928956;
	bh=o1gIah4K7Il1XlQ8OgE/fAmwguOP6eQWUa5LNbztNgA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mSAlGCy79AEhzZQGT9BsFM7KQMIuzLAIXlC5APtuEXmkx9Ci0bzcogw/ca5X0LPys
	 j4ph8Q+wXflsd+B0khC14jnk2fgLd8Yge+desGuOqR1y4UDE5km6uevRvR1IPJqlmF
	 4/ZUXqrFGWQb3QwQ4oZdGS9lMzhyDtJd/MhPrt2a+SzdlWZbdNVfxHH6FJOdB0seMo
	 T6JQmq/EyxX8XECDDhfYDDCD+pWnJlO3PP2d0wbNYxJB8PSrRjL+ARtnCoumgOxgul
	 lA6twXuAinw2+9mIpJtxhFQOKDKtY7Mr8ZaDLV1kCYn9i5xyeTL5JDdyP98DLC2Dvt
	 2uR3DBmfbtCQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB070383BF51;
	Mon, 11 Aug 2025 16:16:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btintel_pcie: Use strscpy() instead of
 strscpy_pad()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175492896874.1716045.7275722865948412355.git-patchwork-notify@kernel.org>
Date: Mon, 11 Aug 2025 16:16:08 +0000
References: <20250811091906.4640-1-thorsten.blum@linux.dev>
In-Reply-To: <20250811091906.4640-1-thorsten.blum@linux.dev>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 11 Aug 2025 11:19:06 +0200 you wrote:
> kzalloc() already zero-initializes the destination buffer 'data', making
> strscpy() sufficient for safely copying 'name'. The additional
> NUL-padding performed by strscpy_pad() is unnecessary.
> 
> Add a new local variable to store the length of 'name' and reuse it
> instead of recalculating the same length.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btintel_pcie: Use strscpy() instead of strscpy_pad()
    https://git.kernel.org/bluetooth/bluetooth-next/c/523024537985

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


