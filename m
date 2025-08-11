Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A38241CA2
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 16:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754930393; cv=none; b=q3IGdz19v43S0lGwifMHRQUoZ+bOEVrNYIwLQ6cqlgldv3A6Q7GdvNtVqXJP2/oTx8fvX8Vq3rUT/n+jHmbLQug+NU4G6oJVk/XGN5whHBWCobYg9KQPC5kGVq5sQt17oF6W3rEeyrBPiFdJpQSk5Dm4XCMRAoc56YhCf8YlQ80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754930393; c=relaxed/simple;
	bh=y34m99iyB8m3wiDZ4rdxXZW4SfcaoMCRPmvQ81K+1jo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K65G+RTna7PZEIhkpndqCjh2uqu50jSYOIgaoUb/IcTYh8Xgo76UPZW6pKJ8Eg3U5fd0RSVm+sP597RtvPZXmEFzjjbhokERgaPolLL7FjsAVrZDv37jt95828FwhlbFh9PZIDqOcYjpbZY6N2WqnRswP8+aU1aB85bA4hjUbJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkYUaqMx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkYUaqMx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FA1C4CEED;
	Mon, 11 Aug 2025 16:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754930392;
	bh=y34m99iyB8m3wiDZ4rdxXZW4SfcaoMCRPmvQ81K+1jo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WkYUaqMxbcHEg0/0sX2xA27rSwxWMzuE64RPxUHCfVlJIt2RdmFhyaLRnWAQ0P7q+
	 QFhgNsS8pFgX79sC0TuMk8VvI/njZVbWXyqUTpd1zHDckVwQkofLBCiw1YqKSoC/9N
	 kdsjcbjV6H86vR0igtOdJHdWaU9viwUhZ/P2eH6X9oBU5uu4aiBsp17Y5FSrjrHk7m
	 yteutAzu5x1fNUoZ6ITACIu7Y7hrUkf0tfGMcCjZNSCYZf+f0Ar4XZ0TheSxooccrf
	 uLlWvGZgmI33UN9CBw9mAznmZlpvSr/enX09zrFbgDWvX0i8m+LM635Dl10KA32v2y
	 TaK619Mr2aP2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F14383BF51;
	Mon, 11 Aug 2025 16:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_conn: do return error from
 hci_enhanced_setup_sync()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175493040525.1801125.17464343512639742190.git-patchwork-notify@kernel.org>
Date: Mon, 11 Aug 2025 16:40:05 +0000
References: <14e5f8f1-1f93-461d-9cc7-57e1f0b57911@omp.ru>
In-Reply-To: <14e5f8f1-1f93-461d-9cc7-57e1f0b57911@omp.ru>
To: Sergey Shtylyov <s.shtylyov@omp.ru>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, brian.gix@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 5 Aug 2025 22:14:51 +0300 you wrote:
> The commit e07a06b4eb41 ("Bluetooth: Convert SCO configure_datapath to
> hci_sync") missed to update the *return* statement under the *case* of
> BT_CODEC_TRANSPARENT in hci_enhanced_setup_sync(), which led to returning
> success (0) instead of the negative error code (-EINVAL).  However, the
> result of hci_enhanced_setup_sync() seems to be ignored anyway, since NULL
> gets passed to hci_cmd_sync_queue() as the last argument in that case and
> the only function interested in that result is specified by that argument.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_conn: do return error from hci_enhanced_setup_sync()
    https://git.kernel.org/bluetooth/bluetooth-next/c/8477821d5f12

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


