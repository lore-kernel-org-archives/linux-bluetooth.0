Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040411AF0D6
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Feb 2025 21:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738962611; cv=none; b=nBCN3O5fPIG5HopQrCHmJdQ/eX9pUApORfV7Rv/M903Jst6+5I2LNx1wDD7MUA1OWrlb/xIMzp8cA/A3QRWuvqYQOsFCIlyN6Yxu3A0f9mpYN3zkCwL5S/f7BQcD6K3SJZ15mMRzIUbOV5AG6/taKWODUn91gZkgjeJrMmR3Wac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738962611; c=relaxed/simple;
	bh=qL91uq84yKctyN8bwY6Sft+4T2I5lG0hj1KVC7FQmHA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iYQTP9J8iEQFPG9Mvy0NTrBsrkSAYoSNikOAjADmO4r/RLO3uTCDdi5x12fncy7yFbyZi8H81d70jWsk1dBFqHHrd17OKXayB8eXxUrlCl1W/TH0geFbDSiSzETSQH+gls5Yv+eoLHne3wyUBeZOSRy1w8/UJoAHDvh8X5geBDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDpTnyR3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDpTnyR3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BAF9C4CED1;
	Fri,  7 Feb 2025 21:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738962610;
	bh=qL91uq84yKctyN8bwY6Sft+4T2I5lG0hj1KVC7FQmHA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PDpTnyR3JxZBfVdmzHNp3i3oIl5aJh9pmpN966J0lf7ZzljRFyOnaOhvv15EllXJm
	 Snnqt3YLo5ccbY24+agRbRWnKzjfzYcor9r5Yp4JT3PoY+NjQkJV7pkhDje8X4olwh
	 XgdnkfmDpP+oCo8uplS7ZjTDm7YXOylY1+t8qABpE023h66YETn2rm3F0fZMC8M6lT
	 loKTNeyI/G7oM716xUhjI+dCA+Z/7rfuWceGLmuH3/xtHzKXXO3gFMBOsq5elhzgap
	 SUgaJkOJEFzEEVFGJZx9bgCSOui1otOoXIhfKuAhVD6fKBw/ZnXb28bc4dKcL/jUun
	 l5Zi0pdRHn8VA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE080380AAF5;
	Fri,  7 Feb 2025 21:10:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: L2CAP: Fix corrupted list in hci_chan_del
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173896263850.2382953.5014769464223738334.git-patchwork-notify@kernel.org>
Date: Fri, 07 Feb 2025 21:10:38 +0000
References: <20250207201727.3449504-1-luiz.dentz@gmail.com>
In-Reply-To: <20250207201727.3449504-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  7 Feb 2025 15:17:27 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the following trace by reworking the locking of l2cap_conn
> so instead of only locking when changing the chan_l list this promotes
> chan_lock to a general lock of l2cap_conn so whenever it is being held
> it would prevents the likes of l2cap_conn_del to run:
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: L2CAP: Fix corrupted list in hci_chan_del
    https://git.kernel.org/bluetooth/bluetooth-next/c/dd6367916d2d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


