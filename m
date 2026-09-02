Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21500481FAB;
	Wed,  2 Sep 2026 21:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788384673; cv=none; b=fD92p82TBqmPpL8aMdOsdmjwNZMxCqFC+jN9nRXVAHpbKiM9BOKI8jQz4V7tssNrgKSls3SV7vUAutSKsiGBz/a8YnDR2ttZ/s9nERmtkZU5bDblhvexQiBzCKpOK7Y7GAP6+6nGHOBcyKGSXoCILE/AB2G4gurPMf1USh2QRC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788384673; c=relaxed/simple;
	bh=VqxlyZbmZtxZpwCjmlihb9RBg9CLKsW5GC8xWkhx8fM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AkxhLkzFucwdZgOsu8SV3GNRj6wnm/c5iHfb15ZNgCgGnFPcr2PQrcTNx1Pr95bazBEdPZs96iTzIaffV6Q0XRxbOdSx1i2iam39OguxpAdXun4esvcX0qDFmOdV4N7f3b2AhAZBH3oV+DNiYBnoraNWXu3I7Ck2iEXdmB46/Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3c6I3Rk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3c6I3Rk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD061F00A3A;
	Wed,  2 Sep 2026 21:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788384667;
	bh=sJqXkKSbyH2rvKdZeue1l3Y8JPj93k6i1kpRss78LUs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Z3c6I3Rk3cZtkYeNHqCQEbv/F7zujf5UC2BR9Pv/DGceWo865dQ2IPE4tNeXxEju+
	 ytw7tjn8+cQcm9RntWraJ8k84xGTfFdzFYrbSzNeP1XSyN9WfhuapsELdESu05qUEg
	 OiQ1kHRQhBOczLb1LY0+spZo5Cf+KR55lv6Y1HBPvjdcpXElzrjej7NiEV80s/mYy6
	 KRZ1jqHfyujFhzBPRNS5kB84oxdxAZgkVBOXBbY9T8lbZ944HGO5j3byLdmPv91DCv
	 OZ2sNtRs587X0RjQIXjK9OKdybw3EMWWwbtJGnvstcc/1zwa91Qmy6tiEf2Xo4d+lt
	 cpxq4J8nwJOWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 567CF3927045;
	Wed,  2 Sep 2026 21:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/4] Bluetooth: L2CAP: part 2 of l2cap_conn::chan_l
 locking
 fixes
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178838460889.2957558.5479187163968651566.git-patchwork-notify@kernel.org>
Date: Wed, 02 Sep 2026 21:30:08 +0000
References: <cover.1788296635.git.pav@iki.fi>
In-Reply-To: <cover.1788296635.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, elver@google.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  2 Sep 2026 00:04:32 +0300 you wrote:
> Rebase to fix conflict in remaining commits from series
> https://lore.kernel.org/linux-bluetooth/cover.1788013041.git.pav@iki.fi/
> 
> Fixed minor conflict vs. moved mutex_lock + l2cap_chan_lock in diff
> context
> commit ddaccd985bb0 ("Bluetooth: L2CAP: fix out-of-bounds write in l2cap_ecred_connect")
> 
> [...]

Here is the summary with links:
  - [1/4] Bluetooth: L2CAP: take lock for l2cap_chan_del in l2cap_ecred_rsp_defer
    https://git.kernel.org/bluetooth/bluetooth-next/c/c6d60c24cd7b
  - [2/4] Bluetooth: L2CAP: annotate locking for l2cap_chan_del()
    https://git.kernel.org/bluetooth/bluetooth-next/c/6873eb51dcdd
  - [3/4] Bluetooth: L2CAP: annotate locking for l2cap_ops callbacks
    https://git.kernel.org/bluetooth/bluetooth-next/c/4149ba2a806c
  - [4/4] Bluetooth: L2CAP: refuse __l2cap_chan_add if chan already has conn
    https://git.kernel.org/bluetooth/bluetooth-next/c/6696072ffe07

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


