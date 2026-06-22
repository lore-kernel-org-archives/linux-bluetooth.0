Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB55733F385
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782147630; cv=none; b=Z2jr+PZby3VMAlg1rPo+yWJk65IxxSOzjwt4GaiHxyp4tH2e6EdeakGab2YB9o18Z9UnwdG9dX4+4OWTVhgffGajl7xghxABWSAKVd8KZQg/u8qY7eQLQnB0xiGii+cu+SmIjBDkM5+USaLnQVmcyNUCj75JxsL6amXpDk1/k20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782147630; c=relaxed/simple;
	bh=axagS1//Ok/0EQqo2OslBN2L6U2cuvTR9nAmsH9Jt3s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jXgVoL/fIJBv8ZC5OtI0Ce4m6roUCmPBE0d6v/elQiQf5+bLil86xY9sE7+7qfnfI8B8czX2SEqyxN9zVrm6ra0NCxpInty5HVbJy0wrThYkfTnIi+lzCdjfkT22yKz94sGd66rEN6cxC97sxj5P3KZ6eSIhNCMOY+O4xfIfPuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHGRX3uj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHGRX3uj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36C91F000E9;
	Mon, 22 Jun 2026 17:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782147628;
	bh=xH7DGduVgCh/AAi4SibQgFujKssNpfqsd0Ot9Al5oCI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QHGRX3uj4dEw7yfTLv24HOgTedwjrryn8JztlEGou9RkZ+oL7YkD/nG48ncd0vLIu
	 R9PFKCxXzk164D0T+DR0XnYzcNYjAjJgkZ0rjwwPWGO/t9AN8uLC908Q6TYCC9WvFH
	 08WVoIQ0JjTD31bGRTShlIoLeDJTX0mdT/RxjpVw135YJDiprzrkZ897dVp5/GZBct
	 KUVTGC8UPKUMGr/n4e1D07vk+NlTjEujPEZCkVjIzv7p3mskS0DfrJMBRtfrmBMSjH
	 WlHTg0KprekJ0mctMI/Rg3ihP584YqkkikeH+AYd46CWykpkcp0iM+IgVHGfaeC2jO
	 1YhXQ+Tpj4/YA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939813930917;
	Mon, 22 Jun 2026 17:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 1/2] Bluetooth: hci_conn: Fix null ptr deref in
 hci_abort_conn()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178214761929.1322955.16732313923860679614.git-patchwork-notify@kernel.org>
Date: Mon, 22 Jun 2026 17:00:19 +0000
References: <20260615153527.1583705-1-oss@fourdim.xyz>
In-Reply-To: <20260615153527.1583705-1-oss@fourdim.xyz>
To: Siwei Zhang <oss@fourdim.xyz>
Cc: luiz.dentz@gmail.com, pav@iki.fi, xiaowu.417@qq.com,
 linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 15 Jun 2026 11:33:05 -0400 you wrote:
> hci_abort_conn() read hci_skb_event(hdev->sent_cmd) when a connection
> was pending, but hdev->sent_cmd can be NULL while req_status is still
> HCI_REQ_PEND, leading to a NULL pointer dereference and a general
> protection fault from the hci_rx_work() receive path.
> 
> Instead of inspecting hdev->sent_cmd, track the in-flight create
> connection command with a new per-connection HCI_CONN_CREATE flag and
> route all cancellation through hci_cancel_connect_sync(), which
> dispatches to a dedicated per-type cancel function. The create command
> is in exactly one of two states: still queued, or in flight. The cancel
> function holds cmd_sync_work_lock across the whole decision: the worker
> takes this lock to dequeue every entry, so while it is held a queued
> command cannot start running and an in-flight command cannot complete
> and let the next command become pending. This keeps the flag test and
> hci_cmd_sync_cancel() atomic with respect to the worker, so a queued
> command is simply dequeued, and an in-flight command owned by this
> connection is cancelled without the risk of cancelling an unrelated
> command that became pending in the meantime. CIS uses the same flag
> mechanism via HCI_CONN_CREATE_CIS but cannot be dequeued per-connection.
> 
> [...]

Here is the summary with links:
  - [v6,1/2] Bluetooth: hci_conn: Fix null ptr deref in hci_abort_conn()
    https://git.kernel.org/bluetooth/bluetooth-next/c/76c2d047410b
  - [v6,2/2] Bluetooth: hci_sync: Remove unused hci_cmd_sync_dequeue_once()
    https://git.kernel.org/bluetooth/bluetooth-next/c/8047d832767f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


