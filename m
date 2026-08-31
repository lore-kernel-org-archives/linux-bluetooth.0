Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CD84A8FC2;
	Mon, 31 Aug 2026 17:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788196873; cv=none; b=fzhi8fqvMX3grdUPq8uR0kKz2e5pJmMsTFgDvUfG+ycK9sjpjJZWDc4NdUOkdn3sYUyQ10svvx5PGICQW0z/XgU1Y/MNdnqqIkQ5crAtgrloI4ZMtmE4rDF40d53EgtVt46LL7woPdW89XYMuPndGkHVe6HxDY3jVzfVmIvkXnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788196873; c=relaxed/simple;
	bh=ZznoMgw5FzaBigfEh7mPQF3MLzvGrFnBSyTkA4zdttw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZErEq4L1rvke2ZG7p7CQgOFNnA0yP4DzoYHS8KnoUAZ6eloP0T2aY+GXgHMZL36AffxcCy22o2jCG7XmAH16TP6KyFRNrYS5ozUrqxiJ9gj1F5sopYlIXRxCmJRi2R7IMlWnnxw+upZhP3tE4IuP73caOeW95UYuFcahxAYe6Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h67fx0R3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h67fx0R3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3851F000E9;
	Mon, 31 Aug 2026 17:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788196872;
	bh=RPhtSXEccKcvJfqTXmznjSx8Sg6iQuyhmNkfEzW1Uyo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=h67fx0R31v63H6uFQan6+M+oSVzT+3pKEO81oWeU57mNae34BnyX3moKIX2ipgPJo
	 3GuQhrEnrzTdPb7NLLZ0R1VQwY77BVbPhH5QbKtJvq+ncHGD8fN8Gknune6UFhPESM
	 nGlENHNVZLsDzYTGB2g4k3Yolaehsh7ej3oqsCwbc5wRBz2bxJyH+Xi88qm2fgJOEX
	 HV+KHxlNC4jAvHZr4ynNPCOSmx7+jiC8/U/Fxt7qKwQv/4P9S5x71z9BeB3dwbI3Sy
	 kscp1ZdEU/NKLRfXGjdOpKq4Cmuc9g96tWZjk0GAct9PsaCz6Wd/XYEGL0ZUsansUj
	 yRoHjhzxiemWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939183924458;
	Mon, 31 Aug 2026 17:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] Bluetooth: L2CAP: fix out-of-bounds write in
 l2cap_ecred_connect
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178819681514.671757.16912316502936298927.git-patchwork-notify@kernel.org>
Date: Mon, 31 Aug 2026 17:20:15 +0000
References: 
 <2b863abeea0ada6e990b07a7f3182e261ecd8e09.1788091154.git.pav@iki.fi>
In-Reply-To: 
 <2b863abeea0ada6e990b07a7f3182e261ecd8e09.1788091154.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 30 Aug 2026 15:04:01 +0300 you wrote:
> l2cap_chan_connect() tries to ensure there are no more than
> L2CAP_ECRED_CONN_SCID_MAX pending ECRED channels, so they fit in the
> same L2CAP_ECRED_CONN_REQ that l2cap_ecred_connect() constructs.
> 
> However, the check only counts deferred channels.  If 6 L2CAP sockets
> are connected at the same time in order DDDDND (D=deferred,
> N=non-deferred), the last can bump the total to max+1.  It results to
> one __le16 written out of bounds of the scid array, and an invalid
> ECRED_CONN_REQ being sent.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] Bluetooth: L2CAP: fix out-of-bounds write in l2cap_ecred_connect
    https://git.kernel.org/bluetooth/bluetooth-next/c/ddaccd985bb0
  - [v2,2/2] Bluetooth: L2CAP: clear FLAG_DEFER_SETUP only for same PID/PSM
    https://git.kernel.org/bluetooth/bluetooth-next/c/af04b0e3176e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


