Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25AF3FE374
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 14:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778509857; cv=none; b=LvhoXekAcfcuD4k1HvLfvxebwmapc5cPJXmbtS5IV2e11DoYcwhZOvV52iqN/CFQ6mep52QqYCx9nFW0GswC8KoaABRZakG4r7STX7Me7SH6gkXyGwgcH8x36jJ8SnWxuQnXkbVOoKWJbL1NlF1Oh8Xi11SwTAZ9v5DeKXyF7i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778509857; c=relaxed/simple;
	bh=/0/OKEmHChVqa5OQdaSIlxd1uMo/9Enr7N6RJ9MUYBk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=URvX5cJEu9Io02UI4ucfELIZSHXwr4g/XLmEHiNOW2gNXpZWWZ95vHLd38wIFfueCe87Ahb0/Y3XoSRFq+3Y4LUjOjth+NkbFJZ6s6tDMwteCsWc8xP3MJgVTjKNH2k+ouS3sgGBsf8ui7N7gB6vCsoA3zMr0+g3eo8G9C/YUg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxbnpBUy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxbnpBUy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F6BC2BCB0;
	Mon, 11 May 2026 14:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778509857;
	bh=/0/OKEmHChVqa5OQdaSIlxd1uMo/9Enr7N6RJ9MUYBk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AxbnpBUyXS5O6vr7XQrrJo39g5OqcckKvWNC9r48hJTrEKtz9PPEXtD5PRHA43Tqs
	 F8bV61GNCLzP0jlV2MnE8+NFvHekxi8YxM125OAJrQAhm8Co0gVJvPPxL++ogk18cV
	 NKO5ucZEhMbtosP56RSFzmKfB1D3fU8AreoZmaOfxkqLgS/WarrIbMdVS2vV1olnTt
	 knxGwGyFeZ/Xlo5CX4dwulKSyUFosLTW5kMfwX59JUmJpfOkNEWkZJvC7ZCWFuDQN+
	 ZHyRtb4yoE+doQXRjXStHMhs/AuKfAOi6k4C6TfViuh0HwZ2dvJmRbI3EvGWKUttiY
	 PNk6u5a+YG5Iw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE163930002;
	Mon, 11 May 2026 14:30:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btmtk: accept too short WMT FUNC_CTRL events
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177850980405.2266296.3114753928820395948.git-patchwork-notify@kernel.org>
Date: Mon, 11 May 2026 14:30:04 +0000
References: 
 <770d36b07311bf88210c187923f243fb9f126f04.1777058551.git.pav@iki.fi>
In-Reply-To: 
 <770d36b07311bf88210c187923f243fb9f126f04.1777058551.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, tristan@talencesecurity.com,
 linux-mediatek@lists.infradead.org, sean.wang@mediatek.com,
 mark-yw.chen@mediatek.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 24 Apr 2026 22:24:29 +0300 you wrote:
> MT7925 (USB ID 0e8d:e025) on fw version 20260106153314 sends WMT
> FUNC_CTRL events that are missing the status field.
> 
> Prior to commit 006b9943b982 ("Bluetooth: btmtk: validate WMT event SKB
> length before struct access") the status was read from out-of-bounds of
> SKB data, which usually would result to success with
> BTMTK_WMT_ON_UNDONE, although I don't know the intent here.  The bounds
> check added in that commit returns with error instead, producing
> "Bluetooth: hci0: Failed to send wmt func ctrl (-22)" and makes the
> device unusable.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btmtk: accept too short WMT FUNC_CTRL events
    https://git.kernel.org/bluetooth/bluetooth-next/c/162b1adeb057

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


