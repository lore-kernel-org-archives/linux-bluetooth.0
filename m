Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4634367B9B;
	Mon, 17 Aug 2026 19:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786996006; cv=none; b=BjUVpvdHPF/s371FKgPaXbd/bFZibK4Nrf1P7M3RDIOc3pQuYps8yV6FFH7RrOXuqL09PRiPi/HP001oZv5SpXnZGiElLF+AqyywjiPJ25TblDFe30mEsxywHStW8A35OfYFDoP85exDNIcpZfYUcSdTZW7+GoGF6Lu0bQZaSQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786996006; c=relaxed/simple;
	bh=JlDRS6X8g7qhGooeBqaX1KmNIjm0MkAbYSvJmksxks8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rgVzMI6R1RPn2Yp5s0ciYx/VH3xz+TOV18/pf4t1ldEbNTGsSJFTqhMm4NDbKYuBBFynYH7uEDLLgg2whpu9ePs/SgbIvvIwzhHSVbccfkfG9mxSt52ogBFo9kZfq24qQMl04N+siZ4zxzHOiOtkRk+YndkhtSSFvmPlvOX4pro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQowfqHJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQowfqHJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70DF91F000E9;
	Mon, 17 Aug 2026 19:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786996005;
	bh=q3mTxThq2eLy86xHYm2SOBoR5dU3codgK38xVj3ikbo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GQowfqHJhOQATrJ4wwy0mLfZVGkZwwxoYeddnwivFi9ZVTDK/5ElyY9VTx4maxfGs
	 6c8twxmqHe3FLXlLtmTbLp6G751vG/JBnCzQcAK5dXKl2BWYBB3kudDTs8mgWDzxUT
	 SBNsJ6+vtSate76IjRA2yCw7Ip4OjbqR9iNkbBaSnqbYP6/fb0E2LBJJAQdzI9vZsU
	 AEzDn5uflNILproFtD28idG/7QXGhNPGiaoSRtqlDODBTgdkg5At4Mdo0xzsuTAv01
	 ChLRS52nQRskpBnaiax1XA0RXG7/5L0Whpyf95mUK089m0bdC+QIkXuKbpc5CtUGUl
	 3AtUvHXLaqMxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0CC13926262;
	Mon, 17 Aug 2026 19:45:58 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] Bluetooth: btmtksdio: Fix SKB handling in the TX path
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178699595738.1691257.9499694982738760170.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 19:45:57 +0000
References: <20260817095332.182994-1-chris.lu@mediatek.com>
In-Reply-To: <20260817095332.182994-1-chris.lu@mediatek.com>
To: Chris Lu <chris.lu@mediatek.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 sean.wang@mediatek.com, will-cy.Lee@mediatek.com, ss.wu@mediatek.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 17 Aug 2026 17:53:30 +0800 you wrote:
> btmtksdio_tx_packet() rounds the SDIO transfer size up to the 256 byte
> block size, but never grows the SKB accordingly, so the host controller
> reads up to 255 bytes of uninitialised memory and sends it to the device,
> and can read past the end of the buffer as well.
> 
> Patch 2 fixes that by padding the SKB with zeros. The padding is written
> behind skb->tail, which is only safe once the driver owns the data
> buffer, so patch 1 replaces the open-coded headroom check with
> skb_cow_head() first. Patch 1 on its own changes no observable
> behaviour, but it is a hard prerequisite, so both patches carry the same
> Fixes: tag.
> 
> [...]

Here is the summary with links:
  - [1/2] Bluetooth: btmtksdio: Take exclusive ownership of the SKB before TX
    https://git.kernel.org/bluetooth/bluetooth-next/c/951d9f743029
  - [2/2] Bluetooth: btmtksdio: Fix out-of-bounds DMA read in the TX path
    https://git.kernel.org/bluetooth/bluetooth-next/c/262cb784c96c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


