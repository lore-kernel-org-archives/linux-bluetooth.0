Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A83B57ED8E;
	Tue,  8 Sep 2026 16:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788885071; cv=none; b=vACQ9r/ByoRotqvDU8f0hYL2hU8SBrMtv9mYZwz13PB5D5qsNtvRv4RYQk7fHvurTgrEXYHfjsnxsTz18QUOudAJIY00dmhRDH4jtrv42tWgCUzFdHlUIfhaiJqI0QAcjlBKWm4bKdaHBVeBaApm7NqgQatLpjEHBSKKluRnmuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788885071; c=relaxed/simple;
	bh=gh3rh119QoBt2gXgqc0CxzBxWdAhxRu4oIkIUAYgRRg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hvcnzesIbQzIn/RnqDgnY5Cb77FmQLIkG2zYTcyzM7/0CrJvzHQx0j42F3vbN12e5JoQOeTZU80yTK1+i2RIRJ5HCYG3HvBabHZBrhXVcs2SRnR69fRgUW3efWCj4Ci81B4zUPMdwcBHuNBCmqidIdydFdC2C9kh7vmh7llBCek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhfLBNT7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhfLBNT7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0810D1F00A3A;
	Tue,  8 Sep 2026 16:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788885070;
	bh=0l+8CLev5DKAcAbpMFnU9gJCwMsXufocnc37HiEjWiw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MhfLBNT7HwSP8/Fx3+mo7xplBcCPVO7QON41DGo+f07/vvhJiwwBealzMRHlU1uI0
	 ++O4CmmbJ+5DvYctMqaSmjLVFRemNm1g4IErcYSAYboQjzBXQNX75H2GKQ1iaiYo0u
	 j0vsJ+Tidw9FPS6+9RIDbHQ2PfUDfuaDUr6Y4GYfA67jyAeCI/uyUOWgcxCTPG2wzb
	 +mWR5GUESAhpwiSP7rgXdEnATCJ6YDrvElus4q+xhB35k0dYkmEzCSJG4IVyQfZSGM
	 fIYlWwAxgyHRFeCugUY081BYHW6Z/BcYYuM/iuVVEksIMCO9CGfL8e2fAwteV5CZrd
	 ofc0ICirDXR4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0E0339EAF6D;
	Tue,  8 Sep 2026 16:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bluetooth] Bluetooth: coredump: Quiesce dump work on
 unregister
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178888500873.3627954.10684835097412320189.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 16:30:08 +0000
References: <20260906154332.763402-1-bestswngs@gmail.com>
In-Reply-To: <20260906154332.763402-1-bestswngs@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, abhishekpandit@chromium.org,
 mmandlik@google.com, syzbot+b170dbf55520ebf5969a@syzkaller.appspotmail.com,
 abysamross@gmail.com, tristan@talencesecurity.com, xmei5@asu.edu

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun,  6 Sep 2026 23:43:32 +0800 you wrote:
> hci_devcd_handle_pkt_init() arms dump_timeout and coredump producers
> queue dump_rx without holding an hdev reference. Unregister leaves both
> works live, so disconnecting during an active dump lets them access hdev
> after hci_release_dev() frees it.
> 
> Shut down coredump processing during unregister. Close the producer gate
> under dump_q.lock before disabling both works, then free the active buffer
> and queued packets under hci_dev_lock. Serializing the gate with enqueue
> prevents controller-specific workers from adding packets after the final
> purge.
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: coredump: Quiesce dump work on unregister
    https://git.kernel.org/bluetooth/bluetooth-next/c/701ca71884b3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


