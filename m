Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFCC28504B;
	Thu,  2 Oct 2025 21:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759439416; cv=none; b=C6WbGWYLWF+KFYPTkairNP3MY2oiX5hW7wF0IkeZymbTPbkGfKDzsUa5PvMW5KZA419bYkB9oTIhYm9MRcBtMg/EETgQ6aBk19/z4nXIWjuzuTY/6WLZwU5kCvy+gdcvpiTUx+800g6+fFE/IJsXO3GEMkxAR8cQ4PKMfBVxIKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759439416; c=relaxed/simple;
	bh=XBTBW5MbShLeNjyaGGxGiTwkBDscL9c+6tNM1Fn8R5s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=njwSbjwiQwlpmWSL890PnPWm8ae7DbVYVgNqsueNS91A/ikCWzxbINEvRAMKsa5fK/wYQLSMBz2zCzNGxFFW1e0q5ZVIyBgg61ujGSTqrlC3VXMFCLWPjqmHv9ncjSV4fTrVvLLaVw6OryQR8mc6pJ4mNwQsEO/uFvgRmXofA4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AizsWIlr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AizsWIlr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD90C4CEF9;
	Thu,  2 Oct 2025 21:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759439416;
	bh=XBTBW5MbShLeNjyaGGxGiTwkBDscL9c+6tNM1Fn8R5s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AizsWIlrydvVxmamxrw4Pt8EBxsjt6mpndovqRAb7jQJE+1vu8hJKtvXP0rJGKHDl
	 NDyepjxOIZfDrRDwX6hKdgs6l3+4Ztnx91+BvvpjqW8alGC6qt6qI748KW1kIJRVGE
	 L22rNWZBcRLwr2cxovd8LQg/enSmsAXYzDeB16at2iyjLQJvMDB7UtES77fVrE5+7y
	 ddxc6cBb4GfZiWfjFmgcw/caHuxlfuqZOJ0wr8hgFpb5Gv+ELMmWGUEu7Hn7Fua9wn
	 bUok2OcfGh9IYZMLqskvd1r16vFR6zd0lN6EO9wqxyax4wQUAwtqlFqnLL1/5Fk04s
	 74yqi/D3KdXaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C2539D0C1A;
	Thu,  2 Oct 2025 21:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: btmtksdio: Add pmctrl handling for BT
 closed
 state during reset
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175943940824.3462061.7052492300555223526.git-patchwork-notify@kernel.org>
Date: Thu, 02 Oct 2025 21:10:08 +0000
References: <20250930053933.1685847-1-chris.lu@mediatek.com>
In-Reply-To: <20250930053933.1685847-1-chris.lu@mediatek.com>
To: Chris Lu <chris.lu@mediatek.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 sean.wang@mediatek.com, will-cy.Lee@mediatek.com, ss.wu@mediatek.com,
 steve.lee@mediatek.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 30 Sep 2025 13:39:33 +0800 you wrote:
> This patch adds logic to handle power management control when the
> Bluetooth function is closed during the SDIO reset sequence.
> 
> Specifically, if BT is closed before reset, the driver enables the
> SDIO function and sets driver pmctrl. After reset, if BT remains
> closed, the driver sets firmware pmctrl and disables the SDIO function.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: btmtksdio: Add pmctrl handling for BT closed state during reset
    https://git.kernel.org/bluetooth/bluetooth-next/c/739892687cf5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


