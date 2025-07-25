Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66518635D
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Jul 2025 13:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753450788; cv=none; b=e8DJ1n3gQWK5sLzv7Be/Loa17oUOvo7NQPwp/0WARHgl6l3XENnLQQ+H8mK5W0zWkMK3o0rbFdkGBnHaq7UPZPyFsFBNe5pNvQ+5sYK21F5iZuCPiXozdUxlTWVcb6LgKg9lSJut83GJYzIFZW4Dd48Utbgt5o+mg/dJOPxbJNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753450788; c=relaxed/simple;
	bh=l+/JqTbcZAoKv7TZk0gNhVi9/yLJ2VD5D45AjsFKiD8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b9tFHxBAtKRoAp5QorOzVSglrZdn3EOAJz1UsiD3BLKSS3O0yKuJF32gx04aBMtGsEdg6IHyWr8W1gdKC/vnMNG+5QDW2y2XpB596eYLg8Rh56FHmLIB8kspHGmfSkPWBOnDn70GPCI+RDbO19CdnrB5Y6t6gmcfQo0JipKlzAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPUNM23a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPUNM23a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667EFC4CEE7;
	Fri, 25 Jul 2025 13:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753450788;
	bh=l+/JqTbcZAoKv7TZk0gNhVi9/yLJ2VD5D45AjsFKiD8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MPUNM23ac9IlT/2qCzXEpMn8/i2qOk9EtRiZySvBYlsYJqrXu4DtRS0Rr3t+uzicE
	 73OHB64jgmpgqlqmyxGTtmHpSy5V4a0ehGJrMIKaQgT6BZenQiofo82C0ljmZAq0Kx
	 CU36QJdQsgyJPH5ZS0s1tnJd+5IHctcsn6Clgh+rvE66bijMvA6fmT3gYeSjqFkRiE
	 nkBMY8H8toKc4b6E1hnxBzfpl3xR2SZlKHl1qSMnqSJOG3YDU10usVkIfl6UVcuG7n
	 ajsgwRyrlTT4uHULXVVQTIVvsEFTgFUUGkufFLoptqLnFQWo9pH5O3YDCiFBdJejID
	 cBXE8jtnL+Ulw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C9D383BF5B;
	Fri, 25 Jul 2025 13:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/3] btdev: Add le_big on
 BT_HCI_CMD_LE_CREATE_BIG
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175345080600.3139929.2651319712881669324.git-patchwork-notify@kernel.org>
Date: Fri, 25 Jul 2025 13:40:06 +0000
References: <20250724202424.6978-1-luiz.dentz@gmail.com>
In-Reply-To: <20250724202424.6978-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 24 Jul 2025 16:24:22 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> When handling BT_HCI_CMD_LE_CREATE_BIG create a struct le_big to
> represent it otherwise the likes of BT_HCI_CMD_LE_TERM_BIG will not be
> able to detect a BIG was created.
> ---
>  emulator/btdev.c | 77 +++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 57 insertions(+), 20 deletions(-)

Here is the summary with links:
  - [BlueZ,v1,1/3] btdev: Add le_big on BT_HCI_CMD_LE_CREATE_BIG
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6939c4706c90
  - [BlueZ,v1,2/3] btdev: Fix handling of BT_HCI_CMD_LE_TERM_BIG
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d427a2a5f197
  - [BlueZ,v1,3/3] btio: Fix handling of getpeername
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=00ffc553a194

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


