Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CD4238C2A
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 20:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752526792; cv=none; b=BVe0GH4h9ge5hA5LT3un+zeSp1MVrF7gWhDtEuRf894Xoo5wfVHdFlfphCopitq6ATGiXG2n+HKojC3RMY/R6xpwWHEv8hgMuHRTk2FDMAP4DwwFnmVQET8gLFHekgyFoX+zsqyeUBaCkacHaVjH+QXwaf4Wr75L8D3cXUmU3uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752526792; c=relaxed/simple;
	bh=iJfP6EKVE425GE3hoiB/y3mCcXqguScYFutKQ/XUjOE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ENQ222b+mnXQuTKoZttJ1Zv3kze0xW1+ycLeX2lG2fdKmkYTOaNF+G85TWkS/BuaeUE2hRIo2952U3d7BKX9GbMTyLCqM9BWWBaqAvxwNlkICWB613RXt719PKs4MK6lv3BfJJxvFJ2LbGcc1YmqXdzeqp9LRa728956OGFbMOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mT5FDT7q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mT5FDT7q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C42C4CEED;
	Mon, 14 Jul 2025 20:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752526791;
	bh=iJfP6EKVE425GE3hoiB/y3mCcXqguScYFutKQ/XUjOE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mT5FDT7qkrlg5McAZWaer1MiM2YZOQ2uDbjUfY6CJEpdxkHjgQ4d6aeW+2PlsoNxQ
	 OlPxORNd9eUMaAlCuQOb2JYCvCWoNQwya1WnkZIr+AuLxeyRn6Lwnw3JYALw/An2UF
	 YYSkY3uTF+PtqaveoPSsDG5RSQWO2Smm9TLHOQxajfEjn9c1mT7vA3JDPy0FSOObN7
	 kvGLE5dwDDRgd2TR4meBNGN6pf8h9jwjdNeyQhTZVgcCTNGp7t5GTih04iF6kkL0CR
	 bFEOYf4irteCwJluwkjhosvhMfof3DrAVVO44ncuPlYO7ueY1aJ2lxky4dRtrdBpH0
	 lIFfPdo0cPgAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCC4383B276;
	Mon, 14 Jul 2025 21:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] monitor: Add sequence number and SDU length to
 ISO
 packets
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175252681224.3985397.5933559775939954251.git-patchwork-notify@kernel.org>
Date: Mon, 14 Jul 2025 21:00:12 +0000
References: <20250714153623.251489-1-luiz.dentz@gmail.com>
In-Reply-To: <20250714153623.251489-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 14 Jul 2025 11:36:23 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This prints sequence number and SDU length of ISO packets:
> 
> > ISO Data RX: Handle 2304 SN 48 flags 0x02 dlen 64 slen 60
> ---
>  lib/hci.h        |  5 +++++
>  monitor/packet.c | 51 ++++++++++++++++++++++++++++++++----------------
>  2 files changed, 39 insertions(+), 17 deletions(-)

Here is the summary with links:
  - [BlueZ,v1] monitor: Add sequence number and SDU length to ISO packets
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=468c5877c3ba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


