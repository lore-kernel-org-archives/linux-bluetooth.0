Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CC412E75
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Oct 2024 20:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729108825; cv=none; b=qkCH9DHVh6xYa5rBmBGSCaKTxr6/t4aimrTQL2OFon7QCqFuCjt3CDRmsaPD0M9NJp7A3/xhpzBfQi8dgSx/psrhGraJXXqjzkEBi5Ix2XbBTbyqx7f4MkST9EIAa7XekOmXku8O1Iuhd83TKVOv5NugSJKwpXuS8La9+weDHR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729108825; c=relaxed/simple;
	bh=jeBefwZPjgniayURn2erjLlZXmc9Udb7hr0/M7Hxd2Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z3TaVup9YmrsZAEaBbN+GcBcd+ycPvr7hkAawO0Fxtb1z4C9IzE2AFmm7A4UaydSp7YNHPcuUquLXlKJU0XchZn9QlkqrRfOH7xVczf05yhdQ7mz1ar05Pnl8tF6UC71mWF+MVulyOpNsXao5rgOTsrQPVycJ/JlDba9FaeIhEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0Ny+Sa3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0Ny+Sa3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E68AC4CEC5;
	Wed, 16 Oct 2024 20:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729108825;
	bh=jeBefwZPjgniayURn2erjLlZXmc9Udb7hr0/M7Hxd2Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h0Ny+Sa3OC+ks365PD/z8Os6NyerGJ5w3VTl1WgdRGXWSndWzHAC1DKikeE9r/koo
	 8TTLzzENfFFf7Rhp6YzioQGj9cT6XWPJyH/5+tLOchsjpLsaphGfvTPLkPpAYEQMUo
	 C+VE+Auu45/vLUV0gYh/qYHmtreKv1VwK0MbEb/bK9nZ/dVo7BsS/rYilT/4sb4kD4
	 tPcgILqngGrTrA6sOft5cvSHQpS7dmN7S6/PKhyot38ETTxzhRv9Zxh/HiSnkiceQt
	 6WJavQAIm2Gf3lFh7gLAUY702f6TNdjQw1ooo0EmAL02SrfmEQ7mnovoNv5Vp7R7S1
	 ECYpxAdGvLkhg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE9C63822D30;
	Wed, 16 Oct 2024 20:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btusb: Fix regression with CSR controllers
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172910883050.1941839.3978569234934402563.git-patchwork-notify@kernel.org>
Date: Wed, 16 Oct 2024 20:00:30 +0000
References: <20241015153719.497388-1-luiz.dentz@gmail.com>
In-Reply-To: <20241015153719.497388-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 15 Oct 2024 11:37:19 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> CSR controllers don't seem to handle short-transfer properly which cause
> command to timeout.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219365
> Fixes: 7b05933340f4 ("Bluetooth: btusb: Fix not handling ZPL/short-transfer")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btusb: Fix regression with CSR controllers
    https://git.kernel.org/bluetooth/bluetooth-next/c/b29d4ac72975

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


