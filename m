Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2670189F20;
	Thu, 23 Jan 2025 18:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737657013; cv=none; b=Bt6djACVJUN+7xvTbbRWu7L2lemP2jw+xHY59T1rPsACRgqQSONdA8yVSso2Wp6zOL3mR/BFoZUyBtrnpV2Vqpi1GbrZJ4FkjivtxQQENXReHAIAUSs42J7fDcnn4BPZSO6zGBrQSOpC8FZZWkArSs3KQdBR9G9DWoVuFoy+hKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737657013; c=relaxed/simple;
	bh=CriC0qTbsDtzs2huAXq8hRIP0SwDqsA9wMGCLm8UcGE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i/Fz828os/sFGfCxtrv7jR7x1lkmgRLfD6hdzhVBXJLTrr+0vZDwGAQfmsRlFIbNUCX5MuWuFQbtTG+T6Lnm0kz79rq1DWX6JwQKGLrGOlsgMnI1bWYhsuE/0WIdqDSKBSiQkwJPDahyA8DYW2b7RCoBbBdH4+ipzSj7s1At3go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcUTraur; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcUTraur"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A610C4CED3;
	Thu, 23 Jan 2025 18:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737657012;
	bh=CriC0qTbsDtzs2huAXq8hRIP0SwDqsA9wMGCLm8UcGE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TcUTraurazKxNwW4OV6B/ThbegWBzpBn+G8HrsltUsvB7jM0c0G2XsrQnT8QPDuEF
	 wqidgsUbvjPur6RdYUPShkJ6Xyt9+nDjDyrESVERMK+ENHu8IMcRGjAN/joB7y3rnB
	 24vDGvMXQl/gt06YV8wnpyfIw2TlB7v4g/HxrLQADr/MowS7xAS+nu0rXNbO08CYnz
	 B1kJVirwZwxbNy7gY0Wh0tewgk6T8aCZ7kTIarmOFwO+1idvuHzYnHz5JqZi/MALB6
	 RC+7JktRNWFTbNyMWOs5M564mqKmxnEKvZ4TYWpCjH5Nhmzs+55PT0yOtKGgkN3xec
	 fS0WuFfr3anKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F99380AA79;
	Thu, 23 Jan 2025 18:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btusb: Add 13 USB device IDs for Qualcomm
 WCN785x
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173765703698.1459736.9781012721915742240.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jan 2025 18:30:36 +0000
References: <20250121-qc_wos_btusb-v2-1-377b3dc2a706@quicinc.com>
In-Reply-To: <20250121-qc_wos_btusb-v2-1-377b3dc2a706@quicinc.com>
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, zijun_hu@icloud.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 gregoire.s93@live.fr

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 21 Jan 2025 19:46:42 -0800 you wrote:
> Add 13 USB device IDs for Qualcomm WCN785x, and these IDs are
> extracted from Windows driver inf file for various types of
> WoS (Windows on Snapdragon) laptop.
> 
> Cc: gs <gregoire.s93@live.fr>
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btusb: Add 13 USB device IDs for Qualcomm WCN785x
    https://git.kernel.org/bluetooth/bluetooth-next/c/02a3ad5b3506

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


