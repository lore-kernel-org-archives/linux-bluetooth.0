Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0631D27E1D5
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Nov 2025 14:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763562644; cv=none; b=NyS429WTALz0NLTI+4pM4MN1w8Op2Z7fMuyeqrm336IeqFT15lPe0i8Vl1moJNzYTh1b9+tYA1uKhUGfmp0d6ucW6iKmt9wsnnQnTZWLJGGdh8IvmtmZE1v3sQfFyrShNqaSMXBbRpJAiMHhG5ZUW0UCGSLGfDBbvlo2T+efu38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763562644; c=relaxed/simple;
	bh=qPDmLLyeKyE16ovnHdzBpvayBKxvmF4ZtdV79uSc+SE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OUT2a+E+/djwqd5dSKMwM1VSxo7zGHSk/5gGmDPQ9oyaewwuCqs+IImxGF1YKbdU/hUyS5DzgEWUqJapPPucd73Yzb4FEgoUFK1OP+09hWRnQ08As8oHxVdpf2PyyBgggXHyqoaPFjHYEqN9KGMqa4xi4x5BYRJWX6mLFdEfnvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jx3HS/36; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jx3HS/36"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7608CC2BCC9;
	Wed, 19 Nov 2025 14:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763562643;
	bh=qPDmLLyeKyE16ovnHdzBpvayBKxvmF4ZtdV79uSc+SE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jx3HS/36T9B7gIZdMCLAzikrbOW+ZMUHS/1LfHI7j9kDW/9YHiKQyHSKx/YLzItkU
	 HaGllvzwyxnZVlV1i2eh4SO0g1JdTsnycVNRKSPBzw3ByacCVadPnhhcRtDJ/dyVBw
	 teHLtGhk7UAS6H1us5W1ELvKUl15G0z0UtwgwzLufEEa9PFkhb7Qm3zGab4+U0l2qL
	 OBEUKQqArp8RAqkkLv24BjEDagpj0hnGFqkF4ozYT1wplHD7pr0gCLuP0SgQ2acji/
	 628GIFo7Ovdmvi1GsnwLZNCe9QFZqSEWTlEFDHa4VPNLdBwl5re3PUIba0UPQpFcKo
	 rJMVRSlgyn+Qw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE4B380AA44;
	Wed, 19 Nov 2025 14:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: hci_core: lookup hci_conn on RX path on
 protocol side
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176356260849.811862.2089974473176645458.git-patchwork-notify@kernel.org>
Date: Wed, 19 Nov 2025 14:30:08 +0000
References: 
 <183db933c90086f465918ac41188d730ac2bab4f.1763224083.git.pav@iki.fi>
In-Reply-To: 
 <183db933c90086f465918ac41188d730ac2bab4f.1763224083.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org,
 syzbot+d32d77220b92eddd89ad@syzkaller.appspotmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 15 Nov 2025 18:43:55 +0200 you wrote:
> The hdev lock/lookup/unlock/use pattern in the packet RX path doesn't
> ensure hci_conn* is not concurrently modified/deleted. This locking
> appears to be leftover from before conn_hash started using RCU
> commit bf4c63252490b ("Bluetooth: convert conn hash to RCU")
> and not clear if it had purpose since then.
> 
> Currently, there are code paths that delete hci_conn* from elsewhere
> than the ordered hdev->workqueue where the RX work runs in. E.g.
> commit 5af1f84ed13a ("Bluetooth: hci_sync: Fix UAF on hci_abort_conn_sync")
> introduced some of these, and there probably were a few others before
> it.  It's better to do the locking so that even if these run
> concurrently no UAF is possible.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: hci_core: lookup hci_conn on RX path on protocol side
    https://git.kernel.org/bluetooth/bluetooth-next/c/1819d1f7c1f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


