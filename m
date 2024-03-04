Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A654CDFB
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Mar 2024 16:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709569829; cv=none; b=pNUYuFPqM1Aln3xNztnd7uEGnIL4HKnobakwVVajJ8aZv/FFtSBL5Ns9czy4DBNst6JfEO8u+g2WEdI/mqml6FGVlHbkbIIcO0kZK5FNYsk1oGKOlPcEo6W6XSsTOXvxvYUQG756+gWJbYVFAcPrTRzzieYQkzvP/q0+DFb7rmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709569829; c=relaxed/simple;
	bh=gkMP0jzMzUpEN/GCnCPlRf7DeQTAqCM4PggLaze3sck=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CNSoQvQTmDuCihsZrXwUvLA9HNK7BsWUAE5xmtspP6cyOI3nLTCAB7IFkJdfbxEILQMRa6OItCgQzhzi4RwOXVA8f0XBkCmGpqSaVrdvRN+Zd2zSm5hDBp6xx57/4k23aeAtk90J/rEB0BMjHPfTzf8+1pwGLIT5nvfyXlGtoxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmxwV4Af; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmxwV4Af"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08090C43609;
	Mon,  4 Mar 2024 16:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709569829;
	bh=gkMP0jzMzUpEN/GCnCPlRf7DeQTAqCM4PggLaze3sck=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KmxwV4AfuiicBbAvFT83638dYH22lqXLyWae4itb0C9B6PN8/HqWnCrZ5Rn3BI8Vx
	 AHI1r+m8bREpAWcfHRnhuuBOBuDgoItu22lC07JE5HkBKA0cB1wLjYdBHfVH7pDYVP
	 9lSDm7cvxbXDXyuNumlGXO0+ySU5meFPnOCmbtW6QnVynpOzJH/ZitKuUP+7AHFUpo
	 j6esPl8b9cOcpQGHuciVFuqBdX5WI2AMrXFoJRZtQgduS//NSyvy3LxCArXmOtWKTq
	 VhzYFPpJ85f/Iw86zhWDxJaFnAyjeP12Oxi2zlqYaBQBZ+5dGV/hpzwhtgvjeBotUg
	 rUpifUjidpZTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0DC0D88F8A;
	Mon,  4 Mar 2024 16:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: fix use-after-free in accessing skb after sending
 it
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170956982891.9053.14301258419582340101.git-patchwork-notify@kernel.org>
Date: Mon, 04 Mar 2024 16:30:28 +0000
References: <90576ca2ad6b1c3e24c585c734cde44bbcb388bf.1709399114.git.pav@iki.fi>
In-Reply-To: <90576ca2ad6b1c3e24c585c734cde44bbcb388bf.1709399114.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat,  2 Mar 2024 19:06:23 +0200 you wrote:
> hci_send_cmd_sync first sends skb and then tries to clone it.  However,
> the driver may have already freed the skb at that point.
> 
> Fix by cloning the sent_cmd cloned just above, instead of the original.
> 
> Log:
> ================================================================
> BUG: KASAN: slab-use-after-free in __copy_skb_header+0x1a/0x240
> ...
> Call Trace: ..
>  __skb_clone+0x59/0x2c0
>  hci_cmd_work+0x3b3/0x3d0 [bluetooth]
>  process_one_work+0x459/0x900
> ...
> Allocated by task 129: ...
>  __alloc_skb+0x1ae/0x220
>  __hci_cmd_sync_sk+0x44c/0x7a0 [bluetooth]
>  __hci_cmd_sync_status+0x24/0xb0 [bluetooth]
>  set_cig_params_sync+0x778/0x7d0 [bluetooth]
> ...
> Freed by task 0: ...
>  kmem_cache_free+0x157/0x3c0
>  __usb_hcd_giveback_urb+0x11e/0x1e0
>  usb_giveback_urb_bh+0x1ad/0x2a0
>  tasklet_action_common.isra.0+0x259/0x4a0
>  __do_softirq+0x15b/0x5a7
> ================================================================
> 
> [...]

Here is the summary with links:
  - Bluetooth: fix use-after-free in accessing skb after sending it
    https://git.kernel.org/bluetooth/bluetooth-next/c/d147be932692

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


