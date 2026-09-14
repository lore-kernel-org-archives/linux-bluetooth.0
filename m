Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20221481FAA
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 14:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396278; cv=none; b=cVgVhqQZIonAZLzsa9eAAzRwPpURIB7TWg7xhDdf//mle82hHCsct8YlIYLGkpUbKR0aSMQBSJxplgCx4nhmcqEre4UkJykagl0nPcYKHI5+X+ZNxbKA2dsl/zKN7mMpy3gmQgzKAkiCqVnLFShg47dH4x2vW6QJ0qjfwHvZCOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396278; c=relaxed/simple;
	bh=IIsezy742XqTVKhz/kb8Cxy1iKLuxDWDSyOdjXKYolA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a08E+05CgZuIdyNv6fzQVpzKAQNd38sUBs4m8XW7wU4hhEW4N+ER4CQXGwkp3Iq27m19THTlTStL4w5H9A8rJ3wzUk+c/nh6mXp7yjrkVRzVKUfniTPtOltb+DFopJtDe2vasHEj62q7vnTa0YehUaGJMtWK6t+5mYzAPPckCro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IG+QMU2C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IG+QMU2C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4CEA1F000FF;
	Mon, 14 Sep 2026 14:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789396276;
	bh=yXX1LPF/g8Uz0tQf207BXCsPXB4z+TMib+l/wjCU0gw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IG+QMU2CliefseJu7aiiJMLnQCF4ggAnKAbI9T7P3F6zbmlYEQ9keUsxg180Ap/Ew
	 xs8Ay9yaLJ3fbIOARTTo/bnZtaA6auxBjd+U52AMgRm16bZjui/Thtpj4U1dtf0Xm5
	 1VuUWxGZt7QafBeN/1KDry/TCuC+d108i/QGo6+WHLZtbNOnwCLYg1/HJ9ec0FOo1g
	 QB8srct2kFDqnwe0XGsvWy3OBuPsueJ4egOrQC/JNBFZiHqEbwz7jOyAAyiU/n3HVm
	 k/kSaVQ4eioCPesfZ+nR2CGTxQuVf2ZL2gEfvIZ60eFb975cm+EvkOouPSgKIcneLZ
	 o5nQT1dQSvVbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569BA3924A67;
	Mon, 14 Sep 2026 14:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: fix off-by-one bounds check
 in RX
 submit
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178939621187.604238.18155595324453750865.git-patchwork-notify@kernel.org>
Date: Mon, 14 Sep 2026 14:30:11 +0000
References: <20260911115222.7651-1-aluvala.sai.teja@intel.com>
In-Reply-To: <20260911115222.7651-1-aluvala.sai.teja@intel.com>
To: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Cc: linux-bluetooth@vger.kernel.org, kiran.k@intel.com,
 chethan.tumkur.narayan@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 11 Sep 2026 17:22:22 +0530 you wrote:
> btintel_pcie_submit_rx() used frbd_index > rxq->count to guard the
> FRBD array access, allowing frbd_index == rxq->count to pass through
> and index one element past the end of the array. Change the check to
> >= rxq->count so every out-of-range index is rejected.
> 
> This issue was reported by Claude Mythos.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: btintel_pcie: fix off-by-one bounds check in RX submit
    https://git.kernel.org/bluetooth/bluetooth-next/c/dc9f6261721d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


