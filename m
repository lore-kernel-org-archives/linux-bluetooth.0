Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72165480952;
	Mon, 14 Sep 2026 14:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396276; cv=none; b=VKcBOmn/r3dP6hhCJrNDPqWc/wS7gulYGAnnFFZX2ryJVce7DXWbIzf0G7ooSnB/GXa6rIYDJBF4fe8BPawzyafNaWW6mser306AesYBomlQuqpQm23n7hAEX63uEcz9UZ1mX++6brrsIwg6XUU5Z9BfB/KOP76UwuNXxipTT90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396276; c=relaxed/simple;
	bh=IpkYKZs3BFzqo5Xzn3TYBSjd1kg/iJA9ETljDAEyjRI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mvhlbjxVAjkAKlELkmrw010d3HBVJONCIHQXVQ8so37dmdu0Xl2OwkGSFlqPmAAMSYJneWDNxq5ousw6LOCJlg4JNey3qJZjozEnbF9ehQP8Jk3SBx3Dxv5+iLjThqa+BTzdwX+CRYw5zfqqG51iPNDNU9LE2fszycCnsg00Tjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frqLHkqg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frqLHkqg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E346B1F000FF;
	Mon, 14 Sep 2026 14:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789396273;
	bh=BaHc0J59bF80D7dByZ1yfmnClcBTs/ECAlg1lj6FjAk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=frqLHkqgtc13XcgSLKxwboCB1DPHQFHgj8y39wPtucLiE3Sdrspm1AG+3lY2xN0+r
	 5MqaFpJHPlS60sUdPn4Nb516k56l6uQJ39x6BDsJevX4QpxEsvExDCtepPLseu1Sh7
	 Dlvgo2g1Tzv79b0ofKytgi0j+qWZXtY4u50T+0T5cfj1UxIwvJ13mBNEIM9TUYDL6X
	 XYHiQc3KMGv9byWFS7swTbz9W83VDYaiEi7WLVUEKPIoCj3rcsBY1LH+kaHOBTnWN4
	 Ys8Z7lt7giLia6NaRuSOn0DjxzfL0n8gPLZZ9yFQ7h0sJZAIwB8XVeKDtkbBl1NSJJ
	 v+pzaeLUs7d1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568D13924A67;
	Mon, 14 Sep 2026 14:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btmtksdio: Fix PM runtime reference leak in
 shutdown
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178939620898.604238.8055106732131583271.git-patchwork-notify@kernel.org>
Date: Mon, 14 Sep 2026 14:30:08 +0000
References: <20260914094729.3222624-1-tzungbi@kernel.org>
In-Reply-To: <20260914094729.3222624-1-tzungbi@kernel.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 sean.wang@mediatek.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 14 Sep 2026 09:47:29 +0000 you wrote:
> In btmtksdio_shutdown(), pm_runtime_get_sync() is called at the
> beginning of the function.  However, if sending the WMT function
> control command fails later, the driver returns early.
> 
> It bypasses the corresponding pm_runtime_put_noidle() and
> pm_runtime_disable() calls, leaking the PM usage counter and leaving PM
> runtime enabled indefinitely.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btmtksdio: Fix PM runtime reference leak in shutdown
    https://git.kernel.org/bluetooth/bluetooth-next/c/d8dd59bd6fd3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


