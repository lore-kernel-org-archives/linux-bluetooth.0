Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793368809;
	b=DrNEggYqzuN9Xq5QOZVkFtZS7gM6hGEt1B37XMSuoMdFa5BDqIRu2kNTyFpvKRHFsAHV
	 dsBKXfjgS+oEV7nl7lXokIi0kBETF6eTyrsXOfg6MUznmzObjOQeHKz96em4kl2/Hc8Cp
	 7AOdzCr6I90+HBfz9WbLALBjrVPzRogWr2uOdF5H7KOxHolQJFS4lzYBozwjLZCkYOgS+
	 zvVhhEsgh5acJRH6pTAZz9ZDV2iQE4FojUCGEnUG1DmJrDRAV5ol/TKA9+JxVsaHuPfZG
	 dvHJzawBuyi5ueVR04hsgmLbrsxr492DOZbRkQmH4uPVrUATY6H8OsdoMhU653XUNaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368809;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=KDmUHr1ttwBjzPIfwyVqwKiJPxoZlsl/K1aAP4Ln+GY=;
	b=CRHpwScH42mdymjnWD6npmipPB9YCFQqpEG/3S/UHSAK85GJMjjoLn/oAX0+G6E3yRJA
	 yDMuuIDunVItKeeJbDUeWy9lOajxTVOftWyfvJe9K5AQGR1/9xe6Vyir9YuUck7/XspEv
	 7GacFYgaPQcYD8Ch2fEh1gl3h9nWv8hcvlx/jOflk2Ctlr1QLM4tfIXpSbuTt0rOqncva
	 FEOQAC8du6nMFGS70FB5WZzk/i18VJhBgrdMrGpyWVQq+RHLoLE77pcv8Yn7x6xnuOOR8
	 1R1fsBE8brp/GcSX/hnh+71PSdLOiwuVwwcniX1jhlwxETNYjVFelSgebm1sVZIfTtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kaKf7nea;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF34F606A320;
	Fri, 30 Oct 2026 14:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kaKf7nea
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94111F000C1;
	Fri, 30 Oct 2026 14:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793368808;
	bh=KDmUHr1ttwBjzPIfwyVqwKiJPxoZlsl/K1aAP4Ln+GY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kaKf7neat4kalm7TTYD3X0qip0R/xrNJrmNsVTrvG555khJ49OS0qjFMN2BptfHqC
	 u3kuNhHKatUXV2/sRb7l3O/hFEdzu2Qi78gJviOMWiGF07ljrt6ZuOLRKSJdpSNzs+
	 lK/Xy5GxY3XL0YFIB1/9NGHkV4qcP9HzaJj0xo1vPbf53IB0/eNavClS+ojXtGb8Ha
	 V/VnJ/g0zRiS8Mef+/lIVHwcvfZayyDl9ddKCMIfoaGrZEL0ioQWzeI1yG5M9ysVZ8
	 tU8ty6gP15zfaz9iaelRqL2JBYnFTnXUP6C/ielLkOoEHwkWxG3UFEfvif7pr5NM6c
	 4ZmB11eK+bp0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA24A3800465;
	Fri, 30 Oct 2026 14:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/4] Bluetooth: Keep borrowed keys inside RCU sections
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179336880729.1091505.16673199626130104099.git-patchwork-notify@kernel.org>
Date: Fri, 30 Oct 2026 14:00:07 +0000
References: 
 <pm-bluetooth-objects-candidate-0122-v8-952ad9eb0ef59367ba6a-0@gmail.com>
In-Reply-To: 
 <pm-bluetooth-objects-candidate-0122-v8-952ad9eb0ef59367ba6a-0@gmail.com>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, jjzuming@gmail.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 29 Oct 2026 21:12:25 +0800 you wrote:
> hci_find_link_key(), hci_find_ltk() and hci_find_irk_by_addr() return
> entries of RCU-protected lists after leaving their read-side sections.
> Management clears and reloads these lists under hdev->lock, and
> kfree_rcu() frees the old entries after a grace period. A user that
> does not hold hdev->lock must therefore keep the returned entry inside
> its own RCU read-side section until it has finished reading it.
> 
> [...]

Here is the summary with links:
  - [1/4] Bluetooth: hci_core: Keep link-key filtering inside RCU
    https://git.kernel.org/bluetooth/bluetooth-next/c/b5bcffa76cbe
  - [2/4] Bluetooth: SMP: Protect link keys during LTK derivation
    https://git.kernel.org/bluetooth/bluetooth-next/c/a7a9d27def4b
  - [3/4] Bluetooth: SMP: Protect LTK encryption with RCU
    https://git.kernel.org/bluetooth/bluetooth-next/c/5b9045b0a114
  - [4/4] Bluetooth: hci_sync: Copy the resolving-list IRK under RCU
    https://git.kernel.org/bluetooth/bluetooth-next/c/c278da2c4761

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


