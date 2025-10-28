Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9997B2D877D;
	Tue, 28 Oct 2025 21:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761687030; cv=none; b=JN9EEnTNTZgeM3Ran8jDENXXJf0U0jnFdefNe3QS/rxMfOyBy2mQ30VP4B6NwL6DTK3J81fw5UZwBKTLGGXtVQEYyzxHp4Dx6+VkbI9llzIkowmoZcwOOckhgKanZPiDHQYE2QyO09V41GKjtILdlIxLUrjdELD9iklfxv1J5iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761687030; c=relaxed/simple;
	bh=PBfFa50thmRpidq6BOC5K0JDhrtSoy0t8qgytuJUK1g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ntvykKe1xW8BIghMDsI9lcq0wONvgJM9L4qHNbFXI1eRzbadJGe3hBhvIKUs8pouvFHWsebVJ0NwqsKLrHjnM2Q9hZklDXHfl37pvCw/6/jkSHnDXBt6/p2R3HQigLG0xVmVH4KfYvOxSsazLX8/c6wGnchlXDxBREhWqJ7efDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3ZXKk6G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3ZXKk6G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16BC6C4CEE7;
	Tue, 28 Oct 2025 21:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761687030;
	bh=PBfFa50thmRpidq6BOC5K0JDhrtSoy0t8qgytuJUK1g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C3ZXKk6GVpXS9q544hhnMwd8d+5SWi0MGFG7FHgsNjjoB72H1adLghT7RRoK9zAsk
	 EKm2yFyplU3iMePMvdJedIAkCYCv+h0Hr5oqJBeiz4xF1Tj3VKK1z3RbNT3EFE6QQ1
	 3o5TRgMLIufUQZPWHqwxL/Rn2wEWp4rvtt1anEi29+VMa6nB8LzBz+BnlD4rtSIH4M
	 qGPFRQJms32QOqt8V2vRgC7kIJOcdQv3Emxyixp+R6WZ2NNuO0hnAM7wRaxcX8fFmU
	 /Jb5RR7iiuF8O0guP5ajb84V32KSSul+scc0bn54BS0/UlFiOFs0WIJU2GAX/ePzHs
	 QgVU4C4nIbl+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id DF56D39EFBBB;
	Tue, 28 Oct 2025 21:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btrtl: Fix memory leak in
 rtlbt_parse_firmware_v2()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176168700749.2391991.7235212202926157732.git-patchwork-notify@kernel.org>
Date: Tue, 28 Oct 2025 21:30:07 +0000
References: <20251028175632.146460-1-nihaal@cse.iitm.ac.in>
In-Reply-To: <20251028175632.146460-1-nihaal@cse.iitm.ac.in>
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 28 Oct 2025 23:26:30 +0530 you wrote:
> The memory allocated for ptr using kvmalloc() is not freed on the last
> error path. Fix that by freeing it on that error path.
> 
> Fixes: 9a24ce5e29b1 ("Bluetooth: btrtl: Firmware format v2 support")
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
> ---
> Compile tested only. Issue found using static analysis.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btrtl: Fix memory leak in rtlbt_parse_firmware_v2()
    https://git.kernel.org/bluetooth/bluetooth-next/c/4a3855790fba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


