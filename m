Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C905C2139B5;
	Thu, 17 Jul 2025 18:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752778187; cv=none; b=NmVvNm6fRshaVOQhWJ4afOp6/arFHWI2EwUeazNNdn27mLP6uefbxBomaRirGaFkUw0xQ6X+M1zUlwZsFn53cF2KgNMqiHWHrLZVbZ+o6GaDv1pWGW6HLleBvJ1U1mdbosljSC0araECypnBP8UijSakOObHJYojB2ZjTznbxng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752778187; c=relaxed/simple;
	bh=oI4Iz1118HuZ/KD1dCn2i+99mHnRsPfR05yV+o2YCeM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t8H7qvf+MnghiM7fCcnxF6W9wNqu1k7Qd6kco1aRp0S+dWElqGJKdrl30QazEaJA6AOeRk0CXPuTw+vG/lkJUf7LF1pq6JV7w96I6Xis8X7r1thO3VLxk5dkpd5iFelISlcjiodrPWieSVYkBZtVGNJqdYipzKzUu/kJtZeOnqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbxEOVN9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbxEOVN9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5C0C4CEE3;
	Thu, 17 Jul 2025 18:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752778186;
	bh=oI4Iz1118HuZ/KD1dCn2i+99mHnRsPfR05yV+o2YCeM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EbxEOVN9t8wTP6+6Swb5jyJVGD5jEk+AWHhZTkQ/ZoxB9hnTjdhzZLnzpWF+LOE7d
	 wvAkW3J/urv4bxD5LHaXWgpfiNWXezK6f4YmWbKlYbzV1kD3nOUeOaKQXVs/4dOY4b
	 UyPvQOd5Yy7EPo+1hH7uKQJZe+ast+uUOpiS8AMEb9v07sIzLcFdA6vp1REM8byH6N
	 D7W9NWjKkHGZUCvjBIsLZX51C9Zq8xVR8MjJe/I/MVyvAdou+xPSo3UnffEvA28xzl
	 Yr01jaoFBfNQaXwOANVTuBevjoznokz933WQYxYD4Wz3KsQCf0t/d8Gn8+WefMj4tl
	 B0y8YLmB37eaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70ACD383BAC1;
	Thu, 17 Jul 2025 18:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_devcd_dump: fix out-of-bounds via
 dev_coredumpv
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175277820626.2039080.12698830804664904950.git-patchwork-notify@kernel.org>
Date: Thu, 17 Jul 2025 18:50:06 +0000
References: <20250717151051.195106-2-ipravdin.official@gmail.com>
In-Reply-To: <20250717151051.195106-2-ipravdin.official@gmail.com>
To: Ivan Pravdin <ipravdin.official@gmail.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+ac3c79181f6aecc5120c@syzkaller.appspotmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 17 Jul 2025 11:10:52 -0400 you wrote:
> Currently both dev_coredumpv and skb_put_data in hci_devcd_dump use
> hdev->dump.head. However, dev_coredumpv can free the buffer. From
> dev_coredumpm_timeout documentation, which is used by dev_coredumpv:
> 
>     > Creates a new device coredump for the given device. If a previous one hasn't
>     > been read yet, the new coredump is discarded. The data lifetime is determined
>     > by the device coredump framework and when it is no longer needed the @free
>     > function will be called to free the data.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_devcd_dump: fix out-of-bounds via dev_coredumpv
    https://git.kernel.org/bluetooth/bluetooth-next/c/2215f5c93ed1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


