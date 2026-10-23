Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792793410;
	b=mEGHzYfchBjWt7KW1yQclxv0mOYC6flxs0mEzQbpqxZReqaItEBJQHEMrXtQuBY6wOsw
	 1LCIIjhkeymAZYeHHRkNisnDEFDQA+i06MKErNqsrNt9E1AqM3nztbWwjq9dtLEQGgSHA
	 bhKVn+8z9xZkLXW1kGVKRX2HZnidKz3T7uvhkN5/m+tJFL91NFW3kJ23LLPFG24GP1tTl
	 Ske+aM5BPtd9eSrQ2PasO/iGkKoSjforCDy8LAC8RnwGymny3DMR7aN/pizqvN/ie+q5b
	 WJwejLdovNUuYk/aqDxuiWE6Hk5PCeUIt9itTqJmHa8RONgrbM5YmrbZhp/sM1/XjMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792793410;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=qOJ1GXXdOfNWDBK0dfVeev5Ia3MBY8+fjGuVb76LtFU=;
	b=J3JkVxf8CtNsfgje8+3IZQo4fAEqnskCwFwuJ1Lz74TdYPiznhvbj2tLn4u0JGXjOeY+
	 9mEwcVP3acJqAwh8e0TUqMY1UkQly1KiYDbfKMalnP+T8JLVK5fL+BF4jXbHSAGPE5SiH
	 QXjo37CcrDXiJSA4F51YJcOzmp3DbjZkm9Al7J1SrFSKxu1SvL+cStRdnqxlWGbC89z5w
	 eAcdhxvjgE4u5LPvnnvgxs8uhEwphEgRdRV/TyXUDQdweXwDcS5oiats+vWpBuqPXqfj0
	 Ad9cPURb1na6GRVmC/uqQuEo5WRl4nv4nHMf1mLV6l2pinVNnIByDtM+1u6GF9ssncA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K6oehAHE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DFF606A322;
	Fri, 23 Oct 2026 22:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K6oehAHE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891D01F01825;
	Fri, 23 Oct 2026 22:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792793409;
	bh=qOJ1GXXdOfNWDBK0dfVeev5Ia3MBY8+fjGuVb76LtFU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=K6oehAHEpA4aS2zkKopMpMRBK36dx65xEGi8mlOPxWdpU4OmrySmuCt08EX+dlGZk
	 he528hyx6zW/3rJHXSkRiVF2A+idC0ZeOAWKwsKDVWXNYrhBy30qcKm7m/tJeDXKdJ
	 RNkxeEsooOvBTJsQK1jQwowzp66zJgIi7LdZmPlrhyo2L16q7YIkOxjVIQP5K0RZPt
	 AYMPvXkAr2PKQ+ZIgN992aho7DA2Jsfp2V5mDw3Vl5J89AZ2/r63TrdJqmdfpH3IPn
	 QlVS+2tPcNmnQ2VDdk/MRuAYCqtStydz0TrIe8YNra1DjmMc1BF+pafBk2yHyzzTt9
	 +YuViHFY7cJCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8159F391B158;
	Fri, 23 Oct 2026 22:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_sync: Protect resolving-list lookups
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179279340798.1294506.10569724909880961113.git-patchwork-notify@kernel.org>
Date: Fri, 23 Oct 2026 22:10:07 +0000
References: 
 <pm-bluetooth-objects-candidate-0159-v11-9bd4b4c3c1e56d9ba355@gmail.com>
In-Reply-To: 
 <pm-bluetooth-objects-candidate-0159-v11-9bd4b4c3c1e56d9ba355@gmail.com>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, jjzuming@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 22 Oct 2026 20:05:56 +0800 you wrote:
> The host resolving list is updated under hdev->lock, and each
> bdaddr_list_with_irk entry must remain alive throughout a lookup.
> hci_le_del_resolve_list_sync() and hci_le_add_resolve_list_sync()
> traverse that list without taking the lock.
> 
> On an LE privacy-capable controller with a programmed entry, passive
> scan reconciliation can reach hci_le_del_resolve_list_sync() while a
> privileged HCI_RAW client sends LE Clear Resolving List. The raw
> command does not take req_lock, and its successful completion runs
> on the controller workqueue independently of request work:
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_sync: Protect resolving-list lookups
    https://git.kernel.org/bluetooth/bluetooth-next/c/2a464ab1c5ac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


