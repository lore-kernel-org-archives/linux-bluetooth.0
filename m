Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8449119992D
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Jun 2025 15:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749483584; cv=none; b=e/ptlOALiILuZR8sUzUrU9X9altuayqMny43ultJTnKFVGMbZ3A4Kb5wxk53R/ldKZ4C/qVDWzVPGrdwf53lislAIaBIMflwUfJtsP0v5DJYj4gS0XP03DKY5tUeoznrnEu6HX8zwN7l9SMXofyKhgnkbqjnoOZU9xxS4wFjVeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749483584; c=relaxed/simple;
	bh=tY51ZhEegJT5E3pbIbZOpiBTblQ4aCuba7TqslrEmkk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=alihZULx6sjXTMiQZor5SH3g8U7slhHQWqd/eZ6YK2YPvwTkRiU9kZ7i8iQmL0Znzgn/NQo/ALLpvWEnB8iOzEVzxKrBPEm/Mx6GwY4rT2xQpwpjOyTxnvCSu3kyPNVYNe+kUzdMmTi1SZR0hcWdmH6JVYvS4sYLA6pF5atHHlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=toCsy4Hq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="toCsy4Hq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6E6C4CEEB;
	Mon,  9 Jun 2025 15:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749483583;
	bh=tY51ZhEegJT5E3pbIbZOpiBTblQ4aCuba7TqslrEmkk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=toCsy4Hqzvgxoh4vEDhREP/f0dF/c4diBam6eaCQjEjrOvKBgF9Tn4Y3EEVY+N63c
	 0GKhcZi+sPVLJTM5Mqhmc2xw+dxa/3J6Oav/bDLUa35Fck3oLN22tlnR9tkJW1k1nh
	 lSEF/lgqtUt70B0qmdV1YnEJXv25ncEhLF2Lwv4kmtrGtMElf1Yb23bq6Zqttw+DBS
	 X7tbhtuPRzdPy8rRl+hYTW/9AjmiufXeAWHC8EE0TC/cJzfE7R/ROln7wzsXAbAkzQ
	 a1Zbr0sUk9f87eEA15Izi4at8wYjRu5663xx9YXA7mziJPceQtinRd+RBG4MbdEwMa
	 WZ7fcgLUFHsqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE412380DBE9;
	Mon,  9 Jun 2025 15:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 0/1] monitor: Add support for decoding Channel
 Sounding
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174948361348.1126847.810400440128654403.git-patchwork-notify@kernel.org>
Date: Mon, 09 Jun 2025 15:40:13 +0000
References: <20250609104716.1814089-1-magdalena.kasenberg@codecoup.pl>
In-Reply-To: <20250609104716.1814089-1-magdalena.kasenberg@codecoup.pl>
To: Magdalena Kasenberg <magdalena.kasenberg@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  9 Jun 2025 12:47:15 +0200 you wrote:
> Hello,
> 
> This patch adds initial support for decoding commands and events of
> Channel Sounding, a new feature introduced in Bluetooth Core
> Specification Version 6.0 | Vol 1, Part A, Section 9 "Channel
> Sounding Using Bluetooth Low Energy".
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,1/1] monitor: Add support for decoding Channel Sounding
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b39c37d2179f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


