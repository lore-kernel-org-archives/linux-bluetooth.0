Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43B918C33E
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jul 2024 14:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721053843; cv=none; b=N+vzu9NApIY92FdXzshGeu4FAaSu+k9WLt+eiKwnhPW5e66xjOQdNUMZ3mWSlsq16fwkv8AV7xlq9oEcVXYbomOW+1KBnGskdFLtzL/5uRxebCgb8o0nr5aNhtvXQG1s2HjqgmWTzdAe/6hOGmRu/ZA4FaFpzy497jWIsNVAI20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721053843; c=relaxed/simple;
	bh=xGKXF0d36mYyZL9KA7AxYiss7RXh7cXDifc9BzjyPuI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GD+HGmXbL4WU4sJmr7J8tHkiVWdlOmg/HyyPAaolIRyddonLv/mHY9naaqa4PVLilYrTqBTq/m7l3ead0IhyZTCHQ3S+RzM3g0jAyFYju1/j/Iq7ltA/HrWyTuKQlgv8qncXB4jrCRm/btS/Mxc+b9GvGXk9IX08BlTcYq3/5CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UksfyyGn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UksfyyGn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86588C4AF0A;
	Mon, 15 Jul 2024 14:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721053843;
	bh=xGKXF0d36mYyZL9KA7AxYiss7RXh7cXDifc9BzjyPuI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UksfyyGnLUCS24+W6iGW05yN/6YeQe10dS3sZhd7x9HcPBeWZ66aNgpkXeCCrdgL3
	 8dwRrrZ/IIi0kxYEMaZxhQgrPDdenikfhj66aYVvNulhKsyyi1vOXEQx0MKMVdpfhD
	 KAJwv1tPpBQc6zQPLpv9lnPLz5flRwb1A5riDkzDpleRq1yXoxH7Fzhh72xV/bK+6A
	 uCfag2tqBRSzyYzixos9wCbdkcEh+RF5Vw8M65Hd3/0JqKFL+7Cwz+MX5xNbfdduEQ
	 u180zsShq1SriBi9VoyUDzkt8dJ25LYRjvH4J8MVvHVbe8xVs4ELKcFdG+zgKrB05p
	 IeLuKhatRkHVg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71356C4332C;
	Mon, 15 Jul 2024 14:30:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: hci_qca: Fix build error
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172105384345.11441.1051358335000057009.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jul 2024 14:30:43 +0000
References: <20240715015109.239742-2-luiz.dentz@gmail.com>
In-Reply-To: <20240715015109.239742-2-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 14 Jul 2024 21:51:04 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the following build error introduced by a887c8dede8e
> ("Bluetooth: hci_qca: schedule a devm action for disabling the clock"):
> 
> drivers/bluetooth/hci_qca.c: In function ‘qca_serdev_remove’:
> drivers/bluetooth/hci_qca.c:2501:2: error: label at end of compound statement
>  2501 |  default:
>       |  ^~~~~~~
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: hci_qca: Fix build error
    https://git.kernel.org/bluetooth/bluetooth-next/c/84f9288208df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


