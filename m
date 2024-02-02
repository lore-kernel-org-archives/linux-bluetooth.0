Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26EE135DCE
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Feb 2024 19:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706900430; cv=none; b=oF+K1jnTn4wZMO4bRq91zERdiKQCU9MU0dki20V00PdczJ4nNxXFVlZSUfcqJaESSflP46UkiwiKiUmwg9Qc9UIzfZ9oGvIUYA2loh6UyftgUr9Ct1fJJ7M8xy1hVSzP4GdK2Pj6RTXXDxUK8J4IgSiOfcPNcPJNyMSVHrQQf5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706900430; c=relaxed/simple;
	bh=1/g1Wzik/dVSHX20OxyrwaTpmIEnd5Bn0yLd4bjot9Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A0FmkYLX5+oQhjMNZswn1od9P8HlghS975nsnQms6TwBqtSkSB5Dt2TIfNfxUdVFLZGEXW1oSieMP6sehlEHvthT5LmYcjKubd+0Jb0mFEv+AyZda9yIHkJgsgp2NlP8Z4ucQ0KVzbNYlRiQ7x5TRoZZLeFAmqXXhn8Q+BqzU5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAc1aZvV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAc1aZvV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A450C43390;
	Fri,  2 Feb 2024 19:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706900430;
	bh=1/g1Wzik/dVSHX20OxyrwaTpmIEnd5Bn0yLd4bjot9Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XAc1aZvV7GzWHeTwdqwjeCEuARE7MCzla3gChVtEkmma6YNYnhFv2CCPolDhSOjcZ
	 gPHBRwGBNyw8sfCSBFVFoysLdg86qNQRfhEYIN/ijv8W2hGN9ylzlpjRufAu6BPZnX
	 DaU4m/Dl8vNFQeRZeC28W7c3HbDpzxB9L3YeXXyef06YM953rG7O6M105HAqULqI97
	 vDZADfEM2qpHvzGH/7ga2l1D6JaBKUg0JM4eIWt+hp0GmVrrL4zgOUgNJoYukPDI4A
	 WBMISjJKE0b2AaDoCjyTq/l0c+g0hY7EZj2ae/v+7aDUCCdkG1BA/PXJHehA27PBh2
	 XL0SNGoHN59Kg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2E413C04E27;
	Fri,  2 Feb 2024 19:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: hci_event: Fix not indicating new connection
 for BIG Sync
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170690043018.7237.2977373390725173014.git-patchwork-notify@kernel.org>
Date: Fri, 02 Feb 2024 19:00:30 +0000
References: <20240202180951.1605724-1-luiz.dentz@gmail.com>
In-Reply-To: <20240202180951.1605724-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  2 Feb 2024 13:09:51 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> BIG Sync (aka. Broadcast sink) requires to inform that the device is
> connected when a data path is active otherwise userspace could attempt
> to free resources allocated to the device object while scanning.
> 
> Fixes: 1d11d70d1f6b ("Bluetooth: ISO: Pass BIG encryption info through QoS")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: hci_event: Fix not indicating new connection for BIG Sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/104ee1dd1ffa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


