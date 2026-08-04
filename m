Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253D545FFD1;
	Tue,  4 Aug 2026 17:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785865247; cv=none; b=eJi2fRX2a4QdjpTaVwhr5uk1ahdWRKqRmAS3CA37aaOEpsTgLc4QD63PuVrEIN056ZpZwogZzN71moWXwVWz+/ptjojIBAMXWhZhKAmAaGg815nPCZMQ7mb6+oGmTG+y12rvUcjtmS6n+llnwGfod0qVogstp5inAP1iSBTDYQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785865247; c=relaxed/simple;
	bh=n5ZwJTtEjDBEf3PdOxZgW8h1Ec/ty6cm4d48ElfZNdk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iahg/djYdi7M75Gn/8rzM5gSffPTtih6fRL2q5/RdBdkiokPkcFWAZ6GimSSwmvSvESNiPr2w1GeexKfjGlWrqmQi28rjSTk32Mhc5jlO/r3Mxr0KvdxnCyn5LRSRxvQQ4n+P4s82LohiK6+5HPQZWOZwlRzRJfFZmEAlhmOOvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ib2hSx6K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ib2hSx6K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D348E1F000E9;
	Tue,  4 Aug 2026 17:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785865245;
	bh=bfQicKI4BU9aOY1rMKjBCrn9zaY6KF0qdwDHPiJGpyc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ib2hSx6Kn8SACASyDz9iDG9hTxZkScG9rcMytNQgNn9pqptPFP3X1UEMkFqQi/w+d
	 42JCUUVLB7dfsWBHI/SwkgDCy00ErtJK1xWYVZaHip6/TgoQKl44778pEzxB4Z84lZ
	 FBvNajJbFo0gmvLkB8TTnvjHB8B7HqZ1ndrLbXTE31baAuNOaKL9gHNizBuE7ULkWP
	 ObilNYALNGkjsl7ZpSI2HND9ErgBnQHG8hPHCQCgxYnUNolUzXW9lSar4XazY0O4/d
	 Nwin/EdWTpzO6/Yic1GhtndM+gi2Z58X+6b2giwWIkQFBGkla07WGPx1uRftT5iBVe
	 bl/3JducSlRnw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A713926272;
	Tue,  4 Aug 2026 17:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] Bluetooth: L2CAP: use proto_lock for l2cap_data to
 fix
 l2cap_disconn_ind
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178586520639.3702995.4820111211961794827.git-patchwork-notify@kernel.org>
Date: Tue, 04 Aug 2026 17:40:06 +0000
References: 
 <a672a4ee3d24c93156c51ef84ca4dc3364a18109.1785609341.git.pav@iki.fi>
In-Reply-To: 
 <a672a4ee3d24c93156c51ef84ca4dc3364a18109.1785609341.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, linux-kernel@vger.kernel.org,
 syzbot+9c40ad7c6ed7165e46e8@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat,  1 Aug 2026 21:37:23 +0300 you wrote:
> hci_conn::l2cap_data is accessed without locks in l2cap_disconn_ind via
> hci_conn_timeout (disc_work) -> hci_proto_disconn_ind ->
> l2cap_disconn_ind.  This is UAF if the l2cap_conn is deleted
> concurrently.
> 
> disc_work is disabled sync in hci_conn_del(), so we cannot take
> hci_dev_lock in disc_work.
> 
> [...]

Here is the summary with links:
  - [1/2] Bluetooth: L2CAP: use proto_lock for l2cap_data to fix l2cap_disconn_ind
    https://git.kernel.org/bluetooth/bluetooth-next/c/b974e13aafe9
  - [2/2] Bluetooth: add annotations for l2cap_data locking context
    https://git.kernel.org/bluetooth/bluetooth-next/c/d740cf77461a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


