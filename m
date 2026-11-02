Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793658019;
	b=jT/8NhVKkzTkSU0zYLVl2DcW6S3QufdIf1GFZC4Wkeq2XRDaBhfX+G2KosjEGvs8cvvR
	 yW0CJg7djnLBzziI8PDplvS0TxdBE1sf9SXi7vuZHS+UhHdKXbxMpowxD0NS0TpuqptLg
	 RVtCDCGuk6HJTZNNrOLcUj4XZ3FzOK2YionOByVV8/CLjMXbZ0o6sw3MRmhy/cC4/Rmvl
	 R5BpjIV0axpJeL7vFImfAQohCABF5+skVgN/Zv6MLWykYSLGf2ftHTLTK0Pq0ceDIXuIl
	 BPrrXI5zPFnIRpRieMvuRPefn5Zei2jTMvGAbhv7RYHDF0lYmffW08hZSME22awzLhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793658019;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=cqaOPE2Xk8rotTZLlUPPZMUYvIGPRM5aIicgRX/cWEM=;
	b=aflLJ6AJfzCAxhYwEZOSUEFkv67yaRMZwlCMU+vBSYyqBoPtL+2oLGAB0OrHfsn9cY0B
	 5EgI654TMY99XBQEj0sCM4s/Yt//ItUNthbnkBKdh2OIGycxepqpnWQvFg67uCcB/o+K+
	 DA1yhvjqtHbpPkAMGKtvY+JBgMf9XWKwmjnePGtgXvgQP+alsXGYRxDCBA0SsNzax+KBJ
	 WD4RAZcYTPgcmCu3Lzx+NxM3drO5M26a0iDq0hvIQcsGIVmyaSJ9jxXprC1cubN1OZdD5
	 4hnRneHyjDQYY9W2kPGBkW0onpGCcDnUusdhVE+YvwmFIFalf3U5FukaGDdNCO+Sm8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GxWhXOti;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C412606A329;
	Mon,  2 Nov 2026 22:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GxWhXOti
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7DA1F00A1A;
	Mon,  2 Nov 2026 22:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793658018;
	bh=cqaOPE2Xk8rotTZLlUPPZMUYvIGPRM5aIicgRX/cWEM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GxWhXOtiAGIaWMOuP+cdMjTK7+f0uM9uPFsXC9TfeK/fCtfLr33xz5DeeulTJXA2k
	 9cl+nJFgy5YCZ/gLdaoXvvgB7VwCR6AaOSQZILV+A62jlO+kKEqepNhJAb7+88TyUX
	 /CZpVe2rTfSMrc7HWOyc4zrbn/m3fXDMif4szWeaVDQXcP2t8SnDP7KVVDOTJycGso
	 CtIlQhejmnif6uHe7B3SbZDTtwGdQu6wl0B8CgEoybsYShtRqTX2hUbzN/C8s5lJlx
	 7tdoFQt52KQdqEE1rGEVbPK6KFNyFXpVVOpxTYAEjldIaSufcIN6izbFezsk67CcFC
	 jbDErsy1wF/ug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 031C9380821F;
	Mon,  2 Nov 2026 22:20:18 +0000 (UTC)
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
Subject: Re: [PATCH 0/2] Bluetooth: Fix advertising instance accesses without
 hdev->lock
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179365801654.694758.6672265217691317645.git-patchwork-notify@kernel.org>
Date: Mon, 02 Nov 2026 22:20:16 +0000
References: 
 <pm-bluetooth-objects-candidate-0245-v9-6b34bc036455ad3dd4ea-0@gmail.com>
In-Reply-To: 
 <pm-bluetooth-objects-candidate-0245-v9-6b34bc036455ad3dd4ea-0@gmail.com>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, jjzuming@gmail.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 30 Oct 2026 22:27:43 +0800 you wrote:
> Commit cdc36db204ff ("Bluetooth: hci_sync: Fix advertising data UAFs")
> fixed the extended advertising data paths that use advertising
> instances without hdev->lock. Patch 1 fixes the remaining request paths
> with the same problem in the same way, and copies the instance numbers
> under the lock for walks that send commands, as commit cac164b6246f
> ("Bluetooth: hci_sync: Copy the LE accept list under hdev->lock") does.
> 
> [...]

Here is the summary with links:
  - [1/2] Bluetooth: hci_sync: Fix remaining advertising instance UAFs
    (no matching commit)
  - [2/2] Bluetooth: hci_core: Initialize advertising RPA work only once
    https://git.kernel.org/bluetooth/bluetooth-next/c/a7c5c18b7cc3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


