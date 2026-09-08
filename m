Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EBE56E057;
	Tue,  8 Sep 2026 16:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788885087; cv=none; b=fdE8j9XGQmZgMfqxcTiQT31qYpFTeb5l24wklE2tL9VURei4nIjwkttWrdvYPOazgn0U4JSIYGCbpmLYe+eTvzxMH+W0f21R7IQNrEa63A/8hF7PAtcnJi/UXONyZvMiH8X3se3tVQSsvexqx5edk9DyIznqWL4ST3dFSus5J1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788885087; c=relaxed/simple;
	bh=+m3CzOqet5yoCW2jIjsF7t3L9KDCPk4mO9q9BVW0ycE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PVERxw6N28AjhU/3Z+y70uyU6jemycZLiwt5A2VmCDuYpfREliFBpJSrz6cby7mWZXwAJLLvW19SrZwfWQEqJWbXFpXf+0hcKEMGpAmTFZeh8nqkuAZYIfY53FZ5ubuYZJMEtJfTx3rXcnNOsxbeDYfdKDIfgGbKKNJSRx2bcac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4kYmY1s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4kYmY1s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D841F00A3A;
	Tue,  8 Sep 2026 16:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788885086;
	bh=/2Ber8ss9JqZNhYHK02YS4tYx+x2tekjJjgrmS2PiBU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=n4kYmY1sN2m9oQXECwSJHdE7Ef57f1bqYRu8UaMSYerBFztXseWNr477YI0MYmUTR
	 I3qMam6aBV681iFYqfTj1t6+Mz/nNNat2R4YdhSsDNH2pYoMLzDFyVUrPKRc/Wnpf7
	 QPUoc/isgrFLA3DgnRGh3eeAdrs0p/kHjrcJJEkAeUTyXfYNTVuGwz9rpgnmKOx2pH
	 84mdhcoF+CB1XzZKZwyeV7IbJE2iyYcmFdLiFRgRSsN048dD4zRtTqsolgKIrGGkn3
	 Ek12dx3hi5v49jamFMrMVF3E6dunPevskNPIDKRKWJMvgWnwkODGKv+b0pRGjHfpZU
	 9Y1Bff6Uri7Pw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19AD939EAF6D;
	Tue,  8 Sep 2026 16:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_core: Fix queuing tx_work after workqueue
 is
 drained
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178888502461.3627954.10490846236142598970.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 16:30:24 +0000
References: <20260906152127.90734-1-ngocthang2710.1999@gmail.com>
In-Reply-To: <20260906152127.90734-1-ngocthang2710.1999@gmail.com>
To: ThangNN99 <ngocthang2710.1999@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+b6919040d9958e2fc1ae@syzkaller.appspotmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun,  6 Sep 2026 22:21:27 +0700 you wrote:
> hci_send_acl(), hci_send_sco() and hci_send_iso() queue hdev->tx_work
> unconditionally. They can run from the L2CAP/SCO/ISO socket send path
> while hci_dev_close_sync() is draining hdev->workqueue (HCIDEVDOWN
> racing with a socket write). Since that queue_work() is not chained
> work from the tx_work worker itself, __queue_work() sees the queue
> marked __WQ_DRAINING, warns "cannot queue %ps on wq %s", and drops
> the work:
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_core: Fix queuing tx_work after workqueue is drained
    https://git.kernel.org/bluetooth/bluetooth-next/c/0010ea1bd14d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


