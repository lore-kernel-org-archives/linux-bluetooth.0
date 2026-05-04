Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CA33783C7;
	Mon,  4 May 2026 17:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777914660; cv=none; b=VxL4uKR8NWt+uCehpzx47aXhK1L2AU+zDeXCkCrBm/ncYob80s8U0EPnTEsURrEmDUH8DSPtPiS9AVpbDOk0lWMINBTLe/TOTXxVDjjIKF8Qeu7VMkJVE9uwmdU6b/xC0r7LoJQVN0PU9vanyy5jE2u+0/n2cyBLIG7ISzqhJ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777914660; c=relaxed/simple;
	bh=aQH+vAx12vuKTW/PnsalyF/7XUig7GxBDSH8xdXuLNU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kePGy8R/rDOCoiKDhHIyuJZBzkSgAz3YiFjEfzBWXg+iASaxbfkpGC3DVAtq6U65NN27Abx7Wwi4RBoW89uPtbIWo8yGi7dUdtmSpgCNrLEWekOex4cZofv/EUPhujIOqbATPW/+tXG65X7Fa7XFy3km3jWF2ChJc5KHbgqdIIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgziC3pF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgziC3pF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B061EC2BCF5;
	Mon,  4 May 2026 17:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777914659;
	bh=aQH+vAx12vuKTW/PnsalyF/7XUig7GxBDSH8xdXuLNU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sgziC3pFrMFk1+p0AqLO0CFEra4bh9agNFH8DSvGjoAyhsosWDGcDEYyz8ntSSF72
	 CklrosJYyVjHSinxDmXTWmIdHR1IIzpjBTW/JrrcpOINAlDsSJdyluA3OZLISAaj7M
	 xiF3xu4bZvjTegU62vUlmU74QPHeON2c0nLbAHopQ//ts4JG4JhR9arepLWmVjk8yX
	 s3+47FM2PSs53bNfZukNoS4Dio2BLrcWR6dSXPMWHgJuipf7sW5zj7LX1GYjo/akgS
	 gjJJhElJPJONDSzDOI+m+HSiLhdqOhdhazirxmHIPtp3Z2nkuT9EEjrrdsctqf4e3+
	 bqrtuvICvbJLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02BF03930032;
	Mon,  4 May 2026 17:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_event: fix memset typo
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177791461054.801187.15935896147672715874.git-patchwork-notify@kernel.org>
Date: Mon, 04 May 2026 17:10:10 +0000
References: <20260429-bluetooth-memset-fix-v1-1-73507b81a903@google.com>
In-Reply-To: <20260429-bluetooth-memset-fix-v1-1-73507b81a903@google.com>
To: Jann Horn <jannh@google.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, iulia.tanasescu@nxp.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 29 Apr 2026 15:40:46 +0200 you wrote:
> hci_le_big_sync_established_evt() currently does:
> 
>     conn->num_bis = 0;
>     memset(conn->bis, 0, sizeof(conn->num_bis));
> 
> sizeof(conn->num_bis) is wrong - it would make sense to either use
> conn->num_bis (before setting that to 0) or sizeof(conn->bis).
> Fix it by using sizeof(conn->bis), the least intrusive change.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_event: fix memset typo
    https://git.kernel.org/bluetooth/bluetooth-next/c/bed1ff8e28fc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


