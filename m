Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64CD3FB042;
	Tue, 11 Aug 2026 20:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786479056; cv=none; b=kUcteK9zj39Cq5iuWWznys6O6AuJE7/LD1fZuY81AFgQgY8wAHkG5OpN1j5tgFs002U1v6RcOTFu92w2mOtfTNAagjpEug+aHprErtOBhIpq8D2Vg2sI11WZZ4TckgGkcuGdCyKTtr/BQUQCP8wqDObk6f/KE9tQOuESor9Xcp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786479056; c=relaxed/simple;
	bh=DKKEBpKNEgv0+EYwRA6HikcoP2klDmwS0MiO2XEc5dw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xb5ysIylkBqWg/0/9UhrkLhLd0DB4/4m9tE7hYf1jXFWq4yA5YGn55FvPNu8b3sJTAabuIxMrpAU5nFZyL4Hw0WnyQUzErTld27/yYgH7aNmON4BP804gkb1b6FjR7oG5afCklKmLtcnqbqm8YUeg+fSBphPaiSRZRS9HJPRbzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChtfQWSw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChtfQWSw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9741F00A3A;
	Tue, 11 Aug 2026 20:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786479054;
	bh=EAJjCoiV5fJcp4B7NTs6m0CiofBUJT6nxuHHHQzJ3No=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ChtfQWSwKErMgvj/80MPMu5bnIOre+YlDXCljPUVhKNfY9DCwPJicL81G2lKI2OX7
	 8ecPKo9KD/+hbf4hsyU6iEaPCEOj1Hdm2Z+/MJpUmtd9ewwBeq7NS80KMwEOsIepgN
	 rwgGJbIkYh1p12wgR46HvF3p0hLXd770fMuN+1C+E/VpLUgjp6Qw13l+zOKdd94oMq
	 wfc8o7+EaBemCxs1g3jXMj0r3SWNrzxkh8vZLLvGA5IwVxrQCVQA4GE6bI8ZExOWci
	 1Q312BvUxvUrsQSeJglNEVY1suaQ7oYpM7RSqqfsFtpHMaS4W68cuVgTx2EFN1KyNU
	 1lgb2jjo3zQZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D094A3809A0A;
	Tue, 11 Aug 2026 20:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: L2CAP: access chan->conn safely in
 get/setsockopt
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178647901038.1134064.15275221947394205709.git-patchwork-notify@kernel.org>
Date: Tue, 11 Aug 2026 20:10:10 +0000
References: 
 <e4b6658ac62a0dd6ca90e7c7a3d4f58b04ec4b48.1786296912.git.pav@iki.fi>
In-Reply-To: 
 <e4b6658ac62a0dd6ca90e7c7a3d4f58b04ec4b48.1786296912.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, elver@google.com, linux-kernel@vger.kernel.org,
 syzbot+b106284c2a0b7bc80cf9@syzkaller.appspotmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun,  9 Aug 2026 20:42:41 +0300 you wrote:
> Since commit b66774b48dd9 ("Bluetooth: L2CAP: Fix UAF in channel timeout by holding conn ref")
> l2cap_chan::conn has held reference and remains non-NULL also after the
> corresponding hci_conn is deleted.  In this state accessing various
> fields eg. hci_conn::hdev is invalid, which leads to KASAN crash in
> l2cap_sock_setsockopt() access of conn->hcon->hdev.
> 
> Check l2cap_chan::conn.hcon corresponds to an alive hci_conn before
> trying to use it in l2cap_sock.c.  Hold l2cap_chan_lock() in
> getsockopt/setsockopt to ensure it stays alive, and to avoid data races
> in l2cap_chan fields.
> 
> [...]

Here is the summary with links:
  - Bluetooth: L2CAP: access chan->conn safely in get/setsockopt
    https://git.kernel.org/bluetooth/bluetooth-next/c/d1b752f55289

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


