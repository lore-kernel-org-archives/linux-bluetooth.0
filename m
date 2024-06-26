Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA4F18FC9C;
	Wed, 26 Jun 2024 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719432033; cv=none; b=AEx8H52wuf3vULH8P0FxrtFw8F2s4ByDLWA3zEHvky74Bp1nnOcOid87/h1+b6JJKdtDa9qdM92zMZY8j9A3PPV+qu8Me+YbwpYYlOn2Uaq14HbFGrzGGDIU1mlbPlh7AZNi3zaxsaoqRPnEBLQu8DoVeHcyWKdTsxCxaSZzE/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719432033; c=relaxed/simple;
	bh=HYHpe0pq5g0+okKD/6rI2QS/YyqmW5YCZzuUSCj2C7c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A9dYQdHYFzsehlBxvP0LUNxtEficDZz0JQn3Ky7nX3yHXoQ7yYCRXqbdIvvmC6+Wjbw2MLiCmUuGmaPbn1d1tU+nDUDDbTQoVyRQ/QAiAXmFZmNgNpxCYQaf56et2+Lie9Rncx1sZx+BmJIg9/m3ZOfpx/OSPYS3wRaCzVn9CdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUjHP/LZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUjHP/LZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BCD47C4AF07;
	Wed, 26 Jun 2024 20:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719432032;
	bh=HYHpe0pq5g0+okKD/6rI2QS/YyqmW5YCZzuUSCj2C7c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hUjHP/LZHbkELKJU5nMH1aY+VJydm/AdIrGIePf50g9pHWTm0wk5gsi5JmZF5Avkb
	 GcmiwFgU9K2aunImU4u1lW9QhNzTlcgFp3LAgkVQpUj2qzxpjUeEPsF6TRiuaT5vTr
	 39AF0wY/199OywbWNwI9ncw5x1MmjClefJqoRUqGVeqoZ9zBcyMvmHWzDY/4mFNsz9
	 LHW5hjfg+yeSFoqNBQOJbHgZD8Y6dkFoExVuGQrC/hKOS7dGs6A5P1mBhV+CSIX6D/
	 OtYFDzdxZzaKQKmCng7hGsW/MP1emCspQRzYSMCHS/MHmuRLkV3DVMeoJneui9oN7n
	 hkCKxkteG55lw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AD1C1C43446;
	Wed, 26 Jun 2024 20:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btintel: Fix spelling of *intermediate* in comment
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171943203270.19782.16945455633652764768.git-patchwork-notify@kernel.org>
Date: Wed, 26 Jun 2024 20:00:32 +0000
References: <20240621071858.148358-1-pmenzel@molgen.mpg.de>
In-Reply-To: <20240621071858.148358-1-pmenzel@molgen.mpg.de>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, kiran.k@intel.com,
 luiz.von.dentz@intel.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 21 Jun 2024 09:18:57 +0200 you wrote:
> Fixes: f3b845e0aea3 ("Bluetooth: btintel: Add support to download intermediate loader")
> Cc: Kiran K <kiran.k@intel.com>
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>  drivers/bluetooth/btintel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - Bluetooth: btintel: Fix spelling of *intermediate* in comment
    https://git.kernel.org/bluetooth/bluetooth-next/c/94382b8caa3b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


