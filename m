Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8123126DA
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Aug 2025 14:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755873600; cv=none; b=IPvKq066RlPX9K9mJC0GR3ZcL9tnxB0M8DkSwZvea68GiCFAbR1gBIEm39Banlcep0c+Yj8O2MP4mYwESjaYHW+6p9YD6PSYimgP/VzqlPFF47gS2uZM6/nG11dYX36I/nulkWGNUi0lkl7oe8WXItTX4FRTha2lXVoJ2p67LGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755873600; c=relaxed/simple;
	bh=wglY2hI4m2AGAv159eyvH3s4eHQVGJwA5JxY2BbZwOU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t71HYtA8+gQ1neHGdmdhkCVKdKKVJhlzo2SC81BLglWzDwOT4obeQPs82kdIAbFvAF1qiAkL3AgKfQe2y/tCVatU2hFbCRX/DLIakWkDoYXjXGqwmhNJvq3nSeZf/ncYCbWksyV66sPUhOaRmVMto+h94iUQHlRO9bI2UONu5C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gl46mnI8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gl46mnI8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D65C19421;
	Fri, 22 Aug 2025 14:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755873600;
	bh=wglY2hI4m2AGAv159eyvH3s4eHQVGJwA5JxY2BbZwOU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gl46mnI8v0qb2SvQRaaUHd6Z7mxiftLErlVwRXUjZPHR7zaT1Ko98qx62UfGDAh2J
	 1svSJeZpoI3F99iCO+Ex6O5Fn70e+prfdhNvQgWeneBkuoKW/udV0u1Eeap4dL7fuo
	 BjjBpIw3my4GZEo96IkqtJnzTtEZyyYBvfSu4gtjEUP1V38mToYQkKi5sL9fCdK14b
	 lcC1uq3Q4DXpO8wCZ3YAtnAWH9FqGGD/thE/CRQ4agnDj47ILlgW0XbX/nNl1MyP7P
	 1cKg34/nBNDNf1/eEsdpu2pvd+ud97R/PlO7nnDz5Ju0x7md62N4Qq5cRftF2vJujc
	 pUjt1eG2jBF6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E70383BF6A;
	Fri, 22 Aug 2025 14:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: hci_event: Detect if HCI_EV_NUM_COMP_PKTS
 is
 unbalanced
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175587360922.1857936.6282108383563655616.git-patchwork-notify@kernel.org>
Date: Fri, 22 Aug 2025 14:40:09 +0000
References: <20250821134714.2032684-1-luiz.dentz@gmail.com>
In-Reply-To: <20250821134714.2032684-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 21 Aug 2025 09:47:14 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This attempts to detect if HCI_EV_NUM_COMP_PKTS contain an unbalanced
> (more than currently considered outstanding) number of packets otherwise
> it could cause the hcon->sent to underflow and loop around breaking the
> tracking of the outstanding packets pending acknowledgment.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: hci_event: Detect if HCI_EV_NUM_COMP_PKTS is unbalanced
    https://git.kernel.org/bluetooth/bluetooth-next/c/05be312ba55c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


