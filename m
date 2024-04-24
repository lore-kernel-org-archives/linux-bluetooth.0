Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8657515CD6E
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 14:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713968429; cv=none; b=FdDouW/83lMK2a1WtzvYu8/ZPsCG3XGO1wCKWs9tG17BoujG4cGDBzx3c6p7B65KWMVNqWqguqplnbudAtE83b3KNZpR2r0SsJbHsG3cWho1ep24LNjJo3XjoUgPNcDSOghkf74qGAIlZJFWR2Z7JmmMTM41J9GbXdqvQP8i4rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713968429; c=relaxed/simple;
	bh=1XTHE73kVJ5uRy8eHWe1dmq/nhWhqvcBUnU334Bkl8g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=roXdjUdmXkjh/GY/2NY10q1Xvhp7J/E++WgD2LRrBKIgihXCfwRQMuFEhGSH3lPzj8IfL5QVL1B6pNFqYCYv3jei5FNONDccWVJHH9q9wtTuWJpF0yIweUvGbYKWFWlkKwJSf+B7riXMHvPi0lamYq+qTJtXSIincbKB4Zi3gro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRMMyl05; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRMMyl05"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 417FBC113CE;
	Wed, 24 Apr 2024 14:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713968429;
	bh=1XTHE73kVJ5uRy8eHWe1dmq/nhWhqvcBUnU334Bkl8g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KRMMyl05x/Vjpk99M7n+Qy4uKwkd+Qhps1rf/PkqXJ5XSQ4lbDaXp0dQfNmiAZ+Ca
	 VyYK+SBOyPI9lEjfDbkKGjipcS2aCJAUPjsWeXCOjKcgVaCYg8g70a9OMLTwFLAzR8
	 qYoKhm6e3nbvvsHeTpbBw7uc+UfVZIFkAjsQJpztHU3I1YKry+Pco3QEk4PmKVOKZV
	 LkxXpiEUdTOv57Hba5lcgLwgxQHGCogCXhDamgyeYDj94cd3kqvPvDtqhRSAR+0hXi
	 92P98NLmpZ1vnB9kgzPPYAdH5Ui91jNStat6yBxJf9j9irzoFpfTyYBRw98jHlgw13
	 bRv4/PUhIxYMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3072EC595D2;
	Wed, 24 Apr 2024 14:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: qca: Support downloading board id specific NVM for
 WCN7850
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171396842919.29186.18002017736788488212.git-patchwork-notify@kernel.org>
Date: Wed, 24 Apr 2024 14:20:29 +0000
References: <1713340174-1304-1-git-send-email-quic_zijuhu@quicinc.com>
In-Reply-To: <1713340174-1304-1-git-send-email-quic_zijuhu@quicinc.com>
To: quic_zijuhu <quic_zijuhu@quicinc.com>
Cc: luiz.dentz@gmail.com, luiz.von.dentz@intel.com, marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 17 Apr 2024 15:49:34 +0800 you wrote:
> Download board id specific NVM instead of default for WCN7850 if board id
> is available.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/bluetooth/btqca.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)

Here is the summary with links:
  - Bluetooth: qca: Support downloading board id specific NVM for WCN7850
    https://git.kernel.org/bluetooth/bluetooth-next/c/39844750bddf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


