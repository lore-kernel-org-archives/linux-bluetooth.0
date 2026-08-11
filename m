Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525B8339362;
	Tue, 11 Aug 2026 20:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786479062; cv=none; b=kOZ8sMKkJxQZ64dtrO+rKq4QzLElEaFgDNigWvdGJj8Moyfh6US2Nm7YZmtqDA9mokF2GOoSjDhBaV3NqG+BUcWUDfzjmEMl+/pkIVGT4V031X0XbYXNTxRZNVU56BxpkIgrsDykmcHMOyfCM4D6DvEjCDchubGACciB6+BFYng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786479062; c=relaxed/simple;
	bh=CjEUvMo9FrceCh5EuGDkOZ5Mu3Vf4ndFDjIeXl0M9fY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jR+ynWE9mkqHKdnZIcRc/NVzk8m5oae2BJSqkVz3Qglq9H/EnOkJ39SD/4BhuQAOvq/DK468M5GRfPgTpHSOpVJSQJW3ECu2Z5DPlla/DUhCx2kYX/6F//XsNr0yfpx6CoX2oKkABeY7aw+qA2DknKC2MQy6Gjgy9ruK2DIZhRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6O4apfP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6O4apfP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272291F000E9;
	Tue, 11 Aug 2026 20:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786479059;
	bh=HVb8BMA2Rm3P+1dmF5w88CK6rWOwc0GHqH9cK6spkEg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=V6O4apfPsfGr8k6+Hl6BWOLiq6y12ez6eXdJa3vS2te7hiJgB4jVD7dmc1GtL2B4m
	 CQaIARJ1bHou0bo8l52/iDvxoilg6ZjPpVctT+Ho13zGjXWuallnaZukjTDm1pBEmD
	 uOy7RHtzlupR6M9vwBQVYD5b2Iyp3a/SOQ6o3wgnQFykLo0qT5OXS/XsC+uLWpAt9H
	 hSmZEATSOa7FZQ+J3EEc8nOb+Uf2L8i8IgkfEWdSJrb0N1jGSLu9wWVH2MJ1aeJRAG
	 54YGmBWYk3HS3bScKGdLipI+4ya43/T9krUE0IevGYecC3pOyRbA3aqSICTNem85JF
	 lHP/xkeRSezSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 567FA3809A0A;
	Tue, 11 Aug 2026 20:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: L2CAP: reject accept queue add unless
 BT_LISTEN
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178647901488.1134064.17530228641432806685.git-patchwork-notify@kernel.org>
Date: Tue, 11 Aug 2026 20:10:14 +0000
References: 
 <204b3dea7b0e001f64920ed1114d38c16afdb397.1786225848.git.pav@iki.fi>
In-Reply-To: 
 <204b3dea7b0e001f64920ed1114d38c16afdb397.1786225848.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, oss@fourdim.xyz, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com,
 syzbot+9265e754091c2d27ea29@syzkaller.appspotmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun,  9 Aug 2026 01:06:05 +0300 you wrote:
> New sk should not be added to parent socket accept queue after last
> l2cap_sock_cleanup_listen() has run in l2cap_sock_teardown_cb() and
> state set to BT_CLOSED, as that can result to UAF on dereferencing the
> dangling parent reference.
> 
> l2cap_sock_new_connection_cb() may race with parent l2cap_chan teardown,
> due to chan->state accessed without consistent locking:
> 
> [...]

Here is the summary with links:
  - Bluetooth: L2CAP: reject accept queue add unless BT_LISTEN
    https://git.kernel.org/bluetooth/bluetooth-next/c/9db7e5fffbae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


