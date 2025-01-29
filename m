Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51DA1E32C3;
	Wed, 29 Jan 2025 20:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738182007; cv=none; b=qhfPQ8hVLxle1I5doFb/F10WBPQQ71wSDtRx0KbGaJT7UyxKUa2MLx5cQWdC+Pe5kW9FxQ3Lwwksi3XOrrmjvdDDEjrNIT3teWEVo7DnHTdUsYH1Ml6nLwzm2BVmv9XooInK4vkY/u/6ibE6Cl3prU9m6UOLLVokoJnKGUJBAOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738182007; c=relaxed/simple;
	bh=gjm7iueyFnsJoZL+2T16tjkWPFnCT29nFDY6A7qIg5s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HLMF82vR1f0586UtJGyfCTki+TJp2utf5MJM0a+SWntLtt5lNln90UZvBE4CEuPsh8c4Yif/C/fE9G+FqK82QLW7PoF6Elu93BxKSE8Yi+RY6BE9u2X8G83dj5dMictxLnp5ycGfThmH4fgOokXTJfEwUVEcQDoj9oztoGubuo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFrXOYju; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFrXOYju"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD09C4CEE5;
	Wed, 29 Jan 2025 20:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738182007;
	bh=gjm7iueyFnsJoZL+2T16tjkWPFnCT29nFDY6A7qIg5s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gFrXOYjupte15L6PV3HE/c1rFoASrEtSgNQ9eljgmoXY8fXNFusvOxJBX5uob7WeK
	 i02ZccRZwxalAcTpbnyZ+nw89P66trqUD5FSjx1og1y3/ZTXCk5pgR8vcLgU4VkBTB
	 2CER4svLTYzeQjMH3bex3VAW6HqYFbqAqM4CYtKyAgNwmHUN8CdLu4endDMKAYzxc3
	 75r5KYgqvABfKWayTwb0qUX6RCiXzj2NC8J9GAz9XEWhFGf0uPDmjFYqMbKrrLo0s1
	 2Y3Caaq5djBweNZGAbz7ClNIGJ6xroau4STkDnSWXjW8wNLE8UL/3eF5g6QyX4P7GT
	 ZfkcRl9UezGQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 72F23380AA66;
	Wed, 29 Jan 2025 20:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: Unnecessary braces around single line statment.
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173818203324.417583.7389670075822777929.git-patchwork-notify@kernel.org>
Date: Wed, 29 Jan 2025 20:20:33 +0000
References: <20250125165804.11486-1-deaner92@yahoo.com>
In-Reply-To: <20250125165804.11486-1-deaner92@yahoo.com>
To: Jeremy Dean <deaner92@yahoo.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 25 Jan 2025 17:58:02 +0100 you wrote:
> From: Jeremy Clifton <deaner92@yahoo.com>
> 
> Warning found with checkpatch.pl script. Removed unnecessary braces.
> 
> Signed-off-by: Jeremy Clifton <deaner92@yahoo.com>
> ---
>  drivers/bluetooth/bfusb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Here is the summary with links:
  - Bluetooth: Unnecessary braces around single line statment.
    https://git.kernel.org/bluetooth/bluetooth-next/c/a2a245849af8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


