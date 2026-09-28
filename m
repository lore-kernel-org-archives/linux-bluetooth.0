Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776594E77F2;
	Mon, 28 Sep 2026 15:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790610099; cv=none; b=gEB5Xko+FXtKp7qAWoFZxFwlMUK7cmjoDZ7COKbPD1c5AxlGvTgQYmBc1kyuBdmlYhQ2eaHNBQKCKYjN50DJxzoHlIqJ83dOHzmdnrrtjhOPporQ9CcZDp68rCs9F7dWo9hxu8iMQ6IoSXtunnxZxBz5vBJRrMGaxXkM6kgihHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790610099; c=relaxed/simple;
	bh=uU+F/7FYGQHfFslTNU5W7RudQjwWoBHoUyeqy2aFqdE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Pub1+O6WuUVfXX9xQ2EzZnWOF1kMU7jlg7OsmB8tgZp6b5V+VJZE4MN2gj5ul1vZ9MzIiF9OXb3nfj4mfUUgmGE+0gh5An7AercGxxFXuXbDieKe6dRfwBX0o/veU6mh9sXU9hl1oEyz/z7/XaTwBRvT6pz8IcoTA1Mr85GNwBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEJx2e7n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEJx2e7n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172AD1F00893;
	Mon, 28 Sep 2026 15:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790610098;
	bh=VXo/JE8EB/EhbwiTk0PKT6hLxNQqkf6OMqKoYexfHVk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KEJx2e7npaSAWf3QUuW0WBz8lcs8ygK8UCjmUjRd0rOz8O47w8qzwQ1rxXuHCEYLz
	 wd/Y1zIryJaeTlc7XWPIOTpcb5YCgNjhbaSNzYb0rTrjVO4fmjbH/Grk/dNsxwti84
	 ByeyMw+XoZIskENcBnLvPasd9XSsVu8XPfrakCtuzVYzeM+p1dYS22tIF69IG2nT9j
	 vSOEipZq3Pa0x5B8881zmizStM7b00cJDau0lL1tJ9Qmv12OopVO55lxjKmmMXa5BB
	 d19bKrQAZ1zNc6L6zrZkthOYDb7/2iQIpfCPYW9/B1r6lhMNn8iw3HvdKWOYfhoqMR
	 SrTEt/obi6y9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19B1C3924456;
	Mon, 28 Sep 2026 15:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_sync: don't drain cmd_sync backlog on
 unregister
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179061002265.4169639.8219573133250587416.git-patchwork-notify@kernel.org>
Date: Mon, 28 Sep 2026 15:40:22 +0000
References: <20260927151802.13619-1-ngocthang2710.1999@gmail.com>
In-Reply-To: <20260927151802.13619-1-ngocthang2710.1999@gmail.com>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+217e3f1283cafe80586e@syzkaller.appspotmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 27 Sep 2026 22:18:02 +0700 you wrote:
> hci_unregister_dev() disables cmd_work and cmd_timer, then calls
> hci_cmd_sync_clear(), whose cancel_work_sync() waits for
> hci_cmd_sync_work() to return. That worker dequeues and runs every
> entry on cmd_sync_work_list. With cmd_work disabled nothing reaches
> the controller, so each queued HCI command waits the full
> HCI_CMD_TIMEOUT (2s).
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_sync: don't drain cmd_sync backlog on unregister
    https://git.kernel.org/bluetooth/bluetooth-next/c/b1f24c1ab523

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


