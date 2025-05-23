Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2CD2951B5
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 May 2025 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748011196; cv=none; b=D6FLBbsn8nPDpC6xpiMjomG3QuTzRerL2Afl+O4Bkh8MfK8lAd1TpS+QE43PI29PnClURVR5ddV8arup3hTTZCDnjCmcjom7WAT26PFFkRidgHEs91dT4mKfHNntGBX6B8PHHHYqVW/6yekYiDtUQsKWHyZ9gSQvw3NoSI4UCjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748011196; c=relaxed/simple;
	bh=zv3doc5crphIDH8hfl5HlibT7dZ8PfGTufWU8/BcY/E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QSV0mDPR94tJZ9df+0+9WAUYeQ539l/fcU3Oqp87gseGn4CN7V5XrEbCBz+Q4cTtYZ0fsd0qk6JAGOkuMc4RZEySRVqfF4vlfD5tAEP8NsOqfAx298WzCp2sxLToAN8yNP8/3jtq+yZ6gwPw0/fzHm/rM/HpJ+FKXV+MhRiKcQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwbdZwT/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwbdZwT/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3A9C4CEE9;
	Fri, 23 May 2025 14:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748011195;
	bh=zv3doc5crphIDH8hfl5HlibT7dZ8PfGTufWU8/BcY/E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TwbdZwT/1nfpltL+j2uia9jQH2PZb/5+ms8YTr65Cg6GYhZekC4Yn49EhgQ1qPE+e
	 7ses7EsnAHyqUX7TskWqeV5x8hp7pit4vXC4KxFQhBGre5D6T5MSMfGvz3nJiA4Bfz
	 fmltNY5JVXSM6mvCzimsRSMROs/gnDR4hBZNuPDjy+WG0lIsJpBOsOjRvWJ9Uean0t
	 VB9Y/VONVb8d4fVDQ5UABRKbi0SZVJZeJCiJdZUctAnYfkmHyZreZiCyp7t2ihtb5m
	 8rNc9yxSUrNxu8EpLMgJCFsUbpqiZJxGhYZ+zkdPXeJCjyn5J1anS28ggj7dJ+6cOU
	 6QACpX4bUv3qw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EE93810902;
	Fri, 23 May 2025 14:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: MGMT: reject malformed HCI_CMD_SYNC commands
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174801123101.3616952.16066745120197261789.git-patchwork-notify@kernel.org>
Date: Fri, 23 May 2025 14:40:31 +0000
References: <20250522181602.908248-1-dmantipov@yandex.ru>
In-Reply-To: <20250522181602.908248-1-dmantipov@yandex.ru>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org, johan.hedberg@gmail.com,
 linux-bluetooth@vger.kernel.org,
 syzbot+5fe2d5bfbfbec0b675a0@syzkaller.appspotmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 22 May 2025 21:16:02 +0300 you wrote:
> In 'mgmt_hci_cmd_sync()', check whether the size of parameters passed
> in 'struct mgmt_cp_hci_cmd_sync' matches the total size of the data
> (i.e. 'sizeof(struct mgmt_cp_hci_cmd_sync)' plus trailing bytes).
> Otherwise, large invalid 'params_len' will cause 'hci_cmd_sync_alloc()'
> to do 'skb_put_data()' from an area beyond the one actually passed to
> 'mgmt_hci_cmd_sync()'.
> 
> [...]

Here is the summary with links:
  - Bluetooth: MGMT: reject malformed HCI_CMD_SYNC commands
    https://git.kernel.org/bluetooth/bluetooth-next/c/2ab3abab237b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


