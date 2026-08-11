Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4744D37A842
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 20:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786479653; cv=none; b=aQD5Cwv5+Dk/DgnTieoWlMjpizF7F8AIfm/ne+CreCkMkgM+n1TRuRwp9myNccN27KhGJ+DAucRhxgSiAHpJR1My536h0Uuvab/us/Z35Ra6XO5sh60nPECHPR5GtmOcz1V/2L6bCjZb0W2B5casiIN5extGf4Z2A7p1C62KU2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786479653; c=relaxed/simple;
	bh=XoF1VKMuHKIQBC0nwS9ADC6Nv2WnF3kjLl7S5Ws2024=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PmCM1iCt3UacF5jp3cpL1t8Mj27RQGPlXppsCRiRj5pPNwjM7SMPaXUIMUGl6+eMVlHp5wONEKoQiO3OTWpr+0aSqCVckS+3Iq6IyDYGiiB0TAjxa98W29Z2U15t/a8CaEwNLryvTpV+UdEKAN3ZogOyZweb/HVoZ10pVE7+Ip8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRe0Y0xF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRe0Y0xF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2381F00A3A;
	Tue, 11 Aug 2026 20:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786479651;
	bh=inFF2kQ3LM036zUwpceWNkDmrDYXdlxXN96S2bOB2wk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PRe0Y0xFAQPcRYCo/2DZDFiISD5kb1hpDvHlfCW2/+vXeW45CFobvw4m+Xu44nLOz
	 wefOvL8xCxEbObbg0Yl+otvqBLMNbPtA8EhaxMo2n69Cn6f0mvFg74D0B+Zuv9Pfp4
	 16KQSocA46pMriQLOj0fTqg9g9+vAsaBe9VvmmQzyOKWPzn6h8Qyk6Xvtsqfcbq5yl
	 bYm6lAobfOFPTufK4qBCGwjwCIVlUxEhuxh44nU+PKt3NIp+s5ZLhCWFybeDf3nzyG
	 kz1Q2sLbU7jTfUQN5t+J/e4Xg7c4DdQMtpi9lGB0EL/5undeORg9loW/pU3tQ8ZijN
	 jCebHzGYfCYYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197013809A0A;
	Tue, 11 Aug 2026 20:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] tools/l2cap-tester: add tests changing BT_SECURITY
 after connecting
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178647960763.1138292.17435722690288115421.git-patchwork-notify@kernel.org>
Date: Tue, 11 Aug 2026 20:20:07 +0000
References: 
 <b85da0d5625e37d6289be01e3b83663c115420df.1786293828.git.pav@iki.fi>
In-Reply-To: 
 <b85da0d5625e37d6289be01e3b83663c115420df.1786293828.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun,  9 Aug 2026 19:45:05 +0300 you wrote:
> Add tests that change BT_SECURITY value after connection established:
> 
> L2CAP BR/EDR Client PIN Code Change Sec - Success
> L2CAP LE Client Change Sec - Success
> L2CAP LE ATT Client Change Sec  - Success
> L2CAP LE EATT Client Change Sec - Success
> 
> [...]

Here is the summary with links:
  - [BlueZ] tools/l2cap-tester: add tests changing BT_SECURITY after connecting
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=45747c6d0c85

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


