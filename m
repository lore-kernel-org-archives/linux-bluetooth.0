Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2999481A8B;
	Mon, 14 Sep 2026 14:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396278; cv=none; b=GKz7aZmBV8vFn702kDJmyXCpN+ZNiWpSdmJR8rdRuHEALaQwithZAATUGOLHwAQHQ7Edmw5WY9znfJ+TDt36uU3JQITuB2jP3nZfy6YYDZFHq71+BCxsQi0odxmsLPFDi4EfrSzkTKH02apIs0Ii7RgNysPRDi2/Eh0fr1YGQI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396278; c=relaxed/simple;
	bh=KVdtTKp8zrkgxT30KQuJrFANdaiwogDsJRwu0kndxmQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T3RXqw/m4fNyD9SywK3rlT0dAoG5ilJcorDRw+XtJpb2twxbWQf1Pfr+vtSfvx6fT/HphB00giv+9b0ZauFKjVGhQmqPDhuCo7Rz5wkGxCGDj5kbwf0/fgs+JhxqqEZtb95QwBGNre9F08LvuwASo9tne1U6heSSnrztgTMKjv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWwiPNa/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWwiPNa/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E631F00893;
	Mon, 14 Sep 2026 14:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789396275;
	bh=gJNF53PmLPj5deMp9Pjgqq4wyAuMv2TkvIXcYDN6iXs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EWwiPNa/sqkyk1XcGKzh+JowcwmjL/ub2Cu93weo+1G843YiepsRydTEtTkBlCU/G
	 a3Alwiw0ccPeij90qwsdhY9qz9tvnYFowK3aSHn7oRtvt9N4A5GJsa/oYFZ12u8ZEE
	 I4mBulYBtO1T1zXPEmKVoHnkkY/hpi1vawSTfyXvu5OViZ8i5pixzhq3eVMKPUQB0w
	 OqPSRSZuiFlIujjTQx6vifKXG+EN2/hi1svjwBUxqJmtLeZopV36TrFlR5vktQVDlY
	 4yBcdo/5dHLpGPYthJITizGVXgYlDSmANvV3iVuGpnSC/ZESey2SoERp8bWO5vY2Vg
	 vA4opJprAiJng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B133924A67;
	Mon, 14 Sep 2026 14:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: RFCOMM: avoid socket lock inversion in
 listener
 cleanup
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178939621037.604238.10748160763592538123.git-patchwork-notify@kernel.org>
Date: Mon, 14 Sep 2026 14:30:10 +0000
References: <20260913030945.4011-1-jcperdomo100@gmail.com>
In-Reply-To: <20260913030945.4011-1-jcperdomo100@gmail.com>
To: Juan Perdomo <jcperdomo100@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+0cece8fa7d83523f47a3@syzkaller.appspotmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 12 Sep 2026 23:09:45 -0400 you wrote:
> rfcomm_sock_cleanup_listen() closes unaccepted child sockets through
> rfcomm_sock_close(), which takes the child socket lock before
> rfcomm_dlc_close() acquires rfcomm_mutex. The RFCOMM worker takes these
> locks in reverse order while handling connections and DLC state changes,
> so lockdep reports a possible deadlock.
> 
> Close dequeued children without taking their socket lock. The accept queue
> owns a reference to each child, and bt_accept_dequeue() locks the child
> while unlinking it and clearing its parent pointer.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: RFCOMM: avoid socket lock inversion in listener cleanup
    https://git.kernel.org/bluetooth/bluetooth-next/c/0186e4e1e5c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


