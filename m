Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A99738E8B9
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 20:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787604061; cv=none; b=oaQRT/wpXMIPbwq8+iSisyAefRqNQc/yzYp7LwJS0QY4ASIs21TTDC64h41DN1qC2CEDbPlUSAbu2JC3bZ3uUBnidgBxf/tnD/hrU+iNxWzjEa8tJ9mHRYrLNmdJoBKV/LYx6K2CCLFaC0TQALtdXLrdXpGPobiJxErjnrC2zN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787604061; c=relaxed/simple;
	bh=RrCsr3zofJDopeNfnKwmQdWw3Krn160Dpa8LiVgW/pc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=prNEKto/V3gNJy1Ls+0Vq7VQrlwE44+PZ6AyWy7qzqNjAJIj0X/qGcrM8WLwNolNK1UX460PHudo0UQRaGdU4tjav4PUuy3s2lLEcrdXEd0rd+CqtATJqxW4e/qZMHCL6N3wKeVI5ZSMr1KyofdkrWBVe5ELWegmjPVJuf/98Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sl5SVecc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sl5SVecc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17A31F000E9;
	Mon, 24 Aug 2026 20:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787604059;
	bh=/t2Z0NlhBJ6+Wfa73MybMV+f1z6X1QGzrs2MKnuXWwA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Sl5SVeccu80jSyt6Q9YoDIFLj6Wyer8X27zmUHYOCUtKZpRNkL+UG7JQ0A9uqV1AJ
	 98INc5QEcEgWiGVDsB+gFhUZG4BfetBR75w95mFZ176X+SKfPpFULd5v6vibkN0rYQ
	 SqsCOvSR/mso++MJJBHDHJYUNgFWEw4FL+LkyOVQObYEm/0Z3EZt2rupFcvK/o9wzX
	 4gc2thbf229sQtjcwAymjkhRXlc2cm2RGUiL6EF2Tyw4oVlgYnDjfqRVwQ1F0cLojV
	 46n+E+3lQNefIqWSbN+sa7ISM/puM9LPF5PVLOFRTs2wQGKWYdSkuaG3vwaVPdsx75
	 MNbxGDgnqhU8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939003924A51;
	Mon, 24 Aug 2026 20:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/5] player: Fix crash and related defects around
 the
 pending request
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178760400713.3109701.10398466433951422779.git-patchwork-notify@kernel.org>
Date: Mon, 24 Aug 2026 20:40:07 +0000
References: <20260821193449.1336263-1-george.kiagiadakis@collabora.com>
In-Reply-To: <20260821193449.1336263-1-george.kiagiadakis@collabora.com>
To: George Kiagiadakis <george.kiagiadakis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 21 Aug 2026 22:34:44 +0300 you wrote:
> A player that advertises the AVRCP NowPlaying feature bit but not the
> Browsing bit exports playable MediaItem1 objects while the player scope
> is still unset, and calling org.bluez.MediaItem1.Play() on one of them
> crashes bluetoothd with a NULL dereference at offset 0x28.
> 
> media_item_play() dereferences mp->scope, which is only ever set from
> SetBrowsedPlayer or ChangeFolder, and both are reached only when the
> player advertises Browsing (features[7] & 0x08). The /NowPlaying folder
> and its playable items are gated on a different bit (features[8] &
> 0x02), so the two can disagree. msg sits at offset 40 in struct
> media_folder on LP64, which is the reported fault address.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/5] player: Fix crash on MediaItem1.Play() without a browsing scope
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a8d22214940d
  - [BlueZ,2/5] player: Answer pending request when the player is destroyed
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ede23fb50e41
  - [BlueZ,3/5] player: Fix NumberOfItems never being updated on SetBrowsedPlayer
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3215010456f1
  - [BlueZ,4/5] player: Report EBUSY from a busy Search()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a93047cd044f
  - [BlueZ,5/5] unit/test-media-player: Add media player tests
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


