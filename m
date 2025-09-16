Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0974C625
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Sep 2025 13:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758028838; cv=none; b=QjbxI4uOofr10w6RkcC1BJIJ5grZ1QSXAVa/+4WTa5zVKCN3vmwyutC3HT7PbiEJJrSSab5MTbv3Rm/u1EUwg2Gpcip/bqjAvx+YkMAylRnF8CL9Rng+Pw8A9dN0otZ480c2s+p7L44EcMgWXHu23QeQjq6ZHv8GXryRebz0H/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758028838; c=relaxed/simple;
	bh=hC69tCigwTgPHy2+bpNbe3MyaXpR4mo58Qheu1MKb3Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j5BfNscGDgDoVkEUGoolKXZb68kVbCcf5U41IpnL3rIJqsVKwRnVOYYQVGGA3oKckj/CU4mNwCFlQj5mhDFpJli9BU0cIQy7Aovk5FtQ3OvmjeLJjuFgT/8Kboi0nyObpQKEsbUWQrrfshoNUUZ5qrGWiqPjsqz4kr9QEAGyyhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4LCumHi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4LCumHi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80DE3C4CEEB;
	Tue, 16 Sep 2025 13:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758028837;
	bh=hC69tCigwTgPHy2+bpNbe3MyaXpR4mo58Qheu1MKb3Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g4LCumHiSx/6LGQEic44/I/KFRG7oFZNJo45EgKW55QmqHtlOcuVGGFE4vmtwifXq
	 wpNPEXIkcDiDeS5Ezbrg6dKgA3zFAyXe6cc3pNHtui5wJdwL8vaPfs7Pqz3a4s6rm5
	 nH5yOFXelWZMaBQ6ugzI4H6Vm3lR1iUG2OSb5nsuWp/aQGf31b4vaCoFmo/M34gM1A
	 kRDvuciOhxPk80ntQrMrjHVDvzxk+B4aNquNDL/SPAuVUWs3W0Knn2RNGe6V/6ZK9W
	 qiilcwJCFxFv6F5o3Hoxtk7Id4Loi3p+Sqw0IVv92nIuRhKZDM8yZ7b64upWfNAzRU
	 F8gaW2YKFEUuw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEE339D0C1A;
	Tue, 16 Sep 2025 13:20:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 1/3] Bluetooth: MGMT: Fix possible deadlock in
 mgmt_remove_adv_monitor_complete
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175802883848.749893.14812000078040934187.git-patchwork-notify@kernel.org>
Date: Tue, 16 Sep 2025 13:20:38 +0000
References: <20250829192104.2010557-1-luiz.dentz@gmail.com>
In-Reply-To: <20250829192104.2010557-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 29 Aug 2025 15:21:02 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the following deadlock:
> 
> --------------------------------------------
> syz.4.423/7568 is trying to acquire lock:
> ffff888068c48078 (&hdev->lock){+.+.}-{4:4}, at: mgmt_remove_adv_monitor_complete+0x9e/0x2e0 net/bluetooth/mgmt.c:5524
> 
> [...]

Here is the summary with links:
  - [v1,1/3] Bluetooth: MGMT: Fix possible deadlock in mgmt_remove_adv_monitor_complete
    (no matching commit)
  - [v1,2/3] Bluetooth: hci_event: Fix UAF in hci_conn_tx_dequeue
    https://git.kernel.org/bluetooth/bluetooth-next/c/6b74ce021062
  - [v1,3/3] Bluetooth: hci_event: Fix UAF in hci_acl_create_conn_sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/b6018d6825ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


