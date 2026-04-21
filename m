Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43654C6C;
	Tue, 21 Apr 2026 17:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776793246; cv=none; b=Fj+/znjxTP8+7xZ/EIZ4H6jQfySu07ozn/4N1RxRJGvN+SlTSpzqJgokRDz3jxMVQbb7qByIz3E6ulLrpjIaL/6hQSOtrOwAZYFwRzRVAT5Jb4uzWqpA9bbBkb6p6eabGijSIEf1o2vlqlP78sEuNOBpfyssTZYgjcKynt6fQGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776793246; c=relaxed/simple;
	bh=3qtqG7J9kMvND6hT2tLevpqBaufSPreCC7vVtd7TGlg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SC7FIGsmAodgIvp6svBgW6DR1LmcZMWtYCi3dM9EkuZJU179GbnTP+2Ecbi35uPZ/ry+i+9o+4bPNS5tj2ZObZbRDLQujqHluIDu+dOJuklHpBaAA2guJRmJ11dlLVofs6R+nVvFh4iWGF2ZJNczAzpC3IlHKKvZDXg/vy1juTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VhxL1IYC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VhxL1IYC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9297AC2BCB0;
	Tue, 21 Apr 2026 17:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776793245;
	bh=3qtqG7J9kMvND6hT2tLevpqBaufSPreCC7vVtd7TGlg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VhxL1IYCmIWcVAQYGFy/JF+bOeqpZnwlE+fbfom/nseQPina6LMxFfSk45gl2usNV
	 M0CKWtojfOB8zBHNz3A9nqFR1mFULxJ4QXclEQiYCUZCAWKNo//6dK0oZqzbxmztzb
	 DQ5lx6tALgayrbDkJD2fbV2jaf3XDGMfjRed9nXNJYdkKmaM6dqoMa9lsPBPuKpzjK
	 nLfmeZFWhrLp18PK9sHICvz+eDZVmNHo/noFUNtl/js/4BjQTcismPv+HcD99BBchk
	 SUTpsNnm+sK4/vIushafbKdNtwgImXuq3A/oS1b7MUlDjzS+WnF/W1+SQh2rPN0Kvm
	 EbGgko5dJLrog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC0B39301B9;
	Tue, 21 Apr 2026 17:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_uart: Fix NULL deref in recv callbacks
 when
 priv is uninitialized
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177679320879.2928707.16610281359734342622.git-patchwork-notify@kernel.org>
Date: Tue, 21 Apr 2026 17:40:08 +0000
References: <20260421135331.15425-1-aurelien@hackers.camp>
In-Reply-To: <20260421135331.15425-1-aurelien@hackers.camp>
To: Aurelien DESBRIERES <aurelien@hackers.camp>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 johan.hedberg@gmail.com, luiz.dentz@gmail.com, linux-kernel@vger.kernel.org,
 syzbot+ff30eeab8e07b37d524e@syzkaller.appspotmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 21 Apr 2026 15:53:31 +0200 you wrote:
> When a fault is injected during hci_uart line discipline setup, the
> proto open() callback may fail leaving hu->priv as NULL. A subsequent
> TIOCSTI ioctl can trigger the recv() callback before priv is
> initialized, causing a NULL pointer dereference.
> 
> Fix all four affected HCI UART protocol drivers by adding a NULL check
> on hu->priv at the start of their recv() callbacks: h4, h5, ath and
> bcsp.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_uart: Fix NULL deref in recv callbacks when priv is uninitialized
    https://git.kernel.org/bluetooth/bluetooth-next/c/259c0a6e10fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


