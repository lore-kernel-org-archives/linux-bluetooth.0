Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461010;
	b=FEo3d/lelL0KkCu1NHS9HgeCpYUKxlkMz/81cuVIOZgDFHxREE/lNR86a+lGpuHTLMiQ
	 ldyppHapwAzN2T+0zx+dvQeR3UVSBZHqk8d5pqTHEzyMBxUm7GTpyObf/iKX1wdALKq7g
	 jG4Q2V9eidAaX2JPiOMhM3MpqX8HmJeVuHk5EBbs/JxaiJR6wkKzpTisYLa9OfQBRRCD1
	 wL+RNrGs+jgJSuBw5RXNSsi3h2/eFR/zso9wz4gDX9oVMZXcVTsKTQH6YVTocErFwXAz/
	 rGyT9lAayB4IhHovVCpD2Q1uMBXZZEIKCgIhxCoT9qg+hL0kx/O52o/f9jhGOT95l0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461010;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Ucq/S5sMsOFO1DiWhqcLilgfDf0RwqxjNqIslSHBbnM=;
	b=ZkbCrU1csf94hTkZEIDfX3J2kFVeidgfUEYXl5I2sGJbMgd9uMeGZh+gY6MKd7nC7t/m
	 XFP1jJb7HjIFjQ1myZvwAun9NydKTQigZ1h9ZI12CxKVdz0x8DC9DrotmvQtrxJaHu24V
	 ujKhg6+4JD2ThdGGdsEgR9a6fwzJ635VxJ90pszGdyLoMuw3+eCPG9EsCad0DKb4+EuoX
	 8vpd9HLtZO7COtYlfwK3P0Jf3/r23QogiaDjdP/FJ16gtCQTNor1zrRyAn/1bjPBaHV9M
	 r8dqSAZeS+NWgAPE2Ae4esSc4YwPV3YzQtwtMv8AKbzIS7fx42b498wTZyqM3j4EJPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KXc1UCOq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF2E606A332;
	Mon, 23 Nov 2026 19:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KXc1UCOq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42DB01F000D3;
	Mon, 23 Nov 2026 19:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795461009;
	bh=Ucq/S5sMsOFO1DiWhqcLilgfDf0RwqxjNqIslSHBbnM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KXc1UCOq0C+M5cfehtm3pXT5VEqEy4cMsK5yDPvT6d0Fz5UwKEYZwzL3q16RErSPX
	 uYgjN2I7hsgr/yt1H0XGiN89RsYcuLj1M9h5pJV7QDTmiFYABTMxMID1QEcCPuupjp
	 42EkkcW31ZFo99bOxx0NEHmQ5jP/st/AJLyllZhtJ015QAhrHS1XgU5HEdY3KjxQ7M
	 3nefrrfxIsfEhYUBQVMeRe6No6RLs0H+QCULqZH2zd/gdYXEDfsb3tmPcgHc8X+j+X
	 mnXJfsC5oa1sDfQ0/YNR+EsKfxZcapRrgQ84HOIVyYlqut54Ph5E9OnjdTzDjMx690
	 ozqhDeuYoC4oA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3CE392EE35;
	Mon, 23 Nov 2026 19:10:09 +0000 (UTC)
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
Subject: Re: [PATCH] Bluetooth: hci_sync: invoke destroy callbacks outside
 lock
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179546100789.3063022.8839982539012275088.git-patchwork-notify@kernel.org>
Date: Mon, 23 Nov 2026 19:10:07 +0000
References: <20261121120121.576-1-viennaoffh@gmail.com>
In-Reply-To: <20261121120121.576-1-viennaoffh@gmail.com>
To: Zheng Shuhao <viennaoffh@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 21 Nov 2026 20:01:20 +0800 you wrote:
> hci_cmd_sync_clear() cancels queued command-sync entries while holding
> cmd_sync_work_lock. Cancellation invokes entry->destroy(), and
> add_ext_adv_params_complete() takes hdev->lock. In the opposite direction,
> le_conn_complete_evt() holds hdev->lock while hci_update_passive_scan()
> queues work and acquires cmd_sync_work_lock. This creates the circular
> locking dependency reported by lockdep during controller teardown.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_sync: invoke destroy callbacks outside lock
    https://git.kernel.org/bluetooth/bluetooth-next/c/f99caa0d2467

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


