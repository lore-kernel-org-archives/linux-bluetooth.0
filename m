Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45AB53E31D
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790694651; cv=none; b=mKTRyQLo56TL2GTb4QA3UoDp8jvUBpRRALOX/jdSSghwASim9r/7yJ/j8J/7f6r2WbPBNvi0p0m3htvaCKgsZPIceidC02e/s15QZiKXbK4Rplwd+kXx7IufL5DuujiUmweXkf6r6TlihtJO5JWD0frltzXWIvDmf45dtPBd7Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790694651; c=relaxed/simple;
	bh=GQLqLFfYp702vdI10Fn6mEl6mSZprM3kgnDASw2K71E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l+xQmsbg5sTYvwkb6M96jiOjYCdJG408ppOTvXjtQ+QzyvkgbhhKulwEXm2ZiF7KEICZXe/q3++R0gI2DgdAdOpYIoMSaij5JwtzAKWpbSEFe7IaxPGXtSxRDDct9jg9nwcpMHnc8v7q0/0Whpo7j2CGLJ75BXQ2q99RYs98HdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPjF2ByO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPjF2ByO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184BB1F0089E;
	Tue, 29 Sep 2026 15:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790694622;
	bh=DHC2QEol0qB5tG7ZZszzkBemOGO5z0asjtKVetQ56Wk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OPjF2ByOvn0kmkAsaFQXL3oxUWElfQ1V6SXZbc0Eaq6GD8kKVmMEKo9mbBfz0S7Xc
	 qo91Hwdw3G1hxAgp/hcnL7be6ljyNOslEjMf/raGw9TcKpG+STqX0ltMXnGSXwf4f1
	 mHbtnytBJjpUumEheQGeXD5IJdzS/LEmXg0q+kkeR9ABu4728KLGDiqYgWpo5StWMo
	 u2yBJVMAehgzxRVhdgdyEBV2K+FoH5m5h90Uirwp6+ZO/w+4Ns8av7ylharqSVapMV
	 m7OmLqYcDnchf09m18fADm0QonUkpaY5xSC5cpwVxN3T7LJiiB6JRkH8c9KA9evoqJ
	 gTiKyTpKYpJSw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0E8773927049;
	Tue, 29 Sep 2026 15:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btintel_pcie: Add shared HW reset for clean
 start
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179069462092.983246.2089317518518826890.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 15:10:20 +0000
References: <20260929061233.204406-1-aluvala.sai.teja@intel.com>
In-Reply-To: <20260929061233.204406-1-aluvala.sai.teja@intel.com>
To: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Cc: linux-bluetooth@vger.kernel.org, kiran.k@intel.com,
 chethan.tumkur.narayan@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 29 Sep 2026 11:42:33 +0530 you wrote:
> Reset shared Bluetooth hardware after mapping the BAR and before setting
> up MSI-X interrupts, so stale device state is cleared before IRQ handlers
> and interrupt masks are configured.
> 
> Propagate reset errors so probe aborts rather than continuing when the
> reset fails.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btintel_pcie: Add shared HW reset for clean start
    https://git.kernel.org/bluetooth/bluetooth-next/c/1465494e8d07

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


